//===----------------------------------------------------------------------===//
// QEMUEmitCPass.cpp - QEMU C Code Emission Pass (Bus-Transaction Driven)
//
// Final pass in the LLHD-to-QEMU conversion pipeline.
// Reads qemu.* metadata from the IR and emits QEMU-compatible C code.
//
// KEY DESIGN CHANGE (v2 - Protocol Decoupled):
// - Reads `qemu.functional_txns` from Phase 1 (FunctionalBusTxnInferPass)
// - Extracts addr_signal / wdata_signal / rdata_signal names
// - Generates protocol-agnostic MMIO _read/_write callbacks that directly
//   map QEMU's hwaddr/value to the inferred flattened signal names
// - Falls back to legacy APB mapping only if no functional_txns found
//
// This makes the generated C code independent of TL-UL / APB / AXI.
//===----------------------------------------------------------------------===//

#include "CombTranslator.h"
#include "PassReports.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"

// Include the existing QEMUCodeGen from qemu-output
#include "QEMUCodeGen.h"
#include "BackendBlueprint.h"
#include "DeviceCatalog.h"
#include "GenericSysBusEmitter.h"
#include "ClkAnalysisResult.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/SymbolTable.h"
#include "llvm/ADT/DenseMap.h"

#include <algorithm>
#include <cassert>
#include <cctype>
#include <map>
#include <set>
#include <regex>

// TableGen-generated pass declaration and definition
#define GEN_PASS_DECL_QEMUEMITC
#define GEN_PASS_DEF_QEMUEMITC
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;
// for comb_translator::parityFold — the >64-bit parity truncation trap is the
// same on both expression builders, and one copy of that reasoning is enough.

namespace {

//===----------------------------------------------------------------------===//
// Helper: Name Sanitization (FLAT - no hierarchy)
//===----------------------------------------------------------------------===//

/// Sanitize signal name to valid C identifier (no module prefix)
static std::string sanitizeName(llvm::StringRef name) {
  std::string result = name.str();
  for (char &c : result) {
    if (c == '.' || c == '[' || c == ']' || c == '-' || c == ' ' || c == ':') {
      c = '_';
    }
  }
  if (!result.empty() && std::isdigit(static_cast<unsigned char>(result[0]))) {
    result = "_" + result;
  }
  return result;
}

//===----------------------------------------------------------------------===//
// Flat Signal Registry - FLAT naming (aligned with qemu-output architecture)
//===----------------------------------------------------------------------===//

class FlatSignalRegistry {
public:
  struct SignalInfo {
    std::string originalName;
    std::string sanitizedName;
    unsigned bitWidth;
    // Bug G: signals wider than 128 bits can't fit in any C scalar
    // (max __uint128_t = 128).  Store as `uint64_t arr[nWords]` and
    // route reads/writes through array indexing.  nWords == 0 means
    // "scalar storage", nWords > 0 means wide-array.
    unsigned nWords = 0;
  };

  /// Register a signal with flat name (no module prefix).
  ///
  /// We key the lookup table on the *sanitized* form rather than the
  /// raw input.  This unifies different raw names that map to the same
  /// canonical state-struct field — without it, e.g.
  ///   "u_reg_u_rsp_intg_gen.tl_o.d_data"
  ///   "u_reg_u_rsp_intg_gen_tl_o.d_data"
  /// both sanitize to `u_reg_u_rsp_intg_gen_tl_o_d_data` but the second
  /// gets a `_2` collision suffix and the actual data flow breaks
  /// across the bridge: the inner sig's drv writes the `_2` field
  /// while the output bridge reads the unsuffixed one.
  std::string registerSignal(llvm::StringRef signalName, unsigned bitWidth,
                             bool authoritative = false) {
    std::string sanitized = sanitizeName(signalName);
    std::string key = signalName.str();
    auto it = nameToSanitized_.find(sanitized);
    if (it != nameToSanitized_.end()) {
      // Also map this raw name to the canonical sanitized form so
      // lookup() finds it regardless of which raw spelling came in.
      nameToSanitized_[key] = it->second;
      // Authoritative re-registration: comb_logic regex sweep registers
      // references with the LHS target's width, which is a slice width,
      // not the signal's true width.  Instance-port walks (the "callee
      // declared this port as iN") are authoritative — let them override
      // any earlier inferred width.  Without this, a wide signal whose
      // first observed use is a narrow bit-extract gets a too-narrow
      // struct field type and `(s->X >> 47) & 0xFFFFFFFF` returns 0
      // because uint8_t shifted by 47 is undefined behaviour.
      if (authoritative) {
        signals_[it->second].bitWidth = bitWidth;
        signals_[it->second].nWords =
            (bitWidth > 128) ? ((bitWidth + 63) / 64) : 0;
      }
      return it->second;
    }
    // First time we see this sanitized form — record under both keys.
    nameToSanitized_[sanitized] = sanitized;
    nameToSanitized_[key] = sanitized;
    usedNames_.insert(sanitized);

    SignalInfo info;
    info.originalName = key;
    info.sanitizedName = sanitized;
    info.bitWidth = bitWidth;
    info.nWords = (bitWidth > 128) ? ((bitWidth + 63) / 64) : 0;
    signals_[sanitized] = info;

    return sanitized;
  }

  std::string lookup(llvm::StringRef name) const {
    auto it = nameToSanitized_.find(name.str());
    if (it != nameToSanitized_.end()) {
      return it->second;
    }
    // Fall back to sanitize-then-look-up; bridges that didn't go
    // through registerSignal still get a consistent answer.
    std::string san = sanitizeName(name);
    auto it2 = nameToSanitized_.find(san);
    if (it2 != nameToSanitized_.end())
      return it2->second;
    return san;
  }

  const std::map<std::string, SignalInfo>& getSignals() const {
    return signals_;
  }

private:
  std::map<std::string, std::string> nameToSanitized_;
  llvm::StringSet<> usedNames_;
  std::map<std::string, SignalInfo> signals_;
};

//===----------------------------------------------------------------------===//
// Phase 2.a — Per-instance rendering of qemu.comb_logic
//
// Background: the original architecture walked every hw.module flat and
// concatenated their qemu.comb_logic into one global update_state.  That
// breaks for multi-instance modules: a callee instantiated N times shares
// one set of state-struct fields, so writes to instance #1's "wr_en" alias
// instance #2's "wr_en", and the address decode goes wrong.
//
// Phase 2.a switches to a recursive walk of the hw.instance tree starting
// at the top module.  At each visited module we apply a prefix derived
// from the instance path ("u_uart_core_u_reg_if" etc.) to every sig,
// port, and qemu.comb_logic target/expression so that each instance gets
// independent state-struct fields.  The top module itself uses the empty
// prefix, so its signal names (and therefore the BIP names that the MMIO
// callbacks reference) are unchanged.
//
// What Phase 2.a deliberately does NOT do:
//   - bridge caller→callee operand values across instance edges (Phase 2.b)
//   - consume qemu.seq_logic / generate tick() (Phase 2.c)
//   - emit setter API for top-level non-BIP inputs (Phase 2.d)
//
// As a result, after Phase 2.a alone, generated update_state grows in
// size (each instance contributes its own prefixed copy) but firmware
// still cannot round-trip a register write — the missing bridges and
// the missing sequential tick() are the remaining gap.
//===----------------------------------------------------------------------===//

/// Prefix a single name with the instance-path prefix.  Empty prefix
/// leaves the name unchanged (top-level module case).
/// One scalar leaf of an aggregate port: its path suffix, its bit offset in
/// the packed value, and its width.
struct BridgeLeafSpec {
  std::string path;
  uint64_t off;
  unsigned width;
};

/// Flatten an aggregate type into scalar leaves with packed bit offsets.
///
/// Layout must match what the rest of the emitter uses: a struct's field 0
/// occupies the HIGHEST bits (walk down from the total width), an array's
/// element 0 the LOWEST.  Leaf paths join with '.' except an array index,
/// which appends "[k]" with no dot.  Returns false for a shape it cannot
/// flatten (a leaf wider than 64 bits, an unknown type) rather than guessing.
static bool collectTypeLeaves(mlir::Type ty,
                              llvm::SmallVectorImpl<BridgeLeafSpec> &out) {
  bool ok = true;
  std::function<void(mlir::Type, const std::string &, uint64_t)> walk =
      [&](mlir::Type t, const std::string &path, uint64_t base) {
        if (!ok)
          return;
        if (auto it = dyn_cast<IntegerType>(t)) {
          if (!it.getWidth() || it.getWidth() > 64) { ok = false; return; }
          out.push_back({path, base, it.getWidth()});
          return;
        }
        if (auto st = dyn_cast<hw::StructType>(t)) {
          int64_t total = hw::getBitWidth(st);
          if (total <= 0) { ok = false; return; }
          uint64_t pos = (uint64_t)total;
          for (auto fld : st.getElements()) {
            int64_t fw = hw::getBitWidth(fld.type);
            if (fw <= 0) { ok = false; return; }
            pos -= (uint64_t)fw;
            walk(fld.type, path + "." + fld.name.getValue().str(), base + pos);
          }
          return;
        }
        if (auto at = dyn_cast<hw::ArrayType>(t)) {
          int64_t ew = hw::getBitWidth(at.getElementType());
          if (ew <= 0) { ok = false; return; }
          for (unsigned k = 0; k < at.getNumElements(); ++k)
            walk(at.getElementType(), path + "[" + std::to_string(k) + "]",
                 base + (uint64_t)k * (uint64_t)ew);
          return;
        }
        ok = false;
      };
  walk(ty, std::string(), 0);
  return ok && !out.empty();
}

/// POST-CONDITION for the instance-port bridge delegation.
///
/// Returns the first `s->NAME` in `expr` that is not a declared state field,
/// or "" if every reference resolves.
///
/// WHY A POST-CONDITION AND NOT A NAMING FIX.  The bridge installs a mapper so
/// CombTranslator can name signals the way the flattened emitter does, and the
/// mapper refuses to invent a field.  But the mapper only covers the sites
/// that ASK the signal registry; a name synthesised from an instance and a
/// port (`u_sync` + `rptr_gray_q_o` -> `u_sync_rptr_gray_q_o`) never consults
/// it, so it walked straight past the guard and out into the emitted C, where
/// spi_device failed to compile.  Auditing every naming site would have to be
/// redone for the next one added.  Checking the RESULT closes the whole class
/// once: whatever route a name took, if it does not name a real field the
/// translation is rejected and the port falls through to the ordinary skip
/// diagnostic.  A loud give-up, never a wrong model.
static std::string bridgeExprUnresolved(llvm::StringRef expr,
                                        const FlatSignalRegistry &reg) {
  size_t pos = 0;
  while ((pos = expr.find("s->", pos)) != llvm::StringRef::npos) {
    size_t b = pos + 3, e = b;
    while (e < expr.size() &&
           (isalnum((unsigned char)expr[e]) || expr[e] == '_'))
      ++e;
    llvm::StringRef name = expr.substr(b, e - b);
    // `_qp*` are the runtime's own fields (settle bookkeeping, staging
    // temporaries); they are declared by the emitter, not the registry.
    if (!name.empty() && !name.starts_with("_qp") &&
        !reg.getSignals().count(name.str()))
      return name.str();
    pos = e;
  }
  return std::string();
}

static std::string prefixedName(llvm::StringRef name, llvm::StringRef prefix) {
  if (prefix.empty()) return name.str();
  return (prefix + "_" + name).str();
}

/// Size ceiling for one speculative bridge translation.
///
/// 256 KB is far above any expression a bridge has legitimately produced (the
/// fifteen M10 recoveries are all under 4 KB) and far below what killed the
/// process.  It is a backstop against a runaway cone, not a tuning knob.
static constexpr size_t kBridgeExprBudget = 256u * 1024u;

/// Installs the caller-scope field mapper for the duration of a scope.
///
/// Both bridge delegation paths (scalar translateValue, aggregate sliceValue)
/// need it.  Written once as a guard rather than copied into each, because a
/// second weaker copy of a resolver is the exact defect M1b and M10 both fixed
/// — and the aggregate path having been written WITHOUT the mapper is how
/// aes_ctr's ctr_o came out naming `s->qpinl7_out_0_` instead of the field's
/// flattened name.
namespace {
struct BridgeMapperScope {
  std::function<std::optional<std::string>(llvm::StringRef)> saved;
  BridgeMapperScope(llvm::StringRef childPrefix, const FlatSignalRegistry &reg) {
    auto &mapper = comb_translator::signalFieldMapper();
    saved = mapper;
    std::string prefix = childPrefix.str();
    const FlatSignalRegistry *r = &reg;
    mapper = [prefix, r](llvm::StringRef raw) -> std::optional<std::string> {
      std::string field = r->lookup(prefixedName(raw.str(), prefix));
      // lookup() FALLS BACK to the sanitized name for anything it does not
      // know, which would invent a field.  Confirm it exists.
      if (!r->getSignals().count(field)) {
        if (getenv("QP_DBG_MAP"))
          llvm::errs() << "    [map miss] raw=" << raw << " flat="
                       << prefixedName(raw.str(), prefix) << "\n";
        return std::nullopt;
      }
      return std::string("s->") + field;
    };
  }
  ~BridgeMapperScope() { comb_translator::signalFieldMapper() = saved; }
};
} // namespace


/// Apply the instance-path prefix to all `s->NAME` references in an
/// expression string AND sanitize each captured name so it matches the
/// flat state-struct field name FlatSignalRegistry registers.
///
/// Why the regex must accept `.`: CombLogicExtract / CombTranslator can
/// emit expressions like `s->tl_i.d_data` when residual struct-field
/// names from hw-flatten-io / circt-verilog survive into comb_logic.
/// FlatSignalRegistry::sanitizeName flattens those to `tl_i_d_data` for
/// the state-struct field, so we must do the same to every reference
/// the expression embeds — otherwise the generated C reads a struct
/// path (`s->tl_i.d_data`) that doesn't exist in the flat state struct.
///
/// CombLogicExtract emits expressions whose `s->NAME` references all
/// bind to callee-local names (sigs, ports, instance-result names).
/// MLIR's hw.module is a closed namespace, so we never see
/// `s->parent_X` patterns that would need a no-op rule.
static std::string applyPrefix(llvm::StringRef expr, llvm::StringRef prefix) {
  // Capture `[A-Za-z_]` start + `[A-Za-z0-9_.]*` continuation so the
  // dot-bearing residuals get folded into a single match group.
  static const std::regex pat(R"(s->([A-Za-z_][A-Za-z0-9_.]*))");
  std::string in = expr.str();
  std::string out;
  out.reserve(in.size() + (prefix.size() + 1) * 4);
  auto begin = std::sregex_iterator(in.cbegin(), in.cend(), pat);
  auto end   = std::sregex_iterator();
  size_t lastPos = 0;
  for (auto it = begin; it != end; ++it) {
    const auto &m = *it;
    out.append(in, lastPos, m.position() - lastPos);
    std::string captured = m[1].str();
    // Model-global fields (`_qp_*`, e.g. the pump pulse `_qp_pump`) are not
    // instance-scoped: never prefix them.
    bool global = llvm::StringRef(captured).starts_with("_qp_");
    std::string full =
        (prefix.empty() || global) ? captured : (prefix.str() + "_" + captured);
    out.append("s->");
    out.append(sanitizeName(full));
    lastPos = m.position() + m.length();
  }
  out.append(in, lastPos, std::string::npos);
  return out;
}

/// Join an instance-path prefix and a child instance name.
/// joinInstPath("", "u_X")          -> "u_X"
/// joinInstPath("u_X", "u_Y")       -> "u_X_u_Y"
static std::string joinInstPath(llvm::StringRef prefix, llvm::StringRef instName) {
  if (prefix.empty()) return instName.str();
  return (prefix + "_" + instName).str();
}

/// Walking context for renderModule.
///
/// `instancePath` is the prefix applied to every name produced while
/// rendering this module.  `registry`, `combOut` and `seqOut` are
/// shared across the entire recursion (refs into the runOnOperation
/// locals).  Sequential entries (Phase 2.c) live in `seqOut` and are
/// emitted into a separate tick() function, while combOut feeds
/// update_state().
struct EmitCtx {
  std::string instancePath;
  FlatSignalRegistry &registry;
  std::vector<clk_analysis::CombinationalAssignment> &combOut;
  std::vector<clk_analysis::CombinationalAssignment> &seqOut;
  // Backing stores created by memory-organ collapses (prim_rom):
  // (state field name, word depth).  The emitter turns these into a
  // loader API + shim image properties.  Optional: null when the
  // caller doesn't collect them.
  std::vector<std::pair<std::string, uint64_t>> *backingStores = nullptr;
};

/// Resolve a Value to a C expression string in `prefix`'s namespace.
///
/// Phase 2.b uses this to bridge instance edges:
///   - input bridges call resolveValueExpr(inst.getOperand(i), <caller_prefix>)
///   - output bridges call resolveValueExpr(outputOp.getOperand(j), <child_prefix>)
///
/// Handled patterns (covers the common OT shapes):
///   - hw.constant         -> integer literal (e.g. "1")
///   - llhd.prb of llhd.sig (with optional sig.extract chain)
///                         -> "s->prefix_<sig_name>"
///   - BlockArgument of an enclosing hw.module
///                         -> "s->prefix_<port_name>"
///   - hw.instance result  -> "s->prefix_<inst_name>_<port_name>"
///
/// Returns std::nullopt for arbitrary comb expressions (anything else).
/// Phase 2.b is conservative: an unresolvable input drops the bridge,
/// which leaves the callee's input field at its init value (0).  That
/// preserves correctness — the field still exists, it just isn't
/// dynamically wired — and avoids us emitting wrong inline expressions.
static std::optional<std::string> resolveStructRootName(Value v);
static void walkLeaves(Type ty, std::string &path,
                       llvm::function_ref<void(StringRef, unsigned)> cb);

static std::optional<std::string>
resolveValueExpr(Value v, llvm::StringRef prefix,
                 const FlatSignalRegistry *registry = nullptr,
                 unsigned depth = 16,
                 const llvm::DenseMap<mlir::BlockArgument, std::string>
                     *argBinding = nullptr,
                 const llvm::DenseMap<mlir::Value, std::string>
                     *localSig = nullptr) {
  // Bound the recursion: a malformed or deeply-aliased SSA chain
  // shouldn't put us in a stack-overflow situation.  16 is plenty for
  // OT IR — the deepest comb chains we see are mux selectors with ~5
  // levels of struct_extract + a few comb.extract / comb.icmp.  Do NOT
  // raise this wholesale: there is no memoization, so a wide shared-node
  // comb DAG re-expands per path and a big depth goes exponential
  // (spi_device regen went 2min -> stuck when this was tried at 1024).
  if (depth == 0)
    return std::nullopt;

  // Requested (pre-unwrap) type — the leaf width a consumer actually asked
  // for; used by the instance-leaf case to pre-register a field whose
  // producer renders later in the module body.
  Type reqTy = v.getType();

  // Unwrap hw.struct_extract / hw.array_get chains so a chain like
  //   %arr = struct_extract %x["intr_test0"]            : array<1×struct<...>>
  //   %elt = array_get %arr[0]                          : struct<q,qe>
  //   %qe  = struct_extract %elt["qe"]                  : i1
  // traces back to the root %x and accumulates a path matching
  // walkLeaves's convention: "intr_test0[0].qe".  The "." appears only
  // between adjacent field names (or between `]` and a field name);
  // there is NO "." between a field name and `[`.  This makes the
  // sanitized output line up with both walkLeaves's bridge emission AND
  // ExplodeStructSigs's per-leaf sig naming.
  std::string fieldPath;
  // Prepend a path component, inserting "." iff the existing path
  // starts with a field-name character (i.e., we're joining "X" + "."
  // + "field…" but never "X" + "." + "[…").
  auto prependPathComponent = [&](llvm::StringRef component) {
    if (fieldPath.empty()) {
      fieldPath = component.str();
      return;
    }
    bool needDot = !fieldPath.empty() && fieldPath[0] != '[';
    fieldPath = component.str() + (needDot ? "." : "") + fieldPath;
  };
  while (true) {
    if (auto se = v.getDefiningOp<hw::StructExtractOp>()) {
      prependPathComponent(se.getFieldNameAttr().getValue());
      v = se.getInput();
      continue;
    }
    if (auto ag = v.getDefiningOp<hw::ArrayGetOp>()) {
      auto idxConst = ag.getIndex().getDefiningOp<hw::ConstantOp>();
      if (!idxConst)
        break;  // dynamic index — can't bridge, fall through to leaf cases
      prependPathComponent(
          "[" + std::to_string(idxConst.getValue().getZExtValue()) + "]");
      v = ag.getInput();
      continue;
    }
    break;
  }

  // wrap() returns std::nullopt if the synthesized field name isn't in
  // the registry — then the calling bridge skips emitting altogether
  // (graceful fallback) instead of writing a state-struct field that
  // doesn't exist (which would be a C compile error in lowrisc-qemu).
  auto wrap = [&](std::string baseField) -> std::optional<std::string> {
    if (!fieldPath.empty()) {
      // Mirror prependPathComponent: array indices ("[N]") attach without a
      // separator dot, so an array-element-of-input like lc_escalate_en_i[1]
      // sanitizes to "..._i_1_" (matching the struct/array flattening) rather
      // than "..._i__1_" (which is absent from the registry → wrongly skipped).
      bool needDot = fieldPath[0] != '[';
      baseField += (needDot ? "." : "") + fieldPath;
    }
    std::string field = sanitizeName(prefixedName(baseField, prefix));
    if (registry) {
      const auto &signals = registry->getSignals();
      if (signals.find(field) == signals.end())
        return std::nullopt;
    }
    return std::string("s->") + field;
  };

  // ---------- Leaf cases -----------------------------------------
  if (auto cst = v.getDefiningOp<hw::ConstantOp>()) {
    llvm::APInt cv = cst.getValue();
    if (cv.getActiveBits() > 64 && cv.getBitWidth() <= 128) {
      // 65..128-bit constant: legal C as two 64-bit halves.
      uint64_t lo = cv.extractBitsAsZExtValue(64, 0);
      uint64_t hi = cv.extractBitsAsZExtValue(cv.getBitWidth() - 64, 64);
      return "((((__uint128_t)0x" + llvm::utohexstr(hi) +
             "ULL) << 64) | 0x" + llvm::utohexstr(lo) + "ULL)";
    }
    if (cv.getActiveBits() > 64) {
      // >128-bit literal: no scalar C carrier, but the consumers that
      // CAN handle one (wide icmp per-word compare, the wordwise
      // rewriter's array-literal expansion) recognize the full hex
      // spelling — mirror CombTranslator's behavior.  A leak into a
      // genuinely scalar context fails loudly at C compile time.
      llvm::SmallString<96> hexStr;
      cv.toString(hexStr, 16, /*Signed=*/false);
      return "0x" + std::string(hexStr) + "ULL";
    }
    uint64_t u = cv.getZExtValue();
    if (u > 0x7FFFFFFFull)
      return std::to_string(u) + "ULL";
    return std::to_string(u);
  }
  if (auto prb = v.getDefiningOp<llhd::ProbeOp>()) {
    Value sig = prb.getSignal();
    // Inside an inlined func.func body: a probe of a FUNCTION-LOCAL signal
    // (the importer's encoding of SV function locals, e.g.
    // prim_sha2_pkg::conv_endian32's conv_data) reads the symbolically
    // evaluated expression, not a state field.
    if (localSig) {
      auto it = localSig->find(sig);
      if (it != localSig->end())
        return it->second;
    }
    while (auto ex = sig.getDefiningOp<llhd::SigExtractOp>())
      sig = ex.getInput();
    if (localSig) {
      auto it = localSig->find(sig);
      if (it != localSig->end())
        return it->second;   /* slice-of-local: whole value (mask upstream) */
    }
    if (auto sigOp = sig.getDefiningOp<llhd::SignalOp>()) {
      if (auto nameOpt = sigOp.getName())
        return wrap(nameOpt->str());
    }
    return std::nullopt;
  }
  if (auto ba = dyn_cast<BlockArgument>(v)) {
    // Inside an inlined func.func body: the block arg is bound to the
    // caller's actual-argument expression (see the func.call case below).
    if (argBinding) {
      auto it = argBinding->find(ba);
      if (it != argBinding->end())
        return it->second;
    }
    auto parent = ba.getOwner()->getParentOp();
    if (auto hwMod = dyn_cast<hw::HWModuleOp>(parent)) {
      // BlockArgument::getArgNumber() indexes into the *input-only*
      // argument list of the body block, but HWModuleOp::getPortList()
      // returns inputs and outputs interleaved in declaration order.
      unsigned idx = ba.getArgNumber();
      unsigned inputIdx = 0;
      for (const auto &p : hwMod.getPortList()) {
        if (p.dir != hw::ModulePort::Direction::Input)
          continue;
        if (inputIdx == idx)
          return wrap(p.getName().str());
        ++inputIdx;
      }
    }
    return std::nullopt;
  }
  if (auto inst = v.getDefiningOp<hw::InstanceOp>()) {
    if (auto opResult = dyn_cast<OpResult>(v)) {
      unsigned idx = opResult.getResultNumber();
      auto names = inst.getResultNames();
      if (idx < names.size()) {
        if (auto strAttr = dyn_cast<StringAttr>(names[idx])) {
          std::string field =
              inst.getInstanceName().str() + "_" + strAttr.getValue().str();
          if (auto got = wrap(field))
            return got;
          // wrap() refused because the producer's per-leaf bridge has not
          // registered the field YET (instance ordering: a consumer
          // earlier in the module body than its producer — spi_device's
          // SRAM-FIFO adapters read u_arbiter.rsp_rdata_o[k] and the
          // arbiter is rendered later).  When the requested leaf width is
          // known, register the field now and reference it; the producer's
          // assignment lands later in update_state and the extra sweeps
          // absorb the one-sweep lag.
          if (registry && !fieldPath.empty() &&
              isa<IntegerType>(reqTy)) {
            std::string flat = field;
            flat += (fieldPath[0] == '[' ? "" : ".") + fieldPath;
            std::string full = sanitizeName(prefixedName(flat, prefix));
            // resolveValueExpr's registry param is const; registration
            // here is the one sanctioned mutation (pre-registering a
            // producer-rendered-later leaf).
            const_cast<FlatSignalRegistry *>(registry)->registerSignal(
                full, cast<IntegerType>(reqTy).getWidth());
            return std::string("s->") + full;
          }
          // Same pre-registration for a WHOLE integer instance result: a
          // consumer in the parent can reference a child-instance output
          // before that child is rendered (keymgr_input_checks reads its
          // anchor buffers' 256-bit out_o in the vld comb the parent's
          // output bridge resolves first).  The producer's assignment
          // lands later in update_state; the extra sweeps absorb the lag.
          if (registry && fieldPath.empty() &&
              isa<IntegerType>(v.getType())) {
            std::string full = sanitizeName(prefixedName(field, prefix));
            const_cast<FlatSignalRegistry *>(registry)->registerSignal(
                full, cast<IntegerType>(v.getType()).getWidth());
            return std::string("s->") + full;
          }
          return std::nullopt;
        }
      }
    }
    return std::nullopt;
  }

  // ---------- comb / hw value-op recursion -----------------------
  //
  // When a hw.output / hw.instance operand is a combinational
  // computation rather than a direct sig/port reference, walk the
  // comb DAG and serialize it as a parenthesized C expression.  Any
  // unhandled op shape returns nullopt so the caller (output bridge)
  // skips emitting the assignment — preserves correctness, just
  // leaves that field at its zero init.
  //
  // Why this matters: in tlul_adapter_reg, `addr_o = a_address[N:2]`
  // is a comb.extract of the bus address.  Without this branch the
  // OUTPUT bridge for u_reg.u_reg_if's addr_o port can't generate
  // any assignment, so the `reg_addr` chain stays at 0 and every
  // MMIO access incorrectly hits the register at offset 0.
  Operation *defOp = v.getDefiningOp();
  if (!defOp)
    return std::nullopt;
  if (!fieldPath.empty()) {
    // We unwrapped struct_extract above and ended on a comb op —
    // applying a leaf path to a computed value isn't meaningful here
    // (would imply struct-typed comb result) and our IR doesn't
    // produce that shape; bail.
    return std::nullopt;
  }

  auto sub = [&](Value operand) -> std::optional<std::string> {
    return resolveValueExpr(operand, prefix, registry, depth - 1, argBinding,
                            localSig);
  };

  // hw.array_get with a DYNAMIC index over an hw.array_create of integers:
  // a select table (spi_host_shift_register's `sd_o = table[speed]`).  CIRCT
  // MSB-first convention: operand[N-1-i] = element i.  Emit a ternary chain
  // keyed on the index (same as CombTranslator's comb path).
  if (auto ag = dyn_cast<hw::ArrayGetOp>(defOp)) {
    // Constant lookup table (hw.aggregate_constant) with any index
    // expression — aes's LUT S-box is `sbox_table[255 - data]`.  Emit a C
    // compound literal indexed in place.  hw.aggregate_constant fields are
    // MSB-first (fields[0] = element N-1), so write the C array reversed and
    // index it directly; % N guards the (hardware would return X) OOB case.
    if (auto agg = ag.getInput().getDefiningOp<hw::AggregateConstantOp>()) {
      auto arrTy = dyn_cast<hw::ArrayType>(agg.getType());
      auto elemTy =
          arrTy ? dyn_cast<IntegerType>(arrTy.getElementType()) : nullptr;
      if (!elemTy || elemTy.getWidth() > 64)
        return std::nullopt;
      auto idx = sub(ag.getIndex());
      if (!idx)
        return std::nullopt;
      unsigned n = arrTy.getNumElements();
      const char *cty = elemTy.getWidth() <= 8    ? "uint8_t"
                        : elemTy.getWidth() <= 16 ? "uint16_t"
                        : elemTy.getWidth() <= 32 ? "uint32_t"
                                                  : "uint64_t";
      auto fields = agg.getFields();
      if (fields.size() != n)
        return std::nullopt;
      std::string lit =
          "((const " + std::string(cty) + "[" + std::to_string(n) + "]){";
      for (int i = (int)n - 1; i >= 0; --i) {
        auto ia = dyn_cast<IntegerAttr>(fields[i]);
        if (!ia)
          return std::nullopt;
        lit += std::to_string(ia.getValue().getZExtValue());
        if (i)
          lit += ",";
      }
      lit += "})[((uint64_t)(" + *idx + ")) % " + std::to_string(n) + "u]";
      return lit;
    }
    // Named aggregate + CONSTANT index: the producer's bridge has already
    // registered per-leaf fields `<root>_<k>_` for the aggregate (an
    // instance result like u_arbiter.rsp_rdata_o, or a storage leaf) —
    // reference the element field by name.  spi_device's SRAM-FIFO
    // adapters land here: `w_sram_rdata_i: array_get %arb.rsp_rdata_o[2]`.
    if (isa<IntegerType>(ag.getType())) {
      if (auto idxC = ag.getIndex().getDefiningOp<hw::ConstantOp>()) {
        if (!ag.getInput().getDefiningOp<hw::ArrayCreateOp>() &&
            !ag.getInput().getDefiningOp<hw::AggregateConstantOp>()) {
          if (getenv("QP_DBG_AG")) {
            llvm::errs() << "  [AG-NAMED-TRY] input=";
            if (Operation *d = ag.getInput().getDefiningOp())
              llvm::errs() << d->getName();
            else
              llvm::errs() << "block-arg";
            llvm::errs() << " root="
                         << (resolveStructRootName(ag.getInput())
                                 ? *resolveStructRootName(ag.getInput())
                                 : std::string("<none>"))
                         << "\n";
          }
          if (auto root = resolveStructRootName(ag.getInput()))
            return "s->" +
                   sanitizeName(prefixedName(
                       *root + "[" +
                           std::to_string(idxC.getValue().getZExtValue()) +
                           "]",
                       prefix));
        }
      }
    }
    auto ac = ag.getInput().getDefiningOp<hw::ArrayCreateOp>();
    if (!ac || !isa<IntegerType>(ag.getType())) return std::nullopt;
    auto idx = sub(ag.getIndex());
    if (!idx) return std::nullopt;
    unsigned n = ac.getNumOperands();
    std::string expr;
    // element n-1 as the default (last operand of the chain)
    auto last = sub(ac.getOperand(0));
    if (!last) return std::nullopt;
    expr = "(" + *last + ")";
    for (int i = (int)n - 2; i >= 0; --i) {
      auto el = sub(ac.getOperand(n - 1 - i));
      if (!el) return std::nullopt;
      expr = "((((uint64_t)(" + *idx + ")) == " + std::to_string(i) + "u) ? (" + *el + ") : " + expr + ")";
    }
    return expr;
  }

  // func.call to a single-block, single-scalar-result helper (lifecycle /
  // mubi 4-state test functions, e.g. lc_ctrl_pkg::lc_tx_test_false_strict):
  // inline-expand it.  Translate each actual argument in the caller's context,
  // bind the callee's block args to those expressions, then translate the
  // callee's returned value.  Multi-result / struct-returning funcs (e.g.
  // tlul_pkg::extract_*) fail the scalar guard and return nullopt — skipped
  // exactly as before (no other device has such calls on an emitted path).
  if (auto call = dyn_cast<func::CallOp>(defOp)) {
    if (getenv("QP_DEBUG_CALL"))
      llvm::errs() << "  [CALL] " << call.getCallee() << " results="
                   << call.getNumResults() << " depth=" << depth << "\n";
    if (call.getNumResults() != 1 ||
        !isa<IntegerType>(call.getResult(0).getType()))
      return std::nullopt;
    // sha3_pkg::encode_bytepad_len — a 5-entry keccak-strength lookup whose
    // multi-block case body defeats the single-block inliner.  Closed form
    // (kmac's 352-bit cSHAKE prefix starts with this 16-bit length code).
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("encode_bytepad_len") &&
        call.getNumOperands() == 1) {
      if (auto k = sub(call.getOperand(0))) {
        std::string K = "((unsigned)(" + *k + "))";
        return "((" + K + ") == 0u ? 0xA801u : (" + K +
               ") == 1u ? 0x9001u : (" + K + ") == 2u ? 0x8801u : (" + K +
               ") == 3u ? 0x6801u : (" + K + ") == 4u ? 0x4801u : 0u)";
      }
      return std::nullopt;
    }
    // prim_mubi_pkg::mubi4_or_hi / mubi4_and_hi — mirror of the
    // CombTranslator closed forms (True = 4'h6, False = 4'h9): per bit,
    // or_hi: True[i] ? a|b : a&b; and_hi: True[i] ? a&b : a|b.
    // rom_ctrl's bus-select flop d_i = mubi4_or_hi(sel_q, sel_i) reaches
    // this resolver via the instance input bridge.
    // keymgr_pkg::valid_data_chk (imported as @valid_chk): a wide value
    // is "valid" iff it is neither all-zero nor all-ones.  The argument
    // is a >64-bit field the generic inliner cannot carry — closed form
    // over the word array.
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("valid_chk") &&
        call.getNumOperands() == 1) {
      Value a0 = call.getOperand(0);
      unsigned w = a0.getType().getIntOrFloatBitWidth();
      auto ae = sub(a0);
      if (ae && w > 64) {
        const std::string &r = *ae;
        size_t b2 = 0, e2 = r.size();
        while (b2 < e2 && (r[b2] == ' ' || r[b2] == '(')) ++b2;
        while (e2 > b2 && (r[e2-1] == ' ' || r[e2-1] == ')')) --e2;
        bool plainA = (e2 - b2 >= 4 && r.compare(b2, 3, "s->") == 0);
        for (size_t i = b2 + 3; plainA && i < e2; ++i)
          if (!(std::isalnum((unsigned char)r[i]) || r[i] == '_'))
            plainA = false;
        if (plainA) {
          std::string n = r.substr(b2 + 3, e2 - b2 - 3);
          unsigned nW = (w + 63) / 64;
          unsigned tail = w % 64;
          std::string orE, andE;
          for (unsigned i = 0; i < nW; ++i) {
            std::string word = "s->" + n + "[" + std::to_string(i) + "]";
            orE += (i ? " | " : "") + word;
            std::string ones =
                (i + 1 == nW && tail)
                    ? "((1ULL << " + std::to_string(tail) + ") - 1)"
                    : "0xFFFFFFFFFFFFFFFFULL";
            andE += std::string(i ? " & " : "") + "(" + word +
                    " == " + ones + ")";
          }
          return "((((" + orE + ") != 0)) && (!(" + andE + ")))";
        }
      }
      return std::nullopt;
    }
    // prim_mubi_pkg::mubi4_or / mubi4_and — same closed form as
    // lc_ctrl_pkg::lc_tx_or, 4 bits wide: per bit, or: act[i] ? a|b : a&b;
    // and: act[i] ? a&b : a|b.  The *_hi wrappers inline down to these
    // through the generic single-block inliner (rom_ctrl's bus-select
    // flop d_i = mubi4_or_hi(sel_q, sel_i)).
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        (call.getCallee().contains("mubi4_or") ||
         call.getCallee().contains("mubi4_and")) &&
        call.getNumOperands() == 3 &&
        !call.getCallee().contains("_hi")) {
      auto a3 = sub(call.getOperand(0));
      auto b3 = sub(call.getOperand(1));
      auto c3 = sub(call.getOperand(2));
      if (a3 && b3 && c3) {
        std::string A = "(" + *a3 + ")", B = "(" + *b3 + ")",
                    C = "(" + *c3 + ")";
        if (call.getCallee().contains("mubi4_or"))
          return "(((" + C + " & (" + A + " | " + B + ")) | (~" + C +
                 " & " + A + " & " + B + ")) & 0xFULL)";
        return "(((" + C + " & " + A + " & " + B + ") | (~" + C +
               " & (" + A + " | " + B + "))) & 0xFULL)";
      }
      return std::nullopt;
    }
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        (call.getCallee().contains("mubi4_or_hi") ||
         call.getCallee().contains("mubi4_and_hi")) &&
        call.getNumOperands() == 2) {
      auto a = sub(call.getOperand(0));
      auto b = sub(call.getOperand(1));
      if (a && b) {
        std::string A = "(" + *a + ")", B = "(" + *b + ")";
        bool orHi = call.getCallee().contains("mubi4_or_hi");
        if (orHi)
          return "(((0x6u & (" + A + " | " + B + ")) | (0x9u & " + A +
                 " & " + B + ")) & 0xFULL)";
        return "(((0x6u & " + A + " & " + B + ") | (0x9u & (" + A +
               " | " + B + "))) & 0xFULL)";
      }
      return std::nullopt;
    }
    auto callee = SymbolTable::lookupNearestSymbolFrom<func::FuncOp>(
        call, call.getCalleeAttr());
    if (!callee || !callee.getBody().hasOneBlock())
      return std::nullopt;
    Block &body = callee.getBody().front();
    auto ret = dyn_cast<func::ReturnOp>(body.getTerminator());
    if (!ret || ret.getNumOperands() != 1 ||
        call.getNumOperands() != body.getNumArguments())
      return std::nullopt;
    llvm::DenseMap<mlir::BlockArgument, std::string> binding;
    for (unsigned i = 0; i < call.getNumOperands(); ++i) {
      auto argExpr = sub(call.getOperand(i));
      if (!argExpr)
        return std::nullopt;
      binding[body.getArgument(i)] = *argExpr;
    }
    // FUNCTION-LOCAL signals (llhd.sig/drv/prb inside the body — the
    // importer's encoding of SV function locals, e.g. conv_endian32's
    // conv_data): evaluate the drvs in order as symbolic assignments so
    // the returned prb reads the composed expression.  Same machinery as
    // CombTranslator::inlineFuncCallWith, in this resolver's context.
    llvm::DenseMap<mlir::Value, std::string> locals;
    for (Operation &bop : body) {
      if (auto sg = dyn_cast<llhd::SignalOp>(bop)) {
        auto initE = resolveValueExpr(sg.getInit(), prefix, registry,
                                      depth - 1, &binding, &locals);
        if (!initE)
          return std::nullopt;
        locals[sg.getResult()] = *initE;
        continue;
      }
      if (auto d = dyn_cast<llhd::DriveOp>(bop)) {
        Value tgt = d.getSignal();
        Value base = tgt;
        std::optional<std::string> loExpr;
        unsigned sliceW = 0;
        if (auto ex = tgt.getDefiningOp<llhd::SigExtractOp>()) {
          base = ex.getInput();
          auto lo = resolveValueExpr(ex.getLowBit(), prefix, registry,
                                     depth - 1, &binding, &locals);
          if (!lo)
            return std::nullopt;
          loExpr = *lo;
          sliceW = cast<llhd::RefType>(ex.getType())
                       .getNestedType().getIntOrFloatBitWidth();
        }
        auto it = locals.find(base);
        if (it == locals.end())
          continue;   // drv to a non-local (module) sig: out of scope here
        auto val = resolveValueExpr(d.getValue(), prefix, registry,
                                    depth - 1, &binding, &locals);
        if (!val)
          return std::nullopt;
        std::string ve = *val;
        if (d.getEnable()) {
          auto en = resolveValueExpr(d.getEnable(), prefix, registry,
                                     depth - 1, &binding, &locals);
          if (!en)
            return std::nullopt;
          ve = "((" + *en + ") ? (" + ve + ") : (" + it->second + "))";
        }
        if (!loExpr) {
          it->second = "(" + ve + ")";
          continue;
        }
        std::string mask =
            sliceW >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                         : ("((1ULL << " + std::to_string(sliceW) + ") - 1)");
        it->second = "((((uint64_t)(" + it->second + ")) & ~(" + mask +
                     " << (" + *loExpr + "))) | ((((uint64_t)(" + ve +
                     ")) & " + mask + ") << (" + *loExpr + ")))";
        continue;
      }
    }
    return resolveValueExpr(ret.getOperand(0), prefix, registry, depth - 1,
                            &binding, &locals);
  }

  // hw.bitcast: same value, different type → pass through.  OT wraps a
  // scalar into a 1-element array to fit an array-typed port and bitcasts it
  // back (`bitcast(array_create %x : array<1xiN>) -> iN`) at the
  // tlul_adapter_sram wdata_o/wmask_o outputs — peel that too.
  if (auto bc = dyn_cast<hw::BitcastOp>(defOp)) {
    Value in = bc.getInput();
    // struct VALUE → packed integer (fields MSB-first).
    if (auto sc = in.getDefiningOp<hw::StructCreateOp>()) {
      auto st = dyn_cast<hw::StructType>(sc.getResult().getType());
      if (!st || hw::getBitWidth(st) > 128) return std::nullopt;
      auto elems = st.getElements();
      unsigned total = hw::getBitWidth(st), consumed = 0;
      bool wide = total > 64;   // >64-bit packing goes through __uint128_t
      std::string castTy = wide ? "__uint128_t" : "uint64_t";
      std::string expr;
      for (unsigned i = 0; i < elems.size(); ++i) {
        unsigned w = hw::getBitWidth(elems[i].type);
        consumed += w;
        unsigned off = total - consumed;
        auto f = sub(sc.getOperand(i));
        if (!f) return std::nullopt;
        std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL" : ("((1ULL << " + std::to_string(w) + ") - 1)");
        std::string piece = "((((" + castTy + ")((uint64_t)(" + *f + ") & " + mask + "))) << " + std::to_string(off) + ")";
        expr = expr.empty() ? piece : (expr + " | " + piece);
      }
      return "(" + expr + ")";
    }
    if (auto ac = in.getDefiningOp<hw::ArrayCreateOp>()) {
      if (ac.getNumOperands() == 1 &&
          hw::getBitWidth(ac.getOperand(0).getType()) == hw::getBitWidth(bc.getType()))
        return sub(ac.getOperand(0));
      // Multi-element integer array bitcast to an integer: pack the elements
      // MSB-first — array_create operand 0 is element N-1, which a bitcast
      // places at the top bits, exactly comb.concat's convention.
      // aes_sub_bytes's `&out_req` reduction and the control-fsm's
      // key_init_qe both take this shape.
      if (isa<IntegerType>(bc.getType()) &&
          hw::getBitWidth(bc.getType()) <= 64 &&
          isa<IntegerType>(
              cast<hw::ArrayType>(in.getType()).getElementType())) {
        unsigned total = hw::getBitWidth(bc.getType());
        unsigned elemW = cast<IntegerType>(
                             cast<hw::ArrayType>(in.getType()).getElementType())
                             .getWidth();
        unsigned n = ac.getNumOperands();
        if (elemW * n == total) {
          std::string expr;
          for (unsigned i = 0; i < n; ++i) {
            auto piece = sub(ac.getOperand(i));
            if (!piece)
              return std::nullopt;
            unsigned off = (n - 1 - i) * elemW;
            std::string mask =
                elemW >= 64
                    ? "0xFFFFFFFFFFFFFFFFULL"
                    : ("((1ULL << " + std::to_string(elemW) + ") - 1)");
            std::string term = "((((uint64_t)(" + *piece + ")) & " + mask +
                               ") << " + std::to_string(off) + ")";
            expr = expr.empty() ? term : (expr + " | " + term);
          }
          return "(" + expr + ")";
        }
      }
    }
    // Any other struct/array VALUE (a struct-typed input port, an instance
    // result, a struct_extract path) → packed integer: the per-leaf state
    // fields `<root>.<leaf>` are the source, packed MSB-first — the exact
    // inverse of the packed-int → aggregate bridge.  spi_host_command_queue's
    // `bitcast %command_i (struct port) -> i56` feeding the command FIFO.
    if (isa<hw::StructType, hw::ArrayType>(in.getType()) && isa<IntegerType>(bc.getType()) &&
        hw::getBitWidth(bc.getType()) <= 128) {
      auto root = resolveStructRootName(in);
      // struct_extract path on top of the root (e.g. bitcast(x.segment))
      std::string rootPath;
      if (!root) {
        Value cur = in;
        while (auto se = cur.getDefiningOp<hw::StructExtractOp>()) {
          rootPath = se.getFieldNameAttr().getValue().str() + (rootPath.empty() ? "" : "." + rootPath);
          cur = se.getInput();
        }
        root = resolveStructRootName(cur);
      }
      if (root) {
        unsigned total = hw::getBitWidth(bc.getType());
        int64_t cum = 0;
        std::string expr;
        bool ok = true;
        bool wide = total > 64;
        std::string castTy = wide ? "__uint128_t" : "uint64_t";
        std::string path;
        walkLeaves(in.getType(), path, [&](StringRef leaf, unsigned w) {
          if (!ok) return;
          int64_t off = (int64_t)total - cum - (int64_t)w;
          cum += w;
          std::string flat = *root;
          if (!rootPath.empty()) flat += "." + rootPath;
          if (!leaf.empty()) flat += (leaf.front() == '[' ? "" : ".") + leaf.str();
          std::string field = sanitizeName(prefixedName(flat, prefix));
          if (registry && !registry->getSignals().count(field)) { ok = false; return; }
          std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL" : ("((1ULL << " + std::to_string(w) + ") - 1)");
          std::string piece = "((((" + castTy + ")((uint64_t)(s->" + field + ") & " + mask + "))) << " + std::to_string(off) + ")";
          expr = expr.empty() ? piece : (expr + " | " + piece);
        });
        if (ok && !expr.empty()) return "(" + expr + ")";
      }
      return std::nullopt;
    }
    return sub(in);
  }

  // comb.extract %v from <lo> : (iA) -> iB
  if (auto ex = dyn_cast<comb::ExtractOp>(defOp)) {
    unsigned lowBit = ex.getLowBit();
    auto resTy = dyn_cast<IntegerType>(ex.getType());
    if (!resTy)
      return std::nullopt;
    unsigned width = resTy.getWidth();
    unsigned inputWidth = ex.getInput().getType().getIntOrFloatBitWidth();

    // DYNAMIC wide extract: `extract(shru(wide, shamt), 0) -> <=64` is the
    // importer's encoding of `data_i[sel*W +: W]` over a very wide value
    // (kmac's prim_slicer reads 32/64-bit words out of the 1600-bit Keccak
    // state).  Emit qpw_wide_extract(field, nWords, shamt, W): its
    // out-of-range => 0 behavior matches the zero-extension concat.
    if (lowBit == 0 && width <= 64 && inputWidth > 128) {
      if (auto shr = ex.getInput().getDefiningOp<comb::ShrUOp>()) {
        // -- the wide operand: peel a zero-extension concat down to a
        //    plain named field (BlockArg / instance result / probe).
        Value wide = shr.getLhs();
        if (auto cc = wide.getDefiningOp<comb::ConcatOp>()) {
          Value nonConst;
          bool zerosOnly = true;
          unsigned lowZeros = 0;
          for (unsigned oi = 0; oi < cc.getNumOperands(); ++oi) {
            Value o = cc.getOperand(oi);
            auto k = o.getDefiningOp<hw::ConstantOp>();
            if (k && k.getValue().isZero()) {
              if (nonConst) // zeros BELOW the payload shift it up
                lowZeros += o.getType().getIntOrFloatBitWidth();
              continue;
            }
            if (nonConst) { zerosOnly = false; break; }
            nonConst = o;
          }
          if (zerosOnly && nonConst && lowZeros == 0)
            wide = nonConst;
        }
        unsigned wideW = wide.getType().getIntOrFloatBitWidth();
        auto wideExpr = sub(wide);
        // -- the shift amount: peel `concat(zeros, sel, zerosLow)` into
        //    `sel << zerosLow`; a plain <=64-bit operand resolves directly.
        std::optional<std::string> shamt;
        Value sh = shr.getRhs();
        if (auto scc = sh.getDefiningOp<comb::ConcatOp>()) {
          Value payload;
          unsigned lowZ = 0;
          bool ok = true;
          for (unsigned oi = 0; oi < scc.getNumOperands(); ++oi) {
            Value o = scc.getOperand(oi);
            auto k = o.getDefiningOp<hw::ConstantOp>();
            if (k && k.getValue().isZero()) {
              if (payload)
                lowZ += o.getType().getIntOrFloatBitWidth();
              continue;
            }
            if (payload) { ok = false; break; }
            payload = o;
          }
          if (ok && payload) {
            if (auto pe = sub(payload)) {
              std::string pm = *pe;
              unsigned pw = payload.getType().getIntOrFloatBitWidth();
              if (pw < 64)   // narrow-width wraparound (see CombTranslator)
                pm = "((" + pm + ") & " +
                     std::to_string((1ULL << pw) - 1) + "ULL)";
              shamt = lowZ ? ("(((unsigned)(" + pm + ")) << " +
                              std::to_string(lowZ) + ")")
                           : ("((unsigned)(" + pm + "))");
            }
          }
        } else if (sh.getType().getIntOrFloatBitWidth() <= 64) {
          if (auto pe = sub(sh))
            shamt = "((unsigned)(" + *pe + "))";
        }
        if (wideExpr && shamt && wideW > 128) {
          // strip to a plain s->NAME so we can take the array decay
          const std::string &weS = *wideExpr;
          size_t b2 = 0, e2 = weS.size();
          while (b2 < e2 && (weS[b2] == ' ' || weS[b2] == '(')) ++b2;
          while (e2 > b2 && (weS[e2-1] == ' ' || weS[e2-1] == ')')) --e2;
          bool plain2 = (e2 - b2 >= 4 && weS.compare(b2, 3, "s->") == 0);
          for (size_t i2 = b2 + 3; plain2 && i2 < e2; ++i2) {
            char c2 = weS[i2];
            if (!(std::isalnum((unsigned char)c2) || c2 == '_')) plain2 = false;
          }
          if (plain2) {
            unsigned nWords = (wideW + 63) / 64;
            return "qpw_wide_extract(" + weS.substr(b2, e2 - b2) + ", " +
                   std::to_string(nWords) + ", " + *shamt + ", " +
                   std::to_string(width) + ")";
          }
        }
      }
    }

    // Bug G: input wider than 128 bits → storage is `uint64_t arr[N]`.
    // Mirror CombTranslator's wide-input handling: index into the
    // appropriate 64-bit word for constant-position extracts.
    if (inputWidth > 128 && width <= 64) {
      auto inner = sub(ex.getInput());
      if (!inner)
        return std::nullopt;
      // Match `s->NAME` (with optional surrounding parens).
      const std::string &innerExpr = *inner;
      size_t b = 0, e = innerExpr.size();
      while (b < e && (innerExpr[b] == ' ' || innerExpr[b] == '(')) ++b;
      while (e > b && (innerExpr[e-1] == ' ' || innerExpr[e-1] == ')')) --e;
      bool plain = (e - b >= 4 && innerExpr.compare(b, 3, "s->") == 0);
      for (size_t i = b + 3; plain && i < e; ++i) {
        char c = innerExpr[i];
        if (!(std::isalnum((unsigned char)c) || c == '_')) plain = false;
      }
      if (plain) {
        std::string sigName = innerExpr.substr(b + 3, e - b - 3);
        unsigned wordLo = lowBit / 64;
        unsigned bitLo  = lowBit % 64;
        unsigned wordHi = (lowBit + width - 1) / 64;
        uint64_t mask = (width >= 64) ? ~uint64_t(0)
                                      : ((uint64_t(1) << width) - 1);
        if (wordLo == wordHi) {
          if (bitLo == 0) {
            return "((s->" + sigName + "[" + std::to_string(wordLo) +
                   "]) & 0x" + llvm::utohexstr(mask) + "ULL)";
          }
          return "(((s->" + sigName + "[" + std::to_string(wordLo) +
                 "]) >> " + std::to_string(bitLo) + ") & 0x" +
                 llvm::utohexstr(mask) + "ULL)";
        }
        unsigned hiBits = (lowBit + width) - wordHi * 64;
        unsigned loBits = width - hiBits;
        return "((((s->" + sigName + "[" + std::to_string(wordLo) +
               "]) >> " + std::to_string(bitLo) + ") | "
               "((s->" + sigName + "[" + std::to_string(wordHi) +
               "]) << " + std::to_string(loBits) + ")) & 0x" +
               llvm::utohexstr(mask) + "ULL)";
      }
      // Cross-fall-through: bridge translator can't synthesise a
      // wide-input extract from a non-plain expression.
      return std::nullopt;
    }

    auto inner = sub(ex.getInput());
    if (!inner)
      return std::nullopt;
    if (width >= 64)
      return "((" + *inner + ") >> " + std::to_string(lowBit) + ")";
    uint64_t mask = (uint64_t(1) << width) - 1;
    return "(((" + *inner + ") >> " + std::to_string(lowBit) +
           ") & 0x" + llvm::utohexstr(mask) + ")";
  }

  // comb.concat %a, %b, ... — first operand is MSBs.
  if (auto cc = dyn_cast<comb::ConcatOp>(defOp)) {
    SmallVector<std::string> pieces;
    SmallVector<unsigned> widths;
    for (Value operand : cc.getOperands()) {
      auto r = sub(operand);
      if (!r)
        return std::nullopt;
      auto intTy = dyn_cast<IntegerType>(operand.getType());
      if (!intTy)
        return std::nullopt;
      pieces.push_back(*r);
      widths.push_back(intTy.getWidth());
    }
    // Total packed width determines the cast type.  Any concat whose
    // result is wider than 64 bits (e.g. spi_host's tlul_socket_1n
    // request fifo packs the full 95-bit a_* tuple) needs a 128-bit
    // intermediate or the upper-bit shifts (offset >= 64) become C UB
    // and silently produce 0.  GCC/Clang's __uint128_t is the
    // portable-enough intermediate; QEMU is already built with one of
    // those compilers.
    unsigned totalWidth = 0;
    for (unsigned w : widths) totalWidth += w;
    const char *castTy = (totalWidth > 64) ? "__uint128_t" : "uint64_t";
    // Place last piece at LSBs, walk MSB-ward.
    unsigned offset = 0;
    std::string result;
    for (size_t i = pieces.size(); i-- > 0;) {
      std::string term = std::string("(((") + castTy + ")(" + pieces[i] +
                          ")) << " + std::to_string(offset) + ")";
      result = result.empty() ? term : ("(" + result + " | " + term + ")");
      offset += widths[i];
    }
    return result;
  }

  // n-ary bitwise: comb.and / comb.or / comb.xor
  auto naryBit = [&](Operation *op, const char *cOp) -> std::optional<std::string> {
    std::string r;
    for (unsigned i = 0; i < op->getNumOperands(); ++i) {
      auto piece = sub(op->getOperand(i));
      if (!piece)
        return std::nullopt;
      if (i)
        r += " ";
      r += i ? (std::string(cOp) + " (" + *piece + ")") : ("(" + *piece + ")");
    }
    return "(" + r + ")";
  };
  if (auto andOp = dyn_cast<comb::AndOp>(defOp))
    return naryBit(andOp, "&");
  if (auto orOp = dyn_cast<comb::OrOp>(defOp))
    return naryBit(orOp, "|");
  if (auto xorOp = dyn_cast<comb::XorOp>(defOp))
    return naryBit(xorOp, "^");
  // comb.parity (gray-code pointer sync in prim_fifo_async): XOR-reduce.
  // Same >64-bit truncation trap as the translator's parity site — see
  // comb_translator::parityFold.
  if (auto parOp = dyn_cast<comb::ParityOp>(defOp)) {
    auto in = sub(parOp.getInput());
    if (!in) return std::nullopt;
    std::string pf = comb_translator::parityFold(
        *in, parOp.getInput().getType().getIntOrFloatBitWidth());
    if (pf.empty()) return std::nullopt;   // no exact fold: refuse, loudly
    return pf;
  }

  // comb.icmp predicate %a, %b
  if (auto cmp = dyn_cast<comb::ICmpOp>(defOp)) {
    unsigned operandWidth =
        cmp.getLhs().getType().getIntOrFloatBitWidth();
    auto lhs = sub(cmp.getLhs());
    auto rhs = sub(cmp.getRhs());
    if (!lhs || !rhs)
      return std::nullopt;
    // Bug G: wide operands (>128 bits) live as `uint64_t arr[N]`.
    // For eq/ne against literals, OR-reduce the array.
    if (operandWidth > 128) {
      if (getenv("QP_DEBUG_BRIDGE"))
        llvm::errs() << "  [WIDE-ICMP] lhs=" << (lhs ? *lhs : "<fail>")
                     << " rhs=" << (rhs ? *rhs : "<fail>") << "\n";
      auto pred = cmp.getPredicate();
      bool isEq = (pred == comb::ICmpPredicate::eq) || (pred == comb::ICmpPredicate::ceq) ||
                  (pred == comb::ICmpPredicate::weq);
      bool isNe = (pred == comb::ICmpPredicate::ne) || (pred == comb::ICmpPredicate::cne) ||
                  (pred == comb::ICmpPredicate::wne);
      if (!(isEq || isNe))
        return std::nullopt;
      // lhs must be a plain `s->NAME` and rhs must not reference state.
      const std::string &lhsExpr = *lhs;
      size_t b = 0, e = lhsExpr.size();
      while (b < e && (lhsExpr[b] == ' ' || lhsExpr[b] == '(')) ++b;
      while (e > b && (lhsExpr[e-1] == ' ' || lhsExpr[e-1] == ')')) --e;
      bool plain = (e - b >= 4 && lhsExpr.compare(b, 3, "s->") == 0);
      for (size_t i = b + 3; plain && i < e; ++i) {
        char c = lhsExpr[i];
        if (!(std::isalnum((unsigned char)c) || c == '_')) plain = false;
      }
      if (!plain)
        return std::nullopt;
      std::string sigName = lhsExpr.substr(b + 3, e - b - 3);
      unsigned nWords = (operandWidth + 63) / 64;
      const char *cop = isEq ? "==" : "!=";
      // Case 1: rhs is another plain wide field — word-wise compare.
      {
        const std::string &r = *rhs;
        size_t b2 = 0, e2 = r.size();
        while (b2 < e2 && (r[b2] == ' ' || r[b2] == '(')) ++b2;
        while (e2 > b2 && (r[e2-1] == ' ' || r[e2-1] == ')')) --e2;
        bool plainR = (e2 - b2 >= 4 && r.compare(b2, 3, "s->") == 0);
        for (size_t i = b2 + 3; plainR && i < e2; ++i)
          if (!(std::isalnum((unsigned char)r[i]) || r[i] == '_'))
            plainR = false;
        if (plainR) {
          std::string rName = r.substr(b2 + 3, e2 - b2 - 3);
          std::string cmpE;
          for (unsigned i = 0; i < nWords; ++i)
            cmpE += std::string(i ? " & " : "") + "(s->" + sigName + "[" +
                    std::to_string(i) + "] == s->" + rName + "[" +
                    std::to_string(i) + "])";
          return isEq ? "(" + cmpE + ")" : "(!(" + cmpE + "))";
        }
      }
      if (rhs->find("s->") != std::string::npos)
        return std::nullopt;
      // Case 2: rhs is a wide hex literal (>16 digits) — per-word compare.
      {
        std::string lit = *rhs;
        size_t b3 = 0, e3 = lit.size();
        while (b3 < e3 && (lit[b3] == ' ' || lit[b3] == '(')) ++b3;
        while (e3 > b3 && (lit[e3-1] == ' ' || lit[e3-1] == ')')) --e3;
        std::string t = lit.substr(b3, e3 - b3);
        if (t.size() > 18 && t.compare(0, 2, "0x") == 0) {
          std::string hex = t.substr(2);
          while (!hex.empty() && (hex.back() == 'U' || hex.back() == 'L' ||
                                  hex.back() == 'u' || hex.back() == 'l'))
            hex.pop_back();
          bool okHex = true;
          for (char hc : hex)
            if (!std::isxdigit((unsigned char)hc)) okHex = false;
          if (okHex) {
            while (hex.size() < 16 * nWords) hex.insert(hex.begin(), '0');
            std::string cmpE;
            for (unsigned i = 0; i < nWords; ++i)
              cmpE += std::string(i ? " & " : "") + "(s->" + sigName + "[" +
                      std::to_string(i) + "] == 0x" +
                      hex.substr(hex.size() - 16 * (i + 1), 16) + "ULL)";
            return isEq ? "(" + cmpE + ")" : "(!(" + cmpE + "))";
          }
        }
      }
      // Case 3: compare against "-1" (all-ones) — word-wise AND of
      // equalities (an OR-reduce equal to ~0 does NOT mean every word
      // is ~0; keymgr's key_chk "!= all-ones" hit this).
      {
        std::string t2 = *rhs;
        while (t2.size() >= 2 && t2.front() == '(' && t2.back() == ')')
          t2 = t2.substr(1, t2.size() - 2);
        if (t2 == "-1") {
          std::string andE;
          for (unsigned i = 0; i < nWords; ++i)
            andE += std::string(i ? " & " : "") + "(s->" + sigName + "[" +
                    std::to_string(i) + "] == 0xFFFFFFFFFFFFFFFFULL)";
          return isEq ? "(" + andE + ")" : "(!(" + andE + "))";
        }
      }
      // Case 4 (historical): narrow literal (usually 0) — OR-reduce.
      std::string orExpr = "s->" + sigName + "[0]";
      for (unsigned i = 1; i < nWords; ++i) {
        orExpr = "(" + orExpr + " | s->" + sigName + "[" +
                 std::to_string(i) + "])";
      }
      return "((" + orExpr + ") " + std::string(cop) + " (" + *rhs + "))";
    }
    const char *cOp = nullptr;
    bool isSigned = false;
    switch (cmp.getPredicate()) {
      case comb::ICmpPredicate::eq:  cOp = "=="; break;
      case comb::ICmpPredicate::ne:  cOp = "!="; break;
      case comb::ICmpPredicate::ceq: cOp = "=="; break;   // 4-state ===  (no X/Z here)
      case comb::ICmpPredicate::cne: cOp = "!="; break;
      case comb::ICmpPredicate::weq: cOp = "=="; break;   // wildcard ==?
      case comb::ICmpPredicate::wne: cOp = "!="; break;
      case comb::ICmpPredicate::ult: cOp = "<";  break;
      case comb::ICmpPredicate::ule: cOp = "<="; break;
      case comb::ICmpPredicate::ugt: cOp = ">";  break;
      case comb::ICmpPredicate::uge: cOp = ">="; break;
      case comb::ICmpPredicate::slt: cOp = "<";  isSigned = true; break;
      case comb::ICmpPredicate::sle: cOp = "<="; isSigned = true; break;
      case comb::ICmpPredicate::sgt: cOp = ">";  isSigned = true; break;
      case comb::ICmpPredicate::sge: cOp = ">="; isSigned = true; break;
      default: return std::nullopt;
    }
    if (isSigned) {
      return "(((int64_t)(" + *lhs + ")) " + std::string(cOp) +
             " ((int64_t)(" + *rhs + ")))";
    }
    return "((" + *lhs + ") " + std::string(cOp) + " (" + *rhs + "))";
  }

  // arith.select %c, %t, %f on integer values (Moore's lowering of an
  // if/else with constant arms) — same as comb.mux.
  if (auto sel = dyn_cast<mlir::arith::SelectOp>(defOp)) {
    if (!isa<IntegerType>(sel.getType())) return std::nullopt;
    auto c = sub(sel.getCondition());
    auto tv = sub(sel.getTrueValue());
    auto fv = sub(sel.getFalseValue());
    if (!c || !tv || !fv) return std::nullopt;
    return "((" + *c + ") ? (" + *tv + ") : (" + *fv + "))";
  }

  // comb.mux %sel, %t, %f
  if (auto mux = dyn_cast<comb::MuxOp>(defOp)) {
    auto sel = sub(mux.getCond());
    auto tv  = sub(mux.getTrueValue());
    auto fv  = sub(mux.getFalseValue());
    if (!sel || !tv || !fv)
      return std::nullopt;
    return "((" + *sel + ") ? (" + *tv + ") : (" + *fv + "))";
  }

  // Shifts (left, logical right)
  if (auto shl = dyn_cast<comb::ShlOp>(defOp)) {
    auto a = sub(shl.getLhs());
    auto n = sub(shl.getRhs());
    if (!a || !n) return std::nullopt;
    return "((" + *a + ") << (" + *n + "))";
  }
  if (auto shru = dyn_cast<comb::ShrUOp>(defOp)) {
    // Bug G: don't try to scalar-shift a wide-array operand.
    if (shru.getLhs().getType().getIntOrFloatBitWidth() > 128)
      return std::nullopt;
    auto a = sub(shru.getLhs());
    auto n = sub(shru.getRhs());
    if (!a || !n) return std::nullopt;
    return "((" + *a + ") >> (" + *n + "))";
  }

  // Arithmetic — handle the common ones (n-ary add/mul, binary sub).
  // Sufficient for OT control / decode paths.
  if (auto addOp = dyn_cast<comb::AddOp>(defOp)) {
    // qemu.pump_acc_operand (AccumulateRingDetect): accumulate ring — every
    // non-accumulator operand is the step, gated by the pump pulse.
    if (auto acc = addOp->getAttrOfType<IntegerAttr>("qemu.pump_acc_operand")) {
      std::string out;
      for (unsigned i = 0; i < addOp.getNumOperands(); ++i) {
        auto o = sub(addOp.getOperand(i));
        if (!o) return std::nullopt;
        if (i) out += " + ";
        out += ((int)i == (int)acc.getInt()) ? ("(" + *o + ")")
                                             : ("((s->_qp_pump) ? (" + *o + ") : 0)");
      }
      return "(" + out + ")";
    }
    return naryBit(addOp, "+");
  }
  if (auto subOp = dyn_cast<comb::SubOp>(defOp)) {
    auto a = sub(subOp.getLhs());
    auto b = sub(subOp.getRhs());
    if (!a || !b) return std::nullopt;
    if (subOp->hasAttr("qemu.pump_acc_operand"))
      return "((" + *a + ") - ((s->_qp_pump) ? (" + *b + ") : 0))";
    return "((" + *a + ") - (" + *b + "))";
  }
  if (auto mulOp = dyn_cast<comb::MulOp>(defOp))
    return naryBit(mulOp, "*");

  // comb.replicate %v : (iA) -> iB  --  concatenate `mult = B/A` copies
  // of v.  prim_intr_hw uses replicate(qe_i, i1->i32) as an AND-mask, so
  // we MUST handle it on output-bridge paths.
  if (auto rep = dyn_cast<comb::ReplicateOp>(defOp)) {
    auto inner = sub(rep.getInput());
    if (!inner)
      return std::nullopt;
    auto inTy = dyn_cast<IntegerType>(rep.getInput().getType());
    auto outTy = dyn_cast<IntegerType>(rep.getType());
    if (!inTy || !outTy)
      return std::nullopt;
    unsigned a = inTy.getWidth();
    unsigned b = outTy.getWidth();
    if (a == 0 || b == 0 || (b % a) != 0)
      return std::nullopt;
    unsigned mult = b / a;
    if (mult == 1)
      return inner;
    if (a == 1) {
      // 0/1 → 0/all-ones via two's-complement negation.
      if (b >= 64)
        return "(0 - ((uint64_t)(" + *inner + ")))";
      uint64_t mask = (uint64_t(1) << b) - 1;
      return "((0 - ((uint64_t)(" + *inner + "))) & 0x" +
             llvm::utohexstr(mask) + ")";
    }
    // General A>1 case: OR of shifted, masked copies.
    uint64_t maskA = (a >= 64) ? ~uint64_t(0)
                                : ((uint64_t(1) << a) - 1);
    std::string base = "(((uint64_t)(" + *inner + ")) & 0x" +
                       llvm::utohexstr(maskA) + ")";
    std::string result;
    for (unsigned i = 0; i < mult; ++i) {
      std::string term = "(" + base + " << " + std::to_string(i * a) + ")";
      result = result.empty() ? term : ("(" + result + " | " + term + ")");
    }
    return result;
  }

  // Unhandled: array_get / parity / signed shifts —
  // currently rare on output-port-driving paths in OT.  Fall through.
  return std::nullopt;
}

/// Walk every leaf integer field beneath a (possibly nested) hw struct
/// or array type, calling `cb(leafPath, bitWidth)` once per leaf.
/// `leafPath` accumulates as a dotted (or `[idx]`-bracketed) path —
/// callers run sanitizeName on the joined result to produce a flat
/// state-struct field name.
static void walkLeaves(Type ty,
                       std::string &path,
                       llvm::function_ref<void(StringRef, unsigned)> cb) {
  if (auto intTy = dyn_cast<IntegerType>(ty)) {
    cb(path, intTy.getWidth());
    return;
  }
  if (auto stTy = dyn_cast<hw::StructType>(ty)) {
    for (auto &f : stTy.getElements()) {
      size_t before = path.size();
      if (!path.empty()) path += ".";
      path += f.name.getValue().str();
      walkLeaves(f.type, path, cb);
      path.resize(before);
    }
    return;
  }
  if (auto arrTy = dyn_cast<hw::ArrayType>(ty)) {
    for (size_t i = 0; i < arrTy.getNumElements(); ++i) {
      size_t before = path.size();
      path += "[" + std::to_string(i) + "]";
      walkLeaves(arrTy.getElementType(), path, cb);
      path.resize(before);
    }
    return;
  }
  // Other types (LLHD signals seen here would already be unwrapped):
  // skip silently.
}

/// Compute the caller-side root-name component of a struct/array
/// operand — i.e. the name string that, combined with a leaf path,
/// names the flat per-leaf state-struct field for that leaf.
///
/// Handles the two operand shapes that actually carry whole struct
/// values across hw.instance boundaries in our IR:
///   - BlockArgument of a struct-typed module port      -> "<port_name>"
///   - hw.instance result of a struct-typed output port -> "<inst>_<port>"
/// Returns std::nullopt for anything else (e.g. hw.struct_create
/// aggregations that we'd have to recursively trace per-field —
/// deferred to a follow-up).
static std::optional<std::string>
resolveStructRootName(Value v) {
  if (auto ba = dyn_cast<BlockArgument>(v)) {
    auto parent = ba.getOwner()->getParentOp();
    if (auto hwMod = dyn_cast<hw::HWModuleOp>(parent)) {
      // Same input-only-index issue as resolveValueExpr's BlockArg
      // branch — walk inputs in order, pick the argNumber-th.
      unsigned idx = ba.getArgNumber();
      unsigned inputIdx = 0;
      for (const auto &p : hwMod.getPortList()) {
        if (p.dir != hw::ModulePort::Direction::Input)
          continue;
        if (inputIdx == idx)
          return p.getName().str();
        ++inputIdx;
      }
    }
    return std::nullopt;
  }
  if (auto inst = v.getDefiningOp<hw::InstanceOp>()) {
    if (auto opResult = dyn_cast<OpResult>(v)) {
      unsigned idx = opResult.getResultNumber();
      auto names = inst.getResultNames();
      if (idx < names.size()) {
        if (auto strAttr = dyn_cast<StringAttr>(names[idx])) {
          return inst.getInstanceName().str() + "_" +
                 strAttr.getValue().str();
        }
      }
    }
    return std::nullopt;
  }
  // llhd.prb of a named signal: the root is the signal's name (peeling
  // sig_extract wrappers).  sysrst_ctrl feeds prim_intr_hw with
  // struct_extract(prb(%reg2hw-ish sig)) shapes.
  if (auto prb = v.getDefiningOp<llhd::ProbeOp>()) {
    Value sig = prb.getSignal();
    while (auto ex = sig.getDefiningOp<llhd::SigExtractOp>())
      sig = ex.getInput();
    if (auto sigOp = sig.getDefiningOp<llhd::SignalOp>())
      if (sigOp.getName() && !sigOp.getName()->empty())
        return sigOp.getName()->str();
    return std::nullopt;
  }
  // hw.struct_extract: recurse into the input and append the field name
  // (dot between adjacent names — the same convention walkLeaves uses;
  // never a dot before a bracket).
  if (auto se = v.getDefiningOp<hw::StructExtractOp>()) {
    if (!isa<hw::StructType>(se->getOperand(0).getType()))
      return std::nullopt;
    auto inner = resolveStructRootName(se->getOperand(0));
    if (!inner)
      return std::nullopt;
    return *inner + "." + se.getFieldNameAttr().getValue().str();
  }
  // hw.array_get with a constant index: root[i].
  if (auto ag = v.getDefiningOp<hw::ArrayGetOp>()) {
    auto idxC = ag.getIndex().getDefiningOp<hw::ConstantOp>();
    if (!idxC)
      return std::nullopt;
    auto inner = resolveStructRootName(ag.getInput());
    if (!inner)
      return std::nullopt;
    return *inner + "[" +
           std::to_string(idxC.getValue().getZExtValue()) + "]";
  }
  return std::nullopt;
}

/// Resolve a struct/array operand into a list of (relative leaf path, C
/// expression, bit width) triples — one per integer leaf inside `ty`.
///
/// This is the per-leaf bridge resolver.  Compared with the older
/// `resolveStructRootName + walkLeaves` pair, this helper handles cases
/// where the operand is constructed inline by `hw.struct_create` (or is
/// an all-zero `hw.bitcast` filler), which previously fell through and
/// caused the bridge to be skipped.  In OT's UART, that skip silenced
/// the path `u_reg_if.tl_o_pre → u_rsp_intg_gen.tl_i → u_rsp_intg_gen.tl_o
/// → u_reg.tl_o`, so the read-side mux output never reached the BIP
/// rdata field.
///
/// Returned `leafPath` strings are relative to the enclosing port name
/// (i.e. they're the same dotted form that `walkLeaves` would yield).
/// Callers prepend `pi.name` and the instance-path prefix to produce
/// the flat state-struct field name.
///
/// On any unresolvable leaf, `ok` is set false and `leaves` is cleared,
/// signalling the caller to fall through (preserving the pre-existing
/// "skip the bridge" behaviour, no regression).
struct LeafEmit {
  bool ok = true;
  struct Entry {
    std::string leafPath;  // path relative to the port root, "" for whole
    std::string exprC;     // direct C expression; never wrapped further
    unsigned width;
    int wordIndex = -1;    // >=0: this entry writes word k of a WIDE leaf
  };
  llvm::SmallVector<Entry, 16> leaves;
};

// Forward decl — used in the recursion below.
static std::optional<std::string> resolveStructRootName(Value v);

/// Project bits [off, off+w) (w <= 64) of a wide packed VALUE into a C
/// expression, understanding the importer spellings: bitcast wrappers,
/// muxes, concats (first operand = MSBs), replicate broadcasts, and
/// anything resolveValueExpr can name (plain wide fields via
/// qpw_wide_extract; narrow scalars via shift/mask).
static std::optional<std::string>
wideProjectExpr(Value v, unsigned off, unsigned w, llvm::StringRef prefix,
                FlatSignalRegistry &registry) {
  if (w == 0 || w > 64) return std::nullopt;
  if (auto vb = v.getDefiningOp<hw::BitcastOp>())
    return wideProjectExpr(vb.getInput(), off, w, prefix, registry);
  // Constant of ANY width: the window comes straight from the APInt
  // (csrng's state_db read gate muxes against a 418-bit all-zero arm —
  // the >64-bit constant used to sink the whole projection).
  if (auto vk = v.getDefiningOp<hw::ConstantOp>()) {
    APInt val = vk.getValue();
    uint64_t bits = 0;
    if (off < val.getBitWidth()) {
      APInt win = val.lshr(off);
      bits = win.getBitWidth() > 64 ? win.trunc(64).getZExtValue()
                                    : win.getZExtValue();
    }
    if (w < 64)
      bits &= ((1ULL << w) - 1);
    char kbuf[32];
    (void)snprintf(kbuf, sizeof kbuf, "0x%llxULL", (unsigned long long)bits);
    return std::string(kbuf);
  }
  if (auto vm = v.getDefiningOp<comb::MuxOp>()) {
    auto c = resolveValueExpr(vm.getCond(), prefix, &registry);
    if (!c) return std::nullopt;
    auto a = wideProjectExpr(vm.getTrueValue(), off, w, prefix, registry);
    auto b = wideProjectExpr(vm.getFalseValue(), off, w, prefix, registry);
    if (!a || !b) return std::nullopt;
    return "((" + *c + ") ? " + *a + " : " + *b + ")";
  }
  // comb.extract: shift the window by the constant low bit.
  if (auto ve = v.getDefiningOp<comb::ExtractOp>())
    return wideProjectExpr(ve.getInput(), off + ve.getLowBit(), w, prefix,
                           registry);
  // Pointwise bitwise ops: project every operand at the same window
  // (lc_ctrl's hashed token = digest_share0[127:0] ^ share1[127:0]).
  if (v.getDefiningOp<comb::XorOp>() || v.getDefiningOp<comb::AndOp>() ||
      v.getDefiningOp<comb::OrOp>()) {
    Operation *bop = v.getDefiningOp();
    const char *sym = isa<comb::XorOp>(bop) ? " ^ "
                      : isa<comb::AndOp>(bop) ? " & " : " | ";
    std::string acc;
    for (Value o : bop->getOperands()) {
      auto pe = wideProjectExpr(o, off, w, prefix, registry);
      if (!pe) return std::nullopt;
      acc += (acc.empty() ? "" : sym) + ("(" + *pe + ")");
    }
    return "(" + acc + ")";
  }
  if (auto vc = v.getDefiningOp<comb::ConcatOp>()) {
    // first operand = most significant.  A window inside one operand
    // recurses directly; a window straddling seams is stitched shift-OR
    // wise from every overlapping operand (csrng block_encrypt's
    // rsp_data_o is a concat of 16 i8 AES state bytes — every 64-bit
    // word spans eight of them).
    unsigned hi = v.getType().getIntOrFloatBitWidth();
    std::string acc;
    bool okAll = true;
    for (Value o : vc.getOperands()) {
      unsigned ow = o.getType().getIntOrFloatBitWidth();
      unsigned lo = hi - ow;
      if (off >= lo && off + w <= hi)
        return wideProjectExpr(o, off - lo, w, prefix, registry);
      // overlap of [off, off+w) with [lo, hi)
      unsigned ovLo = std::max(off, lo), ovHi = std::min(off + w, hi);
      if (okAll && ovLo < ovHi) {
        auto pe = wideProjectExpr(o, ovLo - lo, ovHi - ovLo, prefix,
                                  registry);
        if (!pe)
          okAll = false;
        else
          acc += (acc.empty() ? "" : " | ") +
                 ("(((uint64_t)(" + *pe + ")) << " +
                  std::to_string(ovLo - off) + ")");
      }
      hi = lo;
    }
    if (okAll && !acc.empty())
      return "(" + acc + ")";
    return std::nullopt;
  }
  if (auto vr = v.getDefiningOp<comb::ReplicateOp>()) {
    unsigned rw = vr.getInput().getType().getIntOrFloatBitWidth();
    unsigned lo = off % rw;
    auto ie = resolveValueExpr(vr.getInput(), prefix, &registry);
    if (!ie) return std::nullopt;
    std::string unit = "((uint64_t)(" + *ie + "))";
    if (lo + w <= rw) {
      std::string e2 = unit;
      if (lo) e2 = "(" + e2 + " >> " + std::to_string(lo) + ")";
      if (w < 64)
        e2 = "(" + e2 + " & ((1ULL << " + std::to_string(w) + ") - 1))";
      return "(" + e2 + ")";
    }
    // Window spans several copies of the unit: aligned repetition
    // (the 64-bit word of a 32-bit broadcast is unit | unit<<32).
    if (lo == 0 && w % rw == 0 && rw < 64) {
      std::string e2;
      for (unsigned k = 0; k * rw < w; ++k)
        e2 += (k ? " | " : "") + ("(" + unit + " << " +
                                  std::to_string(k * rw) + ")");
      return "(" + e2 + ")";
    }
    return std::nullopt;
  }
  if (auto kc = v.getDefiningOp<hw::ConstantOp>()) {
    uint64_t wv = kc.getValue().extractBitsAsZExtValue(w, off);
    return std::to_string(wv) + "ULL";
  }
  if (auto vac = v.getDefiningOp<hw::ArrayCreateOp>()) {
    // operand 0 = HIGHEST index element
    int64_t eb = hw::getBitWidth(
        cast<hw::ArrayType>(vac.getType()).getElementType());
    if (eb <= 0) return std::nullopt;
    unsigned n = vac.getNumOperands();
    unsigned idx = off / (unsigned)eb;
    if (idx >= n || (off % eb) + w > (unsigned)eb) return std::nullopt;
    return wideProjectExpr(vac.getOperand(n - 1 - idx), off % eb, w,
                           prefix, registry);
  }
  if (auto vg = v.getDefiningOp<hw::ArrayGetOp>()) {
    int64_t eb = hw::getBitWidth(vg.getType());
    if (eb > 0) {
      if (auto kc2 = vg.getIndex().getDefiningOp<hw::ConstantOp>())
        return wideProjectExpr(
            vg.getInput(),
            off + (unsigned)(kc2.getValue().getZExtValue() * eb), w, prefix,
            registry);
      auto arT = dyn_cast<hw::ArrayType>(vg.getInput().getType());
      if (arT && arT.getNumElements() >= 2 && arT.getNumElements() <= 8) {
        auto ie = resolveValueExpr(vg.getIndex(), prefix, &registry);
        if (ie) {
          unsigned nEl = arT.getNumElements();
          SmallVector<std::string> arms;
          bool okA = true;
          for (unsigned k = 0; k < nEl && okA; ++k) {
            auto a = wideProjectExpr(vg.getInput(),
                                     off + k * (unsigned)eb, w, prefix,
                                     registry);
            if (!a) okA = false;
            else arms.push_back(*a);
          }
          if (okA) {
            std::string e5 = arms[nEl - 1];
            for (int k = (int)nEl - 2; k >= 0; --k)
              e5 = "((((unsigned)(" + *ie + ")) == " + std::to_string(k) +
                   "u) ? " + arms[k] + " : " + e5 + ")";
            return e5;
          }
        }
      }
    }
    return std::nullopt;
  }
  if (auto vsc = v.getDefiningOp<hw::StructCreateOp>()) {
    // first struct field = MSBs
    auto stTy = cast<hw::StructType>(vsc.getType());
    unsigned hi = (unsigned)hw::getBitWidth(stTy);
    auto flds = stTy.getElements();
    for (size_t i = 0; i < flds.size(); ++i) {
      int64_t fw = hw::getBitWidth(flds[i].type);
      if (fw <= 0) return std::nullopt;
      unsigned lo = hi - (unsigned)fw;
      if (off >= lo && off + w <= hi)
        return wideProjectExpr(vsc.getOperand(i), off - lo, w, prefix,
                               registry);
      hi = lo;
    }
    return std::nullopt;
  }
  if (auto vx = v.getDefiningOp<comb::XorOp>()) {
    std::string r2;
    for (Value o : vx.getOperands()) {
      auto oe = wideProjectExpr(o, off, w, prefix, registry);
      if (!oe) return std::nullopt;
      r2 += (r2.empty() ? "" : " ^ ") + *oe;
    }
    return "(" + r2 + ")";
  }
  auto vint = dyn_cast<IntegerType>(v.getType());
  if (!vint) {
    // Named aggregate root (instance result / input port / prb of a named
    // sig): map the LSB window [off, off+w) onto the covering leaf
    // field(s).  Leaves are packed MSB-first (first leaf = MSBs); a window
    // that straddles one leaf boundary is stitched from both sides.
    // First users: csrng's state_db read path (prb of an aggregate sig
    // array) and block_encrypt's AES state bytes (instance-result
    // aggregate walked byte-wise).
    if (isa<hw::StructType, hw::ArrayType>(v.getType())) {
      auto root = resolveStructRootName(v);
      if (!root)
        return std::nullopt;
      struct PLeaf { std::string path; int64_t lsbLo; unsigned w; };
      std::vector<PLeaf> pls;
      {
        int64_t cum = 0;
        std::string p0;
        walkLeaves(v.getType(), p0, [&](StringRef lp, unsigned lw) {
          pls.push_back({lp.str(), 0, lw});
          cum += lw;
        });
        // convert declaration order (MSB-first) to LSB offsets
        int64_t hi = cum;
        for (auto &pl : pls) { pl.lsbLo = hi - (int64_t)pl.w; hi -= pl.w; }
      }
      auto leafWindow = [&](const PLeaf &pl, unsigned lo,
                            unsigned ww) -> std::string {
        // bits [lo, lo+ww) WITHIN this leaf (LSB-relative)
        std::string field = sanitizeName(prefixedName(
            *root + (pl.path.empty()
                         ? ""
                         : ((pl.path.front() == '[' ? "" : ".") + pl.path)),
            prefix));
        std::string mask = ww >= 64 ? std::string("0xFFFFFFFFFFFFFFFFULL")
                                    : ("((1ULL << " + std::to_string(ww) +
                                       ") - 1)");
        if (pl.w > 128)
          return "qpw_wide_extract(s->" + field + ", " +
                 std::to_string((pl.w + 63) / 64) + ", " +
                 std::to_string(lo) + ", " + std::to_string(ww) + ")";
        if (pl.w > 64)
          return "((uint64_t)(((__uint128_t)(s->" + field + ")) >> " +
                 std::to_string(lo) + ") & " + mask + ")";
        return "((((uint64_t)(s->" + field + ")) >> " + std::to_string(lo) +
               ") & " + mask + ")";
      };
      for (size_t i = 0; i < pls.size(); ++i) {
        const auto &pl = pls[i];
        int64_t lsbHi = pl.lsbLo + (int64_t)pl.w;
        if ((int64_t)off >= pl.lsbLo && (int64_t)(off + w) <= lsbHi)
          return leafWindow(pl, (unsigned)(off - pl.lsbLo), w);
        if ((int64_t)off >= pl.lsbLo && (int64_t)off < lsbHi &&
            (int64_t)(off + w) > lsbHi && i > 0) {
          // straddles into the NEXT-more-significant leaf (pls[i-1])
          unsigned loW = (unsigned)(lsbHi - (int64_t)off);
          unsigned hiW = w - loW;
          const auto &ph = pls[i - 1];
          if (ph.lsbLo != lsbHi || hiW > ph.w)
            return std::nullopt;
          std::string loE = leafWindow(pl, (unsigned)(off - pl.lsbLo), loW);
          std::string hiE = leafWindow(ph, 0, hiW);
          return "((" + loE + ") | ((" + hiE + ") << " +
                 std::to_string(loW) + "))";
        }
      }
      return std::nullopt;
    }
    return std::nullopt;
  }
  unsigned vw = vint.getWidth();
  auto e = resolveValueExpr(v, prefix, &registry);
  if (!e) return std::nullopt;
  if (vw > 64) {
    const std::string &r = *e;
    size_t b2 = 0, e2i = r.size();
    while (b2 < e2i && (r[b2] == ' ' || r[b2] == '(')) ++b2;
    while (e2i > b2 && (r[e2i-1] == ' ' || r[e2i-1] == ')')) --e2i;
    bool plainS = (e2i - b2 >= 4 && r.compare(b2, 3, "s->") == 0);
    for (size_t i2 = b2 + 3; plainS && i2 < e2i; ++i2)
      if (!(std::isalnum((unsigned char)r[i2]) || r[i2] == '_'))
        plainS = false;
    if (!plainS) return std::nullopt;
    if (vw <= 128) {
      std::string x = "(((__uint128_t)" + r.substr(b2, e2i - b2) + ") >> " +
                      std::to_string(off) + ")";
      std::string m = w < 64 ? ("((1ULL << " + std::to_string(w) + ") - 1)")
                             : std::string("0xFFFFFFFFFFFFFFFFULL");
      return "((uint64_t)" + x + " & " + m + ")";
    }
    return "qpw_wide_extract(" + r.substr(b2, e2i - b2) + ", " +
           std::to_string((vw + 63) / 64) + ", " + std::to_string(off) +
           ", " + std::to_string(w) + ")";
  }
  std::string e3 = "((uint64_t)(" + *e + "))";
  if (off) e3 = "(" + e3 + " >> " + std::to_string(off) + ")";
  if (w < 64)
    e3 = "(" + e3 + " & ((1ULL << " + std::to_string(w) + ") - 1))";
  return "(" + e3 + ")";
}

static void walkBridgeLeavesRec(Type ty, Value operand,
                                 llvm::StringRef prefix,
                                 FlatSignalRegistry &registry,
                                 std::string &leafPath,
                                 LeafEmit &out) {
  if (!out.ok)
    return;

  // ---------- aggregate <-> aggregate bitcast (field renaming) ----
  // The importer spells protocol-struct conversions as an equal-width
  // bitcast (lc_ctrl: `esc_rx_t {resp_p,resp_n}` viewed as
  // `esc_tx_t {esc_p,esc_n}` feeding prim_esc_receiver).  Map each
  // destination leaf to the SOURCE leaf covering the same bit window
  // (MSB-first packing on both sides) and recurse on that leaf's
  // value path by extracting through the source root's state fields.
  if (auto bc2 = operand.getDefiningOp<hw::BitcastOp>()) {
    Value src = bc2.getInput();
    if (isa<hw::StructType, hw::ArrayType>(src.getType()) &&
        isa<hw::StructType, hw::ArrayType>(ty) &&
        hw::getBitWidth(src.getType()) == hw::getBitWidth(ty)) {
      auto root = resolveStructRootName(src);
      if (root) {
        // source leaf table: (path, msbFirstOffset, width)
        struct SrcLeaf { std::string path; int64_t off; unsigned w; };
        std::vector<SrcLeaf> srcLeaves;
        int64_t cum = 0;
        std::string p0;
        walkLeaves(src.getType(), p0, [&](StringRef lp, unsigned w) {
          srcLeaves.push_back({lp.str(), cum, w});
          cum += w;
        });
        int64_t dcum = 0;
        bool ok2 = true;
        std::string p1;
        walkLeaves(ty, p1, [&](StringRef lp, unsigned w) {
          if (!ok2) return;
          int64_t off = dcum;
          dcum += w;
          const SrcLeaf *hit = nullptr;
          for (const auto &sl : srcLeaves)
            if (sl.off <= off && off + (int64_t)w <= sl.off + (int64_t)sl.w) {
              hit = &sl;
              break;
            }
          if (!hit) { ok2 = false; return; }
          std::string flat = *root;
          if (!hit->path.empty())
            flat += (hit->path.front() == '[' ? "" : ".") + hit->path;
          std::string field = sanitizeName(prefixedName(flat, prefix));
          std::string expr = "s->" + field;
          if (hit->w > w) {
            // sub-window of a wider source leaf (MSB-first)
            int64_t shift = (hit->off + hit->w) - (off + w);
            expr = "(((uint64_t)(" + expr + ") >> " +
                   std::to_string(shift) + ") & ((1ULL << " +
                   std::to_string(w) + ") - 1))";
          }
          LeafEmit::Entry e;
          std::string full = leafPath;
          if (!lp.empty()) {
            if (lp.front() != '[' && !full.empty())
              full += ".";
            full += lp.str();
          }
          e.leafPath = full;
          e.exprC = expr;
          e.width = w;
          out.leaves.push_back(std::move(e));
        });
        if (ok2)
          return;
        out.leaves.clear();
        out.ok = false;
        return;
      }
    }
  }

  // ---------- Integer leaf ---------------------------------------
  if (auto intTy = dyn_cast<IntegerType>(ty)) {
    auto exprOpt = resolveValueExpr(operand, prefix, &registry);
    if (!exprOpt) {
      out.ok = false;
      return;
    }
    LeafEmit::Entry e;
    e.leafPath = leafPath;
    e.exprC = *exprOpt;
    e.width = intTy.getWidth();
    out.leaves.push_back(std::move(e));
    return;
  }

  Operation *defOp = operand.getDefiningOp();

  // ---------- hw.bitcast of an INTEGER into this aggregate ----------
  // The importer reinterprets packed-struct assignments as a bitcast of
  // the packed integer (keymgr's kmac app-request `data_o` and its
  // rom_digest_i input both arrive this way).  Project each integer
  // leaf as a bit-slice of the source expression.  HW packing: the
  // FIRST struct field occupies the MOST-significant bits.
  if (auto bc = dyn_cast_or_null<hw::BitcastOp>(defOp)) {
    Value src = bc.getInput();
    if (getenv("QP_DEBUG_BRIDGE")) {
      llvm::errs() << "  [BC-LEAF] src type: " << src.getType() << " expr=";
      auto dbg = resolveValueExpr(src, prefix, &registry);
      llvm::errs() << (dbg ? *dbg : "<fail>") << "\n";
    }
    // Trivial wrapper: array<1 x T> <-> T (keymgr passes rom_digest_i
    // as a 1-element array of the digest struct).  Peel the wrapper and
    // project the inner value.
    if (auto ar1 = dyn_cast<hw::ArrayType>(ty)) {
      if (ar1.getNumElements() == 1 &&
          ar1.getElementType() == src.getType()) {
        size_t before = leafPath.size();
        leafPath += "[0]";
        walkBridgeLeavesRec(ar1.getElementType(), src, prefix, registry,
                            leafPath, out);
        leafPath.resize(before);
        return;
      }
    }
    if (hw::getBitWidth(src.getType()) > 0 &&
        hw::getBitWidth(src.getType()) == hw::getBitWidth(ty)) {
      // Equal-width reinterpretation from ANY source shape: project each
      // destination leaf as a bit window of the source via
      // wideProjectExpr (integer sources, aggregate named roots,
      // array_creates, muxes, constants...).  The old integer-only gate
      // with a whole-value resolve bail dropped csrng's state_db read
      // (mux over an i418 with an all-zero constant arm) and the hw-app
      // cmd response (array<2 x i135> source).
      unsigned total = (unsigned)hw::getBitWidth(src.getType());
      // Walk the aggregate type, emitting extracts.  Offsets count down
      // from the top (first field = MSBs).
      std::function<void(Type, unsigned &)> proj = [&](Type t,
                                                       unsigned &msb) {
        if (!out.ok) return;
        if (auto it2 = dyn_cast<IntegerType>(t)) {
          unsigned w = it2.getWidth();
          unsigned lo = msb - w;
          if (w <= 64) {
            auto expr2 = wideProjectExpr(src, lo, w, prefix, registry);
            if (!expr2) { out.ok = false; return; }
            LeafEmit::Entry e;
            e.leafPath = leafPath;
            e.exprC = *expr2;
            e.width = w;
            out.leaves.push_back(std::move(e));
          } else if (w <= 128) {
            // 65..128-bit leaf: the state field is a __uint128_t SCALAR,
            // not a word array — combine the two projected words into one
            // assignment (csrng state_db's 128-bit `v`).
            auto eLo = wideProjectExpr(src, lo, 64, prefix, registry);
            auto eHi = wideProjectExpr(src, lo + 64, w - 64, prefix,
                                       registry);
            if (!eLo || !eHi) { out.ok = false; return; }
            LeafEmit::Entry e;
            e.leafPath = leafPath;
            e.exprC = "((((__uint128_t)(" + *eHi + ")) << 64) | ((__uint128_t)(" +
                      *eLo + ")))";
            e.width = w;
            out.leaves.push_back(std::move(e));
          } else {
            // WIDE leaf (384-bit digest shares): one per-word entry
            // each, projected independently.
            for (unsigned k = 0; k * 64 < w; ++k) {
              unsigned ww = std::min(64u, w - k * 64);
              auto expr2 =
                  wideProjectExpr(src, lo + k * 64, ww, prefix, registry);
              if (!expr2) {
                if (getenv("QP_DEBUG_BRIDGE"))
                  llvm::errs() << "  [BC-PROJ fail] off=" << (lo + k * 64)
                               << " w=" << ww << "\n";
                out.ok = false; return;
              }
              LeafEmit::Entry e;
              e.leafPath = leafPath;
              e.exprC = *expr2;
              e.width = w;
              e.wordIndex = (int)k;
              out.leaves.push_back(std::move(e));
            }
          }
          msb = lo;
          return;
        }
        if (auto st2 = dyn_cast<hw::StructType>(t)) {
          for (auto f : st2.getElements()) {
            size_t before = leafPath.size();
            if (!leafPath.empty()) leafPath += ".";
            leafPath += f.name.getValue().str();
            proj(f.type, msb);
            leafPath.resize(before);
            if (!out.ok) return;
          }
          return;
        }
        if (auto ar2 = dyn_cast<hw::ArrayType>(t)) {
          // HW packing: element [N-1] occupies the MSBs.
          for (int i2 = (int)ar2.getNumElements() - 1; i2 >= 0; --i2) {
            size_t before = leafPath.size();
            leafPath += "[" + std::to_string(i2) + "]";
            proj(ar2.getElementType(), msb);
            leafPath.resize(before);
            if (!out.ok) return;
          }
          return;
        }
        out.ok = false;
      };
      unsigned msb = total;
      proj(ty, msb);
      return;
    }
  }

  // ---------- comb.mux over an aggregate: zip the two arms ----------
  // (keymgr's sideload kmac_key_o: `sel ? sideload_key : ctrl_key`).
  if (auto vm = dyn_cast_or_null<comb::MuxOp>(defOp)) {
    auto c = resolveValueExpr(vm.getCond(), prefix, &registry);
    if (!c) { out.ok = false; return; }
    LeafEmit la, lb;
    {
      std::string lpA = leafPath;
      walkBridgeLeavesRec(ty, vm.getTrueValue(), prefix, registry, lpA, la);
      std::string lpB = leafPath;
      walkBridgeLeavesRec(ty, vm.getFalseValue(), prefix, registry, lpB, lb);
    }
    if (!la.ok || !lb.ok || la.leaves.size() != lb.leaves.size()) {
      out.ok = false;
      return;
    }
    for (size_t i = 0; i < la.leaves.size(); ++i) {
      if (la.leaves[i].leafPath != lb.leaves[i].leafPath ||
          la.leaves[i].wordIndex != lb.leaves[i].wordIndex) {
        out.ok = false;
        return;
      }
      LeafEmit::Entry e = la.leaves[i];
      e.exprC = "((" + *c + ") ? " + la.leaves[i].exprC + " : " +
                lb.leaves[i].exprC + ")";
      out.leaves.push_back(std::move(e));
    }
    return;
  }

  // ---------- hw.struct_create: recurse field-by-field ----------
  // Field index = operand index (CIRCT positional convention).  The
  // most important case in OT is `tlul_adapter_reg`'s `tl_o_pre`,
  // which packs `rdata_q` (and friends) into the 10-field response
  // struct passed to `u_rsp_intg_gen`.
  if (auto sc = dyn_cast_or_null<hw::StructCreateOp>(defOp)) {
    auto stTy = dyn_cast<hw::StructType>(ty);
    if (!stTy ||
        stTy.getElements().size() != sc.getNumOperands()) {
      out.ok = false;
      return;
    }
    auto fields = stTy.getElements();
    for (size_t i = 0, n = fields.size(); i < n; ++i) {
      size_t before = leafPath.size();
      if (!leafPath.empty())
        leafPath += ".";
      leafPath += fields[i].name.getValue().str();
      walkBridgeLeavesRec(fields[i].type, sc.getOperand(i),
                          prefix, registry, leafPath, out);
      leafPath.resize(before);
      if (!out.ok)
        return;
    }
    return;
  }

  // ---------- hw.aggregate_constant: constant leaves ----------
  // The 2026 importer emits zero/constant struct fillers as
  // hw.aggregate_constant where the old one used `bitcast(hw.constant)`
  // (e.g. the all-zero d_user ECC filler inside tlul_adapter_reg's
  // tl_o_pre).  Without this branch the whole enclosing bridge is
  // dropped — taking live sibling fields (a_ready!) down with it.
  // Attr conventions: struct attrs follow field declaration order;
  // array attrs are MSB-first (attr[0] = element N-1), matching
  // array_create operands.
  if (auto aggc = dyn_cast_or_null<hw::AggregateConstantOp>(defOp)) {
    std::function<bool(Type, Attribute)> emitConstLeaves =
        [&](Type t, Attribute a) -> bool {
      if (auto intTy = dyn_cast<IntegerType>(t)) {
        auto ia = dyn_cast<IntegerAttr>(a);
        if (!ia)
          return false;
        llvm::SmallString<24> hex;
        ia.getValue().zextOrTrunc(intTy.getWidth()).toStringUnsigned(hex, 16);
        LeafEmit::Entry e;
        e.leafPath = leafPath;
        e.exprC = "0x" + std::string(hex) + "ULL";
        e.width = intTy.getWidth();
        out.leaves.push_back(std::move(e));
        return true;
      }
      if (auto stTy = dyn_cast<hw::StructType>(t)) {
        auto arr = dyn_cast<ArrayAttr>(a);
        auto fields = stTy.getElements();
        if (!arr || arr.size() != fields.size())
          return false;
        for (size_t i = 0; i < fields.size(); ++i) {
          size_t before = leafPath.size();
          if (!leafPath.empty())
            leafPath += ".";
          leafPath += fields[i].name.getValue().str();
          bool ok = emitConstLeaves(fields[i].type, arr[i]);
          leafPath.resize(before);
          if (!ok)
            return false;
        }
        return true;
      }
      if (auto arrTy = dyn_cast<hw::ArrayType>(t)) {
        auto arr = dyn_cast<ArrayAttr>(a);
        if (!arr || (int64_t)arr.size() != arrTy.getNumElements())
          return false;
        size_t n = arr.size();
        for (size_t i = 0; i < n; ++i) {
          size_t before = leafPath.size();
          leafPath += "[" + std::to_string(i) + "]";
          bool ok = emitConstLeaves(arrTy.getElementType(), arr[n - 1 - i]);
          leafPath.resize(before);
          if (!ok)
            return false;
        }
        return true;
      }
      return false;
    };
    if (!emitConstLeaves(ty, aggc.getFields()))
      out.ok = false;
    return;
  }

  // ---------- hw.array_create: recurse element-by-element ----------
  // CIRCT MSB-first convention: operand[N-1-i] = element i.  Required
  // for rv_timer's hw2reg input bridge, where the top builds
  // `array<1×struct<d,de>>` for `intr_state0` via array_create instead
  // of leaving it as a sig BlockArg.
  if (auto ac = dyn_cast_or_null<hw::ArrayCreateOp>(defOp)) {
    auto arrTy = dyn_cast<hw::ArrayType>(ty);
    if (!arrTy ||
        arrTy.getNumElements() != ac.getNumOperands()) {
      out.ok = false;
      return;
    }
    unsigned n = ac.getNumOperands();
    for (unsigned i = 0; i < n; ++i) {
      size_t before = leafPath.size();
      // Array index path component uses [i] form (no leading "."),
      // matching walkLeaves + ExplodeStructSigs naming convention.
      leafPath += "[" + std::to_string(i) + "]";
      walkBridgeLeavesRec(arrTy.getElementType(),
                          ac.getOperand(n - 1 - i),
                          prefix, registry, leafPath, out);
      leafPath.resize(before);
      if (!out.ok)
        return;
    }
    return;
  }

  // ---------- builtin.unrealized_conversion_cast: pass-through ----------
  // OT IR uses these to bridge array<NxT> ↔ array<MxT> shape mismatches
  // (e.g. mtimecmp_update casts between array<1xarray<1xi1>> and
  // array<1xi1>).  Recurse into the underlying single operand and
  // continue building the leaf path.
  // Packed INTEGER -> aggregate: any integer-typed source viewed as a
  // struct/array (LowerValueStructs turns `bitcast iN -> struct` into an
  // unrealized_conversion_cast; spi_host_command_queue's `core_command_o` is
  // the FIFO read data `extract(rdata_o)` cast to the command struct).  Each
  // leaf is a bit-slice of the source, fields MSB-first (hw.bitcast packing).
  auto packedIntToLeaves = [&](Value src) -> bool {
    if (!isa<IntegerType>(src.getType()) || !isa<hw::StructType, hw::ArrayType>(ty)) return false;
    int64_t total = hw::getBitWidth(ty);
    if ((int64_t)hw::getBitWidth(src.getType()) != total || total > 128) return false;
    auto srcExpr = resolveValueExpr(src, prefix, &registry);
    if (!srcExpr) return false;
    int64_t cum = 0;
    walkLeaves(ty, leafPath, [&](StringRef fullPath, unsigned w) {
      int64_t off = total - cum - (int64_t)w;   // MSB-first packing
      cum += w;
      std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                                 : ("((1ULL << " + std::to_string(w) + ") - 1)");
      LeafEmit::Entry e;
      e.leafPath = fullPath.str();
      e.exprC = total <= 64
          ? ("((((uint64_t)(" + *srcExpr + ")) >> " + std::to_string(off) + ") & " + mask + ")")
          : ("(((uint64_t)(((__uint128_t)(" + *srcExpr + ")) >> " + std::to_string(off) + ")) & " + mask + ")");
      e.width = w;
      out.leaves.push_back(std::move(e));
    });
    return true;
  };
  if (auto cast = dyn_cast_or_null<UnrealizedConversionCastOp>(defOp)) {
    if (cast.getNumOperands() == 1) {
      if (packedIntToLeaves(cast.getOperand(0))) return;
      walkBridgeLeavesRec(ty, cast.getOperand(0),
                          prefix, registry, leafPath, out);
      return;
    }
  }

  // ---------- comb.concat: struct-rebuild after LowerValueStructs ----------
  // LowerValueStructs flattens `struct<f0:iN0, f1:iN1, ...>` value ops
  // into `comb.concat (f0_val, f1_val, ...)` (MSB-first) producing iN
  // where N = sum(Ni).  For a struct with NESTED struct fields the
  // concat is fully flattened down to integer leaves, so pairing by
  // top-level field count fails.  Iterate leaves with walkLeaves
  // instead — this matches LowerValueStructs's MSB-first declaration
  // order convention and works for any nested struct/array shape.
  // Required for tlul_socket_1n's `tl_d_i: array<3×struct<..., d_user:
  // struct<rsp_intg, data_intg>, ...>>` input bridge: 10 top-level
  // fields but 11 leaf integers.
  if (auto cc = dyn_cast_or_null<comb::ConcatOp>(defOp)) {
    if (isa<hw::StructType>(ty) || isa<hw::ArrayType>(ty)) {
      SmallVector<std::pair<std::string, unsigned>> leaves;
      std::string lp;
      walkLeaves(ty, lp, [&](StringRef leafRel, unsigned w) {
        leaves.emplace_back(leafRel.str(), w);
      });
      if (leaves.size() == cc.getNumOperands()) {
        bool allOk = true;
        for (size_t i = 0, n = leaves.size(); i < n; ++i) {
          // Each leaf is an integer; emit one bridge entry by reusing
          // the integer-leaf branch via direct LeafEmit::Entry append.
          // We can't recurse with `IntegerType` because we'd lose the
          // accumulated leafPath prefix; do the resolveValueExpr inline.
          auto exprOpt = resolveValueExpr(cc.getOperand(i), prefix,
                                          &registry);
          if (!exprOpt) {
            allOk = false;
            break;
          }
          std::string fullPath = leafPath;
          StringRef rel(leaves[i].first);
          if (!rel.empty()) {
            if (!fullPath.empty() && rel.front() != '[')
              fullPath += ".";
            fullPath += rel.str();
          }
          LeafEmit::Entry e;
          e.leafPath = std::move(fullPath);
          e.exprC = std::move(*exprOpt);
          e.width = leaves[i].second;
          out.leaves.push_back(std::move(e));
        }
        if (allOk)
          return;
        out.ok = false;
        // Fall through to legacy fallback as a safety net.
      }
    }
  }

  // ---------- hw.bitcast %c : iN → struct/array ------------------
  // OT's only struct-typed bitcast in struct_create context is
  // `bitcast %c0_i14 : (i14) -> !hw.struct<rsp_intg, data_intg>`
  // — the all-zero ECC filler that's later overwritten by
  // tlul_rsp_intg_gen.  Emit "0" for every leaf.  Non-zero
  // constants (very rare) bail and let the caller take the legacy
  // path (which will likely also fail, leaving the field at its
  // zero init — same behaviour as before this fix).
  if (auto bc = dyn_cast_or_null<hw::BitcastOp>(defOp)) {
    if (auto cst = bc.getInput().getDefiningOp<hw::ConstantOp>()) {
      if (cst.getValue().isZero()) {
        // walkLeaves will append/restore around `leafPath`, so paths
        // surfaced to the callback are the cumulative `entry path +
        // leaf within ty`, which is exactly what we want to record.
        walkLeaves(ty, leafPath,
                   [&](StringRef fullPath, unsigned w) {
                     LeafEmit::Entry e;
                     e.leafPath = fullPath.str();
                     e.exprC = "0";
                     e.width = w;
                     out.leaves.push_back(std::move(e));
                   });
        return;
      }
    }
    // Same-shape reinterpretation between an array of (already lowered)
    // integer elements and an array of structs of the same element width —
    // `bitcast(array_create %packed... : array<5xstruct>) -> array<5xi75>`
    // at prim_sram_arbiter's `data_i`.  Walk the input with the TARGET type:
    // per element the packed integer is the leaf.
    if (auto ac = bc.getInput().getDefiningOp<hw::ArrayCreateOp>()) {
      auto dstArr = dyn_cast<hw::ArrayType>(ty);
      // Target array of AGGREGATE elements built from packed integers
      // (LowerValueStructs' ArrayCreateOfAggregateToInt): each leaf of the
      // element struct is a bit-slice of the packed operand.
      if (dstArr && dstArr.getNumElements() == ac.getNumOperands() &&
          isa<hw::StructType, hw::ArrayType>(dstArr.getElementType()) &&
          isa<IntegerType>(ac.getOperand(0).getType())) {
        unsigned n = ac.getNumOperands();
        Type elTy = dstArr.getElementType();
        int64_t total = hw::getBitWidth(elTy);
        // >128-bit elements live as uint64_t arrays in the state struct — a
        // scalar __uint128_t shift over the array NAME is a C type error
        // (aes's 256-bit prd_clearing shares).  Bail; the field stays 0.
        if (total > 128) { out.ok = false; return; }
        for (unsigned i = 0; i < n; ++i) {
          Value el = ac.getOperand(n - 1 - i);
          if ((int64_t)hw::getBitWidth(el.getType()) != total) { out.ok = false; return; }
          auto elExpr = resolveValueExpr(el, prefix, &registry);
          if (!elExpr) { out.ok = false; return; }
          size_t before = leafPath.size();
          leafPath += "[" + std::to_string(i) + "]";
          int64_t cum = 0;
          walkLeaves(elTy, leafPath, [&](StringRef fullPath, unsigned w) {
            int64_t off = total - cum - (int64_t)w;   // MSB-first packing
            cum += w;
            std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                                       : ("((1ULL << " + std::to_string(w) + ") - 1)");
            LeafEmit::Entry e;
            e.leafPath = fullPath.str();
            e.exprC = total <= 64
                ? ("((((uint64_t)(" + *elExpr + ")) >> " + std::to_string(off) + ") & " + mask + ")")
                : ("(((uint64_t)(((__uint128_t)(" + *elExpr + ")) >> " + std::to_string(off) + ")) & " + mask + ")");
            e.width = w;
            out.leaves.push_back(std::move(e));
          });
          leafPath.resize(before);
        }
        return;
      }
      if (dstArr && dstArr.getNumElements() == ac.getNumOperands() &&
          isa<IntegerType>(dstArr.getElementType())) {
        unsigned n = ac.getNumOperands();
        for (unsigned i = 0; i < n; ++i) {
          Value el = ac.getOperand(n - 1 - i);
          if (hw::getBitWidth(el.getType()) != hw::getBitWidth(dstArr.getElementType())) {
            out.ok = false; return;
          }
          size_t before = leafPath.size();
          leafPath += "[" + std::to_string(i) + "]";
          walkBridgeLeavesRec(dstArr.getElementType(), el, prefix, registry, leafPath, out);
          leafPath.resize(before);
          if (!out.ok) return;
        }
        return;
      }
    }
    // Integer ↔ integer of equal width: pass through.
    if (isa<IntegerType>(bc.getInput().getType()) && isa<IntegerType>(ty) &&
        hw::getBitWidth(bc.getInput().getType()) == hw::getBitWidth(ty)) {
      walkBridgeLeavesRec(ty, bc.getInput(), prefix, registry, leafPath, out);
      return;
    }
    // Aggregate ↔ aggregate of equal width where the SOURCE is an
    // array_create of integer elements: re-pack the source lanes into the
    // destination's leaves by bit range.  aes_ctr's output lands here:
    // `bitcast(array_create ... : array<16xi8>) -> array<8xi16>` — each
    // destination i16 leaf is two source bytes stitched shift-OR-wise.
    // Bit convention: array element k occupies [k*elemW, (k+1)*elemW),
    // element 0 in the LSBs (array_create operand N-1 = element 0).
    if (auto acSrc = bc.getInput().getDefiningOp<hw::ArrayCreateOp>()) {
      auto srcArr = dyn_cast<hw::ArrayType>(bc.getInput().getType());
      auto dstArr2 = dyn_cast<hw::ArrayType>(ty);
      auto srcEl = srcArr ? dyn_cast<IntegerType>(srcArr.getElementType())
                          : nullptr;
      auto dstEl = dstArr2 ? dyn_cast<IntegerType>(dstArr2.getElementType())
                           : nullptr;
      if (srcEl && dstEl && dstEl.getWidth() <= 64 &&
          hw::getBitWidth(srcArr) == hw::getBitWidth(dstArr2)) {
        unsigned sw = srcEl.getWidth(), dw = dstEl.getWidth();
        unsigned nSrc = acSrc.getNumOperands();
        int64_t nDst = dstArr2.getNumElements();
        bool ok = true;
        std::vector<std::string> srcExpr(nSrc);
        for (unsigned k = 0; k < nSrc && ok; ++k) {
          // element k = operand nSrc-1-k
          auto e = resolveValueExpr(acSrc.getOperand(nSrc - 1 - k), prefix,
                                    &registry);
          if (!e) { ok = false; break; }
          srcExpr[k] = *e;
        }
        if (ok) {
          for (int64_t d = 0; d < nDst; ++d) {
            uint64_t off = (uint64_t)d * dw;
            std::string expr;
            for (uint64_t bit = 0; bit < dw;) {
              uint64_t k = (off + bit) / sw;
              uint64_t inOff = (off + bit) % sw;
              uint64_t take = std::min<uint64_t>(sw - inOff, dw - bit);
              if (k >= nSrc) { ok = false; break; }
              std::string mask =
                  take >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                             : ("((1ULL << " + std::to_string(take) + ") - 1)");
              std::string piece = "(((((uint64_t)(" + srcExpr[k] + ")) >> " +
                                  std::to_string(inOff) + ") & " + mask +
                                  ") << " + std::to_string(bit) + ")";
              expr = expr.empty() ? piece : (expr + " | " + piece);
              bit += take;
            }
            if (!ok) break;
            size_t before = leafPath.size();
            leafPath += "[" + std::to_string(d) + "]";
            LeafEmit::Entry e;
            e.leafPath = leafPath;
            e.exprC = "(" + expr + ")";
            e.width = dw;
            out.leaves.push_back(std::move(e));
            leafPath.resize(before);
          }
          if (ok) return;
          out.ok = false;
          return;
        }
      }
    }
    // Packed integer -> struct/array: per-leaf bit slices.
    if (packedIntToLeaves(bc.getInput())) return;

    // LAST RESORT — structural slicer for bitcast over a mux/concat tree
    // (hmac_core's sha_rdata_o).  Deliberately ordered AFTER every
    // established path so previously-working bridges keep their exact
    // emitted shape (running it first re-formed expressions on all 12
    // devices and broke the byte-identical gate).
    auto srcInt = dyn_cast<IntegerType>(bc.getInput().getType());
    if (srcInt && srcInt.getWidth() <= 64) {
      // Private condition resolver: resolveValueExpr plus xor/and, scoped
      // to THIS slicer so no other bridge changes shape (adding these ops
      // globally re-formed a_ready/err_o expressions on every device and
      // broke the byte-identical gate).
      std::function<std::optional<std::string>(Value)> condExpr =
          [&](Value cv) -> std::optional<std::string> {
        if (auto e0 = resolveValueExpr(cv, prefix, &registry))
          return e0;
        Operation *cd = cv.getDefiningOp();
        if (cd && isa<comb::XorOp, comb::AndOp>(cd)) {
          auto ity = dyn_cast<IntegerType>(cd->getResult(0).getType());
          if (!ity || ity.getWidth() > 64)
            return std::nullopt;
          const char *opc = isa<comb::XorOp>(cd) ? "^" : "&";
          std::string expr;
          for (Value o : cd->getOperands()) {
            auto e = condExpr(o);
            if (!e)
              return std::nullopt;
            expr = expr.empty() ? ("(" + *e + ")")
                                : (expr + " " + opc + " (" + *e + ")");
          }
          std::string mask =
              ity.getWidth() >= 64
                  ? "0xFFFFFFFFFFFFFFFFULL"
                  : ("((1ULL << " + std::to_string(ity.getWidth()) + ") - 1)");
          return "((" + expr + ") & " + mask + ")";
        }
        return std::nullopt;
      };
      std::function<std::optional<std::string>(Value, unsigned, unsigned)>
          slice = [&](Value v, unsigned off,
                      unsigned w) -> std::optional<std::string> {
        Operation *d = v.getDefiningOp();
        if (auto cc = dyn_cast_or_null<comb::ConcatOp>(d)) {
          unsigned pos = 0;  // walk operands LSB-first (reverse order)
          for (int i = (int)cc.getNumOperands() - 1; i >= 0; --i) {
            Value o = cc.getOperand(i);
            unsigned ow = o.getType().getIntOrFloatBitWidth();
            if (off >= pos && off + w <= pos + ow)
              return slice(o, off - pos, w);
            pos += ow;
          }
          return std::nullopt;  // leaf straddles operands: not seen in OT
        }
        if (auto mx = dyn_cast_or_null<comb::MuxOp>(d)) {
          auto c = condExpr(mx.getCond());
          auto tv = slice(mx.getTrueValue(), off, w);
          auto fv = slice(mx.getFalseValue(), off, w);
          if (!c)
            return std::nullopt;
          // LOUD degradation: when exactly one arm resolves, emit the
          // resolvable arm and pin the other to 0 rather than killing the
          // whole bridge.  hmac's sha_rdata_o carries its HMAC-mode key
          // stream through extract(shru(i512, var)) — 512-bit variable
          // shifts have no C lowering yet (same wall as the i_pad/o_pad
          // WIDE-ASSIGN DROPs, one fix family, campaign phase 2).  The
          // SHA-mode arm is what NIST needs and it resolves fine.
          if (tv && fv)
            return "((" + *c + ") ? (" + *tv + ") : (" + *fv + "))";
          if (tv || fv) {
            llvm::errs() << "  [SLICE-DEGRADED] mux arm pinned to 0 (off="
                         << off << " w=" << w << ")\n";
            return "((" + *c + ") ? (" + (tv ? *tv : std::string("0")) +
                   ") : (" + (fv ? *fv : std::string("0")) + "))";
          }
          return std::nullopt;
        }
        if (auto nbc = dyn_cast_or_null<hw::BitcastOp>(d))
          if (isa<IntegerType>(nbc.getInput().getType()))
            return slice(nbc.getInput(), off, w);
        auto e = resolveValueExpr(v, prefix, &registry);
        if (!e) {
          if (getenv("QP_DEBUG_SLICE")) {
            llvm::errs() << "  [slice-fail] off=" << off << " w=" << w
                         << " op=";
            if (Operation *dd = v.getDefiningOp())
              llvm::errs() << dd->getName();
            else
              llvm::errs() << "block-arg";
            llvm::errs() << "\n";
          }
          return std::nullopt;
        }
        unsigned vw = v.getType().getIntOrFloatBitWidth();
        if (off == 0 && w == vw)
          return e;
        std::string mask =
            w >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                    : ("((1ULL << " + std::to_string(w) + ") - 1)");
        return "((((uint64_t)(" + *e + ")) >> " + std::to_string(off) +
               ") & " + mask + ")";
      };

      unsigned total = srcInt.getWidth();
      unsigned consumed = 0;
      bool allOk = true;
      SmallVector<LeafEmit::Entry, 8> pending;
      std::string sub;
      walkLeaves(ty, sub, [&](StringRef lp, unsigned w) {
        if (!allOk)
          return;
        consumed += w;
        auto exprOpt = slice(bc.getInput(), total - consumed, w);
        if (!exprOpt) {
          allOk = false;
          return;
        }
        LeafEmit::Entry e;
        std::string full = leafPath;
        if (!lp.empty()) {
          if (!full.empty())
            full += ".";
          full += lp.str();
        }
        e.leafPath = full;
        e.exprC = *exprOpt;
        e.width = w;
        pending.push_back(std::move(e));
      });
      if (allOk && consumed == total) {
        for (auto &e : pending)
          out.leaves.push_back(std::move(e));
        return;
      }
      // slicer failed
    }
    out.ok = false;
    return;
  }

  // ---------- hw.array_get with constant index ---------------------
  // For `array_get %arr[const]` returning element of type T, treat the
  // bridge as sourcing from `<arr_root>[i].<leaf_in_T>`.  Required for
  // tlul_socket_1n's `tl_h_o : array<3×struct<tl_h2d_t>>` instance
  // output → consumer's `tl_i = array_get tl_h_o[0]` input bridge.
  // Without this, resolveStructRootName below fails on array_get and
  // the entire request bus dies (self = self bridge).
  if (auto ag = dyn_cast_or_null<hw::ArrayGetOp>(defOp)) {
    auto idxConst = ag.getIndex().getDefiningOp<hw::ConstantOp>();
    if (!idxConst) {
      out.ok = false;
      return;
    }
    unsigned idx = idxConst.getValue().getZExtValue();
    auto rootOpt = resolveStructRootName(ag.getInput());
    if (!rootOpt) {
      out.ok = false;
      return;
    }
    std::string indexedRoot =
        *rootOpt + "[" + std::to_string(idx) + "]";
    size_t entryLen = leafPath.size();
    walkLeaves(ty, leafPath,
               [&](StringRef fullPath, unsigned w) {
                 StringRef relInTy = fullPath.drop_front(entryLen);
                 if (!relInTy.empty() && relInTy.front() == '.')
                   relInTy = relInTy.drop_front();
                 // NO "." BEFORE AN ARRAY INDEX — the convention this file
                 // states at the top of resolveStructRootName and that
                 // walkLeaves and the bridge emission both follow.  Joining
                 // unconditionally split every NESTED array element into two
                 // struct fields: alert_handler's esc_map[2][3] was written
                 // as `esc_map_2__3_` and read as `esc_map_2___3_`, one extra
                 // underscore, so the escalation map, phase cycles and the
                 // accumulator/escalation counters of classes 2 and 3 read
                 // zero — 35 never-written fields, all of them this.
                 std::string callerFlat =
                     relInTy.empty()
                         ? indexedRoot
                         : (indexedRoot +
                            (relInTy.front() == '[' ? "" : ".") +
                            relInTy.str());
                 std::string callerField = sanitizeName(
                     prefixedName(callerFlat, prefix));
                 registry.registerSignal(callerField, w);
                 LeafEmit::Entry e;
                 e.leafPath = fullPath.str();
                 e.exprC = "s->" + callerField;
                 e.width = w;
                 out.leaves.push_back(std::move(e));
               });
    return;
  }

  // ---------- Legacy fallback: BlockArg / instance result ---------
  // Operand carries a struct/array value as a flat root-named storage
  // (whole port, whole instance result).  Walk type leaves and emit
  // one bridge entry per leaf, keyed by the root + leaf path.
  auto rootOpt = resolveStructRootName(operand);
  if (!rootOpt) {
    out.ok = false;
    return;
  }
  size_t entryLen = leafPath.size();
  walkLeaves(ty, leafPath,
             [&](StringRef fullPath, unsigned w) {
               // Strip the entry prefix to get the leaf path relative
               // to the operand root — that's what we tack onto
               // `*rootOpt` to form the flat caller field name.
               StringRef relInTy = fullPath.drop_front(entryLen);
               if (!relInTy.empty() && relInTy.front() == '.')
                 relInTy = relInTy.drop_front();
               // No "." before an array index — the convention every other
               // naming path follows (prependPathComponent / calleeFlat /
               // resolveValueExpr's wrap).  The unconditional dot made
               // `prio_i` + `[1]` sanitize to `prio_i__1_` while the writer
               // side emitted `prio_i_1_` — rv_plic's per-source priority
               // array arrived at the max tree as all-zeroes.
               std::string callerFlat = relInTy.empty()
                   ? *rootOpt
                   : (*rootOpt + (relInTy.front() == '[' ? "" : ".") +
                      relInTy.str());
               std::string callerField = sanitizeName(
                   prefixedName(callerFlat, prefix));
               // Register the caller-side leaf so the `s->callerField`
               // reference we're about to emit binds to an actual
               // state-struct member.  This matches the pre-fix legacy
               // bridge behaviour (which registered both ends).
               registry.registerSignal(callerField, w);
               LeafEmit::Entry e;
               e.leafPath = fullPath.str();
               e.exprC = "s->" + callerField;
               e.width = w;
               out.leaves.push_back(std::move(e));
             });
}

static LeafEmit walkBridgeLeaves(Type ty, Value operand,
                                  llvm::StringRef prefix,
                                  FlatSignalRegistry &registry) {
  LeafEmit out;
  std::string leafPath;
  walkBridgeLeavesRec(ty, operand, prefix, registry, leafPath, out);
  if (!out.ok)
    out.leaves.clear();
  return out;
}

/// Append a comb-logic-style assignment `s->target = expr;` to `combOut`.
/// Used for both qemu.comb_logic entries and Phase 2.b instance bridges.
static void appendAssign(EmitCtx &ctx,
                         std::string target,
                         std::string expr,
                         unsigned bitWidth) {
  ctx.registry.registerSignal(target, bitWidth);
  clk_analysis::CombinationalAssignment a;
  a.targetSignal = ctx.registry.lookup(target);
  a.expression = std::move(expr);
  a.bitWidth = bitWidth;
  ctx.combOut.push_back(std::move(a));
}

/// Copy a module's OWN boundary scalar output ports out to their state fields.
///
/// renderModule's per-instance loop bridges a CHILD instance's outputs into the
/// caller-side `<inst>_<port>` fields, but nothing bridges the TOP/root module's
/// own `hw.output` operands into its bare port fields (`s->cio_gpio_o`, ...), so
/// those data-output values were computed internally yet never presented at the
/// device boundary (they stayed zero-init).  This runs the same resolve-and-
/// assign for the top module against its own port fields.
///
/// GENERIC, no per-device data: it iterates the module's output ports in order
/// and copies each scalar one whose driver resolves.  Struct/array outputs
/// (e.g. the TL-UL `tl_o` response) are intentionally left to the bus machinery
/// (applyTLULOverride / the rdata signal path), not duplicated here.
/// `resolveValueExpr` already handles `llhd.prb`-of-sig and `hw.instance`
/// results, so no new op support is needed; the port fields are already
/// registered by renderModule's port walk.
static void emitTopOutputBridge(hw::HWModuleOp mod, EmitCtx &ctx) {
  auto outOp = dyn_cast<hw::OutputOp>(mod.getBodyBlock()->getTerminator());
  if (!outOp) return;
  llvm::StringRef ns = ctx.instancePath;  // "" for the root module
  // Every leaf of a struct/array-typed TOP INPUT port is a legitimate
  // (host-driven, zero-init) state field — register them all so an output
  // driver that reads such a leaf directly (spi_host: `cio_sck_o =
  // passthrough_i.passthrough_en ? pt_sck : sck`) resolves.  Leaves that some
  // sig drive already referenced were registered by that reference; the rest
  // (used only in comb expressions at the top) were not, and the bridge below
  // silently skipped the port, leaving e.g. cio_sck_o/cio_csb_o at zero.
  for (auto p : mod.getPortList()) {
    if (p.dir != hw::ModulePort::Direction::Input) continue;
    if (!isa<hw::StructType, hw::ArrayType>(p.type)) continue;
    std::string path;
    walkLeaves(p.type, path, [&](StringRef leaf, unsigned w) {
      std::string flat = p.getName().str();
      if (!leaf.empty()) flat += (leaf.front() == '[' ? "" : ".") + leaf.str();
      ctx.registry.registerSignal(sanitizeName(prefixedName(flat, ns)), w);
    });
  }
  SmallVector<std::pair<std::string, unsigned>, 4> outs;  // (name, width; 0=non-int)
  for (auto p : mod.getPortList()) {
    if (p.dir != hw::ModulePort::Direction::Output) continue;
    unsigned w = 0;
    if (auto it = dyn_cast<IntegerType>(p.type)) w = it.getWidth();
    outs.push_back({p.getName().str(), w});
  }
  // Aggregate output ports named by a bus_master blueprint (a DMA engine's
  // host request ports): bridge them per-leaf so the shim's organ can watch
  // the request beats.  Data-driven: no other device gains any assignment.
  llvm::SmallPtrSet<const void *, 4> bmReqPorts;
  if (auto bm = mod->getAttrOfType<ArrayAttr>("qemu.bus_master_blueprint"))
    for (Attribute a : bm)
      if (auto d = dyn_cast<DictionaryAttr>(a))
        if (auto rp = d.getAs<StringAttr>("req_port"))
          bmReqPorts.insert(rp.getAsOpaquePointer());
  unsigned n = std::min<unsigned>(outOp.getNumOperands(), outs.size());
  for (unsigned j = 0; j < n; ++j) {
    unsigned w = outs[j].second;
    if (w == 0) {
      // Aggregate (struct/array) top output: bridge per-leaf so external
      // consumers can watch it — a bus_master blueprint's request beats,
      // and any signal-level device-to-device link (rom_ctrl's
      // kmac_data_o app stream / pwrmgr_data_o handshake / keymgr_data_o
      // key words).  TL-UL response ports resolve too; their leaves are
      // unread duplicates of the MMIO capture path, harmless.
      unsigned portIdx = 0, outIdx = 0; hw::ModulePort thePort;
      for (auto p : mod.getPortList()) {
        if (p.dir != hw::ModulePort::Direction::Output) continue;
        if (outIdx == j) { thePort = p; break; }
        ++outIdx;
      }
      (void)portIdx;
      bool isBm = bmReqPorts.count(thePort.name.getAsOpaquePointer());
      LeafEmit emit = walkBridgeLeaves(thePort.type, outOp.getOperand(j), ns, ctx.registry);
      if (!emit.ok) {
        llvm::errs() << "  [TOP-OUTPUT SKIP] " << thePort.name.getValue() << " (op: ";
        if (Operation *d = outOp.getOperand(j).getDefiningOp()) llvm::errs() << d->getName();
        else llvm::errs() << "block-arg";
        llvm::errs() << ")\n";
        continue;
      }
      for (const auto &e : emit.leaves) {
        std::string flat = thePort.name.getValue().str();
        if (!e.leafPath.empty()) flat += (e.leafPath.front() == '[' ? "" : ".") + e.leafPath;
        std::string field = sanitizeName(prefixedName(flat, ns));
        ctx.registry.registerSignal(field, e.width);
        if (e.wordIndex >= 0) {
            ctx.registry.registerSignal(field, e.width);
            clk_analysis::CombinationalAssignment wca;
            wca.targetSignal = ctx.registry.lookup(field);
            wca.expression = e.exprC;
            wca.bitWidth = e.width;
            wca.wordIndex = e.wordIndex;
            ctx.combOut.push_back(std::move(wca));
        } else {
            appendAssign(ctx, field, e.exprC, e.width);
        }
      }
      if (isBm)
        llvm::errs() << "  [bus_master] bridged request port '"
                     << thePort.name.getValue() << "' ("
                     << emit.leaves.size() << " leaves)\n";
      continue;
    }
    auto expr = resolveValueExpr(outOp.getOperand(j), ns, &ctx.registry);
    if (!expr) {
      // unresolvable driver -> the port field stays at zero-init.  Say so:
      // a silently missing top output is invisible until a backend needs it.
      llvm::errs() << "  [TOP-OUTPUT SKIP] " << outs[j].first << " (op: ";
      if (Operation *d = outOp.getOperand(j).getDefiningOp()) llvm::errs() << d->getName();
      else llvm::errs() << "block-arg";
      llvm::errs() << ")\n";
      continue;
    }
    appendAssign(ctx, prefixedName(outs[j].first, ns), *expr, w);
  }
}

/// Render a hw.module under the given instance-path prefix:
///   1. Register the module's integer-typed ports + llhd.sigs into the
///      shared FlatSignalRegistry, prefixed.
///   2. Read qemu.comb_logic, prefix each entry's target/expression,
///      register implicit `s->NAME` refs from the expression, append
///      the prefixed entry to combOut.
///   3. Recurse into direct child instances with an extended prefix.
///
/// Phase 2.a stops there.  Phase 2.b will add post-recursion bridge
/// entries (caller-operand → callee-input field, callee-output value
/// → caller-instance-result field).
static void renderModule(hw::HWModuleOp mod,
                         EmitCtx &ctx,
                         SymbolTable &symTable) {
  llvm::StringRef prefix = ctx.instancePath;

  // 1. Register module ports.  Struct/array ports register one field per
  // leaf, spelled exactly the way resolveValueExpr's blockarg branch
  // synthesizes them ("port.field" / "port[i]") — FlattenIO leaves the
  // occasional aggregate port un-flattened (aes's edn_i survived a
  // recursive flatten), and without these entries every bridge reading
  // through such a port is silently skipped.
  for (auto port : mod.getPortList()) {
    if (auto intTy = dyn_cast<IntegerType>(port.type)) {
      ctx.registry.registerSignal(prefixedName(port.getName(), prefix),
                                  intTy.getWidth());
      continue;
    }
    if (isa<hw::StructType, hw::ArrayType>(port.type)) {
      std::string acc;
      walkLeaves(port.type, acc, [&](StringRef leafPath, unsigned w) {
        std::string flat = port.getName().str();
        if (!leafPath.empty())
          flat += (leafPath.front() == '[' ? "" : ".") + leafPath.str();
        ctx.registry.registerSignal(sanitizeName(prefixedName(flat, prefix)),
                                    w);
      });
    }
  }

  // 2. Register llhd.SignalOps.  walk() visits all SignalOps inside
  // this module's body (including those inside processes), but does
  // not cross hw.instance edges (those are symbol references, not
  // nested blocks), so we don't double-count sub-module sigs.
  mod.walk([&](llhd::SignalOp sigOp) {
    auto nameOpt = sigOp.getName();
    if (!nameOpt) return;
    Type ty = sigOp.getType();
    if (auto inoutTy = dyn_cast<llhd::RefType>(ty))
      ty = inoutTy.getNestedType();
    auto intTy = dyn_cast<IntegerType>(ty);
    if (!intTy) {
      // Memory arrays (`array<N x iW>` sigs left whole by ExplodeStructSigs —
      // runtime-indexed, N > kMaxDynamicArrayElems, e.g. prim_ram_2p's
      // `mem : array<1024xi32>`): one wide bitvector field of N*W bits
      // (`uint64_t name[words]`).  Reads/writes index it with the runtime
      // address via qpw_wide_extract / qpw_wide_insert (see CombTranslator).
      // THREE EXITS, ALL SILENT.  A signal that is not registered has no
      // state field, and the consequence is not "it does not exist": the
      // regex sweep later registers whatever name it finds with the width of
      // the OUTER target, producing a family of wrong-width, never-written,
      // reads-zero orphan fields — the same class as `_unknown_argN`, a
      // different shape.  Say which exit was taken.
      if (auto arrTy = dyn_cast<hw::ArrayType>(ty)) {
        if (auto elTy = dyn_cast<IntegerType>(arrTy.getElementType())) {
          uint64_t bits = (uint64_t)arrTy.getNumElements() * elTy.getWidth();
          if (bits <= (1u << 24)) {
            ctx.registry.registerSignal(prefixedName(*nameOpt, prefix), (unsigned)bits);
          } else {
            llvm::errs() << "  [SIG UNREGISTERED] " << *nameOpt << ": array of "
                         << bits << " bits exceeds the 16 Mbit field limit\n";
          }
        } else {
          llvm::errs() << "  [SIG UNREGISTERED] " << *nameOpt
                       << ": array element is not an integer, so no state "
                          "field is created for it\n";
        }
      } else {
        // Anything else surviving to here — a StructType in particular —
        // means ExplodeStructSigs did not do its job, not that a cap fired.
        llvm::errs() << "  [SIG UNREGISTERED] " << *nameOpt
                     << ": aggregate signal survived struct explosion; no "
                        "state field is created for it\n";
      }
      return;
    }
    ctx.registry.registerSignal(prefixedName(*nameOpt, prefix),
                                intTy.getWidth());
  });

  // 3a. Render qemu.comb_logic: prefix target + expression, register
  // referenced fields, accumulate into combOut (-> update_state).
  // 3b. Render qemu.seq_logic similarly into seqOut (-> tick) but
  // skip entries with drv_class == "ACCUMULATE" — those are already
  // wired to ptimers via the read-side sync / write-side reload in
  // generateProtocolAgnosticSource, and re-emitting them in tick()
  // would double-write the counter field every MMIO operation.
  auto renderLogicAttr = [&](ArrayAttr attr,
                             std::vector<clk_analysis::CombinationalAssignment> &out,
                             bool isSeq) {
    if (!attr) return;
    for (Attribute elem : attr) {
      auto dictAttr = dyn_cast<DictionaryAttr>(elem);
      if (!dictAttr) continue;
      auto targetAttr = dictAttr.getAs<StringAttr>("target");
      auto exprAttr   = dictAttr.getAs<StringAttr>("expression");
      auto widthAttr  = dictAttr.getAs<IntegerAttr>("bitWidth");
      auto wordIdxAttr= dictAttr.getAs<IntegerAttr>("wordIndex");
      auto seqDomAttr = dictAttr.getAs<IntegerAttr>("seqDomain");
      if (!targetAttr || !exprAttr) continue;
      // Globalize the per-module sequential-domain id across instances:
      // the same module rendered under two prefixes must not share ids.
      int seqDom = -1;
      if (seqDomAttr) {
        static std::map<std::string, int> gDomainIds;
        std::string key =
            std::string(prefix) + "#" + std::to_string(seqDomAttr.getInt());
        auto ins = gDomainIds.emplace(key, (int)gDomainIds.size());
        seqDom = ins.first->second;
      }

      // Phase 2.c routing: drop ACCUMULATE seq drvs from tick().
      // ptimer is the canonical model for self-driven counters
      // (`q <= q + step`), and emit-c already wires per-counter
      // ptimer_init / ptimer_set_count / IRQ raise; pulling them
      // into tick() would let MMIO writes spuriously re-tick the
      // counter on every bus access.
      if (isSeq) {
        if (auto cls = dictAttr.getAs<StringAttr>("drv_class")) {
          if (cls.getValue() == "ACCUMULATE")
            continue;
        }
      }

      std::string prefixedExpr   = applyPrefix(exprAttr.getValue(), prefix);
      unsigned bitWidth = widthAttr ? unsigned(widthAttr.getInt()) : 32;
      // Verbatim block (memory-array writes from CombLogicExtract): no target
      // field, references were registered by the sig walk (the wide array) or
      // by their own entries.
      if (targetAttr.getValue() == "__RAW__") {
        clk_analysis::CombinationalAssignment a;
        a.targetSignal = "__RAW__";
        a.expression   = prefixedExpr;
        a.bitWidth     = 0;
        out.push_back(std::move(a));
        continue;
      }
      std::string prefixedTarget = prefixedName(targetAttr.getValue(), prefix);

      // Register all `s->X` referenced in the (already-prefixed)
      // expression so any name not yet covered by port/sig walks lands
      // in the state struct.
      static const std::regex refPat(R"(s->([A-Za-z_][A-Za-z0-9_]*))");
      auto begin = std::sregex_iterator(prefixedExpr.begin(),
                                         prefixedExpr.end(), refPat);
      auto end = std::sregex_iterator();
      for (auto it = begin; it != end; ++it) {
        if (llvm::StringRef((*it)[1].str()).starts_with("_qp_")) continue;  // model-global
        ctx.registry.registerSignal((*it)[1].str(), bitWidth);
      }

      ctx.registry.registerSignal(prefixedTarget, bitWidth);
      clk_analysis::CombinationalAssignment a;
      a.targetSignal = ctx.registry.lookup(prefixedTarget);
      a.expression   = prefixedExpr;
      a.bitWidth     = bitWidth;
      a.wordIndex    = wordIdxAttr ? int(wordIdxAttr.getInt()) : -1;
      a.seqDomain    = seqDom;
      out.push_back(std::move(a));
    }
  };
  renderLogicAttr(mod->getAttrOfType<ArrayAttr>("qemu.comb_logic"),
                  ctx.combOut, /*isSeq=*/false);
  renderLogicAttr(mod->getAttrOfType<ArrayAttr>("qemu.seq_logic"),
                  ctx.seqOut,  /*isSeq=*/true);

  // 4. Iterate direct child instances and bridge them.  Ordering of the
  // emitted assignments inside combOut matters because update_state()
  // runs them sequentially; we want, per instance:
  //   (input bridges)  →  (callee comb, recursed)  →  (output bridges)
  // so the callee sees the freshly-bridged input port values when its
  // own comb runs, and the caller-side instance-result field gets the
  // post-callee output value before any later caller-comb that reads it
  // (subject to the well-known multi-pass settling caveat — the MMIO
  // callback re-runs update_state after tick() to converge).
  //
  // PRE-PASS: register every instance's struct/array output leaves up
  // front, before any instance's bridges actually emit.  Otherwise an
  // earlier-in-body instance whose input refers to a later-in-body
  // instance's struct output (e.g. rv_timer's intr_hw at body line N
  // taking u_reg.reg2hw.intr_test0[0].qe where u_reg is at body line
  // N+M) would resolve via resolveValueExpr's wrap() against an empty
  // registry → returns nullopt → bridge silently skipped.  The bug
  // hits any instance topology where data flows "backward" relative
  // to body order — common in OT after CSE moves struct_extract sites.
  for (Operation &op : mod.getBodyBlock()->getOperations()) {
    auto inst = dyn_cast<hw::InstanceOp>(&op);
    if (!inst) continue;
    auto callee = symTable.lookup<hw::HWModuleOp>(inst.getModuleName());
    if (!callee) continue;
    std::string instChildPath = joinInstPath(prefix, inst.getInstanceName());
    for (auto p : callee.getPortList()) {
      if (p.dir != hw::ModulePort::Direction::Output)
        continue;
      // Scalar outputs: pre-register one field.
      if (auto intTy = dyn_cast<IntegerType>(p.type)) {
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + p.getName().str(), prefix);
        ctx.registry.registerSignal(callerInstResult, intTy.getWidth(),
                                    /*authoritative=*/true);
        continue;
      }
      // Struct/array outputs: walk leaves and pre-register each.
      if (isa<hw::StructType>(p.type) || isa<hw::ArrayType>(p.type)) {
        std::string root = inst.getInstanceName().str() + "_"
                           + p.getName().str();
        bool peelOne1 = false;
        if (auto arrP = dyn_cast<hw::ArrayType>(p.type))
          peelOne1 = arrP.getNumElements() == 1;
        std::string acc;
        walkLeaves(p.type, acc, [&](StringRef leafPath, unsigned w) {
          // No "." before an array index — the same naming-join
          // convention as the bridge writers (the dotted variant
          // pre-registered an orphan `mubi_o__0_` while the bridge
          // wrote `mubi_o_0_`, whose width was then polluted by a
          // later 2-bit registration: csrng's mubi8 sync copies were
          // compared ==0x96 after an &3 truncation, so the SW GENBITS
          // gate never opened).
          llvm::SmallVector<std::string, 2> lps;
          lps.push_back(leafPath.str());
          if (peelOne1 && leafPath.starts_with("[0]")) {
            std::string peeled = leafPath.substr(3).str();
            if (!peeled.empty() && peeled.front() == '.')
              peeled.erase(0, 1);
            lps.push_back(std::move(peeled));
          }
          for (const std::string &lp3 : lps) {
            std::string flat = lp3.empty()
                ? root
                : (root + (lp3.front() == '[' ? "" : ".") + lp3);
            std::string field = sanitizeName(prefixedName(flat, prefix));
            ctx.registry.registerSignal(field, w, /*authoritative=*/true);
          }
        });
      }
    }
  }

  for (Operation &op : mod.getBodyBlock()->getOperations()) {
    auto inst = dyn_cast<hw::InstanceOp>(&op);
    if (!inst) continue;
    auto callee = symTable.lookup<hw::HWModuleOp>(inst.getModuleName());
    if (!callee) continue;

    std::string childPath = joinInstPath(prefix, inst.getInstanceName());

    // Collect callee's port info.  Each entry is (name, type, width)
    // where width is 0 for non-integer ports; struct/array port leaves
    // are bridged separately by walking the type recursively.
    struct PortInfo {
      std::string name;
      Type type;
      unsigned width;  // 0 if non-integer
    };
    SmallVector<PortInfo, 8> calleeInputs;
    SmallVector<PortInfo, 4> calleeOutputs;
    for (auto p : callee.getPortList()) {
      unsigned w = 0;
      if (auto intTy = dyn_cast<IntegerType>(p.type)) w = intTy.getWidth();
      PortInfo info{p.getName().str(), p.type, w};
      if (p.dir == hw::ModulePort::Direction::Input)
        calleeInputs.push_back(std::move(info));
      else if (p.dir == hw::ModulePort::Direction::Output)
        calleeOutputs.push_back(std::move(info));
    }

    // Pre-register caller-side instance-result fields for scalar
    // outputs so any earlier caller comb_logic referencing
    // `s->u_inst_q` is consistent with what the OUTPUT bridge below
    // writes, and so output ports we cannot resolve still get a
    // (zero-init) state-struct field.
    for (const auto &pi : calleeOutputs) {
      if (pi.width == 0) continue;
      std::string callerInstResult = prefixedName(
          inst.getInstanceName().str() + "_" + pi.name, prefix);
      ctx.registry.registerSignal(callerInstResult, pi.width,
                                  /*authoritative=*/true);
    }

    // INPUT bridges — for each callee input port at index i, take
    // hw.instance's i-th operand (in declaration order, MLIR HW
    // convention) as the caller-side source.
    //
    // Three cases by operand type:
    //   - scalar integer: resolveValueExpr yields one bridge entry
    //   - struct/array  : walkLeaves emits one bridge per leaf field
    //   - unresolvable  : skip; field stays at 0 (Phase 2.b conservative)
    for (unsigned i = 0;
         i < inst.getNumOperands() && i < calleeInputs.size(); ++i) {
      const auto &pi = calleeInputs[i];
      Value operand = inst.getOperand(i);

      if (pi.width > 0) {
        std::string targetField = childPath + "_" + pi.name;
        ctx.registry.registerSignal(targetField, pi.width,
                                    /*authoritative=*/true);
        // Fault-countermeasure error inputs of OT's sparse-FSM wrappers
        // (mux_sel_err_i / sp_enc_err_i / rnd_ctr_err_i, a naming
        // convention shared across IPs): their producers compare
        // redundant rails / one-hot selects and fire on transients the
        // settle sweep can legitimately expose mid-iteration (aes CTR's
        // select swap latched a fatal on 3|4=7).  A functional model has
        // no fault injection to detect — tie them 0.
        if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
            (pi.name == "mux_sel_err_i" || pi.name == "sp_enc_err_i" ||
            pi.name == "rnd_ctr_err_i" || pi.name == "ecc_err_i")) {
          appendAssign(ctx, targetField, "0", pi.width);
          continue;
        }
        std::optional<std::string> resolvedExpr;
        if (!(pi.width > 128 && operand.getDefiningOp<comb::ConcatOp>()))
          resolvedExpr = resolveValueExpr(operand, prefix, &ctx.registry);
        // WIDE (>128-bit) integer port fed by comb.concat: no scalar C
        // expression can carry it — fill the uint64_t[] field segment by
        // segment (kmac's 352-bit cSHAKE prefix: 11 PREFIX registers
        // concatenated into sha3pad's prim_slicer input).
        if (!resolvedExpr && pi.width > 128) {
          if (auto cc = operand.getDefiningOp<comb::ConcatOp>()) {
            unsigned nW = (pi.width + 63) / 64;
            std::string dstF = "s->" + ctx.registry.lookup(targetField);
            std::string blk =
                "    { /* wide concat input fill: " + targetField + " */\n";
            bool ok = true;
            unsigned msbOff = pi.width;
            for (Value o : cc.getOperands()) {
              unsigned w = o.getType().getIntOrFloatBitWidth();
              msbOff -= w;
              if (w <= 64) {
                auto e = resolveValueExpr(o, prefix, &ctx.registry);
                if (!e) {
                  llvm::errs() << "  [WIDE-FILL bail] narrow seg w=" << w
                               << " op=";
                  if (Operation *d2 = o.getDefiningOp())
                    llvm::errs() << d2->getName();
                  else
                    llvm::errs() << "block-arg";
                  llvm::errs() << "\n";
                  ok = false; break;
                }
                blk += "    qpw_wide_insert(" + dstF + ", " +
                       std::to_string(nW) + ", " + std::to_string(msbOff) +
                       ", " + std::to_string(w) + ", (uint64_t)(" + *e +
                       "));\n";
              } else {
                auto root = resolveStructRootName(o);
                if (!root) {
                  // Not a named signal — project the segment 64-bit
                  // window by window through the generic wide projector
                  // (xor/extract/mux chains: lc_ctrl's 128-bit hashed
                  // token is share0[127:0] ^ share1[127:0] straight from
                  // the kmac response CDC).
                  bool projOk = true;
                  std::string pblk;
                  for (unsigned k = 0; k < w && projOk; k += 64) {
                    unsigned take = (w - k) < 64 ? (w - k) : 64;
                    auto pe = wideProjectExpr(o, k, take, prefix,
                                              ctx.registry);
                    if (!pe) { projOk = false; break; }
                    pblk += "    qpw_wide_insert(" + dstF + ", " +
                            std::to_string(nW) + ", " +
                            std::to_string(msbOff + k) + ", " +
                            std::to_string(take) + ", (uint64_t)(" + *pe +
                            "));\n";
                  }
                  if (projOk) { blk += pblk; continue; }
                  llvm::errs() << "  [WIDE-FILL bail] wide seg w=" << w
                               << " unresolvable root\n";
                  ok = false; break;
                }
                std::string srcName =
                    sanitizeName(prefixedName(*root, prefix));
                const auto &sigMap = ctx.registry.getSignals();
                auto sit = sigMap.find(srcName);
                if (sit == sigMap.end() || sit->second.nWords == 0) {
                  llvm::errs() << "  [WIDE-FILL bail] src field " << srcName
                               << " not wide in registry\n";
                  ok = false;
                  break;
                }
                unsigned srcW = sit->second.nWords;
                blk += "    for (unsigned _qp_k = 0; _qp_k < " +
                       std::to_string(w) + "u; _qp_k += 64)\n";
                blk += "        qpw_wide_insert(" + dstF + ", " +
                       std::to_string(nW) + ", " + std::to_string(msbOff) +
                       "u + _qp_k, (" + std::to_string(w) +
                       "u - _qp_k) < 64u ? (" + std::to_string(w) +
                       "u - _qp_k) : 64u, qpw_wide_extract(s->" + srcName +
                       ", " + std::to_string(srcW) + ", _qp_k, 64));\n";
              }
            }
            if (ok) {
              blk += "    }";
              clk_analysis::CombinationalAssignment raw;
              raw.targetSignal = "__RAW__";
              raw.expression = blk;
              raw.bitWidth = 0;
              ctx.combOut.push_back(std::move(raw));
              continue;
            }
          }
        }
        // LAST RESORT for a wide port: per-word projection through the
        // generic wide-value projector (mux/concat/replicate/bitcast —
        // keymgr's 800-bit gen_data mux).  Emitted as a __RAW__ fill.
        if (!resolvedExpr && pi.width > 64) {
          unsigned nW = (pi.width + 63) / 64;
          std::string dstF = "s->" + ctx.registry.lookup(targetField);
          std::string blk =
              "    { /* wide projected input fill: " + targetField + " */\n";
          bool okP = true;
          for (unsigned wI = 0; wI < nW && okP; ++wI) {
            unsigned ww = std::min(64u, pi.width - wI * 64);
            auto we = wideProjectExpr(operand, wI * 64, ww, prefix,
                                      ctx.registry);
            if (!we) { okP = false; break; }
            blk += "    qpw_wide_insert(" + dstF + ", " +
                   std::to_string(nW) + ", " + std::to_string(wI * 64) +
                   ", " + std::to_string(ww) + ", (uint64_t)(" + *we +
                   "));\n";
          }
          if (okP) {
            blk += "    }";
            clk_analysis::CombinationalAssignment raw;
            raw.targetSignal = "__RAW__";
            raw.expression = blk;
            raw.bitWidth = 0;
            ctx.combOut.push_back(std::move(raw));
            llvm::errs() << "  [WIDE-PROJ FILL] " << targetField << " ("
                         << nW << " words)\n";
            continue;
          }
        }
        // A give-up must say WHY.  The SKIP line named only the operand's op,
        // which cannot distinguish "the router has no rule" from "the
        // speculative budget refused a runaway cone".
        std::string bridgeWhy;
        // WIDE PORT, SAME DELEGATION.  wideProjectExpr is the input side's
        // own weaker projector; when it bails, ask the bit-range router for
        // each 64-bit word instead.  keymgr's u_kmac_if.gen_data_i is 800
        // bits and reached here on a plain comb.mux — that port is the KMAC
        // application-channel payload, so the whole key-derivation message
        // was arriving as zeros.
        if (!resolvedExpr && pi.width > 128) {
          unsigned nW = (pi.width + 63) / 64;
          std::string dstF = "s->" + ctx.registry.lookup(targetField);
          std::string blk =
              "    { /* wide input fill via sliceValue: " + targetField +
              " */\n";
          bool okW = true;
          {
            BridgeMapperScope mapperScope(prefix, ctx.registry);
            comb_translator::ExprBudgetScope budget(kBridgeExprBudget);
            for (unsigned wI = 0; wI < nW && okW; ++wI) {
              unsigned ww = std::min(64u, pi.width - wI * 64);
              auto we = comb_translator::sliceValue(operand, wI * 64, ww, 24);
              if (!we.success) {
                // A bail without a reason is how these stayed invisible.
                llvm::errs() << "  [INPUT-BRIDGE WIDE bail] "
                             << inst.getInstanceName() << "." << pi.name
                             << " word " << wI << "/" << nW << ": "
                             << we.errorMsg << "\n";
                okW = false;
                break;
              }
              std::string bad = bridgeExprUnresolved(we.expr, ctx.registry);
              if (!bad.empty()) {
                llvm::errs() << "  [INPUT-BRIDGE UNRESOLVED] "
                             << inst.getInstanceName() << "." << pi.name
                             << " -> s->" << bad << "\n";
                okW = false;
                break;
              }
              blk += "    qpw_wide_insert(" + dstF + ", " +
                     std::to_string(nW) + ", " + std::to_string(wI * 64) +
                     ", " + std::to_string(ww) + ", (uint64_t)(" + we.expr +
                     "));\n";
            }
          }
          if (okW) {
            blk += "    }";
            clk_analysis::CombinationalAssignment raw;
            raw.targetSignal = "__RAW__";
            raw.expression = blk;
            raw.bitWidth = 0;
            ctx.combOut.push_back(std::move(raw));
            llvm::errs() << "  [INPUT-BRIDGE via sliceValue] "
                         << inst.getInstanceName() << "." << pi.name << " ("
                         << nW << " words)\n";
            continue;
          }
        }
        if (!resolvedExpr && pi.width && pi.width <= 128) {
          // SAME DELEGATION AS THE OUTPUT SIDE (M10).  The input bridge also
          // carries a private resolver weaker than CombTranslator; keymgr's
          // u_kmac_if.gen_data_i died on a plain comb.mux.  The operand here
          // lives in the PARENT's scope, so the mapper takes `prefix`, not
          // childPath.  The same exit post-condition applies: a name that is
          // not a declared field means the whole translation is rejected.
          BridgeMapperScope mapperScope(prefix, ctx.registry);
          // Speculative: the bridge must be able to take no for an answer.
          comb_translator::ExprBudgetScope budget(kBridgeExprBudget);
          auto tr = comb_translator::translateValue(operand);
          if (tr.success && !tr.expr.empty()) {
            std::string bad = bridgeExprUnresolved(tr.expr, ctx.registry);
            if (bad.empty()) {
              appendAssign(ctx, targetField, tr.expr, pi.width);
              llvm::errs() << "  [INPUT-BRIDGE via translateValue] "
                           << inst.getInstanceName() << "." << pi.name << "\n";
              continue;
            }
            llvm::errs() << "  [INPUT-BRIDGE UNRESOLVED] "
                         << inst.getInstanceName() << "." << pi.name
                         << " -> s->" << bad << "\n";
          } else if (!tr.success) {
            bridgeWhy = tr.errorMsg;
          }
        }
        if (!resolvedExpr) {
          // A dropped INPUT bridge leaves the callee field at zero-init
          // forever (dma's u_opcode.d_i — the 71-bit packed config snapshot —
          // was silently dropped this way and the engine error-checked a
          // zeroed config).  Say so.
          llvm::errs() << "  [INPUT-BRIDGE SKIP] " << inst.getInstanceName()
                       << "." << pi.name << " (op: ";
          if (Operation *d = operand.getDefiningOp()) llvm::errs() << d->getName();
          else llvm::errs() << "block-arg";
          llvm::errs() << ")";
          if (!bridgeWhy.empty())
            llvm::errs() << " why: " << comb_translator::brief(bridgeWhy, 200);
          llvm::errs() << "\n";
          continue;
        }
        appendAssign(ctx, targetField, *resolvedExpr, pi.width);
        continue;
      }

      // Non-integer port: per-leaf bridging.  Handles three shapes
      // for `operand`:
      //   - struct/array storage value (BlockArg / instance result):
      //     one bridge per leaf, sourced from `<root>_<leaf>`.
      //   - hw.struct_create: each operand i resolved against the
      //     corresponding field type i (recursively) — what unblocks
      //     `u_reg_if.tl_o_pre → u_rsp_intg_gen.tl_i` in OT.
      //   - hw.bitcast of an all-zero constant: zero-fill every leaf.
      // On any unresolvable leaf we fall through (no bridge), which
      // keeps the field at init 0 — same conservative behaviour as
      // the pre-fix `walkLeaves`-only path.
      if (isa<hw::StructType>(pi.type) || isa<hw::ArrayType>(pi.type)) {
        LeafEmit emit = walkBridgeLeaves(pi.type, operand, prefix,
                                         ctx.registry);
        if (!emit.ok) {
          // A dropped aggregate INPUT bridge zeroes EVERY leaf of the port
          // (tlul_adapter_reg's tl_o_pre d_user filler took a_ready down
          // with it, silently killing all bus ACKs).  Say so.
          llvm::errs() << "  [INPUT-BRIDGE SKIP] " << inst.getInstanceName()
                       << "." << pi.name << " (aggregate; op: ";
          if (Operation *d = operand.getDefiningOp())
            llvm::errs() << d->getName();
          else
            llvm::errs() << "block-arg";
          llvm::errs() << ")\n";
          continue;
        }
        for (const auto &e : emit.leaves) {
          // leafPath may begin with "[" (array index) — do not insert a
          // "." separator in that case, otherwise sanitizeName turns
          // ".[" into "__" and we end up with `tl_d_i__0__d_data`
          // instead of the intended `tl_d_i_0__d_data` that callees
          // (post-ExplodeStructSigs) actually reference.
          std::string calleeFlat;
          if (e.leafPath.empty()) {
            calleeFlat = pi.name;
          } else if (e.leafPath.front() == '[') {
            calleeFlat = pi.name + e.leafPath;
          } else {
            calleeFlat = pi.name + "." + e.leafPath;
          }
          std::string calleeField = sanitizeName(
              prefixedName(calleeFlat, childPath));
          ctx.registry.registerSignal(calleeField, e.width);
          if (e.wordIndex >= 0) {
              ctx.registry.registerSignal(calleeField, e.width);
              clk_analysis::CombinationalAssignment wca;
              wca.targetSignal = ctx.registry.lookup(calleeField);
              wca.expression = e.exprC;
              wca.bitWidth = e.width;
              wca.wordIndex = e.wordIndex;
              ctx.combOut.push_back(std::move(wca));
          } else {
              appendAssign(ctx, calleeField, e.exprC, e.width);
          }
        }
      }
    }

    // prim_reg_cdc functional collapse.  The captured 2-clock-domain handshake
    // (req/ack toggles + pulse_sync + 2-flop syncs) never converges in the
    // bounded MMIO settle, so SW readback is stale/wrong (verified: aon
    // WKUP_COUNT echo reads 0x0 — the handshake half-completes).  A single-clock
    // functional model shouldn't run that handshake: collapse it to a
    // transparent pass-through — the SW transaction goes straight to the dst
    // domain, and SW readback = the live dst register value.  Drive the
    // instance's outputs from its just-bridged INPUT fields (above), then
    // `continue` to skip BOTH the recurse (internal FSM + arb/sync child
    // instances never emitted) and the normal hw.output bridges (which would
    // re-derive the stale handshake value, last-wins, and clobber this).  The
    // dst-side prim_subreg stays the single source of truth and already resolves
    // sw-write vs hw-update, so arbiter priority is preserved there.  Generic
    // over every prim_reg_cdc instance; mirrors the prim_fifo_sync_cnt
    // name-based handling.
    // TL-UL command-integrity checker collapse.  The model's MMIO presenter
    // drives a_user.cmd_intg with 0 (it cannot run the SECDED encoder per
    // access), so the checker would flag EVERY access as corrupt — before the
    // straight-line inliner this bridge happened to be dropped and the err
    // stayed 0 by accident; once the bridge healed, aes routed the false
    // integrity error into its fatal-alert latch at the first register write.
    // On a functional model the bus is trusted by construction: tie the
    // checker's error output to 0 and skip its normal output bridges.
    // Protocol-level knowledge (TL-UL), no device names involved.
    // Fault-injection countermeasure checkers: one-hot mux-select buffers
    // (`*_sel_buf_chk`) and sparse two-value signal buffers
    // (`*_sp2v_sig_buf_chk`) exist to catch PHYSICAL glitches — a select
    // momentarily carrying two one-hot values.  The settle model's sweep
    // iteration can legitimately expose exactly that transient (aes CTR's
    // select swap read 3|4 = 7 mid-sweep and latched a fatal alert on a
    // value real same-tick hardware can never sample).  Collapse ONLY the
    // error outputs to 0; the select pass-through outputs keep their
    // normal bridges.  Structural OT naming convention, no device names.
    // `_sp2v_sig_buf_chk` was a SECOND predicate here and it never matched
    // anything: it was written against an INSTANCE name
    // (u_aes_sp2v_sig_buf_chk_i) while the MODULE is aes_sel_buf_chk, which
    // the first predicate already covers.  Zero matches across all 37 board
    // IPs, so it is deleted rather than left as a rule nobody can test.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName().contains("_sel_buf_chk")) {
      bool collapsed = false;
      for (const auto &po : calleeOutputs) {
        if (po.width == 0) continue;
        if (!llvm::StringRef(po.name).contains("err")) continue;
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + po.name, prefix);
        appendAssign(ctx, callerInstResult, "0", po.width);
        collapsed = true;
      }
      if (collapsed) {
        // Recurse + bridge normally for the non-err outputs, but suppress
        // the checker's own err drivers by masking AFTER the recursion:
        // simplest correct form — run the normal path, then re-assert 0
        // (last-wins in emitted order).
        EmitCtx childCtx2 = ctx;
        childCtx2.instancePath = childPath;
        renderModule(callee, childCtx2, symTable);
        auto outOp2 = dyn_cast<hw::OutputOp>(
            callee.getBodyBlock()->getTerminator());
        if (outOp2) {
          unsigned numOut2 = std::min<unsigned>(outOp2.getNumOperands(),
                                                calleeOutputs.size());
          for (unsigned j2 = 0; j2 < numOut2; ++j2) {
            const auto &po = calleeOutputs[j2];
            if (po.width == 0) continue;
            std::string callerInstResult = prefixedName(
                inst.getInstanceName().str() + "_" + po.name, prefix);
            if (llvm::StringRef(po.name).contains("err")) {
              appendAssign(ctx, callerInstResult, "0", po.width);
              continue;
            }
            auto resolvedExpr =
                resolveValueExpr(outOp2.getOperand(j2), childPath,
                                 &ctx.registry);
            if (resolvedExpr)
              appendAssign(ctx, callerInstResult, *resolvedExpr, po.width);
          }
        }
        continue;
      }
    }

    // tlul_data_integ_dec joins the collapse set: the MMIO presenter drives
    // a_user.data_intg with 0, and the 2026 importer translates the SECDED
    // decoder correctly — so every SRAM-window write would flag
    // error_data_integ and get blanked (spi_device's SFDP egress buffer
    // read back all-zero).  The module's only outputs are error bits.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        (callee.getSymName().contains("tlul_cmd_intg_chk") ||
        callee.getSymName().contains("tlul_data_integ_dec") ||
        callee.getSymName().contains("prim_reg_we_check"))) {
      for (const auto &po : calleeOutputs) {
        if (po.width == 0) continue;
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + po.name, prefix);
        appendAssign(ctx, callerInstResult, "0", po.width);
      }
      continue;
    }

    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName().contains("prim_reg_cdc") &&
        !callee.getSymName().contains("_arb")) {
      auto inField = [&](const char *inPort) {
        return std::string("s->") +
               ctx.registry.lookup(prefixedName(inPort, childPath));
      };
      for (const auto &po : calleeOutputs) {
        if (po.width == 0) continue;
        std::string rhs;
        if (po.name == "dst_we_o")          rhs = inField("src_we_i");
        else if (po.name == "dst_re_o")     rhs = inField("src_re_i");
        else if (po.name == "dst_regwen_o") rhs = inField("src_regwen_i");
        else if (po.name == "dst_wd_o")     rhs = inField("src_wd_i");
        else if (po.name == "src_qs_o")     rhs = inField("dst_qs_i");
        else if (po.name == "src_busy_o")   rhs = "0";
        else continue;  // no other scalar outputs expected
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + po.name, prefix);
        appendAssign(ctx, callerInstResult, rhs, po.width);
      }
      continue;
    }

    // SRAM-FIFO functional collapse (data queue).  i2c/spi_device FIFOs
    // (FMT/RX/TX/ACQ) are multi-stage SRAM adapters (inp_buf -> SRAM -> oup_buf
    // + arbiter) the bounded MMIO settle can't keep coherent (un-freezing the
    // prim_fifo_sync_cnt pointers loses data or garbages the read pipeline —
    // acq depth underflows to 65533).  A FIFO is functionally just a queue:
    // collapse the whole adapter to a functional queue — occupancy `qcnt` +
    // data array `qdata[CAP]` (wptr/rptr).  depth/rvalid/wready/rdata are
    // combinational from the queue; the push/pop (with the runtime-indexed
    // qdata[wptr]=wdata write the single-LHS emitter can't express) is one raw
    // tick() block via the "__RAW__" emitAssign escape.  inp_buf/oup_buf/
    // sram_ptrs/SRAM sub-instances are never emitted (continue).  Recognized by
    // module name; uart/spi_host use plain prim_fifo_sync and are untouched.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName().contains("sram_adapter")) {
      bool continueNormalTranslation = false;
      auto isInput = [&](llvm::StringRef p) -> bool {
        for (const auto &port : callee.getPortList())
          if (port.dir == hw::ModulePort::Direction::Input &&
              port.getName() == p)
            return true;
        return false;
      };
      auto portWidth = [&](llvm::StringRef p) -> unsigned {
        for (const auto &port : callee.getPortList())
          if (port.getName() == p)
            if (auto it = dyn_cast<IntegerType>(port.type))
              return it.getWidth();
        return 0;
      };
      auto inField = [&](llvm::StringRef inPort) {
        return std::string("s->") +
               ctx.registry.lookup(prefixedName(inPort, childPath));
      };
      auto reg = [&](llvm::StringRef suffix, unsigned w) {
        std::string n =
            prefixedName(inst.getInstanceName().str() + suffix.str(), prefix);
        ctx.registry.registerSignal(n, w);
        return std::string("s->") + ctx.registry.lookup(n);
      };
      unsigned depthW = 0;
      for (const auto &po : calleeOutputs)
        if (po.name == "fifo_depth_o") depthW = po.width;
      if (depthW == 0) depthW = 16;
      // CAP = queue capacity (power of two upper-bounded by depth-port width);
      // also the data-array length.  Capped at 2^16 to bound state size.
      uint64_t cap =
          (depthW >= 16) ? (uint64_t(1) << 16) : (uint64_t(1) << depthW);
      std::string capNum = std::to_string(cap);
      unsigned dataW = portWidth("fifo_wdata_i");
      if (dataW == 0) dataW = 8;
      unsigned elemBits =
          dataW <= 8 ? 8 : dataW <= 16 ? 16 : dataW <= 32 ? 32 : 64;
      std::string elemTy = "uint" + std::to_string(elemBits) + "_t";
      std::string dataMask =
          (dataW >= 64)
              ? std::string("~(uint64_t)0")
              : (std::to_string((uint64_t(1) << dataW) - 1) + "ULL");
      std::string qc = reg("_qcnt", depthW);
      std::string wp = reg("_qwptr", depthW);
      std::string rp = reg("_qrptr", depthW);
      // Data array stored as a wide bitvector (uint64_t arr[N]); accessed as
      // an elemTy[] via cast (QEMU builds -fno-strict-aliasing).
      std::string data = reg("_qdata", (unsigned)(cap * elemBits));
      std::string arr = "((" + elemTy + " *)" + data + ")";

      // Combinational outputs from the queue.
      for (const auto &po : calleeOutputs) {
        if (po.width == 0) continue;
        std::string rhs;
        if (po.name == "fifo_depth_o")
          rhs = qc;
        else if (po.name == "fifo_rvalid_o")
          rhs = "((" + qc + ") > 0)";
        else if (po.name == "fifo_wready_o")
          rhs = "((" + qc + ") < " + capNum + ")";
        else if (po.name == "fifo_rdata_o")
          rhs = "((" + arr + "[" + rp + "]) & " + dataMask + ")";
        else
          rhs = "0";  // err, sram_* (skipped)
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + po.name, prefix);
        appendAssign(ctx, callerInstResult, rhs, po.width);
      }

      // Reset/clear condition (device reset rst_ni==0, or FIFO clr_i).
      std::string clrExpr = "0";
      {
        std::vector<std::string> terms;
        if (isInput("rst_ni"))
          terms.push_back("((" + inField("rst_ni") + ") == 0)");
        if (isInput("clr_i"))
          terms.push_back("(" + inField("clr_i") + ")");
        if (!terms.empty()) {
          clrExpr = terms[0];
          for (size_t i = 1; i < terms.size(); ++i)
            clrExpr += " || " + terms[i];
        }
      }
      // ORGAN CONTRACT.  This handler binds roles to OpenTitan port NAMES, and
      // the module predicate above is a SUBSTRING match, so it fires on any
      // module whose name happens to contain "sram_adapter".  It already does:
      // i2c_fifo_sync_sram_adapter has the fifo_* ports this expects, while
      // prim_fifo_async_sram_adapter and spid_fifo2sram_adapter name the same
      // signals wvalid_i/wdata_i/... with no prefix.
      //
      // The old code answered a missed lookup with a literal 0.  That turned
      // the one failure mode the emitter is otherwise LOUD about — an unknown
      // signal name produces a nonexistent field and breaks the C build — into
      // a silent one: five spi_device queues whose push and pop conditions
      // were `if ((0) && ...)`, a model that compiled, booted and passed the
      // gate while its upload path was dead.
      //
      // So state the contract and refuse.  A module that matches the name but
      // not the shape is NOT collapsed; it goes through normal translation,
      // where any loss it suffers is reported by the ordinary drop
      // diagnostics.  A loud drop beats a silent zero.
      {
        static const char *kRequired[] = {"fifo_wvalid_i", "fifo_rready_i",
                                          "fifo_wdata_i"};
        std::string missing;
        for (const char *p : kRequired)
          if (!isInput(p))
            missing += (missing.empty() ? "" : ", ") + std::string(p);
        if (portWidth("fifo_depth_o") == 0)
          missing += (missing.empty() ? "" : ", ") + std::string("fifo_depth_o");
        if (!missing.empty()) {
          llvm::errs() << "  [ORGAN CONTRACT MISS] " << callee.getSymName()
                       << " matched the sram_adapter organ but lacks: "
                       << missing << " - NOT collapsing; the module will be "
                       << "translated normally\n";
          continueNormalTranslation = true;
        }
      }
      if (!continueNormalTranslation) {
      std::string wv = inField("fifo_wvalid_i");
      std::string rr = inField("fifo_rready_i");
      std::string wd = inField("fifo_wdata_i");
      // Raw push/pop block (the runtime-indexed array write needs __RAW__).
      // push/pop strobes are one-shot (FDATA-write qe self-clears in u_reg), so
      // no settle over-count.
      std::string blk;
      blk += "    { /* functional FIFO queue: " +
             inst.getInstanceName().str() + " */\n";
      blk += "        if (" + clrExpr + ") { " + qc + " = 0; " + wp + " = 0; " +
             rp + " = 0; }\n";
      blk += "        else {\n";
      blk += "            if ((" + wv + ") && ((" + qc + ") < " + capNum +
             ")) {\n";
      blk += "                " + arr + "[" + wp + "] = (" + elemTy + ")(" + wd +
             ");\n";
      blk += "                " + wp + " = (" + wp + " + 1) % " + capNum + "; " +
             qc + " = " + qc + " + 1;\n";
      blk += "            }\n";
      blk += "            if ((" + rr + ") && ((" + qc + ") > 0)) { " + rp +
             " = (" + rp + " + 1) % " + capNum + "; " + qc + " = " + qc +
             " - 1; }\n";
      blk += "        }\n";
      blk += "    }";
      clk_analysis::CombinationalAssignment raw;
      raw.targetSignal = "__RAW__";
      raw.expression = blk;
      raw.bitWidth = 0;
      ctx.seqOut.push_back(std::move(raw));
      }  /* if (!continueNormalTranslation) */
      // Only suppress the real module body when the organ actually
      // fired.  On a contract miss the body must be rendered.
      if (!continueNormalTranslation) {
        continue;
      }
    }

    // prim_rom memory-organ collapse.  The technology-library ROM macro
    // arrives as an UNINITIALIZED all-zero aggregate constant (no
    // ROM_INIT_FILE at import), so the read port has nothing to read and
    // the normal expansion degenerates to a self-hold.  Collapse to a
    // backing-store array `_qp_mem[Depth]` (one uint64_t per word) plus
    // the macro's registered read port: rvalid <= req (reset 0),
    // rdata <= mem[addr] on req.  Content is injected from outside
    // (host harness / QEMU loader) by writing the array — the model
    // never bakes in an image.  Matched by exact module name; the
    // prim_rom_adv wrapper above it expands normally.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName() == "prim_rom") {
      auto portW = [&](llvm::StringRef p) -> unsigned {
        for (const auto &port : callee.getPortList())
          if (port.getName() == p)
            if (auto it = dyn_cast<IntegerType>(port.type))
              return it.getWidth();
        return 0;
      };
      auto inField = [&](llvm::StringRef inPort) {
        return std::string("s->") +
               ctx.registry.lookup(prefixedName(inPort, childPath));
      };
      unsigned addrW = portW("addr_i");
      unsigned dataW = 0;
      for (const auto &po : calleeOutputs)
        if (po.name == "rdata_o") dataW = po.width;
      if (addrW == 0 || addrW > 24 || dataW == 0 || dataW > 64) {
        llvm::errs() << "  [ROM-COLLAPSE SKIP] " << inst.getInstanceName()
                     << " addrW=" << addrW << " dataW=" << dataW << "\n";
        continue;
      }
      uint64_t depth = uint64_t(1) << addrW;
      std::string memName =
          prefixedName(inst.getInstanceName().str() + "_qp_mem", prefix);
      ctx.registry.registerSignal(memName, (unsigned)(depth * 64));
      std::string mem = "s->" + ctx.registry.lookup(memName);
      if (ctx.backingStores)
        ctx.backingStores->push_back({ctx.registry.lookup(memName), depth});
      auto outLeaf = [&](llvm::StringRef port, unsigned w) {
        std::string n = prefixedName(
            inst.getInstanceName().str() + "_" + port.str(), prefix);
        ctx.registry.registerSignal(n, w);
        return std::string("s->") + ctx.registry.lookup(n);
      };
      std::string rv = outLeaf("rvalid_o", 1);
      std::string rd = outLeaf("rdata_o", dataW);
      std::string blk;
      blk += "    { /* prim_rom memory organ: " +
             inst.getInstanceName().str() + " */\n";
      blk += "        if (!(" + inField("rst_ni") + ")) { " + rv + " = 0; }\n";
      blk += "        else {\n";
      blk += "            " + rv + " = (" + inField("req_i") + ") & 1;\n";
      blk += "            if (" + inField("req_i") + ") " + rd + " = " + mem +
             "[(" + inField("addr_i") + ") & " + std::to_string(depth - 1) +
             "ULL];\n";
      blk += "        }\n";
      blk += "    }";
      clk_analysis::CombinationalAssignment raw;
      raw.targetSignal = "__RAW__";
      raw.expression = blk;
      raw.bitWidth = 0;
      ctx.seqOut.push_back(std::move(raw));
      continue;
    }

    // prim_lc_sync passthrough collapse.  A 2-stage CDC synchronizer for
    // the life-cycle escalation signal: in the settle model there is no
    // clock-domain crossing to protect, but the two flop stages mean the
    // tied lc value does NOT reach consumers within the reset sequence's
    // two ticks — kmac's errchk FSM read the un-synced 0, took the
    // escalate arm to StError, and latched a boot-time fatal.  Replicate
    // the input onto every output copy combinationally.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName().contains("prim_lc_sync")) {
      auto inField = [&](llvm::StringRef inPort) {
        return std::string("s->") +
               ctx.registry.lookup(prefixedName(inPort, childPath));
      };
      for (const auto &po : calleeOutputs) {
        // lc_en_o is an AGGREGATE port (array<N x i4>) — po.width is 0 for
        // aggregates, so compute the bit count from the type.
        unsigned aggW = po.width;
        if (aggW == 0)
          if (int64_t bw = hw::getBitWidth(po.type); bw > 0)
            aggW = (unsigned)bw;
        if (aggW == 0) continue;
        // lc_en_o is NumCopies x 4 bits.  The aggregate output bridge
        // splits it into per-copy leaves `<inst>_<port>__<k>_` — emit one
        // passthrough per copy under the same naming so consumers (the
        // exploded lc_escalate_en[k] sigs) see the tied value.
        std::string in4 = "((" + inField("lc_en_i") + ") & 0xFULL)";
        unsigned copies = (aggW + 3) / 4;
        for (unsigned k = 0; k < copies; ++k) {
          std::string leaf = prefixedName(
              inst.getInstanceName().str() + "_" + po.name + "[" +
                  std::to_string(k) + "]",
              prefix);
          appendAssign(ctx, leaf, in4, 4);
        }
      }
      continue;
    }

    // prim_packer functional collapse (byte-stream packing buffer).
    // kmac's MSG_FIFO packer accumulates masked input bytes into a
    // 2*OutW stored_data/stored_mask pair — 128-bit values whose
    // mux/shift update the scalar expression emitter cannot carry
    // (uint64_t cannot hold them; the transitional emission produced
    // uncompilable C).  A packer is functionally a bit-append queue:
    // keep pos + 128-bit data/mask buffers, append `data_i & mask_i`
    // at pos on accept, emit the low OutW as a beat when full (or
    // flushing), shift down on beat accept.  Byte order is preserved,
    // which is the only property sha3pad consumes.  Generic: matched
    // by module name, no device knowledge.
    if (qemu_passes::usesOpenTitanRTLAdapter(callee) &&
        callee.getSymName().contains("prim_packer") &&
        !callee.getSymName().contains("fifo")) {
      auto inField = [&](llvm::StringRef inPort) {
        return std::string("s->") +
               ctx.registry.lookup(prefixedName(inPort, childPath));
      };
      auto reg = [&](llvm::StringRef suffix, unsigned w) {
        std::string n =
            prefixedName(inst.getInstanceName().str() + suffix.str(), prefix);
        ctx.registry.registerSignal(n, w);
        return std::string("s->") + ctx.registry.lookup(n);
      };
      unsigned outW = 0;
      for (const auto &po : calleeOutputs)
        if (po.name == "data_o") outW = po.width;
      if (outW == 0 || outW > 64) { /* unsupported shape */ } else {
      std::string pos = reg("_pkpos", 8);
      std::string fl  = reg("_pkflush", 1);  // sticky: flush_i is a PULSE
      std::string blo = reg("_pkdlo", 64), bhi = reg("_pkdhi", 64);
      std::string mlo = reg("_pkmlo", 64), mhi = reg("_pkmhi", 64);
      std::string vI  = inField("valid_i"), dI = inField("data_i");
      std::string mI  = inField("mask_i"), rI = inField("ready_i");
      std::string fI  = inField("flush_i"), rstN = inField("rst_ni");
      std::string oW  = std::to_string(outW);
      // Combinational outputs.
      for (const auto &po : calleeOutputs) {
        if (po.width == 0) continue;
        std::string rhs;
        if (po.name == "valid_o")
          rhs = "(((" + pos + ") >= " + oW + ") || ((((" + fI + ") | (" +
                fl + ")) != 0) && ((" + pos + ") > 0)))";
        else if (po.name == "data_o")
          rhs = blo;
        else if (po.name == "mask_o")
          rhs = mlo;
        else if (po.name == "ready_o")
          rhs = "((" + pos + ") <= " + oW + ")";
        else if (po.name == "flush_done_o")
          rhs = "(((((" + fI + ") | (" + fl + ")) != 0)) && ((" + pos +
                ") == 0))";
        else
          rhs = "0";  // err_o
        std::string callerInstResult = prefixedName(
            inst.getInstanceName().str() + "_" + po.name, prefix);
        appendAssign(ctx, callerInstResult, rhs, po.width);
      }
      // Raw tick block: push (append at pos) then pop (shift down).
      std::string blk;
      blk += "    { /* functional packer: " + inst.getInstanceName().str() +
             " */\n";
      blk += "        if ((" + rstN + ") == 0) { " + pos + " = 0; " + blo +
             " = 0; " + bhi + " = 0; " + mlo + " = 0; " + mhi + " = 0; " +
             fl + " = 0; }\n";
      blk += "        else {\n";
      blk += "            if (" + fI + ") " + fl + " = 1;\n";
      blk += "            else if ((" + fl + ") && ((" + pos +
             ") == 0)) " + fl + " = 0;\n";
      blk += "            __uint128_t _pd = ((__uint128_t)(" + bhi +
             ") << 64) | (" + blo + ");\n";
      blk += "            __uint128_t _pm = ((__uint128_t)(" + mhi +
             ") << 64) | (" + mlo + ");\n";
      // The pop decision below must use the REGISTERED position (the value
      // the comb valid_o/ready_o were computed from), not the post-append
      // one: judging `pos >= OutW` after the same-tick append consumed the
      // beat one tick early, so the comb window never saw a full word and
      // the downstream FIFO never received it (rom_ctrl's 5-byte app
      // stream vaporized word by word; the SW KAT's short messages never
      // fill a word and never reached this path).\n
      blk += "            unsigned _ppre = (unsigned)(" + pos + ");\n";
      blk += "            if ((" + vI + ") && (_ppre <= " + oW +
             ")) {\n";
      // TL byte lanes: a 1-byte write at offset k arrives with data and
      // mask in bit lane [8k+7:8k].  The packer's contract right-aligns
      // the masked bytes before appending (prim_packer asserts the mask
      // is contiguous) — without this shift every non-lane-0 byte landed
      // 8*k bits too high (kmac's "abc" packed as 61@0,62@16,63@32).
      blk += "                { unsigned _pksh = ((" + mI +
             ") != 0) ? (unsigned)__builtin_ctzll(" + mI + ") : 0u;\n";
      blk += "                _pd |= ((__uint128_t)(((" + dI + ") & (" + mI +
             ")) >> _pksh)) << (" + pos + ");\n";
      blk += "                _pm |= ((__uint128_t)((" + mI +
             ") >> _pksh)) << (" + pos + "); }\n";
      blk += "                " + pos + " = (" + pos +
             ") + (unsigned)__builtin_popcountll(" + mI + ");\n";
      blk += "            }\n";
      blk += "            if (((_ppre >= " + oW + ") || ((((" +
             fI + ") | (" + fl + ")) != 0) && (_ppre > 0))) && (" + rI +
             ")) {\n";
      blk += "                _pd >>= " + oW + "; _pm >>= " + oW + ";\n";
      blk += "                " + pos + " = (_ppre >= " + oW +
             ") ? (" + pos + ") - " + oW + " : ((" + pos +
             ") - _ppre);\n";
      blk += "            }\n";
      blk += "            " + blo + " = (uint64_t)_pd; " + bhi +
             " = (uint64_t)(_pd >> 64);\n";
      blk += "            " + mlo + " = (uint64_t)_pm; " + mhi +
             " = (uint64_t)(_pm >> 64);\n";
      blk += "        }\n";
      blk += "    }";
      clk_analysis::CombinationalAssignment raw;
      raw.targetSignal = "__RAW__";
      raw.expression = blk;
      raw.bitWidth = 0;
      ctx.seqOut.push_back(std::move(raw));
      continue;
      }
    }

    // Recurse — appends callee's comb (and any nested-instance
    // bridges) AFTER the input bridges above so the callee body sees
    // the freshly-bridged input fields when its own update_state
    // entries run.
    EmitCtx childCtx = ctx;
    childCtx.instancePath = childPath;
    renderModule(callee, childCtx, symTable);

    // OUTPUT bridges — for each callee output port j, take
    // callee-side hw.output operand[j] as the source and assign into
    // the caller-side instance-result field.  Same three-case split
    // by operand type.
    auto outOp = dyn_cast<hw::OutputOp>(
        callee.getBodyBlock()->getTerminator());
    if (outOp) {
      unsigned numOut = std::min<unsigned>(outOp.getNumOperands(),
                                            calleeOutputs.size());
      for (unsigned j = 0; j < numOut; ++j) {
        const auto &pi = calleeOutputs[j];
        Value operand = outOp.getOperand(j);

        if (pi.width > 0) {
          if (getenv("QP_DBG_OBRIDGE"))
            llvm::errs() << "  [OBRIDGE-TRY] " << inst.getInstanceName()
                         << "." << pi.name << "\n";
          auto resolvedExpr =
              resolveValueExpr(operand, childPath, &ctx.registry);
          if (!resolvedExpr) {
            // Fallback: word-wise projection.  Handles shapes the plain
            // resolver cannot name (csrng block_encrypt's rsp_data_o: a
            // concat of 16 array_get bytes off the AES core's aggregate
            // instance result) — each 64-bit window resolves through
            // wideProjectExpr's structural arms.
            bool projected = true;
            std::string callerInstResult = prefixedName(
                inst.getInstanceName().str() + "_" + pi.name, prefix);
            llvm::SmallVector<std::string, 4> wexprs;
            for (unsigned k = 0; projected && k * 64 < pi.width; ++k) {
              unsigned ww = std::min(64u, pi.width - k * 64);
              auto we = wideProjectExpr(operand, k * 64, ww, childPath,
                                        ctx.registry);
              if (!we)
                projected = false;
              else
                wexprs.push_back(*we);
            }
            if (projected) {
              if (pi.width <= 64) {
                appendAssign(ctx, callerInstResult, wexprs[0], pi.width);
              } else if (pi.width <= 128) {
                // __uint128_t scalar field: one combined assignment.
                appendAssign(ctx, callerInstResult,
                             "((((__uint128_t)(" + wexprs[1] +
                                 ")) << 64) | ((__uint128_t)(" + wexprs[0] +
                                 ")))",
                             pi.width);
              } else {
                std::string cf = sanitizeName(callerInstResult);
                ctx.registry.registerSignal(cf, pi.width);
                for (unsigned k = 0; k < wexprs.size(); ++k) {
                  clk_analysis::CombinationalAssignment wca;
                  wca.targetSignal = ctx.registry.lookup(cf);
                  wca.expression = wexprs[k];
                  wca.bitWidth = pi.width;
                  wca.wordIndex = (int)k;
                  ctx.combOut.push_back(std::move(wca));
                }
              }
              continue;
            }
            // LAST RESORT: hand it to CombTranslator.  The private resolver
            // above is a second, weaker implementation of the same job — it
            // refuses comb.icmp, func.call and hw.bitcast, all of which
            // CombTranslator has handled for months.  That is the same shape
            // of defect M1b fixed for slicePacked: a capable router existed
            // and the caller could not reach it.  The confirmed casualties
            // were aes_ctr's ctr_o (8 fields, so the CTR counter never
            // advanced), alert_handler's two shadow-CSR error outputs and
            // kmac's sha3_fsm_o.
            //
            // The reason it could not simply be called is naming:
            // translateValue names signals as written inside their own
            // module, while the emitter flattens the hierarchy.  The mapper
            // supplies that translation and returns nullopt for a field that
            // does not exist, so a name is never invented.
            {
              BridgeMapperScope mapperScope(childPath, ctx.registry);
              comb_translator::ExprBudgetScope budget(kBridgeExprBudget);
              auto tr = comb_translator::translateValue(operand);
              if (getenv("QP_DBG_MAP") && !tr.success)
                llvm::errs() << "    [translateValue failed] " << tr.errorMsg
                             << "\n";
              if (tr.success && !tr.expr.empty() &&
                  !bridgeExprUnresolved(tr.expr, ctx.registry).empty()) {
                llvm::errs() << "  [OUTPUT-BRIDGE UNRESOLVED] "
                             << inst.getInstanceName() << "." << pi.name
                             << " -> s->"
                             << bridgeExprUnresolved(tr.expr, ctx.registry)
                             << "\n";
                tr.success = false;
              }
              if (tr.success && !tr.expr.empty()) {
                appendAssign(ctx, callerInstResult, tr.expr, pi.width);
                llvm::errs() << "  [OUTPUT-BRIDGE via translateValue] "
                             << inst.getInstanceName() << "." << pi.name
                             << "\n";
                continue;
              }
            }
            // A dropped output bridge leaves the caller-side field forever
            // at its reset value — say so (spi_device's status FIFO rvalid_o
            // vanished this way behind an unsupported comb.parity).
            llvm::errs() << "  [OUTPUT-BRIDGE SKIP] " << inst.getInstanceName()
                         << "." << pi.name << " (op: ";
            if (Operation *d = operand.getDefiningOp()) llvm::errs() << d->getName();
            else llvm::errs() << "block-arg";
            llvm::errs() << ")\n";
            if (getenv("QP_DEBUG_BRIDGE"))
              if (Operation *d = operand.getDefiningOp()) {
                d->print(llvm::errs());
                llvm::errs() << "\n";
                for (Value o : d->getOperands())
                  if (Operation *d2 = o.getDefiningOp()) {
                    llvm::errs() << "    <- ";
                    d2->print(llvm::errs());
                    llvm::errs() << "\n";
                  }
              }
            continue;
          }
          std::string callerInstResult = prefixedName(
              inst.getInstanceName().str() + "_" + pi.name, prefix);
          appendAssign(ctx, callerInstResult, *resolvedExpr, pi.width);
          continue;
        }

        if (isa<hw::StructType>(pi.type) || isa<hw::ArrayType>(pi.type)) {
          // Same per-leaf treatment as the input bridge, mirrored for
          // the callee → caller direction.  The operand here is the
          // value driving the callee's `hw.output` at port j, in
          // `childPath`'s namespace; the resolved expression is the
          // RHS for the caller-side instance-result leaf.
          LeafEmit emit = walkBridgeLeaves(pi.type, operand, childPath,
                                           ctx.registry);
          if (!emit.ok) {
            // LAST RESORT for an AGGREGATE port: ask the bit-range router
            // for each leaf instead of demanding a whole-value carrier.
            // walkBridgeLeaves needs a leaf-shaped source; an operand like
            // `bitcast(<wide expr>)` or `struct_create(<mux>, ...)` has none.
            //
            // Two confirmed casualties.  aes_ctr's ctr_o (array<8 x i16>) —
            // 8 fields, so the CTR counter never advanced, which the
            // single-block KAT could not see.  And hmac's sha_rdata_o
            // (struct<data: i32, mask: i4>) — the SHA-2 core's FIFO read
            // data, so `u_prim_sha2_512_fifo_rdata_i_data` was assigned from
            // a field nothing writes and the engine hashed ZEROS while three
            // gate targets reported PASS.
            //
            // Leaf naming and bit layout must match what the emitter uses
            // everywhere else: a struct's field 0 occupies the HIGHEST bits
            // (walk down from the total width), an array's element 0 the
            // LOWEST; leaf paths join with '.' except an array index, which
            // appends "[k]" with no dot.
            {
              struct Leaf { std::string path; uint64_t off; unsigned width; };
              llvm::SmallVector<Leaf, 16> leaves;
              bool shapeOk = true;
              std::function<void(mlir::Type, const std::string &, uint64_t)>
                  walk = [&](mlir::Type ty, const std::string &path,
                             uint64_t base) {
                    if (!shapeOk)
                      return;
                    if (auto it = dyn_cast<IntegerType>(ty)) {
                      if (!it.getWidth() || it.getWidth() > 64) {
                        shapeOk = false;
                        return;
                      }
                      leaves.push_back({path, base, it.getWidth()});
                      return;
                    }
                    if (auto st = dyn_cast<hw::StructType>(ty)) {
                      int64_t total = hw::getBitWidth(st);
                      if (total <= 0) { shapeOk = false; return; }
                      uint64_t pos = (uint64_t)total;
                      for (auto fld : st.getElements()) {
                        int64_t fw = hw::getBitWidth(fld.type);
                        if (fw <= 0) { shapeOk = false; return; }
                        pos -= (uint64_t)fw;
                        walk(fld.type, path + "." + fld.name.getValue().str(),
                             base + pos);
                      }
                      return;
                    }
                    if (auto at = dyn_cast<hw::ArrayType>(ty)) {
                      int64_t ew = hw::getBitWidth(at.getElementType());
                      if (ew <= 0) { shapeOk = false; return; }
                      for (unsigned k = 0; k < at.getNumElements(); ++k)
                        walk(at.getElementType(),
                             path + "[" + std::to_string(k) + "]",
                             base + (uint64_t)k * (uint64_t)ew);
                      return;
                    }
                    shapeOk = false;
                  };
              walk(pi.type, std::string(), 0);
              if (shapeOk && !leaves.empty() && leaves.size() <= 256) {
                llvm::SmallVector<std::string, 16> exprs;
                bool all = true;
                {
                  BridgeMapperScope mapperScope(childPath, ctx.registry);
                  comb_translator::ExprBudgetScope budget(kBridgeExprBudget);
                  for (const Leaf &lf : leaves) {
                    auto e2 = comb_translator::sliceValue(operand, lf.off,
                                                          lf.width, 16);
                    if (!e2.success) { all = false; break; }
                    std::string bad =
                        bridgeExprUnresolved(e2.expr, ctx.registry);
                    if (!bad.empty()) {
                      llvm::errs() << "  [OUTPUT-BRIDGE UNRESOLVED] "
                                   << inst.getInstanceName() << "." << pi.name
                                   << " -> s->" << bad << "\n";
                      all = false;
                      break;
                    }
                    exprs.push_back(e2.expr);
                  }
                }
                if (all) {
                  for (size_t li = 0; li < leaves.size(); ++li) {
                    std::string callerFlat = inst.getInstanceName().str() +
                                             "_" + pi.name + leaves[li].path;
                    std::string callerField =
                        sanitizeName(prefixedName(callerFlat, prefix));
                    ctx.registry.registerSignal(callerField,
                                                leaves[li].width);
                    appendAssign(ctx, callerField, exprs[li],
                                 leaves[li].width);
                  }
                  llvm::errs() << "  [OUTPUT-BRIDGE via sliceValue] "
                               << inst.getInstanceName() << "." << pi.name
                               << " (" << leaves.size() << " leaves)\n";
                  continue;
                }
              }
            }
            llvm::errs() << "  [OUTPUT-BRIDGE SKIP] " << inst.getInstanceName()
                         << "." << pi.name << " (aggregate; op: ";
            if (Operation *d = operand.getDefiningOp()) llvm::errs() << d->getName();
            else llvm::errs() << "block-arg";
            llvm::errs() << ")\n";
            continue;
          }
          // Single-element array port (array<1 x T>): consumers that
          // reach the value through a bitcast PEEL the wrapper and read
          // the BARE name, while walkLeaves spells the "[0]" leaf —
          // entropy_src's fw_over mubi8 sync (array<1 x i8>) read zero
          // forever.  Emit every leaf under BOTH spellings.
          bool peelOne = false;
          if (auto arr1 = dyn_cast<hw::ArrayType>(pi.type))
            peelOne = arr1.getNumElements() == 1;
          for (const auto &e : emit.leaves) {
            // No "." before an array index — the convention every other
            // naming path follows (rv_plic's prio fix covered the legacy
            // input fallback; this output-bridge join had the same bug:
            // sha2's digest_o[k] writer became digest_o__k_ while the
            // caller read digest_o_k_ — the DIGEST CSR read zeroes).
            llvm::SmallVector<std::string, 2> paths;
            paths.push_back(e.leafPath);
            if (peelOne && llvm::StringRef(e.leafPath).starts_with("[0]")) {
              std::string peeled = e.leafPath.substr(3);
              if (!peeled.empty() && peeled.front() == '.')
                peeled.erase(0, 1);
              paths.push_back(std::move(peeled));
            }
            for (const std::string &lp2 : paths) {
              std::string callerFlat = lp2.empty()
                  ? (inst.getInstanceName().str() + "_" + pi.name)
                  : (inst.getInstanceName().str() + "_" + pi.name +
                     (lp2.front() == '[' ? "" : ".") + lp2);
              std::string callerField = sanitizeName(
                  prefixedName(callerFlat, prefix));
              ctx.registry.registerSignal(callerField, e.width);
              if (e.wordIndex >= 0) {
                  ctx.registry.registerSignal(callerField, e.width);
                  clk_analysis::CombinationalAssignment wca;
                  wca.targetSignal = ctx.registry.lookup(callerField);
                  wca.expression = e.exprC;
                  wca.bitWidth = e.width;
                  wca.wordIndex = e.wordIndex;
                  ctx.combOut.push_back(std::move(wca));
              } else {
                  appendAssign(ctx, callerField, e.exprC, e.width);
              }
            }
          }
          // AND MATERIALISE THE PACKED FORM.
          //
          // The parent may use the port as a WHOLE value even though the data
          // lives in the leaves.  pinmux does exactly that: prim_pad_attr
          // drives attr_warl_o field by field, the parent ANDs the whole
          // struct against the pad-attribute register, and the packed field
          // was written by nothing — so the WARL mask was 0 and every one of
          // the 63 pads read its attributes back as 0.  It was also declared
          // 4 bits wide for a 14-bit struct, because the only widths anyone
          // had registered for that name came from narrow bit-extracts.
          //
          // This is the mirror of the ALIAS FILL rule: there the wide form is
          // written and the leaves are read, here the leaves are written and
          // the packed form is read.  Same principle — one RTL value must not
          // have two C names that disagree.
          {
            llvm::SmallVector<BridgeLeafSpec, 16> specs;
            if (collectTypeLeaves(pi.type, specs)) {
              uint64_t total = 0;
              for (const auto &sp : specs)
                total = std::max(total, sp.off + sp.width);
              if (total && total <= 64) {
                std::string packed;
                for (const auto &sp : specs) {
                  std::string flat = inst.getInstanceName().str() + "_" +
                                     pi.name +
                                     (sp.path.empty()
                                          ? std::string()
                                          : (sp.path.front() == '['
                                                 ? sp.path
                                                 : sp.path));
                  std::string fld =
                      sanitizeName(prefixedName(flat, prefix));
                  std::string term = "(((uint64_t)(s->" + fld + ")) << " +
                                     std::to_string(sp.off) + ")";
                  packed = packed.empty() ? term : (packed + " | " + term);
                }
                std::string packedFlat =
                    inst.getInstanceName().str() + "_" + pi.name;
                std::string packedField =
                    sanitizeName(prefixedName(packedFlat, prefix));
                ctx.registry.registerSignal(packedField, (unsigned)total,
                                            /*authoritative=*/true);
                appendAssign(ctx, packedField, "(" + packed + ")",
                             (unsigned)total);
                llvm::errs() << "  [PACK FROM LEAVES] " << inst.getInstanceName()
                             << "." << pi.name << " (" << specs.size()
                             << " leaves -> " << total << " bits)\n";
              }
            }
          }
        }
      }
    }
  }
}

//===----------------------------------------------------------------------===//
// Bus Interface Port (BIP) — Protocol-Decoupled Bus Mapping
//
// A BIP represents a signal that bridges the QEMU MMIO external interface
// and the internal combinational logic.  Instead of hardcoding protocol-
// specific register maps (APB/TL-UL/AXI), we extract these from
// Phase 1's `qemu.functional_txns` attribute.
//
// For a WRITE transaction:
//   QEMU _write(addr, value) --> s->addr_signal = addr;
//                                s->wdata_signal = value;
//                                update_state(s);
//
// For a READ transaction:
//   QEMU _read(addr) --> s->addr_signal = addr;
//                        update_state(s);
//                        return s->rdata_signal;
//
// This design erases the struct layer: no matter what bus struct (tl_i,
// apb_paddr, etc.) the hardware used, QEMU's native read/write directly
// connects to the flattened data-flow variables.
//===----------------------------------------------------------------------===//

struct BusInterfaceMapping {
  /// Inferred addr/wdata/rdata signal names (sanitized, C-safe).
  /// Empty string means "not inferred / not present".
  std::string addrSignal;
  std::string wdataSignal;
  std::string rdataSignal;
  std::string enableSignal;
  std::string maskSignal;

  /// Bit widths (0 = unknown)
  unsigned addrWidth  = 0;
  unsigned wdataWidth = 0;
  unsigned rdataWidth = 0;

  /// Transaction kind from Phase 1
  enum Kind { READ, WRITE, UNKNOWN } kind = UNKNOWN;

  /// Confidence and quality flags
  double confidence = 0.0;
  bool weak = false;
  bool isBusWrite = false;
};

/// Extract Bus Interface Mappings from qemu.functional_txns across all
/// hw.module ops.  We scan ALL modules (not just the top) because the
/// bus transaction inference may have tagged sub-modules (e.g. uart_reg_top).
///
/// Returns the collected BIPs, plus populates `bipSignals` with the set
/// of signal names that are Bus Interface Ports (for state-struct registration).
static std::vector<BusInterfaceMapping>
extractBusInterfaceMappings(ModuleOp mod,
                            llvm::StringSet<> &bipSignals) {
  std::vector<BusInterfaceMapping> result;

  // Declaration overrides derivation across the whole hierarchy.  It is not
  // enough to preserve the declared top-module attribute in FBTI: that pass
  // may still infer candidates on adapter/child modules, and the old emitter
  // merged all of them with the declaration.  If any module is explicitly
  // marked, consume only explicitly marked modules.
  bool hasDeclaredModule = false;
  mod.walk([&](hw::HWModuleOp hwMod) {
    hasDeclaredModule |= hwMod->hasAttr("qemu.bus_profile_declared");
  });

  mod.walk([&](hw::HWModuleOp hwMod) {
    if (hasDeclaredModule &&
        !hwMod->hasAttr("qemu.bus_profile_declared"))
      return;
    auto txnArrayAttr =
        hwMod->getAttrOfType<ArrayAttr>("qemu.functional_txns");
    if (!txnArrayAttr)
      return;

    for (Attribute elem : txnArrayAttr) {
      auto dictAttr = dyn_cast<DictionaryAttr>(elem);
      if (!dictAttr)
        continue;

      BusInterfaceMapping bip;

      // --- Parse kind ---
      if (auto kindAttr = dictAttr.getAs<StringAttr>("kind")) {
        llvm::StringRef k = kindAttr.getValue();
        if (k == "READ")       bip.kind = BusInterfaceMapping::READ;
        else if (k == "WRITE") bip.kind = BusInterfaceMapping::WRITE;
        else                   bip.kind = BusInterfaceMapping::UNKNOWN;
      }

      // --- Parse confidence / quality ---
      if (auto confAttr = dictAttr.getAs<FloatAttr>("confidence"))
        bip.confidence = confAttr.getValueAsDouble();
      if (auto weakAttr = dictAttr.getAs<BoolAttr>("weak"))
        bip.weak = weakAttr.getValue();
      if (auto busAttr = dictAttr.getAs<BoolAttr>("is_bus_write"))
        bip.isBusWrite = busAttr.getValue();

      // --- Parse signal names (the core protocol-decoupled bindings) ---
      if (auto attr = dictAttr.getAs<StringAttr>("addr_signal")) {
        bip.addrSignal = attr.getValue().str();
        bipSignals.insert(bip.addrSignal);
      }
      if (auto attr = dictAttr.getAs<StringAttr>("wdata_signal")) {
        bip.wdataSignal = attr.getValue().str();
        bipSignals.insert(bip.wdataSignal);
      }
      if (auto attr = dictAttr.getAs<StringAttr>("rdata_signal")) {
        bip.rdataSignal = attr.getValue().str();
        bipSignals.insert(bip.rdataSignal);
      }
      if (auto attr = dictAttr.getAs<StringAttr>("enable_signal")) {
        bip.enableSignal = attr.getValue().str();
        bipSignals.insert(bip.enableSignal);
      }
      if (auto attr = dictAttr.getAs<StringAttr>("mask_signal")) {
        bip.maskSignal = attr.getValue().str();
        bipSignals.insert(bip.maskSignal);
      }

      // --- Parse widths ---
      if (auto attr = dictAttr.getAs<IntegerAttr>("addr_width"))
        bip.addrWidth = attr.getInt();
      if (auto attr = dictAttr.getAs<IntegerAttr>("wdata_width"))
        bip.wdataWidth = attr.getInt();
      if (auto attr = dictAttr.getAs<IntegerAttr>("rdata_width"))
        bip.rdataWidth = attr.getInt();

      result.push_back(bip);
    }
  });

  return result;
}

//===----------------------------------------------------------------------===//
// Merged Bus Interface: Combine READ and WRITE BIPs into a unified view
//
// When Phase 1 produces separate READ and WRITE candidates for the same
// module, we merge them: take the best addr_signal, the WRITE's wdata,
// and the READ's rdata.  This gives us a single, coherent bus mapping.
//===----------------------------------------------------------------------===//

struct MergedBusInterface {
  std::string addrSignal;
  std::string wdataSignal;
  std::string rdataSignal;
  std::string enableSignal;
  std::string maskSignal;
  // TL-UL handshake fields populated by applyTLULOverride() when the IR
  // matches the TL-UL convention.  Empty when the convention isn't
  // detected — generateProtocolAgnosticSource then skips emitting them.
  std::string validSignal;   // e.g. "tl_i_a_valid"  — pulled high during a txn
  std::string opcodeSignal;  // e.g. "tl_i_a_opcode" — write=0 (PutFullData), read=4 (Get)
  std::string sizeSignal;    // "tl_i_a_size" — 2 (4-byte access)
  std::string instrTypeSignal; // "tl_i_a_user_instr_type" — MuBi4False (0x9): data access
  std::string dReadySignal;    // "<base>_d_ready" — response acceptor (was a hardcoded tl_i_d_ready)
  unsigned addrWidth  = 32;
  unsigned wdataWidth = 32;
  unsigned rdataWidth = 32;
  unsigned opcodeWidth = 3;  // TL-UL fixes a_opcode at 3 bits
  bool valid = false;  // true if at least addr+wdata or addr+rdata found
};

//===----------------------------------------------------------------------===//
// ACCUMULATE Counter Collection (Phase 1: ptimer wiring)
//
// DrvClassificationPass marks sequential drvs of the form `reg = prb(reg) ±
// const` with `qemu.drv_class = "ACCUMULATE"` and `qemu.step = <const>`.  We
// consume those attributes here to emit actual ptimer-backed counter logic in
// the generated C code: a per-counter callback, ptimer init, read-side sync
// (so MMIO reads return the live count), and a write-side reload (so MMIO
// writes that change the register restart the timer).
//===----------------------------------------------------------------------===//
struct AccumulateCounter {
  std::string originalName;    // Raw signal name from llhd.sig
  std::string sanitizedName;   // C-identifier-safe name (FLAT registry)
  int32_t     step = 0;        // +N or -N per tick (from qemu.step)
  unsigned    bitWidth = 32;
};

/// Walk the hw.instance tree from the given top module and collect
/// ACCUMULATE-classified drvs at each instance, prefixing each counter's
/// state-struct field with its instance path.
///
/// Phase 2.a alignment: the module-flat walk that this replaces is
/// inconsistent with renderModule's per-instance prefixing — counters
/// in a sub-module instantiated multiple times need one ptimer per
/// instance, not one shared ptimer.  Walking via the instance tree
/// gives every counter a unique prefixed `sanitizedName`.
static void
collectAccumulateCountersImpl(hw::HWModuleOp mod,
                              llvm::StringRef prefix,
                              SymbolTable &symTable,
                              FlatSignalRegistry &registry,
                              llvm::StringSet<> &seen,
                              std::vector<AccumulateCounter> &counters) {
  mod.walk([&](llhd::DriveOp drv) {
    auto classAttr = drv->getAttrOfType<StringAttr>("qemu.drv_class");
    if (!classAttr || classAttr.getValue() != "ACCUMULATE")
      return;

    // FIFO pointer counters (wptr/rptr) live in OpenTitan's prim_fifo_sync_cnt
    // primitive.  They are EVENT-driven — advanced once per push/pop by the
    // chardev backend — not free-running timers, so they must NOT be routed to
    // a QEMU ptimer (a ptimer would make them drift over time with no I/O).
    // Skipping them here leaves them classified ACCUMULATE (so they stay
    // dropped from tick() → no settle-loop over-count) but with no ptimer:
    // they become plain state fields the shim owns and advances discretely.
    // Real timers (rv_timer / aon_timer counters) are not in this module and
    // keep their ptimer.
    if (qemu_passes::usesOpenTitanRTLAdapter(mod) &&
        mod.getSymName().contains("prim_fifo_sync_cnt"))
      return;

    // Unwrap llhd.sig.extract chains to reach the base llhd.sig
    Value sig = drv.getSignal();
    while (auto ex = sig.getDefiningOp<llhd::SigExtractOp>())
      sig = ex.getInput();

    auto sigOp = sig.getDefiningOp<llhd::SignalOp>();
    if (!sigOp)
      return;
    auto nameOpt = sigOp.getName();
    if (!nameOpt)
      return;
    std::string origName = nameOpt->str();
    std::string fieldName = prefixedName(origName, prefix);
    if (!seen.insert(fieldName).second)
      return;  // already recorded for this instance path

    // Recover bit width from the signal element type
    unsigned bitWidth = 32;
    Type ty = sigOp.getType();
    if (auto inoutTy = dyn_cast<llhd::RefType>(ty))
      ty = inoutTy.getNestedType();
    if (auto intTy = dyn_cast<IntegerType>(ty))
      bitWidth = intTy.getWidth();

    int32_t step = 0;
    if (auto stepAttr = drv->getAttrOfType<IntegerAttr>("qemu.step"))
      step = static_cast<int32_t>(stepAttr.getInt());

    AccumulateCounter c;
    c.originalName = origName;
    c.sanitizedName = registry.registerSignal(fieldName, bitWidth);
    c.step = step;
    c.bitWidth = bitWidth;
    counters.push_back(std::move(c));
  });

  // Recurse into direct child instances only — nested process bodies
  // don't contain hw.instance ops, so iterating top-level body ops is
  // sufficient and avoids visiting the same instance twice.
  for (Operation &op : mod.getBodyBlock()->getOperations()) {
    auto inst = dyn_cast<hw::InstanceOp>(&op);
    if (!inst)
      continue;
    auto callee = symTable.lookup<hw::HWModuleOp>(inst.getModuleName());
    if (!callee)
      continue;
    std::string childPrefix = joinInstPath(prefix, inst.getInstanceName());
    collectAccumulateCountersImpl(callee, childPrefix, symTable, registry,
                                  seen, counters);
  }
}

static std::vector<AccumulateCounter>
collectAccumulateCounters(hw::HWModuleOp top, SymbolTable &symTable,
                          FlatSignalRegistry &registry) {
  std::vector<AccumulateCounter> counters;
  llvm::StringSet<> seen;
  collectAccumulateCountersImpl(top, /*prefix=*/llvm::StringRef(),
                                symTable, registry, seen, counters);
  return counters;
}

static MergedBusInterface
mergeBusInterfaces(const std::vector<BusInterfaceMapping> &bips) {
  MergedBusInterface merged;

  // -------------------------------------------------------------------
  // Merge strategy (priority order):
  //
  //   1. BIPs with isBusWrite=true are *strongly* preferred for WRITE
  //      signals (addr, wdata, enable, mask).  These have been verified
  //      by Phase 1 to originate from actual bus data paths.
  //
  //   2. Among same-priority candidates, higher confidence wins.
  //
  //   3. Non-bus-write WRITE txns are used only as fallbacks.
  //
  //   4. READ txns supply rdata (no bus_write flag applies).
  //
  // This prevents internal/adapter module txns (like tlul_err) from
  // overriding the real MMIO-facing txn (like uart_reg_top).
  // -------------------------------------------------------------------

  // Track best scores separately for bus-write and non-bus-write
  bool  haveBusWrite     = false;
  double bestBusWriteConf = -1.0;
  double bestNonBusConf   = -1.0;
  double bestReadConf     = -1.0;

  // Temporary storage for the best bus-write and non-bus candidates
  struct WriteCand {
    std::string addr, wdata, enable, mask;
    unsigned addrW = 32, wdataW = 32;
    double conf = -1.0;
  };
  WriteCand bestBus, bestNonBus;

  for (const auto &bip : bips) {
    // ---- WRITE candidates ----
    if (bip.kind == BusInterfaceMapping::WRITE) {
      if (bip.isBusWrite) {
        // Bus-write: strong preference
        if (bip.confidence > bestBusWriteConf) {
          bestBus.conf   = bip.confidence;
          bestBusWriteConf = bip.confidence;
          haveBusWrite = true;
          if (!bip.addrSignal.empty()) {
            bestBus.addr  = bip.addrSignal;
            bestBus.addrW = bip.addrWidth > 0 ? bip.addrWidth : 32;
          }
          if (!bip.wdataSignal.empty()) {
            bestBus.wdata  = bip.wdataSignal;
            bestBus.wdataW = bip.wdataWidth > 0 ? bip.wdataWidth : 32;
          }
          if (!bip.enableSignal.empty()) bestBus.enable = bip.enableSignal;
          if (!bip.maskSignal.empty())   bestBus.mask   = bip.maskSignal;
        }
      } else {
        // Non-bus WRITE: fallback only
        if (bip.confidence > bestNonBusConf) {
          bestNonBus.conf = bip.confidence;
          bestNonBusConf  = bip.confidence;
          if (!bip.addrSignal.empty()) {
            bestNonBus.addr  = bip.addrSignal;
            bestNonBus.addrW = bip.addrWidth > 0 ? bip.addrWidth : 32;
          }
          if (!bip.wdataSignal.empty()) {
            bestNonBus.wdata  = bip.wdataSignal;
            bestNonBus.wdataW = bip.wdataWidth > 0 ? bip.wdataWidth : 32;
          }
          if (!bip.enableSignal.empty()) bestNonBus.enable = bip.enableSignal;
          if (!bip.maskSignal.empty())   bestNonBus.mask   = bip.maskSignal;
        }
      }
    }

    // ---- READ candidates ----
    if (bip.kind == BusInterfaceMapping::READ && !bip.rdataSignal.empty()) {
      if (bip.confidence > bestReadConf || merged.rdataSignal.empty()) {
        merged.rdataSignal = bip.rdataSignal;
        if (bip.rdataWidth > 0) merged.rdataWidth = bip.rdataWidth;
        bestReadConf = bip.confidence;
      }
    }

    // ---- Also pick up rdata from WRITE BIPs ----
    // In OpenTitan's register file architecture, the rdata signal
    // (reg_rdata_next) is inferred within the WRITE transaction because
    // the enable condition (reg_we) drives both read and write paths.
    // If no READ BIP provides rdata, use the WRITE BIP's rdata.
    if (bip.kind == BusInterfaceMapping::WRITE && !bip.rdataSignal.empty()) {
      if (merged.rdataSignal.empty()) {
        merged.rdataSignal = bip.rdataSignal;
        if (bip.rdataWidth > 0) merged.rdataWidth = bip.rdataWidth;
      }
    }
  }

  // Select winner: bus-write if available, else non-bus
  const WriteCand &winner = haveBusWrite ? bestBus : bestNonBus;
  merged.addrSignal  = winner.addr;
  merged.addrWidth   = winner.addrW;
  merged.wdataSignal = winner.wdata;
  merged.wdataWidth  = winner.wdataW;
  merged.enableSignal = winner.enable;
  merged.maskSignal   = winner.mask;

  // A merged interface is valid if we have at least addr + one data direction
  merged.valid = !merged.addrSignal.empty() &&
                 (!merged.wdataSignal.empty() || !merged.rdataSignal.empty());

  return merged;
}

//===----------------------------------------------------------------------===//
// applyTLULOverride — Patch mergedBus to use TL-UL convention names that
// align with where Phase 2.b struct-walker bridges actually wire data
// in/out of the design.
//
// Why this is needed:
//   FunctionalBusTxnInferPass identifies wdata/rdata via data-flow tracing
//   inside whichever sub-module owns `qemu.functional_txns` (typically
//   uart_reg_top).  That heuristic finds where data *ends up* (e.g.
//   `u_reg_if_wdata_o` — the post-decode write data) rather than the
//   bus-level *input* point.  After Phase 2.a per-instance prefixing the
//   real value lives at `s->u_reg_u_reg_if_wdata_o`, but the unprefixed
//   `s->u_reg_if_wdata_o` is what the merged-bus emit picks — a dangling
//   field that gets overwritten by hardware on update_state.
//
//   For TL-UL the bus *input* point is the top-level struct port leaf
//   `tl_i.a_data` → flat `tl_i_a_data` — Phase 2.b struct-walker registers
//   it AND creates the bridge `s->u_reg_tl_i_a_data = s->tl_i_a_data;`
//   so writing to the unprefixed top-level name automatically propagates.
//   Same idea applied symmetrically on the rdata side: bus *output* is
//   the `<inst>_tl_o_d_data` field that the OUTPUT bridge writes to.
//
// Algorithm:
//   1. Detect addrSignal matches `<base>_a_address` (e.g. tl_i_a_address)
//   2. Derive wdataSignal = "<base>_a_data" — only override if registered
//   3. Derive validSignal / opcodeSignal from the same base
//   4. Walk top.body terminator (hw.output) operands; find one whose
//      defining op is a hw.instance result of struct type with a `d_data`
//      leaf — that's the rdata source; rdataSignal = "<inst>_<port>_d_data"
//
// Each override step independently checks registry for the candidate
// name; if missing, leaves the original mergedBus value in place
// (graceful fallback for non-TL-UL peripherals).
//===----------------------------------------------------------------------===//
static void applyTLULOverride(MergedBusInterface &bus,
                              hw::HWModuleOp topModule,
                              const FlatSignalRegistry &registry) {
  const auto &registered = registry.getSignals();
  auto isRegistered = [&](const std::string &name) {
    return !name.empty() && registered.find(name) != registered.end();
  };

  // 1. Find the slave request port.  The BIP infer (FunctionalBusTxnInferPass)
  //    heuristics are unreliable here — observed failures: spi_host picked the
  //    phantom `unnamed_addr_0`; dma (a bus MASTER with three host ports and a
  //    slave port named `tl_d_i`, not `tl_i`) picked a reg_top-LOCAL alias
  //    `tl_i_a_address` that aliases nothing at top level, plus `addr_hit` as
  //    wdata, and the old suffix pattern trusted it (ends with "_a_address")
  //    so every additive override (a_valid/a_data/mask/size) silently missed.
  //    So: never trust the BIP name.  A real TL-UL request port has ALL its
  //    leaves registered — pick the VALIDATED base: the shortest prefix with
  //    both `<base>_a_address` and `<base>_a_valid` present (top-port leaves
  //    are the least nested, hence shortest; instance-level copies are longer;
  //    a BIP orphan like `tl_i_a_address` has no `_a_valid` sibling and loses).
  static constexpr llvm::StringLiteral kAddrSuffix = "_a_address";
  std::string bestBase;
  for (const auto &kv : registered) {
    llvm::StringRef n(kv.first);
    if (!n.ends_with(kAddrSuffix))
      continue;
    llvm::StringRef cand = n.drop_back(kAddrSuffix.size());
    if (cand.empty())
      continue;
    if (!isRegistered((cand + "_a_valid").str()))
      continue;  // incomplete request bundle: alias/orphan, not a real port
    if (bestBase.empty() || cand.size() < bestBase.size())
      bestBase = cand.str();
  }
  if (bestBase.empty())
    return;  // truly not TL-UL; keep mergedBus as-is
  llvm::StringRef base = bestBase;
  {
    std::string newAddr = (base + kAddrSuffix).str();
    bus.addrSignal = newAddr;
    bus.addrWidth = registered.at(newAddr).bitWidth;
  }

  // 2. wdata override: replace "_a_address" with "_a_data".
  std::string newWdata = (base + "_a_data").str();
  if (isRegistered(newWdata)) {
    bus.wdataSignal = newWdata;
    bus.wdataWidth = registered.at(newWdata).bitWidth;
  }

  // 3. valid + opcode (additive — never set before this point).
  std::string validName  = (base + "_a_valid").str();
  std::string opcodeName = (base + "_a_opcode").str();
  if (isRegistered(validName))
    bus.validSignal = validName;
  if (isRegistered(opcodeName)) {
    bus.opcodeSignal = opcodeName;
    bus.opcodeWidth  = registered.at(opcodeName).bitWidth;
  }

  // 3c. enableSignal: clear it for TL-UL.  The TL-UL handshake
  // (a_valid + a_opcode) is the only "bus enable" needed; a separate
  // enable signal isn't part of the protocol.  FBTI's heuristic
  // sometimes picks a top-level signal that *looks* enable-shaped
  // (1-bit, gates many drvs) but is actually `rst_ni` (active-low
  // reset).  spi_host happened to pick the harmless `reg_we` (dead at
  // top level — derived internally from we_o), but spi_device picked
  // `rst_ni` and the shim ended up writing `s->rst_ni = 0` at the end
  // of every write callback, putting the device back into reset and
  // wiping every register q.  Clearing the field here makes the shim
  // skip the bogus `s->X = 1/0` lines.
  bus.enableSignal.clear();

  // 3b. mask override.  TL-UL routes the per-byte enable through
  // `_a_mask` (typically i4 for a 32-bit data word).  OT's
  // tlul_adapter_reg gates `wr_err` on the mask matching the access
  // size — without a non-zero mask, every CTRL register write trips
  // wr_err, kills `ctrl_we`, and the seq drv stays at its init value.
  // The BIP infer pass usually picks this up via qemu.functional_txns,
  // but TL-UL's mask annotation isn't always detected on the inferred
  // bus, so override here as part of the TL-UL convention.
  std::string maskName = (base + "_a_mask").str();
  if (isRegistered(maskName))
    bus.maskSignal = maskName;
  // 3d. a_size + a_user.instr_type: the request must be PROTOCOL-VALID for
  // every consumer, not just the register file.  tlul_adapter_sram (SRAM
  // windows) inlines `instr_type ∈ {MuBi4True, MuBi4False}` and
  // `size == 2 for full-word Put` into its error term and drops the request
  // otherwise (the reg path only survived because tlul_err's output bridge was
  // dropped).  Same TL-UL driver-constant class as a_opcode/a_mask above.
  std::string sizeName = (base + "_a_size").str();
  if (isRegistered(sizeName))
    bus.sizeSignal = sizeName;
  std::string instrName = (base + "_a_user_instr_type").str();
  if (isRegistered(instrName))
    bus.instrTypeSignal = instrName;

  // 3e. d_ready: the response-acceptor side of the SAME port bundle.  Was a
  // hardcoded `s->tl_i_d_ready = 1` literal in the entry emission — correct
  // only while every device named its slave port `tl_i` (dma's is `tl_d_i`).
  std::string dReadyName = (base + "_d_ready").str();
  if (isRegistered(dReadyName))
    bus.dReadySignal = dReadyName;

  // 4. rdata override: scan top.body's hw.output operands for an
  //    instance-result struct that contains a `d_data` leaf.  Build the
  //    flat field name `<inst>_<port>_d_data` and check registry.
  if (auto outOp = dyn_cast<hw::OutputOp>(
          topModule.getBodyBlock()->getTerminator())) {
    for (Value operand : outOp.getOperands()) {
      auto inst = operand.getDefiningOp<hw::InstanceOp>();
      if (!inst)
        continue;
      auto opResult = dyn_cast<OpResult>(operand);
      if (!opResult)
        continue;
      unsigned resIdx = opResult.getResultNumber();
      auto names = inst.getResultNames();
      if (resIdx >= names.size())
        continue;
      auto strAttr = dyn_cast<StringAttr>(names[resIdx]);
      if (!strAttr)
        continue;
      // Look for a `d_data` leaf in this result's struct type.  We only
      // need to know it exists, not enumerate fully.
      auto stTy = dyn_cast<hw::StructType>(operand.getType());
      if (!stTy)
        continue;
      bool hasDData = false;
      for (auto &f : stTy.getElements()) {
        if (f.name.getValue() == "d_data") { hasDData = true; break; }
      }
      if (!hasDData)
        continue;
      std::string candidate = (inst.getInstanceName() + "_" +
                               strAttr.getValue() + "_d_data").str();
      if (isRegistered(candidate)) {
        bus.rdataSignal = candidate;
        bus.rdataWidth = registered.at(candidate).bitWidth;
        break;  // first match wins
      }
    }
  }

}

/// Integrity-check suppression for TL-UL.  OT's `tlul_cmd_intg_chk`
/// recomputes SECDED ECC on the incoming a_user.cmd_intg / a_user.data_intg
/// fields and routes its `err_o` into the top register block's `intg_err`
/// line, which then poisons every read (rdata := -1) and write (we := 0).
/// Our simulated TL-UL master injects address+data+opcode but cannot
/// reproduce the OT-specific Hamming-distance ECC encoding without
/// pulling in the prim_secded encoder logic — so the check fires on every
/// bus cycle by default.
///
/// For the firmware-driven simulation milestone we suppress the check by
/// rewriting any combinational assignment whose target is the (prefixed)
/// `intg_err` flat field, or whose expression is a single
/// `s->...u_chk...err_o` reference, to the literal `0`.  Operates on the
/// already-rendered `combLogicEntries` vector so it runs after the
/// renderModule walk that built it from `qemu.comb_logic`.  Only invoked
/// in TL-UL mode (gated by applyTLULOverride having set validSignal /
/// opcodeSignal upstream), so non-TL-UL peripherals are untouched.
static void suppressTLULIntegrityCheck(
    std::vector<clk_analysis::CombinationalAssignment> &combLogicEntries) {
  for (auto &entry : combLogicEntries) {
    llvm::StringRef target(entry.targetSignal);
    llvm::StringRef expr(entry.expression);
    bool isIntg =
        target == "intg_err" || target.ends_with("_intg_err") ||
        expr.contains("u_chk_err_o") || expr.contains("u_chk_u_chk_err_o");
    if (isIntg)
      entry.expression = "0";
  }
}

//===----------------------------------------------------------------------===//
// Stable dependency ordering for update_state()
//
// qemu.comb_logic is collected while recursively rendering the instance tree.
// That collection order keeps local input/callee/output bridges sensible, but
// it is not a global dependency order: a caller assignment may be collected
// before the child/output assignment that produces one of its RHS signals.
//
// Build an assignment graph from `s->NAME` references and emit producers before
// consumers.  Multiple assignments to the same target retain their original
// order because they commonly assemble a value one bit/word at a time.  Real
// combinational cycles are collapsed into SCCs; assignments within an SCC keep
// their original order, while the SCC DAG is topologically ordered.
//===----------------------------------------------------------------------===//

struct CombTopoSortStats {
  size_t dependencyEdges = 0;
  size_t reorderedAssignments = 0;
  size_t cyclicComponents = 0;
  size_t cyclicAssignments = 0;
};

static CombTopoSortStats stableTopologicalSortCombLogic(
    std::vector<clk_analysis::CombinationalAssignment> &logic) {
  CombTopoSortStats stats;
  const unsigned count = logic.size();
  if (count < 2)
    return stats;

  std::map<std::string, std::vector<unsigned>> writers;
  for (unsigned i = 0; i < count; ++i) {
    if (logic[i].targetSignal != "__RAW__")
      writers[logic[i].targetSignal].push_back(i);
  }

  std::vector<std::vector<unsigned>> edges(count);
  std::set<int> backwardDomains;  // domains with a true backward read
  auto addEdge = [&](unsigned from, unsigned to) {
    if (from != to)
      edges[from].push_back(to);
  };

  // Preserve imperative composition for repeated writes to one target.
  for (const auto &entry : writers) {
    const auto &targetWriters = entry.second;
    for (size_t i = 1; i < targetWriters.size(); ++i)
      addEdge(targetWriters[i - 1], targetWriters[i]);
  }

  // A consumer observes the completed value of every RHS signal, so depend on
  // all assignments that contribute to that signal.  Self references are
  // intentionally ignored: they represent partial updates or hold semantics,
  // neither of which can form a useful topological edge.
  static const std::regex refPat(R"(s->([A-Za-z_][A-Za-z0-9_]*))");
  for (unsigned consumer = 0; consumer < count; ++consumer) {
    std::set<std::string> referencedSignals;
    const std::string &expr = logic[consumer].expression;
    for (auto it = std::sregex_iterator(expr.begin(), expr.end(), refPat),
              end = std::sregex_iterator();
         it != end; ++it)
      referencedSignals.insert((*it)[1].str());

    for (const std::string &signal : referencedSignals) {
      if (signal == logic[consumer].targetSignal)
        continue;
      auto writerIt = writers.find(signal);
      if (writerIt == writers.end())
        continue;
      for (unsigned producer : writerIt->second) {
        // Same sequential domain, producer AFTER consumer in program
        // order: inside one unrolled process the drv order is blocking
        // semantics, so the consumer reads the PREVIOUS delta's value —
        // a weak edge.  Building it turned serialized read-modify-write
        // chains (prim_subst_perm's sbox/flip/butterfly) into false
        // SCCs whose 8x fixed point composed the non-idempotent
        // permutation 8 times.  Skip the edge; remember the domain — a
        // real backward read (always_comb feedback) still needs the
        // local fixed point, applied below without an SCC.
        if (logic[producer].seqDomain >= 0 &&
            logic[producer].seqDomain == logic[consumer].seqDomain &&
            producer > consumer) {
          backwardDomains.insert(logic[producer].seqDomain);
          continue;
        }
        addEdge(producer, consumer);
      }
    }
  }

  for (auto &successors : edges) {
    std::sort(successors.begin(), successors.end());
    successors.erase(std::unique(successors.begin(), successors.end()),
                     successors.end());
    stats.dependencyEdges += successors.size();
  }

  // Iterative Kosaraju keeps this safe for very large generated models where a
  // recursive SCC walk could overflow the host stack.
  std::vector<char> visited(count, 0);
  std::vector<unsigned> finishOrder;
  finishOrder.reserve(count);
  for (unsigned root = 0; root < count; ++root) {
    if (visited[root])
      continue;
    visited[root] = 1;
    std::vector<std::pair<unsigned, size_t>> stack;
    stack.emplace_back(root, 0);
    while (!stack.empty()) {
      unsigned node = stack.back().first;
      size_t &nextEdge = stack.back().second;
      if (nextEdge < edges[node].size()) {
        unsigned successor = edges[node][nextEdge++];
        if (!visited[successor]) {
          visited[successor] = 1;
          stack.emplace_back(successor, 0);
        }
        continue;
      }
      finishOrder.push_back(node);
      stack.pop_back();
    }
  }

  std::vector<std::vector<unsigned>> reverseEdges(count);
  for (unsigned from = 0; from < count; ++from)
    for (unsigned to : edges[from])
      reverseEdges[to].push_back(from);

  std::vector<int> componentOf(count, -1);
  std::vector<std::vector<unsigned>> components;
  for (auto it = finishOrder.rbegin(); it != finishOrder.rend(); ++it) {
    unsigned root = *it;
    if (componentOf[root] >= 0)
      continue;
    unsigned component = components.size();
    components.emplace_back();
    std::vector<unsigned> stack{root};
    componentOf[root] = component;
    while (!stack.empty()) {
      unsigned node = stack.back();
      stack.pop_back();
      components.back().push_back(node);
      for (unsigned predecessor : reverseEdges[node]) {
        if (componentOf[predecessor] >= 0)
          continue;
        componentOf[predecessor] = component;
        stack.push_back(predecessor);
      }
    }
    std::sort(components.back().begin(), components.back().end());
    if (components.back().size() > 1) {
      ++stats.cyclicComponents;
      stats.cyclicAssignments += components.back().size();
    }
  }

  const unsigned componentCount = components.size();
  std::vector<std::vector<unsigned>> componentEdges(componentCount);
  std::vector<unsigned> indegree(componentCount, 0);
  std::vector<unsigned> firstOriginalIndex(componentCount, count);
  for (unsigned component = 0; component < componentCount; ++component)
    firstOriginalIndex[component] = components[component].front();

  for (unsigned from = 0; from < count; ++from) {
    unsigned fromComponent = componentOf[from];
    for (unsigned to : edges[from]) {
      unsigned toComponent = componentOf[to];
      if (fromComponent != toComponent)
        componentEdges[fromComponent].push_back(toComponent);
    }
  }
  for (auto &successors : componentEdges) {
    std::sort(successors.begin(), successors.end());
    successors.erase(std::unique(successors.begin(), successors.end()),
                     successors.end());
    for (unsigned successor : successors)
      ++indegree[successor];
  }

  // Stable Kahn ordering: independent SCCs retain source order.
  std::set<std::pair<unsigned, unsigned>> ready;
  for (unsigned component = 0; component < componentCount; ++component)
    if (indegree[component] == 0)
      ready.emplace(firstOriginalIndex[component], component);

  std::vector<unsigned> assignmentOrder;
  assignmentOrder.reserve(count);
  while (!ready.empty()) {
    unsigned component = ready.begin()->second;
    ready.erase(ready.begin());
    assignmentOrder.insert(assignmentOrder.end(),
                           components[component].begin(),
                           components[component].end());
    for (unsigned successor : componentEdges[component]) {
      if (--indegree[successor] == 0)
        ready.emplace(firstOriginalIndex[successor], successor);
    }
  }

  assert(assignmentOrder.size() == count &&
         "SCC condensation graph must be acyclic");
  for (unsigned i = 0; i < count; ++i)
    if (assignmentOrder[i] != i)
      ++stats.reorderedAssignments;

  std::vector<clk_analysis::CombinationalAssignment> sorted;
  sorted.reserve(count);
  for (unsigned index : assignmentOrder) {
    auto a = std::move(logic[index]);
    int comp = componentOf[index];
    a.sccId = comp;
    a.sccCyclic = comp >= 0 && components[comp].size() > 1;
    // A domain with a genuine backward read (always_comb feedback whose
    // weak edge was skipped above) still needs the local fixed point:
    // mark its assignments cyclic under a domain-unique negative id so
    // the renderer groups consecutive runs into one loop.
    if (!a.sccCyclic && a.seqDomain >= 0 &&
        backwardDomains.count(a.seqDomain)) {
      a.sccCyclic = true;
      a.sccId = -(a.seqDomain + 2);
    }
    sorted.push_back(std::move(a));
  }
  logic = std::move(sorted);
  return stats;
}

//===----------------------------------------------------------------------===//
// Protocol-Agnostic C Code Generation
//
// Instead of using QEMUDeviceGenerator's built-in generateMMIORead/Write
// (which requires APBRegisterMapping with hardcoded addresses), we generate
// the MMIO callbacks directly as C strings, driven entirely by the
// MergedBusInterface.
//===----------------------------------------------------------------------===//

// Forward decls for the Phase 2.d input-setter API.  The struct and the
// emit helpers live below generateProtocolAgnosticHeader for proximity
// to header emission, but generateProtocolAgnosticSource also needs to
// reference them by type and by name.
struct SetterEntry;
static void emitInputSetterBodies(
    llvm::raw_ostream &os,
    const std::string &devName,
    const std::vector<SetterEntry> &setters);
static void emitInputSetterDecls(
    llvm::raw_ostream &os,
    const std::string &devName,
    const std::vector<SetterEntry> &setters);

/// Emit the MMIO settle loop.  `tick()` returns true only when one or more
/// sequential state fields changed, so `_qp_required_ticks` becomes the actual
/// number of changing clock edges needed by this transaction/current state.
/// A compact fingerprint history detects periodic state trajectories and stops
/// them as soon as a state repeats.  The cap remains a final backstop for hash
/// collisions or unexpectedly long transients.
/// Emit the MMIO settle loop — ONE semantics for every device:
///   1. fixed point   — `tick()` reports no sequential change: the reaction is
///      done, stop.  The normal exit.
///   2. revisited state — Brent cycle detection over the full-state
///      fingerprint: ONE saved fingerprint, re-taken at power-of-two
///      intervals.  A deterministic trajectory that revisits a complete state
///      is periodic (no fixed point exists) — a bug, ANY period.  A genuinely
///      working engine (a DMA transfer: addresses/counters advance) never
///      revisits a state, so long runs pass through untouched — no progress
///      attestation, no tick caps, no archive.
///   3. budget — a single per-access bound (responsiveness only: the settle
///      runs inside the MMIO callback).  Exhausting it is NOT an error: the
///      remaining work continues on the next access (firmware polling a
///      status register IS the continuation), logged for visibility.
/// `_qp_rewound` (an organ restored a snapshot: a deliberate repeat) resets
/// the camera; `_qp_hold_settle` suppresses the cycle exit while an organ is
/// mid-way through an atomic protocol unit (an SPI byte being replayed).
// capValid/capData (both empty or both set): capture the response data on
// the FIRST tick the response-valid signal is high inside the settle.  A
// FIFO-backed response (tlul_adapter_sram behind a window socket — kmac's
// STATE window) pops after one tick, so sampling rdata AFTER the loop reads
// the error-blanking value (0xFFFFFFFF).  Register-backed responses hold
// their value, so capturing on d_valid is behavior-preserving for them.
static void emitSettleLoop(llvm::raw_ostream &os,
                           const std::string &capValid = "",
                           const std::string &capData = "") {
  std::string cap;
  if (!capValid.empty() && !capData.empty())
    cap = "            if (!s->_qp_rd_cap && s->" + capValid +
          ") { s->_qp_rd_cap = 1; s->_qp_rd_capv = s->" + capData + "; }\n";
  os << "    {\n";
  // Re-entrancy guard: an organ observer (_qp_on_tick) may synchronously
  // reach ANOTHER device whose response path calls back into THIS model
  // (e.g. a bus-master read pops a FIFO, the victim's irq line falls, a
  // splitter routes it to our gpio-in).  The inner call must not run a
  // nested settle on the same state struct; it just latches its input
  // (asynchronous-input semantics) and the outer loop sees it next tick.
  os << "    if (!s->_qp_busy) {\n";
  os << "        s->_qp_busy = 1;\n";
  os << "        unsigned _qp_ticks = 0;\n";
  os << "        update_state(s);\n";
  if (!cap.empty())
    os << cap;
  os << "        QPSettleFingerprint _qp_base = qp_settle_fingerprint(s);\n";
  os << "        unsigned _qp_lam = 0, _qp_pow = 1;\n";
  os << "        bool _qp_ext = false;\n";
  // Two-tier budget: 256 for ordinary accesses (free-running counters — a
  // uart baud/timeout prescaler — legitimately never quiesce NOR cycle, and
  // firmware polling is the continuation, so a big uniform budget just turns
  // every register read into a 65536-tick marathon: the official uart
  // smoketest went 20s -> 58s); the full budget only while an organ holds
  // the settle mid-protocol-unit.
  // Three tiers, re-evaluated at the TAIL of every iteration (never hoisted:
  // both _qp_hold_settle, raised by an observer inside qp_tick, and _qp_ext,
  // set by the settle hook, move during the iteration).
  os << "        unsigned _qp_cap = 256u;\n";
  os << "        while (_qp_ticks < _qp_cap) {\n";
  os << "            bool _qp_ch = qp_tick(s);\n";
  os << "            bool _qp_rw = s->_qp_rewound != 0;\n";
  os << "            if (_qp_rw) { s->_qp_rewound = 0; _qp_ch = true; }\n";
  os << "            if (!_qp_ch && !_qp_ext)\n";
  os << "                break;  /* sequential fixed point reached */\n";
  os << "            ++_qp_ticks;\n";
  os << "            update_state(s);\n";
  if (!cap.empty())
    os << cap;
  os << "            /* settle hook AFTER tick+update: the machine co-steps\n"
        "             * the OTHER ring members (this model is _qp_busy and is\n"
        "             * skipped there) against this model's FRESH post-tick\n"
        "             * outputs — the same phase as a pump costep, so a\n"
        "             * one-clock request pulse is seen exactly once (the\n"
        "             * before-tick placement let a pulse live two partner\n"
        "             * ticks: a boot INS was delivered twice).  Nonzero\n"
        "             * return = cross-model transaction in flight: keeps the\n"
        "             * loop alive past a local fixed point. */\n";
  os << "            int _qp_hk = s->_qp_settle_hook ?\n";
  os << "                         s->_qp_settle_hook(s->_qp_settle_hook_ctx) : 0;\n";
  os << "            /* muzzled: the machine still co-steps (the ring must not\n"
        "             * stall), but its verdict can no longer widen the budget. */\n";
  os << "            _qp_ext = _qp_hk && !s->_qp_hook_muzzle;\n";
  os << "            /* re-mirror after the hook wired fresh partner outputs\n"
        "             * onto this model's inputs: without this, the next tick\n"
        "             * still sees pre-hook mirrors and a one-clock handshake\n"
        "             * (req/ready) takes one beat too long — the boot INS\n"
        "             * was pushed twice.  Costs only while cross-model\n"
        "             * traffic is live. */\n";
  os << "            if (_qp_ext) {\n";
  os << "                update_state(s);\n";
  if (!cap.empty())
    os << cap;
  os << "            }\n";
  os << "            QPSettleFingerprint _qp_now = qp_settle_fingerprint(s);\n";
  os << "            if (_qp_rw) {  /* deliberate repeat: move the camera here */\n";
  os << "                _qp_base = _qp_now; _qp_lam = 0; _qp_pow = 1;\n";
  os << "                continue;\n";
  os << "            }\n";
  os << "            ++_qp_lam;\n";
  os << "            if (_qp_now.first == _qp_base.first &&\n";
  os << "                _qp_now.second == _qp_base.second &&\n";
  os << "                !s->_qp_hold_settle && !_qp_ext)\n";
  os << "                break;  /* state revisited: periodic, no fixed point exists */\n";
  os << "            if (_qp_lam == _qp_pow) {  /* Brent: move camera, double the wait */\n";
  os << "                _qp_base = _qp_now; _qp_lam = 0;\n";
  os << "                if (_qp_pow < (1u << 30)) _qp_pow <<= 1;\n";
  os << "            }\n";
  os << "            _qp_cap = s->_qp_hold_settle ? QP_SETTLE_BUDGET\n";
  os << "                    : (_qp_ext ? QP_EXT_BUDGET : 256u);\n";
  os << "        }\n";
  os << "        s->_qp_last_ticks = (uint16_t)(_qp_ticks > 0xFFFFu ? 0xFFFFu : _qp_ticks);\n";
  os << "        if (_qp_ticks >= _qp_cap) {\n";
  os << "            s->_qp_budget_hit = 1;\n";
  os << "            if (_qp_cap == QP_EXT_BUDGET) {\n";
  os << "                if (s->_qp_ext_strikes < 255u) s->_qp_ext_strikes++;\n";
  os << "                if (s->_qp_ext_strikes >= QP_EXT_STRIKES && !s->_qp_hook_muzzle) {\n";
  os << "                    s->_qp_hook_muzzle = 1;\n";
  os << "                    qemu_log_mask(LOG_GUEST_ERROR,\n";
  os << "                        \"qp settle: hook MUZZLED after %u capped extended settles; \"\n";
  os << "                        \"co-stepping continues, budget reverts to the 256 tier\\n\",\n";
  os << "                        (unsigned)QP_EXT_STRIKES);\n";
  os << "                }\n";
  os << "            }\n";
  os << "            qemu_log_mask(LOG_UNIMP, \"qp settle: budget %u exhausted, state still changing\\n\", _qp_cap);\n";
  os << "        } else if (_qp_cap == QP_EXT_BUDGET) {\n";
  os << "            s->_qp_ext_strikes = 0;  /* an extended settle that CONVERGED */\n";
  os << "        }\n";
  os << "        s->_qp_busy = 0;\n";
  os << "    }\n";
  os << "    }\n";
  os << "    update_state(s);\n\n";
}


/// Word-wise rewrite of a WIDE whole-signal expression (nWords 64-bit words).
/// The extractor's closed grammar for wide registers/wires: `s->NAME` refs
/// (wide refs of the SAME word count get indexed; scalar refs broadcast),
/// literals 0 / -1 (per-word semantics identical), operators ~ & | ^ !, the
/// scalar-condition ternary, parens.  `(s->x ^ 1)` on a 1-bit x is first
/// normalised to `(!(s->x))` (the rst-invert idiom) so no other literal ends
/// up as a bitwise operand.  Returns "" (caller bails to a LOUD TODO) on
/// arithmetic/shift/comparison tokens, a wide ref of a different word count,
/// or any other literal — conservative: only provably pointwise forms pass.
/// `alsoWide` (may be empty) names one extra bare identifier to index (the
/// seq path's `_qp_next_<target>` after the self-reference rewrite).
static std::string wideWordwiseExpr(
    const std::string &exprIn, unsigned words,
    const std::map<std::string, FlatSignalRegistry::SignalInfo> &allSignals,
    const std::string &alsoWide) {
  std::string e = exprIn;
  // 0) fold zero shifts of wide fields: `((s->X) >> 0)` -> `(s->X)`.
  // The importer spells `extract(x, 0)` of a wide value as a shift by 0;
  // textually that shift blocks the pointwise-word rewrite (rom_ctrl's
  // `digest = share0 ^ share1` XOR of two 384-bit inputs was dropped).
  {
    static const std::regex zshift(R"(\((\(s->[A-Za-z0-9_]+\)) >> 0\))");
    e = std::regex_replace(e, zshift, "$1");
  }
  // 0b) constant-offset slice of a WIDER field: `((s->X) >> K)` where X
  // is a wide array — the importer's spelling of `dst = src[K +: W]`
  // (keymgr's seed matrix: nine 256-bit slices out of one multi-kilobit
  // anchor constant).  Word w of the destination is a 64-bit extract at
  // K + 64*w; qpw_wide_extract's out-of-range => 0 matches the
  // zero-extension.  Rewrite BEFORE the shift ban below.
  {
    static const std::regex wshift(R"(\(\(s->([A-Za-z0-9_]+)\) >> ([0-9]+)\))");
    std::string out2;
    std::sregex_iterator it(e.begin(), e.end(), wshift), end;
    size_t last = 0;
    bool any = false;
    for (; it != end; ++it) {
      auto m = *it;
      auto sit = allSignals.find(m[1].str());
      if (sit == allSignals.end() || sit->second.nWords == 0) continue;
      out2 += e.substr(last, m.position() - last);
      out2 += "qpw_wide_extract(s->" + m[1].str() + ", " +
              std::to_string(sit->second.nWords) + ", " + m[2].str() +
              "u + 64u*_qp_w, 64)";
      last = m.position() + m.length();
      any = true;
    }
    if (any) {
      out2 += e.substr(last);
      e = std::move(out2);
    }
  }
  // 0c) sign-extension into a wide destination: the importer spells
  // `dst = W'(signed'(x))` as
  //   ((__uint128_t)(s->X) << 0) | ((__uint128_t)(0 - (uint64_t)((s->X >> B) & 0x1)) << OFF)
  // (keymgr's 256-bit health-state anchor from its 128-bit input).
  // Per destination word w: the low OFF/64 words read X's word w, the
  // rest broadcast the sign word.
  {
    static const std::regex sext(
        R"(\(\(\(\(__uint128_t\)\(s->([A-Za-z0-9_]+)\)\) << 0\) \| \(\(\(__uint128_t\)\(\(0 - \(\(uint64_t\)\(\(\(\(s->\1\) >> ([0-9]+)\) & 0x1\)\)\)\)\)\) << ([0-9]+)\)\))");
    std::smatch m;
    if (std::regex_match(e, m, sext)) {
      std::string X = "s->" + m[1].str();
      unsigned bit = (unsigned)std::stoul(m[2].str());
      unsigned off = (unsigned)std::stoul(m[3].str());
      if (off % 64 == 0 && bit == off - 1) {
        std::string sign = "(0 - (uint64_t)((((__uint128_t)" + X +
                           ") >> " + std::to_string(bit) + ") & 1))";
        // Already fully per-word: return directly, bypassing the scalar
        // operator audit (the ?:/shift here are word-selection, not
        // cross-word arithmetic).
        return "((_qp_w < " + std::to_string(off / 64) +
               "u) ? (uint64_t)(((__uint128_t)" + X +
               ") >> (64u*_qp_w)) : " + sign + ")";
      }
    }
  }
  // 1) normalise ((s->x) ^ 1) -> (!(s->x)) for 1-bit x
  size_t p = 0;
  while ((p = e.find(" ^ 1)", p)) != std::string::npos) {
    // find the s->name immediately before: pattern "(s->NAME) ^ 1)"
    size_t close = e.rfind(')', p);
    if (close == std::string::npos || close != p - 0 + 0) { /* fallthrough */ }
    // locate "(s->" backwards
    size_t open = e.rfind("(s->", p);
    if (open == std::string::npos) { p += 5; continue; }
    std::string name = e.substr(open + 4, e.find(')', open) - open - 4);
    auto it = allSignals.find(name);
    if (it != allSignals.end() && it->second.nWords == 0 &&
        it->second.bitWidth == 1 &&
        e.compare(open, p + 5 - open,
                  "(s->" + name + ") ^ 1)") == 0) {
      // span [open, p+5) is "(s->NAME) ^ 1)" (net paren -1): the balanced
      // replacement must also be net -1 — the outer '(' sits before `open`.
      e = e.substr(0, open) + "!(s->" + name + "))" + e.substr(p + 5);
      p = open + 1;
    } else {
      p += 5;
    }
  }
  // 2) forbidden tokens (token-aware for "->")
  for (size_t i = 0; i < e.size(); ++i) {
    // qpw_wide_extract(...) segments from rewrite 0b are per-word safe;
    // their internal arithmetic must not trip the scalar-operator ban.
    static const char kQpwB[] = "qpw_wide_extract(";
    if (e.compare(i, sizeof(kQpwB) - 1, kQpwB) == 0) {
      size_t j = i + sizeof(kQpwB) - 1;
      unsigned d2 = 1;
      while (j < e.size() && d2) {
        if (e[j] == '(') ++d2;
        else if (e[j] == ')') --d2;
        ++j;
      }
      i = j - 1;
      continue;
    }
    char c = e[i];
    if (c == '-' ) {
      if (i + 1 < e.size() && e[i+1] == '>') { ++i; continue; }   // "->"
      if (i + 1 < e.size() && e[i+1] == '1') { ++i; continue; }   // "-1"
      return "";
    }
    if (c == '+' || c == '*' || c == '/' || c == '%') return "";
    if (c == '<' || c == '>') return "";   // shifts + comparisons ('>' of '->' consumed above)
    if (c == '=' ) {
      // `==` is a SCALAR comparison (0/1) and only appears inside ternary
      // conditions of the wide muxes kmac's state gating uses
      // (`mux_sel == 5 ? state : keep`); broadcast-as-word semantics are
      // identical.  A lone '=' never appears in extractor output.
      if (i + 1 < e.size() && e[i+1] == '=') { ++i; continue; }
      return "";
    }
    if (c == '!' && i + 1 < e.size() && e[i+1] == '=') return "";
  }
  // 3) literal audit + wide-ref rewrite
  std::string out;
  for (size_t i = 0; i < e.size();) {
    // A qpw_wide_extract(...) placed by the 0b rewrite is already
    // per-word — copy it verbatim (its `s->arr` argument is an array
    // decay, NOT a word reference; indexing it would break the call).
    static const char kQpwW[] = "qpw_wide_extract(";
    if (e.compare(i, sizeof(kQpwW) - 1, kQpwW) == 0) {
      size_t j = i + sizeof(kQpwW) - 1;
      unsigned depth2 = 1;
      while (j < e.size() && depth2) {
        if (e[j] == '(') ++depth2;
        else if (e[j] == ')') --depth2;
        ++j;
      }
      out += e.substr(i, j - i);
      i = j;
      continue;
    }
    if (e.compare(i, 3, "s->") == 0) {
      size_t j = i + 3;
      while (j < e.size() && (std::isalnum((unsigned char)e[j]) || e[j] == '_')) ++j;
      std::string name = e.substr(i + 3, j - i - 3);
      auto it = allSignals.find(name);
      out += "s->" + name;
      // An EXPLICIT word index (`s->X[0]` from the per-word compare
      // expansion of a wide icmp) is already word-addressed: appending
      // [_qp_w] would double-subscript a uint64_t (prim_trivium's
      // 288-bit state == 0 OR-reduce).  Copy the bracketed index and
      // move on.
      if (j < e.size() && e[j] == '[') {
        size_t k2 = j;
        while (k2 < e.size() && e[k2] != ']') ++k2;
        if (k2 < e.size()) {
          out += e.substr(j, k2 - j + 1);
          i = k2 + 1;
          continue;
        }
      }
      if (it != allSignals.end() && it->second.nWords > 0) {
        // A WIDER source is fine for pointwise ops: reading word [_qp_w]
        // of the first `words` words is the low-bits truncation the IR's
        // zero-shift extract spelled (rom_ctrl: 256-bit digest from the
        // 384-bit share0 ^ share1).  A NARROWER source has no word to
        // read — bail.
        if (it->second.nWords < words) return "";
        out += "[_qp_w]";
      }
      i = j;
      continue;
    }
    if (!alsoWide.empty() && e.compare(i, alsoWide.size(), alsoWide) == 0 &&
        (i + alsoWide.size() >= e.size() ||
         !(std::isalnum((unsigned char)e[i + alsoWide.size()]) ||
           e[i + alsoWide.size()] == '_'))) {
      out += alsoWide + "[_qp_w]";
      i += alsoWide.size();
      continue;
    }
    if (e[i] == '-' && i + 1 < e.size() && e[i+1] == '1' &&
        (i + 2 >= e.size() || !std::isalnum((unsigned char)e[i+2]))) {
      out += "-1"; i += 2;   // all-ones broadcast: identical per word
      continue;
    }
    if (std::isdigit((unsigned char)e[i])) {
      size_t j = i;
      while (j < e.size() && std::isalnum((unsigned char)e[j])) ++j;
      std::string lit = e.substr(i, j - i);
      // Zero spellings normalize to "0" (a per-word-identical wide
      // operand).  Scalar literals (comparison RHS inside ternary
      // conditions) pass through.  A WIDE hex literal (>16 hex digits —
      // hmac's 512-bit HMAC ipad/opad constants 0x3636…36) is legal per
      // word only if its 64-bit groups all repeat; fold it to one word,
      // otherwise bail.
      bool isZero = lit == "0" || lit == "0u" || lit == "0ULL" ||
                    lit == "0x0" || lit == "0x0ULL";
      if (isZero) {
        out += "0"; i = j; continue;
      }
      if (lit.size() > 18 && lit.compare(0, 2, "0x") == 0) {
        std::string hex = lit.substr(2);
        while (!hex.empty() &&
               (hex.back() == 'U' || hex.back() == 'L' || hex.back() == 'u' ||
                hex.back() == 'l'))
          hex.pop_back();
        // Left-pad to a whole number of 64-bit groups.
        while (hex.size() % 16 != 0) hex.insert(hex.begin(), '0');
        std::string word0 = hex.substr(0, 16);
        bool periodic = true;
        for (size_t g = 16; g < hex.size(); g += 16)
          if (hex.compare(g, 16, word0) != 0) { periodic = false; break; }
        if (periodic) {
          out += "0x" + word0 + "ULL";
        } else {
          // Non-periodic wide constant (kmac_app's 352-bit AppPfx
          // cSHAKE prefix): emit a per-word array literal indexed by
          // the rewrite variable.  Word 0 is the LOW 64 bits (the hex
          // tail); pad with zero words up to the destination count.
          unsigned litWords = hex.size() / 16;
          out += "((const uint64_t[" + std::to_string(words) + "]){";
          for (unsigned k = 0; k < words; ++k) {
            if (k) out += ",";
            if (k < litWords)
              out += "0x" + hex.substr(hex.size() - 16 * (k + 1), 16) + "ULL";
            else
              out += "0";
          }
          out += "})[_qp_w]";
        }
        i = j;
        continue;
      }
      out += lit;
      i = j;
      continue;
    }
    out += e[i]; ++i;
  }
  return out;
}

/// Generate the complete QEMU C source file with protocol-agnostic MMIO.
/// This replaces gen.generateSource() when bus-txn inference is available.
// An AUXILIARY TL-UL target port: a device with more than one bus-facing
// port pair (rom_ctrl: regs_tl CSRs + rom_tl ROM window).  The primary
// port keeps the historical <dev>_read/_write entry points; each aux
// port gets its own <dev>_<port>_read/_write pair driving that port's
// top-level input leaves, with the response captured from the
// per-leaf-bridged top-level OUTPUT leaves.  Detected purely by port
// SHAPE (struct in/out pairs carrying the TL-UL leaf names) — no device
// knowledge.
struct AuxBusPort {
  std::string name;      // sanitized base, e.g. "regs_tl"
  std::string aValid, aOpcode, aAddress, aData, aMask, aSize, aInstr,
      dReady;            // input leaves
  std::string dValid, dData;  // bridged top-output leaves
};

static std::vector<AuxBusPort>
detectAuxTlPorts(hw::HWModuleOp top, const MergedBusInterface &bus) {
  std::vector<AuxBusPort> out;
  for (auto p : top.getPortList()) {
    if (p.dir != hw::ModulePort::Direction::Input) continue;
    if (!isa<hw::StructType>(p.type)) continue;
    llvm::StringRef in = p.getName();
    if (!in.ends_with("_i")) continue;
    std::string base = in.drop_back(2).str();
    // leaf presence on the input struct
    auto st = cast<hw::StructType>(p.type);
    llvm::StringSet<> leaves;
    for (auto e : st.getElements()) leaves.insert(e.name.getValue());
    if (!leaves.count("a_valid") || !leaves.count("a_address") ||
        !leaves.count("a_data") || !leaves.count("d_ready"))
      continue;
    // paired output port with the response leaves
    bool paired = false;
    for (auto q : top.getPortList()) {
      if (q.dir != hw::ModulePort::Direction::Output) continue;
      if (q.getName() != base + "_o") continue;
      if (auto so = dyn_cast<hw::StructType>(q.type)) {
        llvm::StringSet<> ol;
        for (auto e : so.getElements()) ol.insert(e.name.getValue());
        paired = ol.count("d_valid") && ol.count("d_data");
      }
      break;
    }
    if (!paired) continue;
    std::string inS = sanitizeName(in.str());
    if (bus.addrSignal == inS + "_a_address") continue;  // the primary port
    AuxBusPort a;
    a.name = sanitizeName(base);
    a.aValid = inS + "_a_valid";
    a.aOpcode = inS + "_a_opcode";
    a.aAddress = inS + "_a_address";
    a.aData = inS + "_a_data";
    a.aMask = inS + "_a_mask";
    a.aSize = inS + "_a_size";
    a.aInstr = inS + "_a_user_instr_type";
    a.dReady = inS + "_d_ready";
    std::string outS = sanitizeName(base + "_o");
    a.dValid = outS + "_d_valid";
    a.dData = outS + "_d_data";
    out.push_back(std::move(a));
    llvm::errs() << "  [aux-bus] TL-UL target port '" << base
                 << "' -> " << "aux MMIO pair\n";
  }
  return out;
}

static void generateProtocolAgnosticSource(
    llvm::raw_ostream &os,
    const std::string &devName,
    const MergedBusInterface &bus,
    const std::vector<clk_analysis::CombinationalAssignment> &combLogic,
    const std::vector<clk_analysis::CombinationalAssignment> &seqLogic,
    const std::map<std::string, FlatSignalRegistry::SignalInfo> &allSignals,
    const std::vector<AccumulateCounter> &counters,
    const std::vector<SetterEntry> &inputSetters,
    bool timerPump,
    const std::vector<std::pair<std::string, int64_t>> &inputResets,
    uint64_t mmioSize = 0x1000,
    bool hasBusMaster = false,
    const std::vector<AuxBusPort> &auxPorts = {},
    const std::vector<std::pair<std::string, uint64_t>> &backingStores = {},
    bool legacyResetNames = false,
    const qemu_passes::GenericSysBusConfig *genericConfig = nullptr) {

  std::string upperName;
  for (char c : devName)
    upperName += std::toupper(static_cast<unsigned char>(c));

  // ---- File Header ----
  os << "/*\n";
  os << " * Auto-generated QEMU device: " << devName << "\n";
  os << " *\n";
  os << " * Bus interface: protocol-agnostic (inferred from IR)\n";
  os << " *   addr   -> s->" << bus.addrSignal << "\n";
  if (!bus.wdataSignal.empty())
    os << " *   wdata  -> s->" << bus.wdataSignal << "\n";
  if (!bus.rdataSignal.empty())
    os << " *   rdata  <- s->" << bus.rdataSignal << "\n";
  if (!bus.validSignal.empty())
    os << " *   valid  -> s->" << bus.validSignal
       << "  (pulsed 1 per txn — TL-UL a_valid)\n";
  if (!bus.opcodeSignal.empty())
    os << " *   opcode -> s->" << bus.opcodeSignal
       << " (write=0 PutFullData, read=4 Get)\n";
  os << " *\n";
  os << " * The MMIO callbacks directly bridge QEMU's hwaddr/value to the\n";
  os << " * internal flattened state variables, then invoke update_state()\n";
  os << " * to propagate combinational logic. This design erases the bus\n";
  os << " * protocol struct layer (TL-UL / APB / AXI).\n";
  os << " */\n\n";

  os << "#include \"qemu/osdep.h\"\n";
  os << "#include \"hw/irq.h\"\n";
  os << "#include \"hw/qdev-properties.h\"\n";
  os << "#include \"qemu/log.h\"\n";
  os << "#include \"qemu/module.h\"\n";
  if (!counters.empty()) {
    os << "#include \"hw/ptimer.h\"\n";
    os << "#include \"qemu/main-loop.h\"\n";
  }
  os << "#include \"" << devName << ".h\"\n\n";

  // Silence GCC warnings the IR-to-C translator commonly trips, since
  // lowRISC qemu builds with -Werror and the generated combinational
  // expressions are not yet typing-perfect:
  //   -Wbool-operation       — `~(a != b)` patterns from comb dispatch
  //   -Wshift-count-overflow — width mismatches between hw.module port
  //                            widths and field-typedefs in the state
  //                            struct (e.g. shift 57 on a uint32_t).
  // These are semantic gaps in the generator that should be fixed
  // upstream (CombTranslator / FlatSignalRegistry width inference);
  // for now we silence them so the model still compiles and the
  // firmware can boot against it.
  os << "#pragma GCC diagnostic ignored \"-Wbool-operation\"\n";
  os << "#pragma GCC diagnostic ignored \"-Wshift-count-overflow\"\n";
  //   -Wtype-limits — a comparison like `bit_index < 8` where bit_index is a
  //   3-bit value held in a uint8_t field reads as "always true due to limited
  //   range"; same width-inference artifact class, harmless.
  os << "#pragma GCC diagnostic ignored \"-Wtype-limits\"\n\n";

  // Bug G: signals wider than 128 bits are stored as `uint64_t arr[N]`.
  // qpw_wide_extract pulls out a contiguous bitfield (up to 64 bits) from
  // such an array given a runtime-dynamic shift, handling cross-word reads.
  os << "/* Bug G: extract <=64 bits from a wide uint64_t arr[nWords]. */\n";
  os << "static inline uint64_t qpw_wide_extract(const uint64_t *arr,\n";
  os << "                                        unsigned nWords,\n";
  os << "                                        unsigned shift,\n";
  os << "                                        unsigned width)\n";
  os << "{\n";
  os << "    if (width == 0) return 0;\n";
  os << "    unsigned wordIdx = shift / 64;\n";
  os << "    unsigned bitIdx  = shift % 64;\n";
  os << "    uint64_t mask = (width >= 64) ? ~(uint64_t)0\n";
  os << "                                  : (((uint64_t)1 << width) - 1);\n";
  os << "    if (wordIdx >= nWords) return 0;\n";
  os << "    uint64_t lo = arr[wordIdx] >> bitIdx;\n";
  os << "    if (bitIdx + width > 64 && wordIdx + 1 < nWords) {\n";
  os << "        lo |= arr[wordIdx + 1] << (64 - bitIdx);\n";
  os << "    }\n";
  os << "    return lo & mask;\n";
  os << "}\n\n";
  os << "/* Memory arrays: write <=64 bits into a wide uint64_t arr[nWords]. */\n";
  os << "static inline void qpw_wide_insert(uint64_t *arr, unsigned nWords,\n";
  os << "                                   unsigned shift, unsigned width,\n";
  os << "                                   uint64_t val)\n";
  os << "{\n";
  os << "    if (width == 0) return;\n";
  os << "    unsigned wordIdx = shift / 64;\n";
  os << "    unsigned bitIdx  = shift % 64;\n";
  os << "    uint64_t mask = (width >= 64) ? ~(uint64_t)0\n";
  os << "                                  : (((uint64_t)1 << width) - 1);\n";
  os << "    if (wordIdx >= nWords) return;\n";
  os << "    val &= mask;\n";
  os << "    arr[wordIdx] = (arr[wordIdx] & ~(mask << bitIdx)) | (val << bitIdx);\n";
  os << "    if (bitIdx + width > 64 && wordIdx + 1 < nWords) {\n";
  os << "        unsigned hi = bitIdx + width - 64;   /* bits spilling into next word */\n";
  os << "        uint64_t hmask = (((uint64_t)1 << hi) - 1);\n";
  os << "        arr[wordIdx + 1] = (arr[wordIdx + 1] & ~hmask) | ((val >> (64 - bitIdx)) & hmask);\n";
  os << "    }\n";
  os << "}\n\n";
  os << "/* Low 128 bits of a wide uint64_t arr[nWords] as a scalar (65..128-bit\n";
  os << " * expression contexts reading a wide field whole). */\n";
  os << "static inline __uint128_t qpw_wide_read128(const uint64_t *arr,\n";
  os << "                                           unsigned nWords)\n";
  os << "{\n";
  os << "    __uint128_t v = arr[0];\n";
  os << "    if (nWords > 1) v |= ((__uint128_t)arr[1]) << 64;\n";
  os << "    return v;\n";
  os << "}\n\n";

  // Placeholder frequency for ptimer-backed counters.  Real frequency
  // recovery from the pre-clock-removal IR is left to a Phase 2 pass.
  if (!counters.empty()) {
    os << "/* Placeholder tick rate for ACCUMULATE counters.  Real frequency\n";
    os << " * recovery requires info that is stripped by clock-drv-removal;\n";
    os << " * this gives a best-effort \"one decrement per virtual tick\" rate. */\n";
    os << "#define " << upperName << "_PTIMER_FREQ  1000000U\n\n";
  }

  // ---- Forward declarations ----
  os << "static void update_state_once(" << devName << "_state *s);\n";
  os << "typedef struct QPSettleFingerprint {\n";
  os << "    uint64_t first;\n";
  os << "    uint64_t second;\n";
  os << "} QPSettleFingerprint;\n";
  os << "static QPSettleFingerprint qp_settle_fingerprint(const "
     << devName << "_state *s);\n";
  // A single topological sweep can leave a cross-SCC combinational chain one
  // step stale (aes's mux-sel checkers read a half-updated select and latched
  // a false fatal), and a FIXED second sweep is still not enough for deep
  // chains: aes CTR's one-hot select swap crosses FSM comb -> sp2v buffers ->
  // sel_buf_chk, so two sweeps left `state_in_sel` mid-swap (3|4 = 7) and the
  // checker latched a REAL error on a value real hardware can never sample.
  // Combinational logic is idempotent — iterate the sweep to a fingerprint
  // fixed point (bounded) so sequential logic and checkers only ever see
  // fully-settled combinational values, matching same-tick RTL semantics.
  // THREE fixed sweeps.  Two were not enough for aes CTR: its select chain
  // (triple-rail FSM comb -> mr-vote OR -> sp2v buffers -> checker -> mux)
  // needs a third sweep to fully propagate a select swap, and the leftover
  // mid-sweep transient latched a fatal alert.  A fingerprint-convergence
  // loop was tried first and reverted — hashing the full state struct per
  // sweep per settle tick collapsed spi_device's throughput (spidevflash
  // client timeout).  Bisected on the host harness: N=3 settles every
  // chain in the fleet; combinational logic is idempotent so extra sweeps
  // are semantics-preserving.
  os << "static void update_state(" << devName << "_state *s)\n";
  os << "{\n";
  os << "    update_state_once(s);\n";
  os << "    update_state_once(s);\n";
  os << "    update_state_once(s);\n";
  os << "}\n";
  os << "static bool tick(" << devName << "_state *s);\n";
  os << "/* One clock + per-clock observer hook (organs needing edge visibility). */\n";
  os << "static inline bool qp_tick(" << devName << "_state *s)\n{\n"
     << "    if (s->_qp_before_tick) {\n"
     << "        s->_qp_before_tick(s->_qp_before_tick_ctx);\n"
     << "        update_state(s);\n"
     << "    }\n"
     << "    bool _qp_ch = tick(s);\n"
     << "    if (s->_qp_on_tick) s->_qp_on_tick(s->_qp_on_tick_ctx);\n"
     << "    /* Activity bit.  Written AFTER the observer so an organ's\n"
     << "     * whole-core snapshot restore (spi_host byte replay) cannot\n"
     << "     * revert it, and a rewind counts as activity.\n"
     << "     * CONTRACT: consumed ONLY by a ring PUMP, outside every settle.\n"
     << "     * A settle hook must NEVER read it: a model with no fixed point\n"
     << "     * would pin it at 1 and hold every MMIO settle open to its cap. */\n"
     << "    s->_qp_active = (_qp_ch || s->_qp_rewound) ? 1 : 0;\n"
     << "    return _qp_ch;\n}\n\n";

  // A repeated complete model state under unchanged MMIO inputs implies that
  // the deterministic update_state/tick trajectory has entered a cycle.  Keep
  // two independent 64-bit fingerprints so the false-repeat probability is
  // negligible without retaining 256 potentially huge state snapshots.
  os << "/* Single settle bound per MMIO access — responsiveness only, not\n";
  os << " * correctness: leftover work continues on the next access/poll. */\n";
  os << "#define QP_SETTLE_BUDGET 65536u\n";
  os << "/* Cross-model tier: a hook-extended settle's continuation is the ring\n";
  os << " * PUMP, which runs outside the settle — the same argument the 256 tier\n";
  os << " * carries for firmware polling.  65536 survives only for an organ\n";
  os << " * holding an atomic protocol unit, where the MODEL owns the\n";
  os << " * continuation. */\n";
  os << "#define QP_EXT_BUDGET     4096u\n";
  os << "#define QP_EXT_STRIKES       3u\n\n";
  os << "static QPSettleFingerprint qp_settle_fingerprint(const "
     << devName << "_state *s)\n";
  os << "{\n";
  os << "    const uint8_t *bytes = (const uint8_t *)s;\n";
  os << "    QPSettleFingerprint fp = {\n";
  os << "        UINT64_C(1469598103934665603),\n";
  os << "        UINT64_C(1099511628211),\n";
  os << "    };\n";
  os << "\n";
  os << "    for (size_t i = 0; i < sizeof(*s); ++i) {\n";
  os << "        fp.first ^= bytes[i];\n";
  os << "        fp.first *= UINT64_C(1099511628211);\n";
  os << "        fp.second ^= (uint64_t)bytes[i] + UINT64_C(0x9e3779b97f4a7c15)\n";
  os << "                     + (fp.second << 6) + (fp.second >> 2);\n";
  os << "    }\n";
  os << "    return fp;\n";
  os << "}\n\n";

  // ---- Per-counter ptimer expiration callbacks ----
  for (const auto &c : counters) {
    os << "/*\n";
    os << " * ptimer expiration callback for counter '" << c.originalName
       << "'.\n";
    os << " * Fires once when the counter reaches zero (or wraps, depending\n";
    os << " * on ptimer policy).  We raise the associated IRQ line.\n";
    os << " */\n";
    os << "static void " << devName << "_tick_" << c.sanitizedName
       << "(void *opaque)\n";
    os << "{\n";
    os << "    " << devName << "_state *s = opaque;\n";
    os << "    qemu_irq_raise(s->irq_" << c.sanitizedName << ");\n";
    os << "}\n\n";
  }

  // Bug G: emit a single comb_logic / seq_logic assignment, taking
  // wide-array storage into account.  When the target is a uint64_t
  // arr[N] field, scalar-style `s->X = expr` is invalid C, so:
  //   - wordIndex >= 0  → `s->X[wordIndex] = expr;`
  //   - whole copy from another wide signal `s->Y` → memcpy
  //   - assignment to literal 0 → memset
  //   - anything else → emit a /* TODO */ marker so the generator does
  //     not silently miscompile (caller can then extend the catalog).
  auto isPlainScalarRef = [](const std::string &expr,
                             std::string *outName) -> bool {
    size_t b = 0, e = expr.size();
    while (b < e && (expr[b] == ' ' || expr[b] == '(')) ++b;
    while (e > b && (expr[e-1] == ' ' || expr[e-1] == ')')) --e;
    if (e - b < 4) return false;
    if (expr.compare(b, 3, "s->") != 0) return false;
    for (size_t i = b + 3; i < e; ++i) {
      char c = expr[i];
      if (!(std::isalnum((unsigned char)c) || c == '_')) return false;
    }
    if (outName) *outName = expr.substr(b + 3, e - b - 3);
    return true;
  };
  // Bit-width masking (RTL semantics are modulo 2^width).  Fields narrower
  // than their C container (a 3-bit counter in a uint8_t, an i1 in a uint8_t)
  // must be wrapped on assignment, otherwise `cnt - 1` on a 3-bit counter walks
  // 6,13,20,... instead of 6,5,4,... and `cnt == 0` never fires (spi_device s2p
  // data_valid never asserted after 8 sck edges — the event-clock backend
  // probe caught it), and an all-ones constant written as -1 lands as 255 in an
  // i1 field so `(x ^ 1)` is 254 (truthy) instead of 0.  Applied at BOTH the
  // comb (`s->X = ...`) and seq (`_qp_next_X = ...`) emission points; skipped
  // for full-container widths (8/16/32/64) and for wide arrays.
  auto widthMask = [](unsigned w) -> std::string {
    if (w == 0 || w >= 64 || w == 8 || w == 16 || w == 32) return "";
    return " & ((1ULL << " + std::to_string(w) + ") - 1)";
  };

  auto emitAssign = [&](clk_analysis::CombinationalAssignment assign) {
    // Raw-statement escape: a collapse hook that needs a multi-statement C
    // block or a runtime-indexed array write (which the single-LHS assignment
    // forms below can't express) pushes a CombinationalAssignment whose target
    // is the sentinel "__RAW__"; its expression is emitted verbatim.  Used by
    // the SRAM-FIFO data-queue collapse (Stage 2: push/pop with data[wptr]).
    if (assign.targetSignal == "__RAW__") {
      os << assign.expression << "\n";
      return;
    }
    auto sigIt = allSignals.find(assign.targetSignal);
    bool targetIsWide =
        (sigIt != allSignals.end() && sigIt->second.nWords > 0);
    // Scalar twin of the wordwise rewriter's wide-slice rule: a
    // constant-offset read of a wide field into a SCALAR destination
    // `((s->X) >> K)` becomes a qpw_wide_extract (keymgr's key-state
    // words load 64-bit slices of the 256-bit OTP root key shares and
    // the 384-bit kmac digest on the init/update arms — the guard below
    // dropped those arms wholesale).
    if (!targetIsWide || assign.wordIndex >= 0) {
      static const std::regex wslice(
          R"(\(\(s->([A-Za-z0-9_]+)\) >> ([0-9]+)\))");
      std::string &ex = const_cast<std::string &>(assign.expression);
      std::string out2;
      std::sregex_iterator wit(ex.begin(), ex.end(), wslice), wend;
      size_t last = 0;
      bool any = false;
      for (; wit != wend; ++wit) {
        auto m = *wit;
        auto sit2 = allSignals.find(m[1].str());
        if (sit2 == allSignals.end() || sit2->second.nWords == 0) continue;
        out2 += ex.substr(last, m.position() - last);
        if (!targetIsWide && assign.wordIndex < 0 &&
            sigIt != allSignals.end() && sigIt->second.bitWidth > 64 &&
            sigIt->second.bitWidth <= 128) {
          // 128-bit scalar context: take BOTH halves (a single 64-bit
          // extract dropped the high word — csrng's app-port genbits).
          out2 += "((((__uint128_t)qpw_wide_extract(s->" + m[1].str() +
                  ", " + std::to_string(sit2->second.nWords) + ", (" +
                  m[2].str() + ") + 64, 64)) << 64) | qpw_wide_extract(s->" +
                  m[1].str() + ", " + std::to_string(sit2->second.nWords) +
                  ", " + m[2].str() + ", 64))";
        } else {
          out2 += "qpw_wide_extract(s->" + m[1].str() + ", " +
                  std::to_string(sit2->second.nWords) + ", " + m[2].str() +
                  ", 64)";
        }
        last = m.position() + m.length();
        any = true;
      }
      if (any) {
        out2 += ex.substr(last);
        ex = std::move(out2);
      }
    }
    // 128-bit scalar context: a BARE wide-field read (`(s->wideArr)` with
    // no shift) means "the value, truncated to the context width" — the
    // translator spells csrng's `pdata[127:0]` exactly this way.  Rebuild
    // it as a scalar via qpw_wide_read128 so the expression compiles and
    // keeps both halves (the old path dropped the whole arm:
    // rsp_data_o.v's INS update never fired, state v stayed 0).
    if (!targetIsWide && sigIt != allSignals.end() &&
        sigIt->second.bitWidth > 64 && sigIt->second.bitWidth <= 128 &&
        assign.wordIndex < 0) {
      static const std::regex bareWide(R"(\(s->([A-Za-z0-9_]+)\)([^\[]|$))");
      std::string &ex = const_cast<std::string &>(assign.expression);
      std::string out3;
      std::sregex_iterator bit(ex.begin(), ex.end(), bareWide), bend;
      size_t last3 = 0;
      bool any3 = false;
      for (; bit != bend; ++bit) {
        auto m = *bit;
        auto sit3 = allSignals.find(m[1].str());
        if (sit3 == allSignals.end() || sit3->second.nWords == 0) continue;
        out3 += ex.substr(last3, m.position() - last3);
        out3 += "qpw_wide_read128(s->" + m[1].str() + ", " +
                std::to_string(sit3->second.nWords) + ")" + m[2].str();
        last3 = m.position() + m.length();
        any3 = true;
      }
      if (any3) {
        out3 += ex.substr(last3);
        ex = std::move(out3);
      }
    }
    // SCALAR-CONTEXT guard: now that pointwise wide operators (xor/and/or/
    // mux) pass translateValue, their textual form can reach a scalar or
    // word-slice destination, where `s->wideArr` decays to a pointer and
    // the C does not compile (kmac's 256-bit keymgr-key XOR sliced into a
    // 64-bit word).  Scan the RHS for wide-field references and drop the
    // assignment loudly instead.
    auto refersWide = [&](const std::string &e) -> bool {
      size_t p2 = 0;
      while ((p2 = e.find("s->", p2)) != std::string::npos) {
        size_t j2 = p2 + 3;
        while (j2 < e.size() &&
               (std::isalnum((unsigned char)e[j2]) || e[j2] == '_'))
          ++j2;
        // an indexed reference s->arr[...] is fine (single word), and so
        // is the array-decay argument of qpw_wide_extract(s->arr, ...)
        if (j2 < e.size() && e[j2] == '[') { p2 = j2; continue; }
        static const char kQpw[] = "qpw_wide_extract(";
        size_t qn = sizeof(kQpw) - 1;
        if (p2 >= qn && e.compare(p2 - qn, qn, kQpw) == 0) { p2 = j2; continue; }
        static const char kQpr[] = "qpw_wide_read128(";
        size_t qrn = sizeof(kQpr) - 1;
        if (p2 >= qrn && e.compare(p2 - qrn, qrn, kQpr) == 0) { p2 = j2; continue; }
        // pointer-cast access `((elemTy *)s->arr)[i]` (the FIFO collapse's
        // element read) is legal array decay
        if (p2 > 0 && e[p2 - 1] == ')') { p2 = j2; continue; }
        auto it2 = allSignals.find(e.substr(p2 + 3, j2 - p2 - 3));
        if (it2 != allSignals.end() && it2->second.nWords > 0)
          return true;
        p2 = j2;
      }
      return false;
    };
    // Wide-array SLICE into a scalar (<=128-bit) destination: the
    // translator spells `src[K +: W]` as `((s->wide) >> K)` with an
    // optional mask — stitch it from qpw_wide_extract words instead of
    // dropping (lc_ctrl's hashed token is bits [127:0] of the 129-bit
    // token+error CDC output).  A 64-bit all-ones mask on a >64-bit
    // destination is the genMask(>=64) truncation artifact — the
    // destination width already bounds the slice, so it is dropped.
    if ((assign.wordIndex >= 0 || !targetIsWide) &&
        refersWide(assign.expression)) {
      unsigned tw = assign.wordIndex >= 0 ? 64u : assign.bitWidth;
      static const std::regex wslice(
          R"(^\(*\(?s->([A-Za-z0-9_]+)\)?( >> ([0-9]+))?\)*( & (0x[0-9A-Fa-f]+ULL|[0-9]+ULL?))?\)*$)");
      std::smatch m;
      if (tw >= 1 && tw <= 128 &&
          std::regex_match(assign.expression, m, wslice)) {
        auto sit2 = allSignals.find(m[1].str());
        if (sit2 != allSignals.end() && sit2->second.nWords > 0) {
          unsigned nW = sit2->second.nWords;
          unsigned k = m[3].matched ? (unsigned)std::stoul(m[3].str()) : 0;
          std::string src = "s->" + m[1].str();
          std::string e2;
          if (tw <= 64) {
            e2 = "qpw_wide_extract(" + src + ", " + std::to_string(nW) +
                 ", " + std::to_string(k) + ", " + std::to_string(tw) + ")";
          } else {
            e2 = "((((__uint128_t)qpw_wide_extract(" + src + ", " +
                 std::to_string(nW) + ", " + std::to_string(k + 64) + ", " +
                 std::to_string(tw - 64) + ")) << 64) | qpw_wide_extract(" +
                 src + ", " + std::to_string(nW) + ", " +
                 std::to_string(k) + ", 64))";
          }
          if (m[5].matched && !(tw > 64 && m[5].str() == "0xFFFFFFFFFFFFFFFFULL"))
            e2 = "((" + e2 + ") & (__uint128_t)" + m[5].str() + ")";
          assign.expression = e2;
        }
      }
    }
    if ((assign.wordIndex >= 0 || !targetIsWide) &&
        refersWide(assign.expression)) {
      llvm::errs() << "  [SCALAR-CTX WIDE DROP] " << assign.targetSignal
                   << " = " << comb_translator::brief(assign.expression)
                   << "\n";
      os << "    /* TODO: wide operand in scalar context dropped: s->"
         << assign.targetSignal << " */\n";
      return;
    }
    if (assign.wordIndex >= 0) {
      os << "    s->" << assign.targetSignal << "[" << assign.wordIndex
         << "] = " << assign.expression << ";\n";
      return;
    }
    if (!targetIsWide) {
      std::string mask = (sigIt != allSignals.end())
                             ? widthMask(sigIt->second.bitWidth) : "";
      if (mask.empty())
        os << "    s->" << assign.targetSignal << " = " << assign.expression
           << ";\n";
      else
        os << "    s->" << assign.targetSignal << " = (" << assign.expression
           << ")" << mask << ";\n";
      return;
    }
    // Wide-array whole-signal assignment.
    std::string srcName;
    if (isPlainScalarRef(assign.expression, &srcName)) {
      if (srcName == assign.targetSignal) {
        os << "    /* self-copy skipped: s->" << assign.targetSignal
           << " unchanged */\n";
        return;
      }
      // Width guard: memcpy assumes source and target storage agree.  A
      // narrower source (a truncated bridge expression, e.g. a 32-bit
      // register word feeding a 186-bit port) would read out of bounds
      // and fill the port with garbage — be LOUD and leave the target
      // untouched instead.
      auto srcIt = allSignals.find(srcName);
      if (srcIt == allSignals.end() ||
          srcIt->second.bitWidth != sigIt->second.bitWidth) {
        os << "    /* [WIDE-COPY DROP] s->" << assign.targetSignal
           << " <- s->" << srcName << " (width mismatch) */\n";
        llvm::errs() << "  [WIDE-COPY DROP] " << assign.targetSignal
                     << " <- " << srcName << " (src "
                     << (srcIt == allSignals.end()
                             ? 0u : srcIt->second.bitWidth)
                     << "b vs dst " << sigIt->second.bitWidth << "b)\n";
        return;
      }
      if (getenv("QP_DEBUG_COPY"))
        llvm::errs() << "  [wide-copy OK] " << assign.targetSignal << "("
                     << sigIt->second.bitWidth << "b) <- " << srcName << "("
                     << srcIt->second.bitWidth << "b)\n";
      os << "    memcpy(s->" << assign.targetSignal << ", s->" << srcName
         << ", sizeof(s->" << assign.targetSignal << "));\n";
      return;
    }
    // Trim outer parens for literal-0 detection.
    std::string trimmed = assign.expression;
    while (trimmed.size() >= 2 && trimmed.front() == '(' && trimmed.back() == ')')
      trimmed = trimmed.substr(1, trimmed.size() - 2);
    if (trimmed == "0" || trimmed == "0u" || trimmed == "0x0" ||
        trimmed == "0ULL" || trimmed == "0x0ULL") {
      os << "    memset(s->" << assign.targetSignal << ", 0, sizeof(s->"
         << assign.targetSignal << "));\n";
      return;
    }
    std::string ww = wideWordwiseExpr(assign.expression,
                                      (unsigned)sigIt->second.nWords,
                                      allSignals, "");
    if (!ww.empty()) {
      os << "    for (unsigned _qp_w = 0; _qp_w < " << sigIt->second.nWords
         << "; ++_qp_w)\n";
      os << "        s->" << assign.targetSignal << "[_qp_w] = " << ww << ";\n";
      unsigned tail = sigIt->second.bitWidth % 64;
      if (tail)
        os << "    s->" << assign.targetSignal << "[" << (sigIt->second.nWords - 1)
           << "] &= (1ULL << " << tail << ") - 1;\n";
      return;
    }
    llvm::errs() << "  [WIDE-ASSIGN DROP] " << assign.targetSignal << " = "
                 << assign.expression << "\n";
    os << "    /* TODO Bug G: unhandled wide-array whole assignment */\n";
    os << "    /* s->" << assign.targetSignal << " = " << assign.expression
       << "; */\n";
  };

  // ---- update_state() — combinational logic propagation ----
  os << "/*\n";
  os << " * update_state() - Re-evaluate all combinational logic.\n";
  os << " *\n";
  os << " * Called after every MMIO write or read (for read-triggered outputs).\n";
  os << " * This is the \"single-cycle evaluation\" model: we assume all\n";
  os << " * combinational paths settle instantaneously (no multi-cycle handshake).\n";
  os << " */\n";
  os << "static void update_state_once(" << devName << "_state *s)\n";
  os << "{\n";
  if (combLogic.empty()) {
    os << "    /* No combinational logic extracted from IR */\n";
  } else {
    // Cyclic SCCs (true combinational loops) are emitted inside a small local
    // fixed-point loop: their members can only be kept in a best-effort order,
    // and a stale read inside the cycle is NOT caught by tick()'s
    // changed-detection (which only sees sequential state), so without this
    // a comb value could stay stale across a whole settle (spi_readcmd's
    // addr_cnt_set/addr_cnt_d).  Bound = 8 passes.
    size_t i = 0;
    while (i < combLogic.size()) {
      if (!combLogic[i].sccCyclic) { emitAssign(combLogic[i]); ++i; continue; }
      int id = combLogic[i].sccId;
      size_t j = i;
      while (j < combLogic.size() && combLogic[j].sccCyclic && combLogic[j].sccId == id) ++j;
      os << "    /* comb SCC " << id << ": " << (j - i) << " assignment(s), local fixed point */\n";
      os << "    for (unsigned _qp_scc = 0; _qp_scc < 8u; ++_qp_scc) {\n";
      for (size_t k = i; k < j; ++k) emitAssign(combLogic[k]);
      os << "    }\n";
      i = j;
    }
  }
  os << "}\n\n";

  // ---- tick() — sequential register commit ----
  //
  // tick() runs every register-class drv that lives inside an llhd.process
  // (Phase 1 captured them as qemu.seq_logic).  Verilog nonblocking
  // assignments sample the pre-edge state and commit simultaneously, so direct
  // `s->q = expr` emission is incorrect for register chains and cycles: a later
  // expression could observe an earlier register's newly-written value.
  //
  // ACCUMULATE-classified entries are dropped at render time —
  // they're already wired to ptimer instances by the read/write
  // sync logic below.  Re-running them here would let any MMIO
  // access spuriously decrement self-driven counters.
  //
  // Emit two phases:
  //   1. Initialize one `_qp_next_*` temporary per sequential target from the
  //      old state, then evaluate every drv into those temporaries.  References
  //      to other `s->q` fields therefore always see pre-edge state.
  //   2. Commit every temporary back to `s` only after all next-state
  //      expressions have been evaluated.
  //
  // Multiple drvs to the same target retain source order and rewrite only their
  // self-reference to `_qp_next_*`, preserving the existing reset/enable/hold
  // composition while still isolating all cross-register reads from commits.
  os << "/*\n";
  os << " * tick() - Evaluate and atomically commit one sequential edge.\n";
  os << " *\n";
  os << " * Phase 1 computes every next-state value from the same old state.\n";
  os << " * Phase 2 commits all registers together, matching Verilog NBA\n";
  os << " * semantics. The return value reports whether sequential state changed.\n";
  os << " * ACCUMULATE counters are handled by ptimer instead.\n";
  os << " */\n";
  os << "static bool tick(" << devName << "_state *s)\n";
  os << "{\n";
  if (seqLogic.empty()) {
    os << "    /* No sequential logic extracted from IR */\n";
    os << "    return false;\n";
  } else {
    struct SeqTarget {
      std::string name;
      std::string nextName;
      unsigned bitWidth = 32;
      unsigned nWords = 0;
    };

    std::vector<SeqTarget> seqTargets;
    std::map<std::string, unsigned> seqTargetIndex;
    std::vector<const clk_analysis::CombinationalAssignment *> rawSeqBlocks;
    for (const auto &assign : seqLogic) {
      if (assign.targetSignal == "__RAW__") {
        rawSeqBlocks.push_back(&assign);
        continue;
      }
      if (seqTargetIndex.count(assign.targetSignal))
        continue;

      SeqTarget target;
      target.name = assign.targetSignal;
      target.nextName = "_qp_next_" + assign.targetSignal;
      target.bitWidth = assign.bitWidth > 0 ? assign.bitWidth : 32;
      if (auto it = allSignals.find(assign.targetSignal);
          it != allSignals.end()) {
        target.bitWidth = it->second.bitWidth;
        target.nWords = it->second.nWords;
      } else if (target.bitWidth > 128) {
        target.nWords = (target.bitWidth + 63) / 64;
      }
      seqTargetIndex[target.name] = seqTargets.size();
      seqTargets.push_back(std::move(target));
    }

    os << "    bool _qp_changed = false;\n";

    auto scalarCType = [](unsigned bitWidth) -> const char * {
      if (bitWidth <= 8)
        return "uint8_t";
      if (bitWidth <= 16)
        return "uint16_t";
      if (bitWidth <= 32)
        return "uint32_t";
      if (bitWidth <= 64)
        return "uint64_t";
      return "__uint128_t";
    };

    // Nonblocking semantics: every READ of the target inside a next-state
    // expression must see the PRE-edge value — conditions of mutually
    // exclusive arms (`tc == P ? 0 : ...` / `tc != P ? tc + 1 : ...`) and the
    // step itself.  Only the trailing HOLD fall-through (`... : s->X)`) chains
    // to the running next value, so an earlier arm's assignment survives a
    // later arm that does not fire.  Rewriting every occurrence (the previous
    // behaviour) let a wrap arm's `next = 0` be seen by the increment arm's
    // condition in the same tick (7 -> 0 -> 1: period P instead of P+1).
    auto rewriteSelfReference = [](std::string expr, llvm::StringRef target,
                                   llvm::StringRef nextName) {
      std::string token = ("s->" + target).str();
      // Rewrite to the running next value ONLY where the reference means
      // "the value as updated so far in this tick":
      //   (a) the trailing hold fall-through   "... : s->X)"
      //   (b) a bit-slice partial-update base   "(s->X & ~MASK) | (v << k)"
      //       (several slices of one register update in one tick must chain)
      //   (c) a bare self-copy                  "s->X"
      // Every other read (arm conditions, `s->X + 1` steps) is pre-edge.
      if (expr == token) return nextName.str();
      // A SLICE-form partial update (`(s->X & ~MASK) | ...`) is a
      // serialized rewrite step (an inlined function body: the ECC
      // encoder computes parity bits over the data it just loaded into
      // the same temporary).  There, EVERY same-target read means "as
      // updated so far" — replace all of them.  Ternary hold arms keep
      // the narrow rule below: their arm conditions and `s->X + 1`
      // steps are pre-edge reads (a counter's wrap arm must not feed
      // its increment arm's condition in the same tick).
      {
        size_t p0 = expr.find(token);
        bool sliceForm = false;
        while (p0 != std::string::npos) {
          size_t e0 = p0 + token.size();
          size_t r0 = e0;
          if (r0 < expr.size() && expr[r0] == '[') {
            size_t rb = r0 + 1;
            while (rb < expr.size() && std::isdigit((unsigned char)expr[rb]))
              ++rb;
            if (rb < expr.size() && expr[rb] == ']') r0 = rb + 1;
          }
          if ((e0 >= expr.size() ||
               !(std::isalnum((unsigned char)expr[e0]) || expr[e0] == '_')) &&
              expr.compare(r0, 4, " & ~") == 0) {
            sliceForm = true;
            break;
          }
          p0 = expr.find(token, e0);
        }
        if (sliceForm) {
          std::string out2;
          size_t pos2 = 0, last2 = 0;
          while ((pos2 = expr.find(token, pos2)) != std::string::npos) {
            size_t end2 = pos2 + token.size();
            bool wordEnd2 =
                end2 >= expr.size() ||
                !(std::isalnum((unsigned char)expr[end2]) ||
                  expr[end2] == '_');
            if (wordEnd2) {
              out2.append(expr, last2, pos2 - last2);
              out2.append(nextName.str());
              last2 = end2;
            }
            pos2 = end2;
          }
          out2.append(expr, last2, std::string::npos);
          return out2;
        }
      }
      std::string out;
      size_t pos = 0, last = 0;
      while ((pos = expr.find(token, pos)) != std::string::npos) {
        size_t end = pos + token.size();
        bool wordEnd = end >= expr.size() ||
                       !(std::isalnum((unsigned char)expr[end]) || expr[end] == '_');
        // WORD-INDEXED self-references (`s->X[k]` on a wide target):
        // consume the `[k]` before classifying so a hold arm
        // `... : s->X[0])` or slice base `(s->X[0] & ~M)` chains through
        // `_qp_next_X[k]`.  Without this, the SECOND slice-drv to the
        // same word read the OLD state and erased the first one's write
        // (kmac's 16-lane sw_key_data_reg packing lost key word 0).
        size_t refEnd = end;
        if (wordEnd && refEnd < expr.size() && expr[refEnd] == '[') {
          size_t rb = refEnd + 1;
          while (rb < expr.size() && std::isdigit((unsigned char)expr[rb]))
            ++rb;
          if (rb < expr.size() && expr[rb] == ']' && rb > refEnd + 1)
            refEnd = rb + 1;
        }
        bool isHold  = wordEnd && refEnd + 1 == expr.size() &&
                       expr[refEnd] == ')' &&
                       pos >= 3 && expr.compare(pos - 3, 3, " : ") == 0;
        bool isSlice = wordEnd && expr.compare(refEnd, 4, " & ~") == 0;
        if (wordEnd && (isHold || isSlice)) {
          out.append(expr, last, pos - last);
          out.append(nextName.str());
          last = end;   // keep the original `[k]` suffix
        }
        pos = end;
      }
      out.append(expr, last, std::string::npos);
      return out;
    };

    auto isZeroLiteral = [](std::string expr) {
      while (expr.size() >= 2 && expr.front() == '(' && expr.back() == ')')
        expr = expr.substr(1, expr.size() - 2);
      return expr == "0" || expr == "0u" || expr == "0x0" ||
             expr == "0ULL" || expr == "0x0ULL";
    };

    os << "    /* Phase 1: snapshot old state into next-state temporaries. */\n";
    for (const auto &target : seqTargets) {
      if (target.nWords > 0) {
        os << "    uint64_t " << target.nextName << "[" << target.nWords
           << "];\n";
        os << "    memcpy(" << target.nextName << ", s->" << target.name
           << ", sizeof(" << target.nextName << "));\n";
      } else {
        os << "    " << scalarCType(target.bitWidth) << " " << target.nextName
           << " = s->" << target.name << ";\n";
      }
    }
    os << "\n    /* Evaluate all next-state expressions from pre-edge state. */\n";
    for (const auto &assign : seqLogic) {
      if (assign.targetSignal == "__RAW__")
        continue;

      const SeqTarget &target =
          seqTargets[seqTargetIndex.at(assign.targetSignal)];
      std::string expr = rewriteSelfReference(
          assign.expression, target.name, target.nextName);
      // Inliner temporaries (the `qpinl*` naming is the inliner's own
      // convention) are NOT registers: a function body inlined into a
      // clocked process is a serialized computation, so a read of a
      // qpinl temp by ANY later seq assignment means "as computed this
      // tick" — reading the pre-edge state gave keymgr's shared ECC
      // temp a one-tick stale value (and the 16 encoder groups sharing
      // it made every word read the LAST group's previous result).
      {
        size_t qp = 0;
        while ((qp = expr.find("s->", qp)) != std::string::npos) {
          size_t je = qp + 3;
          while (je < expr.size() &&
                 (std::isalnum((unsigned char)expr[je]) || expr[je] == '_'))
            ++je;
          std::string nm = expr.substr(qp + 3, je - qp - 3);
          if (nm.find("qpinl") != std::string::npos &&
              seqTargetIndex.count(nm)) {
            std::string rep = "_qp_next_" + nm;
            expr = expr.substr(0, qp) + rep + expr.substr(je);
            qp += rep.size();
          } else {
            qp = je;
          }
        }
      }

      if (assign.wordIndex >= 0) {
        os << "    " << target.nextName << "[" << assign.wordIndex
           << "] = " << expr << ";\n";
        continue;
      }
      if (target.nWords == 0) {
        std::string mask = widthMask(target.bitWidth);
        if (mask.empty())
          os << "    " << target.nextName << " = " << expr << ";\n";
        else
          os << "    " << target.nextName << " = (" << expr << ")" << mask
             << ";\n";
        continue;
      }

      // Wide whole-signal updates use the same conservative forms as
      // emitAssign(): copy, zero, or leave an explicit TODO rather than
      // silently generating invalid C.
      std::string sourceName;
      if (isPlainScalarRef(assign.expression, &sourceName)) {
        if (sourceName != target.name)
          os << "    memcpy(" << target.nextName << ", s->" << sourceName
             << ", sizeof(" << target.nextName << "));\n";
      } else if (isZeroLiteral(assign.expression)) {
        os << "    memset(" << target.nextName << ", 0, sizeof("
           << target.nextName << "));\n";
      } else {
        std::string ww = wideWordwiseExpr(expr, target.nWords, allSignals,
                                          target.nextName);
        if (!ww.empty()) {
          os << "    for (unsigned _qp_w = 0; _qp_w < " << target.nWords
             << "; ++_qp_w)\n";
          os << "        " << target.nextName << "[_qp_w] = " << ww << ";\n";
          unsigned tail = target.bitWidth % 64;
          if (tail)
            os << "    " << target.nextName << "[" << (target.nWords - 1)
               << "] &= (1ULL << " << tail << ") - 1;\n";
        } else {
          llvm::errs() << "  [WIDE-ASSIGN DROP] (seq) " << target.name << " = "
                       << assign.expression << "\n";
          os << "    /* TODO: unhandled wide next-state whole assignment for "
             << target.name << " */\n";
        }
      }
    }

    // Functional-collapse blocks contain runtime-indexed memory/FIFO updates
    // that cannot be represented by a single assignment.  Execute them after
    // all ordinary next-state expressions have sampled old state, but before
    // ordinary register commits, so they cannot affect those RHS evaluations.
    if (!rawSeqBlocks.empty()) {
      os << "\n    /* Specialized sequential blocks sampled after Phase 1. */\n";
      os << "    char _qp_raw_prev[sizeof(*s)];\n";
      os << "    memcpy(_qp_raw_prev, s, sizeof(*s));\n";
      for (const auto *assign : rawSeqBlocks)
        emitAssign(*assign);
      os << "    _qp_changed |= memcmp(_qp_raw_prev, s, sizeof(*s)) != 0;\n";
    }

    os << "\n    /* Detect changes before committing ordinary registers. */\n";
    for (const auto &target : seqTargets) {
      if (target.nWords > 0) {
        os << "    _qp_changed |= memcmp(" << target.nextName << ", s->"
           << target.name << ", sizeof(s->" << target.name << ")) != 0;\n";
      } else {
        os << "    _qp_changed |= " << target.nextName << " != s->"
           << target.name << ";\n";
      }
    }

    os << "\n    /* Phase 2: commit all ordinary registers simultaneously. */\n";
    for (const auto &target : seqTargets) {
      if (target.nWords > 0) {
        os << "    memcpy(s->" << target.name << ", " << target.nextName
           << ", sizeof(s->" << target.name << "));\n";
      } else {
        os << "    s->" << target.name << " = " << target.nextName << ";\n";
      }
    }
    os << "\n    return _qp_changed;\n";
  }
  os << "}\n\n";

  // ---- advance_tick(): one virtual-time step ----
  // Free-running (ACCUMULATE) counters were dropped from tick() so the MMIO
  // settle loop converges.  Their advance instead happens HERE, called by the
  // QP shim's periodic pump (autonomous, wall-clock) — never inside the settle
  // loop.  We bump each counter by its step (the model's own reset-mux wraps it
  // at the prescaler) then settle one comb/seq round so the
  // counter->tick->writeback chain (e.g. prescaler->tick->mtime) propagates and
  // the comparator->intr_state can fire.  Functional virtual time, not
  // cycle-accurate.  No per-device knowledge — purely the ACCUMULATE set.
  //
  // A timer-declared device with NO ACCUMULATE counter (e.g. aon_timer, whose
  // count is a plain seq register advanced by a hw2reg de-strobe each tick)
  // still needs advance_tick: here it degenerates to a bare settle, and the
  // shim pump driving it periodically is what lets the count + comparator move
  // while firmware is parked in WFI / a busy-wait.
  if (!counters.empty() || timerPump) {
    os << "void " << devName << "_advance_tick(" << devName << "_state *s)\n";
    os << "{\n";
    for (const auto &c : counters) {
      os << "    s->" << c.sanitizedName << " += " << c.step << ";\n";
    }
    // Accumulate rings (AccumulateRingDetect): raise the pump pulse for ONE
    // tick so every `acc + (s->_qp_pump ? step : 0)` steps exactly once, then
    // drop it and settle — the settle sees `acc + 0` and converges.
    os << "    s->_qp_pump = 1;\n";
    os << "    update_state(s);\n";
    os << "    qp_tick(s);\n";
    os << "    s->_qp_pump = 0;\n";
    // Settle to a FIXED POINT (not one round): the counter->tick->writeback
    // chain (e.g. prescaler->tick->mtime register->mtime) needs several
    // comb/seq rounds through the reg_top bridges to propagate.
    emitSettleLoop(os);
    os << "}\n\n";
  }

  // ---- MMIO _read() — Protocol-Agnostic ----
  //
  // Design: When QEMU issues a memory-mapped read:
  //   1. Inject `addr` into the addr_signal state variable
  //   2. Optionally set an enable signal
  //   3. Call update_state() to propagate combinational logic
  //   4. Return the rdata_signal state variable
  //
  // This works because the hardware's address-decode mux tree and data-path
  // are captured in update_state()'s combinational logic.  By setting
  // addr_signal and re-evaluating, the correct register value naturally
  // appears at rdata_signal.
  // ---- _reset() — pulse reset across the model ----
  //
  // Generated prim_subreg's commit RESVAL via `q = (~rst_ni) ? RESVAL : keep`.
  // C-init leaves rst_ni at 0 (reset asserted), but registers with non-zero
  // RESVAL (e.g. REGWEN = 1) need at least one tick() during reset to commit
  // that RESVAL — otherwise q stays at C-init = 0.  The shim calls this once
  // at instance init time, then releases reset.
  //
  // We also need a tick AFTER releasing reset.  prim_fifo_sync's `under_rst`
  // bookkeeping latches to 1 during reset (so wready=0 / rready=0 mask any
  // spurious mid-reset bus traffic) and only flips back to 0 on the *next*
  // tick after rst_ni=1.  Without this trailing tick, post-reset reads of
  // STATUS.TXFULL = (~txfifo.wready) come back stuck at 1, breaking any
  // firmware that polls TXFULL before the first byte is queued.
  // Collect ALL top-level reset signals (rst_ni and any other rst_*_ni
  // dst-clock-domain inputs like rst_core_ni / rst_aon_ni / rst_sys_ni).
  // OT IPs use multi-clock CDC where the dst-domain (often slower clock)
  // has its own reset; these come into the IR as separate top-level
  // ports.  If we only pulse rst_ni, the dst-clock-domain stays in
  // reset forever, the prim_pulse_sync FFs never advance, and CDC
  // handshakes (used by prim_reg_cdc-protected registers) deadlock.
  //
  // Filter: signal name matches /^rst.*_ni$/ AND has no instance-path
  // marker (`_u_` or non-leading underscore-separated word that's a
  // submodule prefix).  Top-level inputs in the state struct are
  // emitted at root scope, so they have a flat name.
  std::vector<std::string> resetSignals;
  for (const auto &kv : allSignals) {
    if (!legacyResetNames) break;
    const std::string &n = kv.first;
    // must end with _ni
    if (n.size() < 5) continue;
    if (n.substr(n.size() - 3) != "_ni") continue;
    // must start with rst (so rst_ni or rst_X_ni)
    if (n.substr(0, 3) != "rst") continue;
    // exclude sub-instance fields (those have _u_ marker)
    if (n.find("_u_") != std::string::npos) continue;
    // exclude reg-block-prefixed (e.g. u_reg_rst_ni) — those start with u_
    if (n.size() >= 2 && n.substr(0, 2) == "u_") continue;
    resetSignals.push_back(n);
  }

  // ---- Auxiliary TL-UL target ports (multi-port devices) ----
  for (const auto &ap : auxPorts) {
    auto has = [&](const std::string &f) { return allSignals.count(f) > 0; };
    os << "/* Aux TL-UL port '" << ap.name << "': same transaction recipe as\n"
       << " * the primary port, response captured from the bridged top-level\n"
       << " * output leaves. */\n";
    os << "uint64_t " << devName << "_" << ap.name
       << "_read(void *opaque, hwaddr addr, unsigned size)\n{\n";
    os << "    " << devName << "_state *s = opaque;\n";
    os << "    s->_qp_access_gen++;\n";
    os << "    s->" << ap.aAddress << " = (uint32_t)addr;\n";
    os << "    s->" << ap.aOpcode << " = (uint8_t)4;  /* Get */\n";
    if (has(ap.aSize))
      os << "    s->" << ap.aSize
         << " = (uint8_t)(size >= 4 ? 2 : size == 2 ? 1 : 0);\n";
    if (has(ap.aMask))
      os << "    s->" << ap.aMask
         << " = (uint8_t)(((1u << (size >= 4 ? 4 : size)) - 1u) << (addr & 3u));\n";
    if (has(ap.aInstr))
      os << "    s->" << ap.aInstr << " = (uint8_t)9;  /* MuBi4False */\n";
    os << "    s->" << ap.dReady << " = 1;\n";
    os << "    s->" << ap.aValid << " = 1;\n";
    os << "    s->_qp_in_request = 1;\n";
    os << "    update_state(s);\n    qp_tick(s);\n";
    os << "    s->" << ap.aValid << " = 0;\n";
    os << "    s->_qp_in_request = 0;\n";
    os << "    s->_qp_rd_cap = 0;\n";
    emitSettleLoop(os, ap.dValid, ap.dData);
    os << "    uint32_t _qp_rv = s->_qp_rd_cap ? s->_qp_rd_capv : s->"
       << ap.dData << ";\n";
    os << "    if (size < 4)\n"
       << "        return ((uint64_t)_qp_rv >> (8u * (addr & 3u))) & ((1ULL << (8u * size)) - 1u);\n";
    os << "    return (uint64_t)_qp_rv;\n";
    os << "}\n\n";
    os << "void " << devName << "_" << ap.name
       << "_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)\n{\n";
    os << "    " << devName << "_state *s = opaque;\n";
    os << "    s->_qp_access_gen++;\n";
    os << "    s->" << ap.aAddress << " = (uint32_t)addr;\n";
    os << "    s->" << ap.aData << " = (uint32_t)value;\n";
    os << "    s->" << ap.aOpcode << " = (uint8_t)0;  /* PutFullData */\n";
    if (has(ap.aSize))
      os << "    s->" << ap.aSize
         << " = (uint8_t)(size >= 4 ? 2 : size == 2 ? 1 : 0);\n";
    if (has(ap.aMask))
      os << "    s->" << ap.aMask
         << " = (uint8_t)(((1u << (size >= 4 ? 4 : size)) - 1u) << (addr & 3u));\n";
    if (has(ap.aInstr))
      os << "    s->" << ap.aInstr << " = (uint8_t)9;\n";
    os << "    s->" << ap.dReady << " = 1;\n";
    os << "    s->" << ap.aValid << " = 1;\n";
    os << "    s->_qp_in_request = 1;\n";
    os << "    update_state(s);\n    qp_tick(s);\n";
    os << "    s->" << ap.aValid << " = 0;\n";
    os << "    s->_qp_in_request = 0;\n";
    emitSettleLoop(os);
    os << "}\n\n";
  }

  // ---- Backing-store loader (memory organs: prim_rom collapses) ----
  if (!backingStores.empty()) {
    os << "/* Load an image into backing store <idx>.  Layout: one 64-bit\n"
       << " * little-endian word per memory word (upper bits beyond the\n"
       << " * organ width ignored).  Returns words loaded, or -1 on\n"
       << " * bad idx / oversized image. */\n";
    os << "int " << devName << "_load_backing(" << devName
       << "_state *s, unsigned idx, const void *bytes, unsigned long n)\n{\n";
    os << "    const unsigned long depths[] = {";
    for (size_t i = 0; i < backingStores.size(); ++i)
      os << (i ? ", " : "") << backingStores[i].second << "UL";
    os << "};\n";
    os << "    uint64_t *mems[] = {";
    for (size_t i = 0; i < backingStores.size(); ++i)
      os << (i ? ", " : "") << "s->" << backingStores[i].first;
    os << "};\n";
    os << "    if (idx >= " << backingStores.size()
       << "u || n > depths[idx] * 8) return -1;\n";
    os << "    memcpy(mems[idx], bytes, n);\n";
    os << "    return (int)(n / 8);\n";
    os << "}\n\n";
  }

  os << "/* Settle to quiescence (no bus access). */\n";
  os << "void " << devName << "_settle(" << devName << "_state *s)\n";
  os << "{\n";
  emitSettleLoop(os);
  os << "}\n\n";

  os << "/* Advance exactly one model clock.  Pin-level transport bridges use\n"
        " * this instead of holding an MMIO settle loop open. */\n";
  os << "void " << devName << "_step(" << devName << "_state *s)\n{\n"
     << "    update_state(s);\n    qp_tick(s);\n    update_state(s);\n}\n\n";
  os << "/* Fine-grained co-step primitives: a machine-level bridge that\n"
        " * LOCK-STEPS two generated models (device-to-device signal links)\n"
        " * must interleave update/tick across the pair — a coarse\n"
        " * step()+step() sequence skews the handshake phases (the keymgr x\n"
        " * kmac app channel only converges under update-update, tick-tick,\n"
        " * update-update ordering). */\n";
  os << "void " << devName << "_update(" << devName << "_state *s)\n{\n"
     << "    update_state(s);\n}\n\n";
  os << "void " << devName << "_tick(" << devName << "_state *s)\n{\n"
     << "    qp_tick(s);\n}\n\n";
  os << "void " << devName << "_step_many(" << devName
     << "_state *s, unsigned count)\n{\n"
     << "    update_state(s);\n"
     << "    while (count--) { qp_tick(s); update_state(s); }\n"
     << "}\n\n";

  os << "/* Pulse reset to commit RESVALs into every prim_subreg. */\n";
  os << "void " << devName << "_reset(" << devName << "_state *s)\n";
  os << "{\n";
  // Declared benign reset values for top inputs that, on real silicon, are
  // driven by another block (e.g. lc_ctrl drives lc_escalate_en_i to the
  // lifecycle "Off" encoding).  Set BEFORE the reset pulse so the post-release
  // settle propagates them (through any CDC sync) to the consuming logic.
  // Source: the binding's `input_resets` block (qemu.input_resets).
  if (!inputResets.empty()) {
    for (const auto &kv : inputResets)
      os << "    s->" << sanitizeName(kv.first) << " = " << kv.second << ";\n";
  }
  if (genericConfig) {
    for (const auto &kv : genericConfig->ties)
      os << "    s->" << kv.first << " = UINT64_C(" << kv.second << ");\n";
    for (const auto &kv : genericConfig->idleInputs)
      os << "    s->" << kv.first << " = UINT64_C(" << kv.second << ");\n";
    if (!genericConfig->resetPort.empty())
      os << "    s->" << genericConfig->resetPort << " = " << genericConfig->resetActive << ";\n";
  }
  // Assert legacy resets only when explicitly enabled.
  for (const auto &r : resetSignals) {
    os << "    s->" << r << " = 0;\n";
  }
  if (genericConfig)
    emitSettleLoop(os);
  else {
  os << "    update_state(s);\n";
  os << "    qp_tick(s);\n";
  os << "    update_state(s);\n";
  }
  if (genericConfig && !genericConfig->resetPort.empty())
    os << "    s->" << genericConfig->resetPort << " = " << (1 - genericConfig->resetActive) << ";\n";
  // Release legacy resets.
  for (const auto &r : resetSignals) {
    os << "    s->" << r << " = 1;\n";
  }
  if (genericConfig)
    emitSettleLoop(os);
  else {
  os << "    update_state(s);\n";
  os << "    qp_tick(s);\n";
  os << "    update_state(s);\n";
  }
  os << "}\n\n";

  os << "/*\n";
  os << " * MMIO Read — Protocol-agnostic bus transaction\n";
  os << " *\n";
  os << " * Instead of a switch(addr) with hardcoded register offsets,\n";
  os << " * we inject the address into the internal addr signal and let\n";
  os << " * update_state() drive the correct value to rdata.\n";
  os << " */\n";
  // Public API (declared in the .h via generateProtocolAgnosticHeader): a
  // shim device that embeds <dev>_state can extern-call this entrypoint.
  os << "uint64_t " << devName
     << "_read(void *opaque, hwaddr addr, unsigned size)\n";
  os << "{\n";
  os << "    " << devName << "_state *s = opaque;\n";
  os << "    s->_qp_access_gen++;   /* organs: state snapshots older than this are stale */\n\n";

  if (!bus.addrSignal.empty()) {
    os << "    /* Inject QEMU address into the internal address signal */\n";
    os << "    s->" << bus.addrSignal << " = (uint"
       << bus.addrWidth << "_t)addr;\n\n";
  }

  if (!bus.enableSignal.empty()) {
    os << "    /* De-assert write enable — this is a read operation */\n";
    os << "    s->" << bus.enableSignal << " = 0;\n\n";
  }

  // TL-UL handshake: pull a_valid high, set a_opcode = 4 (Get).
  // Also pull d_ready high so tlul_adapter_reg's `outstanding_q`
  // (which tracks in-flight bus transactions) can clear via d_ack
  // = d_valid & d_ready.  Without d_ready, after the first write
  // outstanding_q latches at 1 indefinitely → a_ready=0 → subsequent
  // reads never get a_ack=1 → rdata_q never updates → reads return 0.
  // Pre-collapse-fix this didn't matter because outstanding_q was
  // pinned at 0 (the multi-driver `_unknown_arg` placeholder), but
  // once outstanding_q correctly tracks the protocol, d_ready becomes
  // load-bearing.
  if (!bus.validSignal.empty()) {
    os << "    /* TL-UL: assert request valid + Get opcode + always-ready response acceptor */\n";
    os << "    s->" << bus.validSignal << " = 1;\n";
    if (!bus.dReadySignal.empty())
      os << "    s->" << bus.dReadySignal << " = 1;\n";
    if (!bus.opcodeSignal.empty()) {
      // a_opcode is 3-bit in TL-UL; the state struct stores it as the
      // smallest standard integer type (uint8_t) — never `uint3_t`.
      os << "    s->" << bus.opcodeSignal << " = (uint8_t)4;  /* Get */\n";
    }
    // Sub-word accesses are legal TL-UL: a_size = log2(bytes), a_mask = the
    // byte lanes of the access (tlul_err checks size/mask/alignment; the
    // adapters use be_o).  Byte/half-word register I/O (e.g. dif_spi_host's
    // TXDATA byte writes) depends on this.
    if (!bus.sizeSignal.empty())
      os << "    s->" << bus.sizeSignal << " = (uint8_t)(size >= 4 ? 2 : size == 2 ? 1 : 0);  /* log2(bytes) */\n";
    if (!bus.maskSignal.empty())
      os << "    s->" << bus.maskSignal << " = (uint8_t)(((1u << (size >= 4 ? 4 : size)) - 1u) << (addr & 3u));  /* byte lanes */\n";
    if (!bus.instrTypeSignal.empty())
      os << "    s->" << bus.instrTypeSignal << " = (uint8_t)9;  /* MuBi4False: data access */\n";
    os << "\n";
  }

  // Pull live ptimer counts back into the state struct so MMIO reads reflect
  // the real counter value rather than the stale last-written snapshot.
  // The NULL guard accommodates "frontend-only" embedding where a shim
  // device wraps this state but skips ptimer_init (e.g. ot_uart_qp.c).
  // In that mode counter values stay at their last-written snapshot,
  // which is the expected fail-safe for backend-not-wired bring-up.
  if (!counters.empty()) {
    os << "    /* Sync live ptimer counts into state before address decode.\n";
    os << "     * NULL-guarded so a shim that doesn't call uart_realize\n";
    os << "     * (frontend-only embedding) doesn't NULL-deref. */\n";
    for (const auto &c : counters) {
      const char *ctype =
          c.bitWidth <= 8  ? "uint8_t"  :
          c.bitWidth <= 16 ? "uint16_t" :
          c.bitWidth <= 32 ? "uint32_t" : "uint64_t";
      os << "    if (s->ptimer_" << c.sanitizedName << ") {\n";
      os << "        s->" << c.sanitizedName << " = ("
         << ctype << ")ptimer_get_count(s->ptimer_" << c.sanitizedName
         << ");\n";
      os << "    }\n";
    }
    os << "\n";
  }

  os << "    /* Multi-pass settle, same shape as the write callback.\n";
  os << "     *\n";
  os << "     * The read path also has seq drvs that must re-fire under\n";
  os << "     * the read-cycle's opcode (e.g. rdata_q in tlul_adapter_reg\n";
  os << "     * gates on `(error||wr_req) ? -1 : rdata_i` and is itself a\n";
  os << "     * seq drv).  Without ticking on the read, rdata_q remains\n";
  os << "     * at whatever value the previous write callback left it.\n";
  os << "     *\n";
  os << "     * Ticking during read is safe for register storage: with\n";
  os << "     * we==0 (read cycle), every prim_subreg's `q <= we?wd:q`\n";
  os << "     * is a no-op, so register state is preserved.  ACCUMULATE\n";
  os << "     * counters go through ptimer (not tick), also unaffected.\n";
  os << "     */\n";
  if (!bus.validSignal.empty()) {
    // ONE-CLOCK request: the adapter accepts the request in the first tick
    // (a_ready is high when nothing is outstanding); holding a_valid through
    // the whole settle made the adapter re-accept the same access every other
    // tick (write/read strobes oscillated), which is harmless for idempotent
    // register accesses but multiplies FIFO push/pop side effects.  Present
    // the request for exactly one tick, then deassert and let the response
    // path settle.
    os << "    s->_qp_in_request = 1;\n";
    os << "    update_state(s);\n";
    os << "    qp_tick(s);\n";
    os << "    s->" << bus.validSignal << " = 0;   /* request lasted one clock */\n";
    os << "    s->_qp_in_request = 0;\n";
  }
  // Response capture: sample rdata on the tick its companion d_valid is
  // high (see emitSettleLoop).  Only when the sibling signal exists.
  std::string capValid, capData;
  {
    const std::string suffix = "_d_data";
    if (bus.rdataSignal.size() > suffix.size() &&
        bus.rdataSignal.compare(bus.rdataSignal.size() - suffix.size(),
                                suffix.size(), suffix) == 0) {
      std::string cand =
          bus.rdataSignal.substr(0, bus.rdataSignal.size() - suffix.size()) +
          "_d_valid";
      if (allSignals.count(cand)) {
        capValid = cand;
        capData = bus.rdataSignal;
        os << "    s->_qp_rd_cap = 0;\n";
      }
    }
  }
  emitSettleLoop(os, capValid, capData);

  if (!bus.rdataSignal.empty()) {
    if (!capValid.empty()) {
      os << "    uint32_t _qp_rv = s->_qp_rd_cap ? s->_qp_rd_capv : s->"
         << bus.rdataSignal << ";\n";
      os << "    if (size < 4)\n"
         << "        return ((uint64_t)_qp_rv >> (8u * (addr & 3u))) & ((1ULL << (8u * size)) - 1u);\n";
      os << "    return (uint64_t)_qp_rv;\n";
    } else {
    // Sub-word read: QEMU expects the accessed bytes right-aligned.
    os << "    if (size < 4)\n"
       << "        return ((uint64_t)s->" << bus.rdataSignal << " >> (8u * (addr & 3u))) & ((1ULL << (8u * size)) - 1u);\n";
    os << "    return (uint64_t)s->" << bus.rdataSignal << ";\n";
    }
  } else {
    os << "    /* No rdata signal inferred — return 0 as placeholder */\n";
    os << "    qemu_log_mask(LOG_UNIMP, \"" << devName
       << ": read at 0x%\" HWADDR_PRIx \" (no rdata inferred)\\n\", addr);\n";
    os << "    return 0;\n";
  }
  os << "}\n\n";

  // ---- MMIO _write() — Protocol-Agnostic ----
  //
  // Design: When QEMU issues a memory-mapped write:
  //   1. Inject `addr` into addr_signal
  //   2. Inject `value` into wdata_signal
  //   3. Optionally set mask_signal and enable_signal
  //   4. Call update_state() to propagate the write through comb logic
  //
  // The hardware's write-enable mux tree (guarded by addr decode) will
  // route `wdata_signal` to the correct internal register.
  os << "/*\n";
  os << " * MMIO Write — Protocol-agnostic bus transaction\n";
  os << " *\n";
  os << " * Instead of a switch(addr) dispatching to individual registers,\n";
  os << " * we inject addr+value into the internal bus signals and let\n";
  os << " * update_state() propagate the write to the correct target.\n";
  os << " */\n";
  // Public API (declared in the .h via generateProtocolAgnosticHeader): a
  // shim device that embeds <dev>_state can extern-call this entrypoint.
  os << "void " << devName
     << "_write(void *opaque, hwaddr addr,\n";
  os << "        " << std::string(devName.size(), ' ')
     << "uint64_t value, unsigned size)\n";
  os << "{\n";
  os << "    " << devName << "_state *s = opaque;\n";
  os << "    s->_qp_access_gen++;   /* organs: state snapshots older than this are stale */\n\n";

  // Helper: pick the smallest standard C uintN_t (N ∈ {8,16,32,64}) that
  // fits the signal width.  Avoids emitting `uint66_t` when the underlying
  // sig is wider than 64 (e.g. SPI host's wdata bus carries the entire
  // tl_h2d_t request struct flattened to 66 bits, even though only the
  // low 32 bits are user data).  The cast just truncates to the C type;
  // for widths > 64 we accept that the high bits are dropped — the QEMU
  // `value` argument is uint64_t anyway.
  auto stdUintCast = [](unsigned width) -> std::string {
    if (width <= 8)  return "uint8_t";
    if (width <= 16) return "uint16_t";
    if (width <= 32) return "uint32_t";
    return "uint64_t";
  };

  if (!bus.addrSignal.empty()) {
    os << "    /* Inject QEMU address into the internal address signal */\n";
    os << "    s->" << bus.addrSignal << " = ("
       << stdUintCast(bus.addrWidth) << ")addr;\n\n";
  }

  if (!bus.wdataSignal.empty()) {
    os << "    /* Inject QEMU write data into the internal wdata signal\n"
       << "     * (sub-word writes: data sits in the addressed byte lanes) */\n";
    os << "    s->" << bus.wdataSignal << " = ("
       << stdUintCast(bus.wdataWidth) << ")(size < 4 ? (value << (8u * (addr & 3u))) : value);\n\n";
  }

  if (!bus.maskSignal.empty()) {
    /* TL-UL a_mask is a byte-enable: 1 bit per data byte, NOT a per-bit
     * mask.  For a 4-byte access, a_mask = 0xF (4 enable bits set), not
     * 0xFFFFFFFF.  The model checks `reg_be == 15` strictly, and the
     * underlying field is at most 8 bits wide (uint8_t storage), so
     * passing the wider expression would truncate to 0xFF and fail the
     * equality check (0xFF != 15).  GPIO failed this; UART happened to
     * pass because its checks compare bit slices (`& 0x3) != 3`) that
     * are satisfied even by 0xFF. */
    os << "    /* Set write mask (byte-enable bits for the access size, in the\n"
       << "     * addressed lanes: a byte write at +1 -> a_mask = 0x2) */\n";
    os << "    s->" << bus.maskSignal
       << " = (uint8_t)(((1u << (size >= 4 ? 4 : size)) - 1u) << (addr & 3u));\n\n";
  }

  if (!bus.enableSignal.empty()) {
    os << "    /* Assert the bus enable (write cycle) */\n";
    os << "    s->" << bus.enableSignal << " = 1;\n\n";
  }

  // TL-UL handshake: pull a_valid high + a_opcode = 0 (PutFullData) +
  // d_ready=1.  See read-callback comment for why d_ready matters
  // post-collapse-fix (outstanding_q tracking is now real, so d_ack
  // must fire to clear it before the NEXT bus access).
  if (!bus.validSignal.empty()) {
    os << "    /* TL-UL: assert request valid + PutFullData opcode + always-ready response acceptor */\n";
    os << "    s->" << bus.validSignal << " = 1;\n";
    if (!bus.dReadySignal.empty())
      os << "    s->" << bus.dReadySignal << " = 1;\n";
    if (!bus.opcodeSignal.empty()) {
      // Same uint8_t cast rationale as the read path above.
      os << "    s->" << bus.opcodeSignal << " = (uint8_t)0;  /* PutFullData */\n";
    }
    if (!bus.sizeSignal.empty())
      os << "    s->" << bus.sizeSignal << " = (uint8_t)(size >= 4 ? 2 : size == 2 ? 1 : 0);  /* log2(bytes) */\n";
    if (!bus.instrTypeSignal.empty())
      os << "    s->" << bus.instrTypeSignal << " = (uint8_t)9;  /* MuBi4False: data access */\n";
    os << "\n";
  }

  // Snapshot counter values before update_state so we can detect which
  // counters were written to and restart their ptimers accordingly.
  if (!counters.empty()) {
    os << "    /* Snapshot ACCUMULATE counter values before dispatch */\n";
    for (const auto &c : counters) {
      const char *ctype =
          c.bitWidth <= 8  ? "uint8_t"  :
          c.bitWidth <= 16 ? "uint16_t" :
          c.bitWidth <= 32 ? "uint32_t" : "uint64_t";
      os << "    " << ctype << " prev_" << c.sanitizedName
         << " = s->" << c.sanitizedName << ";\n";
    }
    os << "\n";
  }

  os << "    /* Multi-pass comb-seq settle to a steady state.\n";
  os << "     *\n";
  os << "     * The OT register block has a multi-stage chain that needs\n";
  os << "     * several update_state↔tick rounds to converge:\n";
  os << "     *   - Round 1: comb (addr decode, racl gates from prev cycle\n";
  os << "     *     state) → tick (addr_hit and racl_addr_hit_write update,\n";
  os << "     *     register q's commit using stale ctrl_we).\n";
  os << "     *   - Round 2: comb (now ctrl_we is true since racl_addr_hit\n";
  os << "     *     is fresh) → tick (q's commit with fresh ctrl_we).\n";
  os << "     *   - Round 3: comb (qs refreshes from new q) → tick\n";
  os << "     *     (reg_rdata_next mux reads fresh qs).\n";
  os << "     *   - Final comb: propagate reg_rdata_next forward through\n";
  os << "     *     u_reg_if's d_data, rsp_intg, instance bridges, up to\n";
  os << "     *     the top-level rdata BIP.\n";
  os << "     *\n";
  os << "     * The loop exits when sequential state stops changing.  If a full\n";
  os << "     * state repeats, the trajectory is periodic and the current settle\n";
  os << "     * exits early; 256 changing edges remain the final guard.  Autonomous\n";
  os << "     * counters and timers should be classified out of tick and driven by\n";
  os << "     * a QEMU timing backend rather than relying on this safety path.\n";
  os << "     */\n";
  if (!bus.validSignal.empty()) {
    // ONE-CLOCK request (see the read path): accept in the first tick, then
    // deassert so write strobes fire exactly once (FIFO pushes are not
    // idempotent).
    os << "    s->_qp_in_request = 1;\n";
    os << "    update_state(s);\n";
    os << "    qp_tick(s);\n";
    os << "    s->" << bus.validSignal << " = 0;   /* request lasted one clock */\n";
    os << "    s->_qp_in_request = 0;\n";
  }
  emitSettleLoop(os);

  if (!bus.enableSignal.empty()) {
    os << "    /* De-assert enable after evaluation */\n";
    os << "    s->" << bus.enableSignal << " = 0;\n\n";
  }

  // If any ACCUMULATE counter was reloaded by this write, restart its ptimer.
  // This implements the "software writes the counter register -> timer starts
  // decrementing from that value" pattern common in watchdog / one-shot
  // timers.  Counters that software does not touch this cycle keep running.
  // The NULL guard mirrors the read path: a shim that skips ptimer_init
  // (frontend-only embedding) just doesn't restart anything.
  if (!counters.empty()) {
    os << "    /* Reload ptimers for counters whose value changed.\n";
    os << "     * NULL-guarded for frontend-only embedding (see uart_read). */\n";
    for (const auto &c : counters) {
      os << "    if (s->ptimer_" << c.sanitizedName
         << " && s->" << c.sanitizedName << " != prev_"
         << c.sanitizedName << ") {\n";
      os << "        ptimer_transaction_begin(s->ptimer_" << c.sanitizedName
         << ");\n";
      os << "        ptimer_set_count(s->ptimer_" << c.sanitizedName
         << ", s->" << c.sanitizedName << ");\n";
      os << "        ptimer_run(s->ptimer_" << c.sanitizedName
         << ", 1);\n";
      os << "        ptimer_transaction_commit(s->ptimer_" << c.sanitizedName
         << ");\n";
      os << "    }\n";
    }
    os << "\n";
  }

  os << "}\n\n";

  // ---- MMIO ops structure ----
  os << "static const MemoryRegionOps " << devName << "_ops = {\n";
  os << "    .read  = " << devName << "_read,\n";
  os << "    .write = " << devName << "_write,\n";
  os << "    .endianness = DEVICE_LITTLE_ENDIAN,\n";
  os << "    .impl = {\n";
  // TL-UL supports sub-word beats and the generated <dev>_write takes the
  // true access size (lane-shifted mask/data).  min_access_size = 4 made
  // QEMU widen BYTE writes to words — hmac's MSG_FIFO window counted every
  // byte as four (MSG_LENGTH read 96 bits for "abc").  Pass the size
  // through faithfully.
  os << "        .min_access_size = 1,\n";
  os << "        .max_access_size = 4,\n";
  os << "    },\n";
  os << "};\n\n";

  // ---- Device init / realize ----
  os << "static void " << devName << "_realize(DeviceState *dev, Error **errp)\n";
  os << "{\n";
  os << "    " << devName << "_state *s = " << upperName << "(dev);\n\n";
  os << "    memory_region_init_io(&s->mmio, OBJECT(dev), &" << devName
     << "_ops, s,\n";
  os << "                          \"" << devName << "\", 0x" << llvm::utohexstr(mmioSize) << ");\n";
  os << "    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);\n";
  os << "\n";

  // Per-counter ptimer + IRQ wiring.
  if (!counters.empty()) {
    os << "    /* Initialize ACCUMULATE counter ptimers and IRQ lines */\n";
    for (const auto &c : counters) {
      os << "    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq_"
         << c.sanitizedName << ");\n";
      os << "    s->ptimer_" << c.sanitizedName
         << " = ptimer_init(" << devName << "_tick_" << c.sanitizedName
         << ", s, PTIMER_POLICY_LEGACY);\n";
      os << "    ptimer_transaction_begin(s->ptimer_" << c.sanitizedName
         << ");\n";
      os << "    ptimer_set_freq(s->ptimer_" << c.sanitizedName
         << ", " << upperName << "_PTIMER_FREQ);\n";
      os << "    ptimer_transaction_commit(s->ptimer_" << c.sanitizedName
         << ");\n";
    }
    os << "\n";
  }

  os << "    /* Initialize state to zero */\n";
  os << "    update_state(s);\n";
  os << "}\n\n";

  // ---- Type registration boilerplate ----
  os << "static void " << devName << "_class_init(ObjectClass *klass, const void *data)\n";
  os << "{\n";
  os << "    DeviceClass *dc = DEVICE_CLASS(klass);\n";
  os << "    dc->realize = " << devName << "_realize;\n";
  os << "}\n\n";

  os << "static const TypeInfo " << devName << "_info = {\n";
  os << "    .name          = TYPE_" << upperName << ",\n";
  os << "    .parent        = TYPE_SYS_BUS_DEVICE,\n";
  os << "    .instance_size = sizeof(" << devName << "_state),\n";
  os << "    .class_init    = " << devName << "_class_init,\n";
  os << "};\n\n";

  os << "static void " << devName << "_register_types(void)\n";
  os << "{\n";
  os << "    type_register_static(&" << devName << "_info);\n";
  os << "}\n\n";

  os << "type_init(" << devName << "_register_types)\n\n";

  // Phase 2.d setters — emit at end of source so they have visibility
  // of update_state and tick (which are static in this TU).
  emitInputSetterBodies(os, devName, inputSetters);
}

/// Phase 2.d — enumerate the device's top-level non-BIP input ports
/// and produce a setter function per leaf integer field.  The shim
/// wraps these setters around QEMU back-end events (chardev RX,
/// qemu_irq pin level changes, alert handler ack signals, etc.).
///
/// Filtering policy:
///   - clk_i / rst_ni: skipped — the simplified update→tick→update
///     model has no notion of an external clock; reset is a future
///     milestone.
///   - BIP fields (the union of names across all merged-bus signals):
///     skipped — those are written by the MMIO _write callback and
///     re-injecting them via a setter would race the bus.
///
/// For struct/array typed input ports, walkLeaves enumerates each leaf
/// integer field and produces one setter per leaf.  The setter writes
/// the field, then runs the standard settling sequence
/// `update_state → tick → update_state` so the new input value
/// propagates through both the comb network and any sequential paths
/// that depend on it.
struct SetterEntry {
  std::string fieldName;       // sanitized flat field, no `s->` prefix
  std::string setterFnName;    // <dev>_set_<fieldName>
  unsigned bitWidth;
};

static std::vector<SetterEntry>
collectInputSetters(hw::HWModuleOp topModule,
                    const std::string &devName,
                    const llvm::StringSet<> &bipSignals,
                    const FlatSignalRegistry &registry) {
  std::vector<SetterEntry> setters;
  llvm::StringSet<> seen;

  auto isClockOrReset = [&](StringRef name) {
    // OT convention: lowercase clk_i / rst_ni at top level.  Other
    // naming would need a bigger filter, but this covers the templates
    // we actually use today.
    return qemu_passes::usesOpenTitanRTLAdapter(topModule) &&
           (name == "clk_i" || name == "rst_ni");
  };

  auto registerSetter = [&](StringRef rawName, unsigned bitWidth) {
    std::string field = sanitizeName(rawName.str());
    if (field.empty()) return;
    if (bipSignals.count(field)) return;
    // Confirm the field actually exists in the registry (state struct);
    // otherwise the setter would dangle on a non-existent field.
    if (registry.getSignals().find(field) == registry.getSignals().end())
      return;
    if (!seen.insert(field).second) return;
    SetterEntry e;
    e.fieldName    = field;
    e.setterFnName = devName + "_set_" + field;
    e.bitWidth     = bitWidth;
    setters.push_back(std::move(e));
  };

  // Heuristic: if any leaf of a port is a BIP signal, the entire port
  // is part of the bus interface (e.g. `tl_i` is the TL-UL request
  // struct — all of its leaves a_valid/a_opcode/a_address/... move
  // together as one bus transaction).  The MMIO callback writes them
  // as a unit; per-leaf setters would be wrong because individual
  // host-side toggles can't form a coherent bus transaction.
  auto portHasBIPLeaf = [&](Type ty, StringRef portName) {
    bool found = false;
    std::string buf = portName.str();
    walkLeaves(ty, buf, [&](StringRef leafPath, unsigned) {
      if (bipSignals.count(sanitizeName(leafPath.str())))
        found = true;
    });
    return found;
  };

  for (auto port : topModule.getPortList()) {
    if (port.dir != hw::ModulePort::Direction::Input) continue;
    StringRef portName = port.getName();
    if (isClockOrReset(portName)) continue;
    if (portHasBIPLeaf(port.type, portName)) continue;

    if (auto intTy = dyn_cast<IntegerType>(port.type)) {
      registerSetter(portName, intTy.getWidth());
      continue;
    }
    if (isa<hw::StructType>(port.type) || isa<hw::ArrayType>(port.type)) {
      // Pre-seed walkLeaves' path buffer with the port name so each
      // leaf comes out as "<portName>.<...nested fields...>".
      std::string buf = portName.str();
      walkLeaves(port.type, buf, [&](StringRef leafPath, unsigned leafWidth) {
        registerSetter(leafPath, leafWidth);
      });
      continue;
    }
    // Other (LLHD inout etc.): skip.
  }
  return setters;
}

/// Emit the setter function bodies into the .c file.
static void emitInputSetterBodies(
    llvm::raw_ostream &os,
    const std::string &devName,
    const std::vector<SetterEntry> &setters) {
  if (setters.empty()) return;
  os << "/*\n";
  os << " * Public input setters — Phase 2.d\n";
  os << " *\n";
  os << " * Each setter writes one host-driven input field, then runs the\n";
  os << " * `update_state → tick → update_state` settling sequence so the\n";
  os << " * new value propagates through comb + seq logic before the call\n";
  os << " * returns.  Use these from the shim to bridge QEMU back-end\n";
  os << " * events (chardev RX, qemu_irq pin changes, alert handler\n";
  os << " * responses, ...) into the simulated device state.\n";
  os << " */\n";
  for (const auto &e : setters) {
    if (e.bitWidth > 128) {
      // Wide-array field (`uint64_t f[N]`): take a word pointer and copy.
      unsigned words = (e.bitWidth + 63) / 64;
      os << "void " << e.setterFnName << "(" << devName
         << "_state *s, const uint64_t value[" << words << "])\n";
      os << "{\n";
      os << "    memcpy(s->" << e.fieldName << ", value, sizeof(s->" << e.fieldName << "));\n";
      os << "    update_state(s);\n";
      os << "    qp_tick(s);\n";
      os << "    update_state(s);\n";
      os << "}\n\n";
      continue;
    }
    const char *ctype =
        e.bitWidth <= 8  ? "uint8_t"  :
        e.bitWidth <= 16 ? "uint16_t" :
        e.bitWidth <= 32 ? "uint32_t" :
        e.bitWidth <= 64 ? "uint64_t" : "__uint128_t";
    os << "void " << e.setterFnName << "(" << devName
       << "_state *s, " << ctype << " value)\n";
    os << "{\n";
    os << "    s->" << e.fieldName << " = value;\n";
    os << "    update_state(s);\n";
    os << "    qp_tick(s);\n";
    os << "    update_state(s);\n";
    os << "}\n\n";
  }
}

/// Emit extern declarations into the .h file.
static void emitInputSetterDecls(
    llvm::raw_ostream &os,
    const std::string &devName,
    const std::vector<SetterEntry> &setters) {
  if (setters.empty()) return;
  os << "/* Phase 2.d input setters — bridge host-side QEMU events into\n";
  os << " * the simulated device.  Each writes one input-port leaf field\n";
  os << " * and runs update_state→tick→update_state to settle.\n";
  os << " */\n";
  for (const auto &e : setters) {
    if (e.bitWidth > 128) {
      unsigned words = (e.bitWidth + 63) / 64;
      os << "void " << e.setterFnName << "(" << devName
         << "_state *s, const uint64_t value[" << words << "]);\n";
      continue;
    }
    const char *ctype =
        e.bitWidth <= 8  ? "uint8_t"  :
        e.bitWidth <= 16 ? "uint16_t" :
        e.bitWidth <= 32 ? "uint32_t" :
        e.bitWidth <= 64 ? "uint64_t" : "__uint128_t";
    os << "void " << e.setterFnName << "(" << devName
       << "_state *s, " << ctype << " value);\n";
  }
  os << "\n";
}

/// Generate the QEMU header file with the state struct.
static void generateProtocolAgnosticHeader(
    llvm::raw_ostream &os,
    const std::string &devName,
    const MergedBusInterface &bus,
    const llvm::StringSet<> &bipSignals,
    const std::map<std::string, FlatSignalRegistry::SignalInfo> &allSignals,
    const std::vector<AccumulateCounter> &counters,
    const llvm::StringSet<> &liveTargets,
    bool liveTargetPruneEnabled,
    const std::vector<SetterEntry> &inputSetters,
    bool timerPump,
    bool hasBusMaster = false,
    const std::vector<AuxBusPort> &auxPorts = {},
    bool hasBackingStores = false) {

  std::string upperName;
  for (char c : devName)
    upperName += std::toupper(static_cast<unsigned char>(c));

  std::string guardName = upperName + "_H";

  os << "#ifndef " << guardName << "\n";
  os << "#define " << guardName << "\n\n";

  os << "#include \"hw/sysbus.h\"\n";
  os << "#include \"qom/object.h\"\n";
  if (!counters.empty())
    os << "#include \"hw/ptimer.h\"\n";
  os << "\n";

  os << "#define TYPE_" << upperName << " \"" << devName << "\"\n";
  os << "#define " << upperName
     << "(obj) OBJECT_CHECK(" << devName << "_state, (obj), TYPE_"
     << upperName << ")\n\n";

  os << "typedef struct {\n";
  os << "    /* <private> */\n";
  os << "    SysBusDevice parent_obj;\n\n";
  os << "    /* <public> */\n";
  os << "    MemoryRegion mmio;\n\n";

  // Emit BIP signals first with annotation
  os << "    /* ---- Bus Interface Ports (BIP) ---- */\n";
  os << "    /* These signals bridge QEMU MMIO and internal logic. */\n";
  for (const auto &pair : allSignals) {
    const auto &info = pair.second;
    if (bipSignals.count(info.sanitizedName)) {
      // Bug G: signals wider than 128 bits use uint64_t arr[nWords].
      if (info.nWords > 0) {
        os << "    uint64_t " << info.sanitizedName
           << "[" << info.nWords << "];  /* BIP, "
           << info.bitWidth << "-bit (wide-array) */\n";
        continue;
      }
      const char *ctype = "uint32_t";
      if (info.bitWidth <= 8)        ctype = "uint8_t";
      else if (info.bitWidth <= 16)  ctype = "uint16_t";
      else if (info.bitWidth <= 32)  ctype = "uint32_t";
      else if (info.bitWidth <= 64)  ctype = "uint64_t";
      else                           ctype = "__uint128_t";
      os << "    " << ctype << " " << info.sanitizedName
         << ";  /* BIP, " << info.bitWidth << "-bit */\n";
    }
  }

  os << "\n    /* ---- Internal state registers ---- */\n";
  for (const auto &pair : allSignals) {
    const auto &info = pair.second;
    // Skip BIP signals (already emitted above)
    if (bipSignals.count(info.sanitizedName))
      continue;
    // Note: we do NOT prune internal-state fields by liveTargets here.
    // FlatSignalRegistry's "_2" disambiguation gives some emitted
    // comb_logic entries a different `info.sanitizedName` than the raw
    // `target` string seeded into liveTargets — pruning would drop
    // exactly the fields update_state references.  Keep the typedef
    // wide; the comb_logic filter (in runOnOperation) is what gates
    // update_state body size, which is the user-visible win.
    // Bug G: signals wider than 128 bits use uint64_t arr[nWords].
    if (info.nWords > 0) {
      os << "    uint64_t " << info.sanitizedName
         << "[" << info.nWords << "];  /* "
         << info.bitWidth << "-bit (wide-array) */\n";
      continue;
    }
    const char *ctype = "uint32_t";
    if (info.bitWidth <= 8)        ctype = "uint8_t";
    else if (info.bitWidth <= 16)  ctype = "uint16_t";
    else if (info.bitWidth <= 32)  ctype = "uint32_t";
    else if (info.bitWidth <= 64)  ctype = "uint64_t";
    else                           ctype = "__uint128_t";
    os << "    " << ctype << " " << info.sanitizedName
       << ";  /* " << info.bitWidth << "-bit */\n";
  }
  (void)liveTargets;
  (void)liveTargetPruneEnabled;

  // ---- ACCUMULATE counters: ptimer + IRQ line per counter ----
  if (!counters.empty()) {
    os << "\n    /* ---- ACCUMULATE counters (ptimer-backed) ---- */\n";
    os << "    /* One ptimer + IRQ line per counter recognised by\n";
    os << "     * DrvClassificationPass as `reg = prb(reg) +/- const`. */\n";
    for (const auto &c : counters) {
      os << "    ptimer_state *ptimer_" << c.sanitizedName
         << ";  /* step=" << c.step << " */\n";
      os << "    qemu_irq     irq_"    << c.sanitizedName << ";\n";
    }
  }

  // Pump pulse (AccumulateRingDetect): 1 for exactly one tick inside
  // <dev>_advance_tick, 0 during every MMIO settle.  Accumulate-ring steps are
  // emitted as `acc + (s->_qp_pump ? step : 0)`.
  os << "\n    uint8_t _qp_pump;  /* pump pulse: accumulate-ring step enable */\n";
  // Pre-clock observer resolves combinational external pin feedback before
  // sequential logic samples it.  Post-clock observers inspect committed
  // state.  Both are model-global (`_qp_`).
  os << "    void (*_qp_before_tick)(void *ctx);\n";
  os << "    void *_qp_before_tick_ctx;\n";
  // Per-clock observer (organs that need EDGE-level visibility of the model's
  // pins, e.g. an SPI-master bridge that has to see every sck edge inside a
  // settle): called after every tick() when non-NULL.  Model-global (`_qp_`).
  os << "    void (*_qp_on_tick)(void *ctx);  /* per-clock observer hook (organs) */\n";
  os << "    void *_qp_on_tick_ctx;\n";
  os << "    uint8_t  _qp_rewound;      /* organ restored a state snapshot this clock */\n";
  os << "    uint8_t  _qp_hold_settle;  /* organ mid-unit: keep settling (bounded) */\n";
  os << "    uint8_t  _qp_busy;         /* inside settle: re-entrant inputs latch only */\n";
  os << "    uint8_t  _qp_active;       /* last clock moved seq state (PUMP-only) */\n";
  os << "    uint16_t _qp_last_ticks;   /* iterations of the last settle (telemetry) */\n";
  os << "    uint8_t  _qp_budget_hit;   /* last settle ended at its cap */\n";
  os << "    uint8_t  _qp_ext_strikes;  /* consecutive hook-extended settles that capped */\n";
  os << "    uint8_t  _qp_hook_muzzle;  /* circuit breaker: hook still called, verdict ignored */\n";
  os << "    int (*_qp_settle_hook)(void *ctx);  /* machine co-step escape hatch:\n"
        "     * called once per settle iteration; return nonzero while a\n"
        "     * cross-model transaction involving this model is in flight\n"
        "     * (keeps the loop alive past a local fixed point and widens\n"
        "     * the budget).  NULL (the calloc default) = old semantics. */\n";
  os << "    void *_qp_settle_hook_ctx;\n";
  os << "    uint8_t  _qp_rd_cap;       /* read: response captured on its d_valid tick */\n";
  os << "    uint32_t _qp_rd_capv;\n";
  os << "    uint32_t _qp_access_gen;   /* bumped by every MMIO entry (snapshot validity) */\n";
  os << "    uint8_t  _qp_in_request;   /* the bus request clock is being presented (transient inputs) */\n";
  os << "} " << devName << "_state;\n\n";

  // Public API: bridge entrypoints for embedding in a shim device.  The
  // shim's MemoryRegionOps callback can delegate to these.  hwaddr is
  // pulled in via hw/sysbus.h above.
  os << "/* Public API: bridge entrypoints for embedding in a shim device. */\n";
  os << "uint64_t " << devName
     << "_read(void *opaque, hwaddr addr, unsigned size);\n";
  os << "void     " << devName
     << "_write(void *opaque, hwaddr addr,\n";
  os << "        " << std::string(devName.size(), ' ')
     << "uint64_t value, unsigned size);\n";
  for (const auto &ap : auxPorts) {
    os << "uint64_t " << devName << "_" << ap.name
       << "_read(void *opaque, hwaddr addr, unsigned size);\n";
    os << "void     " << devName << "_" << ap.name
       << "_write(void *opaque, hwaddr addr, uint64_t value, unsigned size);\n";
  }
  if (hasBackingStores)
    os << "int      " << devName << "_load_backing(" << devName
       << "_state *s, unsigned idx, const void *bytes, unsigned long n);\n";
  os << "/* Asserts rst_ni for one settle round, then releases — primes the\n";
  os << " * model so registers with non-zero RESVALs see their reset value. */\n";
  os << "void " << devName << "_reset(" << devName << "_state *s);\n";
  os << "/* Run the model to quiescence without a bus access (external event\n"
        " * sources — SPI pumps, pin changes — call this after poking inputs). */\n";
  os << "void " << devName << "_settle(" << devName << "_state *s);\n\n";
  os << "void " << devName << "_step(" << devName << "_state *s);\n";
  os << "void " << devName << "_update(" << devName << "_state *s);\n";
  os << "void " << devName << "_tick(" << devName << "_state *s);\n\n";
  os << "void " << devName << "_step_many(" << devName
     << "_state *s, unsigned count);\n\n";

  // Virtual-time pump entry point (only when the device has free-running
  // ACCUMULATE counters): advances them one step + settles, OUTSIDE the MMIO
  // settle loop.  The QP shim's periodic ptimer calls this then update_irqs().
  if (!counters.empty() || timerPump) {
    os << "/* Advance one virtual-time tick: bump free-running counters + settle\n";
    os << " * one round (counter->tick->writeback).  Driven by the shim pump. */\n";
    os << "void " << devName << "_advance_tick(" << devName << "_state *s);\n\n";
  }

  // Phase 2.d input setter declarations.
  emitInputSetterDecls(os, devName, inputSetters);

  os << "#endif /* " << guardName << " */\n";
}

//===----------------------------------------------------------------------===//
// QP Shim Auto-Emission
//
// Generator emits `<devName>_qp_shim.{c,h}` alongside `<devName>.{c,h}`,
// removing the need to hand-write ot_<dev>_qp.c per device.  The shim
// is the QOM glue between Earl Grey's SoC table and the generated
// model: thin TYPE_OT_<DEV>_QP wrapper that delegates MMIO read/write
// to the generated `<devName>_read` / `<devName>_write` entrypoints,
// declares the IRQ array + properties the SoC table expects, and
// parks rst_ni high so the model leaves reset.
//
// Per-device descriptions are loaded from --device-catalog. The bundled
// catalogs/opentitan.json preserves the original default QOM contract.
//===----------------------------------------------------------------------===//

using qemu_passes::DeviceShim;

/// Emit `<outDir>/<devName>_qp_shim.{c,h}` — full QOM glue equivalent
/// to a hand-written `ot_<dev>_qp.c` plus its header.  Functionally
/// identical to the corresponding upstream-style shim; differences
/// from any prior hand-written copy are limited to comments / spacing.
/// Resolved FIFO write/read pointer wrap-counter fields (one per chardev
/// TX/RX FIFO).  The chardev backend advances these discretely, once per
/// push/pop event, so the model's FIFO occupancy (depth -> STATUS /
/// rx_watermark) tracks real chardev traffic without a free-running ptimer
/// and without entering the cycle-accurate serial path.
struct ShimFifoPtrs {
  std::string rxWptr, rxRptr;  uint64_t rxMask = 0;  bool rxValid = false;
  std::string txWptr, txRptr;  uint64_t txMask = 0;  bool txValid = false;
};

/// Find a FIFO's wptr/rptr wrap-counter flat field names + width-mask in the
/// FlatSignalRegistry by matching the (sanitized) fifo instance name against
/// the prim_fifo_sync_cnt counter signals.  Sets valid only if BOTH found.
/// Keeping name resolution here (registry-driven) avoids replicating the
/// flat-naming/sanitize rules in BackendCharDevDetect.
static void resolveFifoPtrs(const FlatSignalRegistry &registry,
                            llvm::StringRef fifoInstance, std::string &wptrOut,
                            std::string &rptrOut, uint64_t &maskOut,
                            bool &validOut) {
  validOut = false;
  if (fifoInstance.empty())
    return;
  std::string inst = sanitizeName(fifoInstance);
  for (const auto &kv : registry.getSignals()) {
    llvm::StringRef n = kv.second.sanitizedName;
    if (!n.contains(inst))
      continue;
    if (n.contains("fifo_cnt_wptr_wrap_cnt_q")) {
      wptrOut = kv.second.sanitizedName;
      unsigned w = kv.second.bitWidth;
      maskOut = (w >= 64) ? ~0ull : ((1ull << w) - 1);
    } else if (n.contains("fifo_cnt_rptr_wrap_cnt_q")) {
      rptrOut = kv.second.sanitizedName;
    }
  }
  validOut = !wptrOut.empty() && !rptrOut.empty();
}

/// MMIO region size for the device: 2^BlockAw where BlockAw is the register
/// block's address width — structurally, the widest `comb.extract ... from 0`
/// taken from the bus address field (`<addr>_a_address` / `.a_address`) by the
/// decoders (register hit compare + window steering), any module.  Never
/// smaller than one 4 KiB page (the SoC table granularity); spi_device's
/// egress/ingress SRAM windows live at +0x1000..+0x2000 and need 0x2000.
static uint64_t computeMmioSize(ModuleOp mod, llvm::StringRef addrSignal) {
  // leaf name of the address field, e.g. "a_address" from "tl_i_a_address"
  std::string leaf = addrSignal.str();
  size_t p = leaf.rfind("_a_");
  std::string leafDot = p == std::string::npos ? leaf : ("." + leaf.substr(p + 1)); // ".a_address"
  std::string leafUs  = p == std::string::npos ? leaf : ("_" + leaf.substr(p + 1)); // "_a_address"
  unsigned blockAw = 0;
  mod.walk([&](comb::ExtractOp ex) {
    if (ex.getLowBit() != 0) return;
    auto prb = ex.getInput().getDefiningOp<llhd::ProbeOp>();
    if (!prb) return;
    auto sigOp = prb.getSignal().getDefiningOp<llhd::SignalOp>();
    if (!sigOp || !sigOp.getName()) return;
    llvm::StringRef n = *sigOp.getName();
    // The inferred addr candidate OR the TL-UL request address field (the
    // emitter's bus entry drives `<bus>_a_address` under the same convention).
    if (!(n.ends_with(leafDot) || n.ends_with(leafUs) || n == addrSignal ||
          (qemu_passes::usesOpenTitanRTLAdapter(mod) &&
           (n.ends_with(".a_address") || n.ends_with("_a_address"))))) return;
    unsigned w = ex.getType().getIntOrFloatBitWidth();
    unsigned inW = ex.getInput().getType().getIntOrFloatBitWidth();
    if (w < inW && w > blockAw) blockAw = w;
  });
  uint64_t size = blockAw && blockAw < 63 ? (1ull << blockAw) : 0x1000ull;
  if (size < 0x1000ull) size = 0x1000ull;
  return size;
}

static void generateQpShim(llvm::StringRef devName,
                           const DeviceShim &dIn,
                           llvm::StringRef outDir,
                           DictionaryAttr chardevBp = nullptr,
                           DictionaryAttr irqBp = nullptr,
                           const ShimFifoPtrs &fifoPtrs = {},
                           DictionaryAttr pinIoBp = nullptr,
                           llvm::StringRef loopbackField = "",
                           bool hasPump = false,
                           DictionaryAttr spiSlaveBp = nullptr,
                           uint64_t mmioSize = 0x1000,
                           DictionaryAttr spiMasterBp = nullptr,
                           ArrayAttr busMasterBp2 = nullptr,
                           ArrayAttr outLinesBp = nullptr,
                           DictionaryAttr i2cWireBp = nullptr,
                           DictionaryAttr alertInBp = nullptr,
                           DictionaryAttr inputTies = nullptr,
                           ArrayAttr auxPinGroupsBp = nullptr,
                           const std::vector<AuxBusPort> *auxPorts = nullptr,
                           size_t nBackingStores = 0) {
  // Virtual-time pump: when the model has free-running ACCUMULATE counters AND
  // an IRQ path, the shim owns a periodic ptimer that calls <dev>_advance_tick
  // (advancing the counters outside the MMIO settle loop) then update_irqs, so
  // timer-style devices keep time + fire interrupts autonomously (during wfi).
  const bool emitPump = hasPump;
  DeviceShim d = dIn;   // local copy: organs may add properties (spi_slave → chardev)
  // Uppercase the devName for header guards.
  std::string devUpper(devName.size(), '\0');
  for (size_t i = 0; i < devName.size(); ++i)
    devUpper[i] = static_cast<char>(std::toupper(static_cast<unsigned char>(devName[i])));

  // Parse chardev blueprint upfront so the rest of the emit can branch on
  // simple bools / scalars rather than re-parsing nested DictionaryAttrs.
  // Only TX `trigger_offset` and RX `pop_offset` are used today; the rest
  // (FIFO instance names, top-port names) are diagnostic only.
  bool hasTx = false, hasRx = false;
  uint64_t txTriggerOffset = 0, rxPopOffset = 0;
  if (chardevBp) {
    if (auto txAttr = chardevBp.getAs<DictionaryAttr>("tx")) {
      if (auto off = txAttr.getAs<IntegerAttr>("trigger_offset")) {
        hasTx = true;
        txTriggerOffset = off.getInt();
      }
    }
    if (auto rxAttr = chardevBp.getAs<DictionaryAttr>("rx")) {
      if (auto off = rxAttr.getAs<IntegerAttr>("pop_offset")) {
        hasRx = true;
        rxPopOffset = off.getInt();
      }
    }
  }
  bool hasChardev = hasTx || hasRx;

  // SPI-slave transport organ (qemu.spi_slave_blueprint): bytes + chip-select
  // arrive from QEMU over a chardev (lowRISC spidev "/CS" framing); the shim
  // expands each byte into 8 sck edges on the declared pins.  Roles are data
  // (binding), mechanism generic.
  bool hasSpiSlave = false;
  std::string spiSck, spiCsb, spiSdIn, spiSdOut;
  unsigned spiMosiBit = 0, spiMisoBit = 1;
  if (spiSlaveBp) {
    auto g = [&](const char *k) -> std::string {
      if (auto a = spiSlaveBp.getAs<StringAttr>(k)) return sanitizeName(a.getValue().str());
      return "";
    };
    spiSck = g("sck_port"); spiCsb = g("csb_port"); spiSdIn = g("sd_in_port"); spiSdOut = g("sd_out_port");
    if (auto a = spiSlaveBp.getAs<IntegerAttr>("mosi_bit")) spiMosiBit = a.getInt();
    if (auto a = spiSlaveBp.getAs<IntegerAttr>("miso_bit")) spiMisoBit = a.getInt();
    hasSpiSlave = !spiSck.empty() && !spiCsb.empty() && !spiSdIn.empty() && !spiSdOut.empty();
  }
  // SPI-master bridge organ (qemu.spi_master_blueprint): the model drives
  // sck/csb/sd; a per-clock observer (model hook `_qp_on_tick`) watches every
  // sck edge inside the settles and bridges the bit stream to a QEMU SSI bus
  // (`spi<bus-num>`, byte-level peripherals such as m25p80).  Roles are data
  // (binding), mechanism generic.
  bool hasSpiMaster = false;
  std::string spimSck, spimCsb, spimSdOut, spimSdOe, spimSdIn;
  unsigned spimMosiBit = 0, spimMisoBit = 1, spimCsbWidth = 1;
  if (spiMasterBp) {
    auto g = [&](const char *k) -> std::string {
      if (auto a = spiMasterBp.getAs<StringAttr>(k)) return sanitizeName(a.getValue().str());
      return "";
    };
    spimSck = g("sck_port"); spimCsb = g("csb_port"); spimSdOut = g("sd_out_port");
    spimSdOe = g("sd_oe_port"); spimSdIn = g("sd_in_port");
    if (auto a = spiMasterBp.getAs<IntegerAttr>("mosi_bit")) spimMosiBit = a.getInt();
    if (auto a = spiMasterBp.getAs<IntegerAttr>("miso_bit")) spimMisoBit = a.getInt();
    if (auto a = spiMasterBp.getAs<IntegerAttr>("csb_width")) spimCsbWidth = a.getInt();
    hasSpiMaster = !spimSck.empty() && !spimCsb.empty() && !spimSdOut.empty() &&
                   !spimSdOe.empty() && !spimSdIn.empty();
  }
  // I2C wire transport.  Port names are carried entirely by the binding;
  // generated shim code uses the standard QEMU I2CBus byte backend.
  bool hasI2cWire = false;
  std::string i2cSclIn, i2cSclOe, i2cSclOut, i2cSdaIn, i2cSdaOe, i2cSdaOut;
  llvm::SmallVector<std::pair<uint64_t, uint64_t>, 8> i2cResetWrites;
  if (i2cWireBp) {
    auto g = [&](const char *k) -> std::string {
      if (auto a = i2cWireBp.getAs<StringAttr>(k)) return sanitizeName(a.getValue().str());
      return "";
    };
    i2cSclIn = g("scl_in_port"); i2cSclOe = g("scl_oe_port"); i2cSclOut = g("scl_out_port");
    i2cSdaIn = g("sda_in_port"); i2cSdaOe = g("sda_oe_port"); i2cSdaOut = g("sda_out_port");
    if (auto writes = i2cWireBp.getAs<ArrayAttr>("reset_writes")) {
      for (Attribute a : writes) {
        auto wd = dyn_cast<DictionaryAttr>(a);
        if (!wd) continue;
        auto off = wd.getAs<IntegerAttr>("offset");
        auto val = wd.getAs<IntegerAttr>("value");
        if (off && val)
          i2cResetWrites.emplace_back(off.getValue().getZExtValue(),
                                      val.getValue().getZExtValue());
      }
    }
    hasI2cWire = !i2cSclIn.empty() && !i2cSclOe.empty() && !i2cSclOut.empty() &&
                 !i2cSdaIn.empty() && !i2cSdaOe.empty() && !i2cSdaOut.empty();
  }
  // Output-line organ (qemu.out_lines_blueprint): 1-bit model output fields
  // driven out as qemu_irq lines after every access/settle — the generic path
  // for devices WITHOUT an INTR_STATE-style register bank (rv_plic's irq_o /
  // msip_o to the CPU, alert_handler's escalation lines later).  Roles = data.
  llvm::SmallVector<std::string, 4> outLineFields;
  if (outLinesBp)
    for (Attribute a : outLinesBp)
      if (auto sa = dyn_cast<StringAttr>(a))
        outLineFields.push_back(sanitizeName(sa.getValue().str()));
  const bool hasOutLines = !outLineFields.empty();

  // The bridge needs a bus number and a CS count; add the properties when the
  // device catalog entry doesn't already declare them (upstream names).
  if (hasSpiMaster) {
    bool hasBusNum = false, hasNumCs = false;
    for (auto &pr : d.properties) {
      if (pr.fieldName == "bus_num") hasBusNum = true;
      if (pr.fieldName == "num_cs") hasNumCs = true;
    }
    if (!hasBusNum)
      d.properties.push_back({"\"bus-num\"", "DEFINE_PROP_UINT32", "uint32_t", "bus_num", ", 0u"});
    if (!hasNumCs)
      d.properties.push_back({"\"num-cs\"", "DEFINE_PROP_UINT32", "uint32_t", "num_cs", ", 1u"});
  }
  // Bus-master bridge organ (qemu.bus_master_blueprint): the model DRIVES one
  // or more memory-bus request ports; a per-clock observer bridges each beat
  // to a QEMU AddressSpace and feeds the response back.  Roles are data.
  struct BmPort { std::string req, rsp, as; };
  llvm::SmallVector<BmPort, 2> bmPorts;
  if (busMasterBp2)
    for (Attribute a : busMasterBp2)
      if (auto dd = dyn_cast<DictionaryAttr>(a)) {
        BmPort bp;
        if (auto x = dd.getAs<StringAttr>("req_port")) bp.req = sanitizeName(x.getValue().str());
        if (auto x = dd.getAs<StringAttr>("rsp_port")) bp.rsp = sanitizeName(x.getValue().str());
        if (auto x = dd.getAs<StringAttr>("address_space")) bp.as = x.getValue().str();
        if (!bp.req.empty() && !bp.rsp.empty()) bmPorts.push_back(bp);
      }
  bool hasBusMaster = !bmPorts.empty();

  // The transport needs a chardev property; add it when the device catalog
  // entry doesn't already declare one.
  if (hasSpiSlave || hasChardev) {
    bool hasChrProp = false;
    for (auto &pr : d.properties) if (pr.fieldName == "chr") hasChrProp = true;
    if (!hasChrProp)
      d.properties.push_back({"\"chardev\"", "DEFINE_PROP_CHR", "CharFrontend", "chr", ""});
  }
  // System-loopback role (optional, blueprint-driven): when the named model
  // state field is nonzero the model routes TX->RX internally, so the shim must
  // mirror the TX byte into the RX buffer instead of the external chardev.  The
  // field name is already validated against the FlatSignalRegistry by the caller.
  bool hasLoopback = !loopbackField.empty() && hasTx && hasRx && fifoPtrs.rxValid;

  // Backend IRQ/alert driving — fully generic, driven by qemu.irq_blueprint
  // (BackendCharDevDetect Phase 4) which carries the IR-derived MMIO offsets
  // of INTR_STATE / INTR_ENABLE / ALERT_TEST.  The shim reads those registers
  // back and sets irqs[i] = (state&enable) bit i, and pulses the alert on
  // ALERT_TEST writes.  No per-device signal names OR offsets are baked in;
  // when the blueprint is absent the device stays frontend-only.
  bool hasIrqDrive = false;
  bool hasIntrEnable = false;
  uint64_t intrStateOff = 0, intrEnableOff = 0;
  bool hasAlert = false;
  uint64_t alertTestOff = 0;
  if (irqBp && d.irqCount > 0) {
    auto isAttr = irqBp.getAs<IntegerAttr>("intr_state_offset");
    auto ieAttr = irqBp.getAs<IntegerAttr>("intr_enable_offset");
    if (isAttr) {
      // intr_enable is OPTIONAL: some IPs (e.g. aon_timer) expose INTR_STATE +
      // INTR_TEST but NO INTR_ENABLE register — their intr_o follows INTR_STATE
      // directly.  Absent => shim drives irqs[i] = INTR_STATE[i] (no enable mask).
      hasIrqDrive = true;
      intrStateOff = isAttr.getInt();
      if (ieAttr) {
        hasIntrEnable = true;
        intrEnableOff = ieAttr.getInt();
      }
    }
    if (auto atAttr = irqBp.getAs<IntegerAttr>("alert_test_offset")) {
      hasAlert = true;
      alertTestOff = atAttr.getInt();
    }
  }

  // NEVER DECLARE A PIN NOTHING DRIVES.  d.irqCount comes from the device
  // catalog/binding, hasIrqDrive from the blueprint; when they disagree the
  // shim used to emit `IbexIRQ irqs[N]` and `ibex_sysbus_init_irq` with no
  // update path at all.  The board then wires those pins to real PLIC sources
  // and the interrupt simply never arrives — no diagnostic, no compile error,
  // and a firmware that waits on it hangs forever.  Say so.
  if (d.irqCount > 0 && !hasIrqDrive)
    llvm::errs() << "  [IRQ UNDRIVEN] " << devName << ": " << d.irqCount
                 << " interrupt line(s) declared but no irq_blueprint, so the "
                    "shim exports pins it never drives\n";

  // Generic data-pin I/O — driven by qemu.pin_io_blueprint (role-based: the
  // recognizer/binding names the data_out / output_enable / data_in ports; this
  // emit consumes ROLES, never device names).  Output export needs the
  // data_out + output_enable pair; input wiring needs data_in.  Absent blueprint
  // => no pin wiring (register-only devices unaffected).
  bool hasPinOut = false, hasPinIn = false;
  std::string pinDataOutPort, pinOePort, pinDataInPort;
  unsigned pinOutWidth = 0, pinInWidth = 0;
  if (pinIoBp) {
    auto doPort = pinIoBp.getAs<StringAttr>("data_out_port");
    auto oePort = pinIoBp.getAs<StringAttr>("output_enable_port");
    auto doW = pinIoBp.getAs<IntegerAttr>("data_out_width");
    if (doPort && oePort && doW) {
      hasPinOut = true;
      pinDataOutPort = doPort.getValue().str();
      pinOePort = oePort.getValue().str();
      pinOutWidth = (unsigned)doW.getInt();
    }
    auto diPort = pinIoBp.getAs<StringAttr>("data_in_port");
    auto diW = pinIoBp.getAs<IntegerAttr>("data_in_width");
    if (diPort && diW) {
      hasPinIn = true;
      pinDataInPort = diPort.getValue().str();
      pinInWidth = (unsigned)diW.getInt();
    }
  }

  // Auxiliary named pin groups (qemu.aux_pin_groups): extra qdev buses
  // beyond the primary pin_io group — "<name>-out"/"<name>-in" named lines
  // plus constant all-ones ties.  First user: pinmux's peripheral side.
  struct AuxPinGroup {
    std::string name, outPort, inPort;
    unsigned outW = 0, inW = 0;
    std::vector<std::pair<std::string, unsigned>> tieOnes;
  };
  std::vector<AuxPinGroup> auxGroups;
  if (auto auxAttr = auxPinGroupsBp) {
    for (Attribute ga : auxAttr) {
      auto gd = dyn_cast<DictionaryAttr>(ga);
      if (!gd)
        continue;
      AuxPinGroup g;
      if (auto n = gd.getAs<StringAttr>("name"))
        g.name = n.getValue().str();
      if (auto p = gd.getAs<StringAttr>("out_port")) {
        g.outPort = p.getValue().str();
        if (auto w = gd.getAs<IntegerAttr>("out_width"))
          g.outW = (unsigned)w.getInt();
      }
      if (auto p = gd.getAs<StringAttr>("in_port")) {
        g.inPort = p.getValue().str();
        if (auto w = gd.getAs<IntegerAttr>("in_width"))
          g.inW = (unsigned)w.getInt();
      }
      if (auto ties = gd.getAs<ArrayAttr>("tie_ones"))
        for (Attribute ta : ties)
          if (auto td = dyn_cast<DictionaryAttr>(ta))
            if (auto tp = td.getAs<StringAttr>("port"))
              if (auto tw = td.getAs<IntegerAttr>("width"))
                g.tieOnes.push_back(
                    {tp.getValue().str(), (unsigned)tw.getInt()});
      if (!g.name.empty())
        auxGroups.push_back(std::move(g));
    }
  }

  // ---- Header file ----
  std::string headerPath = (outDir + "/" + devName + "_qp_shim.h").str();
  std::error_code EC;
  llvm::raw_fd_ostream h(headerPath, EC);
  if (EC) {
    llvm::errs() << "Error: Cannot create " << headerPath << ": "
                 << EC.message() << "\n";
    return;
  }
  std::string guard = "HW_OPENTITAN_" + devUpper + "_QP_SHIM_H";
  h << "#ifndef " << guard << "\n"
    << "#define " << guard << "\n\n"
    << "#include \"qom/object.h\"\n\n"
    << "#define TYPE_" << d.typeMacroBase << " \"" << d.typeNameMacro << "\"\n"
    << "OBJECT_DECLARE_SIMPLE_TYPE(" << d.structName << ", "
    << d.typeMacroBase << ")\n\n"
    << "/* Generic core accessor for machine-level device-to-device bridges:\n"
    << " * returns the embedded <dev>_state (see qemu_passes/" << devName
    << ".h). */\n"
    << "void *ot_" << devName << "_qp_core(DeviceState *dev);\n\n"
    << "/* Settle-hook arming (ring-table form: soc_glue arms members by\n"
    << " * name, one call per ring member). */\n"
    << "void ot_" << devName
    << "_qp_set_settle_hook(DeviceState *dev, int (*fn)(void *), void *ctx);\n\n"
    << "#endif /* " << guard << " */\n";

  // ---- Source file ----
  std::string sourcePath = (outDir + "/" + devName + "_qp_shim.c").str();
  llvm::raw_fd_ostream c(sourcePath, EC);
  if (EC) {
    llvm::errs() << "Error: Cannot create " << sourcePath << ": "
                 << EC.message() << "\n";
    return;
  }

  // Header banner
  c << "/*\n"
    << " * QEMU OpenTitan " << devUpper << " device — qemu-passes shim (auto-generated)\n"
    << " *\n"
    << " * DO NOT EDIT.  Re-emit by re-running qemu-passes with --qemu-emit-c\n"
    << " * after changing the JSON selected by --device-catalog.\n"
    << " *\n"
    << " * Frontend wrapper around the auto-generated " << devUpper << " model from\n"
    << " *   hw/opentitan/qemu_passes/" << devName << ".{c,h}\n"
    << " *\n"
    << " * MMIO read/write callbacks delegate to the generated entrypoints\n"
    << " * " << devName << "_read() / " << devName << "_write().";
  if (hasChardev) {
    c << "  Chardev backend\n"
      << " * is wired by intercepting MMIO at the trigger/pop offsets that\n"
      << " * BackendCharDevDetectPass identified as TX/RX pivots — see the\n"
      << " * `qemu.chardev_blueprint` attribute on @" << devName
      << " in the IR.\n"
      << " */\n\n";
  } else {
    c << "  The QEMU backend\n"
      << " * interface (chardev, IRQ wires, ptimer, ...) is intentionally NOT wired\n"
      << " * here — frontend-only milestone.  Backend hookup is a later milestone.\n"
      << " */\n\n";
  }

  // Includes
  c << "#include \"qemu/osdep.h\"\n"
    << "#include \"qemu/log.h\"\n"
    << "#include \"qemu/module.h\"\n"
    << "#include \"qapi/error.h\"\n"
    << "#include \"chardev/char-fe.h\"\n";
  if (hasChardev)
    c << "#include \"qemu/fifo8.h\"\n";
  if (emitPump && hasIrqDrive)
    c << "#include \"hw/ptimer.h\"\n";
  if (hasSpiMaster)
    c << "#include \"hw/ssi/ssi.h\"\n";
  unsigned alertInCount = 0;
  std::string alertInPrefix;
  if (alertInBp) {
    if (auto cA = alertInBp.getAs<IntegerAttr>("count"))
      alertInCount = (unsigned)cA.getValue().getZExtValue();
    if (auto pA = alertInBp.getAs<StringAttr>("port_prefix"))
      alertInPrefix = sanitizeName(pA.getValue().str());
  }
  bool hasAlertIn = alertInCount > 0 && !alertInPrefix.empty();

  if (hasI2cWire)
    c << "#include \"hw/i2c/i2c.h\"\n"
      << "#include \"qemu/timer.h\"\n";
  if (hasBusMaster)
    c << "#include \"system/address-spaces.h\"\n"
      << "#include \"system/memory.h\"\n";
  if (d.keySinkIf)
    c << "#include \"hw/opentitan/ot_key_sink.h\"\n";
  c << "#include \"hw/sysbus.h\"\n"
    << "#include \"hw/qdev-properties.h\"\n"
    << "#include \"hw/qdev-properties-system.h\"\n"
    << "#include \"hw/irq.h\"\n"
    << "#include \"hw/opentitan/ot_alert.h\"\n"
    << "#include \"hw/opentitan/ot_common.h\"\n"
    << "#include \"hw/riscv/ibex_irq.h\"\n\n"
    << "/* Generated " << devName << " model entrypoints + state struct. */\n"
    << "#include \"qemu_passes/" << devName << ".h\"\n\n"
    << "/* This shim's own type declaration. */\n"
    << "#include \"hw/opentitan/" << devName << "_qp_shim.h\"\n\n";

  // IRQ count
  c << "#define " << d.typeMacroBase << "_IRQ_NUM " << d.irqCount << "u\n";
  if (hasChardev) {
    c << "#define " << d.typeMacroBase << "_RX_BUF_DEPTH 64u\n";
  }
  if (emitPump && hasIrqDrive) {
    // Pump rate: a fixed virtual-time constant (real clock freq is stripped by
    // clock-drv-removal).  Functional, not cycle-accurate.  Kept LOW (1 kHz) so
    // the periodic callback does not starve the guest — a faster rate floods
    // QEMU with settle work and the guest never makes progress.  Could be
    // promoted to an AI-fillable binding `pump_hz` knob later.
    c << "#define " << d.typeMacroBase << "_PUMP_HZ 1000u\n";
  }
  c << "\n";

  // State struct
  c << "struct " << d.structName << " {\n"
    << "    SysBusDevice parent_obj;\n"
    << "    MemoryRegion mmio;\n";
  if (auxPorts)
    for (const auto &ap : *auxPorts)
      c << "    MemoryRegion mmio_" << ap.name << ";\n";
  for (size_t bi = 0; bi < nBackingStores; ++bi)
    c << "    char *backing" << bi << "_image;\n";
  c << ""
    << "    IbexIRQ irqs[" << d.typeMacroBase << "_IRQ_NUM];\n"
    << "    IbexIRQ alert;\n";
  if (hasI2cWire)
    c << "    I2CBus *i2c_bus; /* qemu.i2c_wire_blueprint transport bus */\n"
      << "    I2CSlave *i2cw_target; /* byte-level QEMU master -> pin-level model */\n"
      << "    bool i2cw_scl, i2cw_sda, i2cw_slave_sda_low;\n"
      << "    bool i2cw_wire_busy, i2cw_bus_active;\n"
      << "    bool i2cw_external_master, i2cw_master_scl_low, i2cw_master_sda_low;\n"
      << "    bool i2cw_scan_from_rtl;\n"
      << "    bool i2cw_expect_address, i2cw_next_read, i2cw_ack;\n"
      << "    uint8_t i2cw_state, i2cw_byte, i2cw_bit;\n"
      << "    uint32_t i2cw_kick_ticks, i2cw_timer_ticks;\n"
      << "    QEMUTimer *i2cw_timer;\n";
  if (hasPinOut) {
    c << "    qemu_irq pin_out[" << pinOutWidth << "]; /* data-pin output lines */\n";
    c << "    uint64_t pin_out_last; /* last driven output bus (per-bit change dedup) */\n";
  }
  if (hasOutLines)
    c << "    IbexIRQ out_lines[" << outLineFields.size()
      << "]; /* declared 1-bit model outputs (out_lines role) */\n";
  if (hasPinIn) {
    if (pinInWidth > 64)
      c << "    uint64_t pin_in_shadow[" << ((pinInWidth + 63) / 64)
        << "]; /* current data-pin input bus value (wide) */\n";
    else
      c << "    uint64_t pin_in_shadow; /* current data-pin input bus value */\n";
  }
  for (const auto &g : auxGroups) {
    if (g.outW) {
      c << "    qemu_irq aux_" << g.name << "_out[" << g.outW
        << "]; /* aux pin group '" << g.name << "' output lines */\n";
      c << "    __uint128_t aux_" << g.name << "_out_last;\n";
    }
    if (g.inW)
      c << "    __uint128_t aux_" << g.name
        << "_in_shadow; /* aux pin group '" << g.name << "' input bus */\n";
  }
  if (!d.properties.empty()) {
    c << "\n    /* Property fields (mirror upstream ot_" << devName
      << "_eg.c so SoC-table-injected\n"
      << "     * values are accepted by QOM).";
    if (!hasChardev)
      c << "  We accept-but-ignore: the\n"
        << "     * generated model has its own initial state and no chardev wiring.";
    c << " */\n";
    for (const auto &p : d.properties)
      c << "    " << p.fieldType << " " << p.fieldName << ";\n";
  }
  if (hasChardev) {
    c << "\n    /* Shim-side RX byte buffer.  Bytes pushed in via the chardev\n"
      << "     * `receive` callback land here; the read callback drains one\n"
      << "     * byte per R_RDATA read (overriding the generated model's\n"
      << "     * register value, which has its own deserializer-based timing\n"
      << "     * model that doesn't fit chardev's byte-stream interface). */\n"
      << "    Fifo8 rx_buf;\n";
  }
  if (hasSpiSlave) {
    c << "\n    /* SPI-slave transport (qemu.spi_slave_blueprint): lowRISC spidev\n"
      << "     * framing over the chardev — 8-byte header \"/CS\" ver mode pad len16,\n"
      << "     * then len MOSI bytes; we answer with len MISO bytes.  Each byte is\n"
      << "     * pumped as 8 sck edges into the model (mode 0, MSB first). */\n"
      << "    uint8_t  spi_hdr[8];\n"
      << "    unsigned spi_hdr_len;\n"
      << "    unsigned spi_remaining;   /* payload bytes still expected */\n"
      << "    bool     spi_release;     /* deassert /CS after this packet */\n"
      << "    bool     spi_cs_low;\n";
  }
  if (hasSpiMaster) {
    c << "\n    /* SPI-master bridge (qemu.spi_master_blueprint): the model's sck/csb/sd\n"
      << "     * pins are watched every model clock (per-tick observer) and the bit\n"
      << "     * stream is bridged to a byte-level QEMU SSI bus. */\n"
      << "    SSIBus  *ssi;\n"
      << "    IbexIRQ *cs_lines;\n"
      << "    uint32_t spim_csb_prev;\n"
      << "    uint8_t  spim_sck_prev, spim_mosi_prev;\n"
      << "    bool     spim_active;      /* some CS asserted */\n"
      << "    bool     spim_first_edge;  /* first sck edge after CS assert pending (CPHA detect) */\n"
      << "    uint8_t  spim_cpol, spim_cpha;\n"
      << "    uint8_t  spim_bitcnt;      /* sample edges seen in the current byte */\n"
      << "    uint8_t  spim_txsh;        /* MOSI bits shifted in so far (MSB first) */\n"
      << "    uint8_t  spim_rx;          /* MISO byte being presented (replay pass) */\n"
      << "    bool     spim_replay;      /* second pass of the current byte (rx known) */\n"
      << "    /* Speculate/rewind: snapshot of the model + organ state at the byte\n"
      << "     * start; the first pass only learns the MOSI byte, the transfer to\n"
      << "     * the byte-level bus happens at its end, then the byte is replayed\n"
      << "     * from the snapshot with the slave's reply on MISO. */\n"
      << "    " << devName << "_state *spim_snap;\n"
      << "    bool     spim_snap_valid;\n"
      << "    uint32_t spim_snap_gen;\n"
      << "    uint8_t  spim_snap_sck_prev, spim_snap_mosi_prev;\n"
      << "    bool     spim_snap_first_edge;\n"
      << "    uint8_t  spim_snap_cpol, spim_snap_cpha;\n";
  }
  if (hasBusMaster) {
    c << "\n    /* Bus-master bridge (qemu.bus_master_blueprint): request beats on\n"
      << "     * the model's host port(s) are executed against a QEMU AddressSpace\n"
      << "     * and the response is presented on the next model clock. */\n";
    for (unsigned i = 0; i < bmPorts.size(); ++i)
      c << "    AddressSpace *bm_as_" << i << ";     /* '" << bmPorts[i].as << "' */\n"
        << "    bool     bm_rsp_pending_" << i << ";\n"
        << "    uint8_t  bm_rsp_opcode_" << i << ";\n"
        << "    uint32_t bm_rsp_data_" << i << ";\n"
        << "    uint8_t  bm_rsp_err_" << i << ";\n"
        << "    uint8_t  bm_rsp_size_" << i << ";\n"
        << "    uint8_t  bm_rsp_source_" << i << ";\n";
  }
  if (emitPump && hasIrqDrive)
    c << "\n    /* Virtual-time pump: periodic ptimer that advances the model's\n"
      << "     * free-running counters (via " << devName << "_advance_tick) and\n"
      << "     * redelivers interrupts, so timer-style devices keep time + fire\n"
      << "     * autonomously (during CPU wfi, no MMIO). */\n"
      << "    ptimer_state *qp_pump;\n";
  c << "\n    /* Embedded auto-generated device state. */\n"
    << "    " << devName << "_state core;\n"
    << "};\n\n";

  // OBJECT_DEFINE_SIMPLE_TYPE — with the key-sink interface when the SoC's
  // keymgr pushes sideload keys at this device (it asserts on a missing sink).
  if (d.keySinkIf)
    c << "OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(" << d.structName << ", "
      << "ot_" << devName << "_qp,\n"
      << "                                          " << d.typeMacroBase
      << ", SYS_BUS_DEVICE,\n"
      << "                                          { TYPE_OT_KEY_SINK_IF },\n"
      << "                                          { NULL })\n\n";
  else
    c << "OBJECT_DEFINE_SIMPLE_TYPE(" << d.structName << ", "
      << "ot_" << devName << "_qp, " << d.typeMacroBase << ", SYS_BUS_DEVICE)\n\n";

  if (hasI2cWire) {
    c << "#define TYPE_" << d.typeMacroBase << "_TARGET \"ot-" << devName
      << "-qp-target\"\n"
      << "OBJECT_DECLARE_SIMPLE_TYPE(" << d.structName << "Target, "
      << d.typeMacroBase << "_TARGET)\n\n"
      << "struct " << d.structName << "Target {\n"
      << "    I2CSlave parent_obj;\n"
      << "    " << d.structName << " *owner;\n"
      << "    uint8_t pending_address;\n"
      << "};\n\n";
  }

  // Interrupt delivery helper — fully generic, no per-device signal data.
  // The PLIC source-i interrupt level is (INTR_STATE & INTR_ENABLE) bit i, by
  // the OpenTitan register contract.  We read those two registers back from
  // the model (OT reggen invariant: INTR_STATE @ 0x0, INTR_ENABLE @ 0x4 on
  // every IP that has interrupts) so the bit<->PLIC-source mapping comes
  // straight from the hardware register layout — exactly mirroring upstream
  // ot_<dev>.c's update_irqs.  ibex_irq_set is edge-deduplicated, so calling
  // this after each write is cheap.  Called after MMIO writes (the only thing
  // that changes INTR_STATE/ENABLE in this model).
  if (hasIrqDrive) {
    c << "/* === Interrupt delivery ========================================= */\n"
      << "static void ot_" << devName << "_qp_update_irqs(" << d.structName
      << " *s)\n"
      << "{\n"
      << "    /* The IRQ lines reflect the SETTLED device state: an external\n"
      << "     * stimulus (pin edge, chardev push, SPI byte) may have moved the\n"
      << "     * model only one clock (synchronizer / edge-detect / INTR_STATE\n"
      << "     * latch still propagating), and a bus read samples the register\n"
      << "     * on the request clock.  Let the model reach quiescence first —\n"
      << "     * cheap when already settled (one tick that changes nothing). */\n"
      << "    " << devName << "_settle(&s->core);\n"
      << "    uint32_t intr_state  = (uint32_t)" << devName
      << "_read(&s->core, 0x" << llvm::utohexstr(intrStateOff) << "u, 4);\n";
    if (hasIntrEnable)
      c << "    uint32_t intr_enable = (uint32_t)" << devName
        << "_read(&s->core, 0x" << llvm::utohexstr(intrEnableOff) << "u, 4);\n"
        << "    uint32_t masked = intr_state & intr_enable;\n";
    else
      c << "    /* No INTR_ENABLE register — intr_o follows INTR_STATE directly. */\n"
        << "    uint32_t masked = intr_state;\n";
    c << "    for (unsigned i = 0; i < " << d.typeMacroBase
      << "_IRQ_NUM; i++) {\n"
      << "        ibex_irq_set(&s->irqs[i], (int)((masked >> i) & 1u));\n"
      << "    }\n"
      << "}\n\n";
  }

  // Virtual-time pump callback — advances the model one tick (free-running
  // counters, OUTSIDE the MMIO settle loop) then redelivers interrupts.  Fires
  // periodically in wall-clock/virtual time, so timer devices count + fire
  // their interrupt autonomously during CPU wfi.  Generic: no per-device data.
  if (emitPump && hasIrqDrive) {
    c << "/* === Virtual-time pump ========================================== */\n"
      << "static void ot_" << devName << "_qp_pump(void *opaque)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    " << devName << "_advance_tick(&s->core);\n"
      << "    ot_" << devName << "_qp_update_irqs(s);\n"
      << "}\n\n";
  }

  // Bus-master bridge organ: per-clock request observer -> QEMU AddressSpace.
  if (hasBusMaster) {
    c << "/* === Bus-master bridge ========================================== */\n"
      << "/* Called after EVERY model clock (model hook _qp_on_tick).  For each\n"
      << " * declared host port: when the model presents a request (a_valid, with\n"
      << " * our constant a_ready=1), execute it against the port's AddressSpace\n"
      << " * (Get -> read, Put -> write with byte enables) and present the TL-UL\n"
      << " * response (d_valid / d_opcode / d_data / d_error, source and size\n"
      << " * echoed) on the next clock; drop d_valid once the engine takes it\n"
      << " * (d_ready).  The settle loop needs no help from us: a working\n"
      << " * transfer never revisits a state, so Brent's cycle exit stays\n"
      << " * silent and the loop runs until the engine goes quiet. */\n"
      << "static void ot_" << devName << "_qp_bm_on_tick(void *opaque)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n";
    for (unsigned i = 0; i < bmPorts.size(); ++i) {
      const auto &bp = bmPorts[i];
      c << "\n    /* --- port " << i << ": " << bp.req << " -> AddressSpace '" << bp.as << "' --- */\n"
        << "    {\n"
        << "        s->core." << bp.rsp << "_a_ready = 1;\n"
        << "        /* response consumed? (d_valid && engine d_ready this clock) */\n"
        << "        if (s->bm_rsp_pending_" << i << " && s->core." << bp.req << "_d_ready) {\n"
        << "            s->bm_rsp_pending_" << i << " = false;\n"
        << "            s->core." << bp.rsp << "_d_valid = 0;\n"
        << "        }\n"
        << "        if (s->bm_rsp_pending_" << i << ") {\n"
        << "            /* keep presenting the response */\n"
        << "            s->core." << bp.rsp << "_d_valid = 1;\n"
        << "        } else if (s->core." << bp.req << "_a_valid) {\n"
        << "            uint32_t addr = (uint32_t)s->core." << bp.req << "_a_address;\n"
        << "            uint32_t wdata = (uint32_t)s->core." << bp.req << "_a_data;\n"
        << "            uint8_t  mask = (uint8_t)s->core." << bp.req << "_a_mask;\n"
        << "            uint8_t  opc  = (uint8_t)s->core." << bp.req << "_a_opcode;\n"
        << "            bool     is_get = (opc == 4);\n"
        << "            MemTxResult r = MEMTX_OK;\n"
        << "            uint32_t rdata = 0;\n"
        << "            if (is_get) {\n"
        << "                r = address_space_read(s->bm_as_" << i << ", addr & ~3u,\n"
        << "                                       MEMTXATTRS_UNSPECIFIED, &rdata, 4);\n"
        << "            } else {\n"
        << "                /* byte-enable write: read-modify-write unless full word */\n"
        << "                if (mask == 0xFu) {\n"
        << "                    r = address_space_write(s->bm_as_" << i << ", addr & ~3u,\n"
        << "                                            MEMTXATTRS_UNSPECIFIED, &wdata, 4);\n"
        << "                } else {\n"
        << "                    uint32_t cur = 0;\n"
        << "                    r = address_space_read(s->bm_as_" << i << ", addr & ~3u,\n"
        << "                                           MEMTXATTRS_UNSPECIFIED, &cur, 4);\n"
        << "                    for (unsigned b = 0; b < 4; b++)\n"
        << "                        if ((mask >> b) & 1u) {\n"
        << "                            cur &= ~(0xFFu << (8u * b));\n"
        << "                            cur |= (wdata & (0xFFu << (8u * b)));\n"
        << "                        }\n"
        << "                    if (r == MEMTX_OK)\n"
        << "                        r = address_space_write(s->bm_as_" << i << ", addr & ~3u,\n"
        << "                                                MEMTXATTRS_UNSPECIFIED, &cur, 4);\n"
        << "                }\n"
        << "            }\n"
        << "            s->bm_rsp_pending_" << i << " = true;\n"
        << "            s->bm_rsp_err_" << i << " = (r != MEMTX_OK);\n"
        << "            s->core." << bp.rsp << "_d_valid = 1;\n"
        << "            s->core." << bp.rsp << "_d_opcode = is_get ? 1 : 0;  /* AccessAckData : AccessAck */\n"
        << "            s->core." << bp.rsp << "_d_data = rdata;\n"
        << "            s->core." << bp.rsp << "_d_error = (r != MEMTX_OK);\n"
        << "            s->core." << bp.rsp << "_d_size = s->core." << bp.req << "_a_size;\n"
        << "            s->core." << bp.rsp << "_d_source = s->core." << bp.req << "_a_source;\n"
        << "        }\n"
        << "    }\n";
    }
    c << "}\n\n";
  }

  // SPI-master bridge organ: per-clock pin observer -> SSI bus.
  if (hasSpiMaster) {
    c << "/* === SPI-master bridge ========================================== */\n"
      << "/* Called after EVERY model clock (model hook _qp_on_tick), so it sees each\n"
      << " * sck edge the FSM produces inside the MMIO settles.  Bit lanes: MOSI = bit\n"
      << " * " << spimMosiBit << " of `" << spimSdOut << "`, MISO = bit " << spimMisoBit << " of `" << spimSdIn << "`.\n"
      << " *  - CS lines follow `" << spimCsb << "` (level; SSI convention 1 = deselected).\n"
      << " *  - CPOL = sck level at CS assert; CPHA = 1 iff the master launched MOSI on\n"
      << " *    the very first sck edge (data changed with that edge), else 0.  Sample\n"
      << " *    edge = rising when CPOL == CPHA, falling otherwise.\n"
      << " *  - A byte-level bus can only answer once it has the whole byte, but the\n"
      << " *    bit-level master samples MISO from the first edge.  So every byte runs\n"
      << " *    TWICE: a first (speculative) pass from a snapshot of the model state\n"
      << " *    taken at the byte start collects the MOSI byte, hands it to\n"
      << " *    ssi_transfer at the 8th sample edge, restores the snapshot and replays\n"
      << " *    the byte with the slave's reply presented on MISO bit by bit.  The\n"
      << " *    model is deterministic, so the replay is identical except MISO.  The\n"
      << " *    settle is held while a byte is in flight (`_qp_hold_settle`) so bytes\n"
      << " *    do not straddle MMIO accesses; a snapshot older than the last MMIO\n"
      << " *    access (`_qp_access_gen`) is stale -> that byte is transferred late\n"
      << " *    (reply not replayed) and logged. */\n"
      << "static void ot_" << devName << "_qp_spim_present_miso(" << d.structName << " *s, unsigned bit)\n"
      << "{\n"
      << "    uint64_t sd = (uint64_t)s->core." << spimSdIn << " & ~(1ull << " << spimMisoBit << ");\n"
      << "    sd |= (uint64_t)((s->spim_rx >> bit) & 1u) << " << spimMisoBit << ";\n"
      << "    s->core." << spimSdIn << " = sd;\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_spim_snapshot(" << d.structName << " *s)\n"
      << "{\n"
      << "    if (s->core._qp_in_request) { s->spim_snap_valid = false; return; }   /* transient bus inputs: retake next clock */\n"
      << "    memcpy(s->spim_snap, &s->core, sizeof(s->core));\n"
      << "    s->spim_snap_valid = true;\n"
      << "    s->spim_snap_gen = s->core._qp_access_gen;\n"
      << "    s->spim_snap_sck_prev = s->spim_sck_prev; s->spim_snap_mosi_prev = s->spim_mosi_prev;\n"
      << "    s->spim_snap_first_edge = s->spim_first_edge;\n"
      << "    s->spim_snap_cpol = s->spim_cpol; s->spim_snap_cpha = s->spim_cpha;\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_spim_on_tick(void *opaque)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    uint32_t csb = (uint32_t)s->core." << spimCsb << ";\n"
      << "    uint8_t  sck = (uint8_t)(s->core." << spimSck << " & 1u);\n"
      << "    bool mosi = ((s->core." << spimSdOut << " >> " << spimMosiBit << ") & 1u) != 0;\n"
      << "    bool oe   = ((s->core." << spimSdOe << " >> " << spimMosiBit << ") & 1u) != 0;\n"
      << "    uint32_t csmask = (s->num_cs >= 32u) ? 0xFFFFFFFFu : ((1u << s->num_cs) - 1u);\n"
      << "    if ((csb & csmask) != (s->spim_csb_prev & csmask)) {\n"
      << "        for (unsigned i = 0; i < s->num_cs; i++) {\n"
      << "            if (((csb ^ s->spim_csb_prev) >> i) & 1u)\n"
      << "                ibex_irq_set(&s->cs_lines[i], (int)((csb >> i) & 1u));\n"
      << "        }\n"
      << "        bool active = (csb & csmask) != csmask;\n"
      << "        if (active && !s->spim_active) {\n"
      << "            /* transaction start: idle clock level = CPOL, CPHA unknown */\n"
      << "            s->spim_cpol = sck; s->spim_cpha = 0; s->spim_first_edge = true;\n"
      << "            s->spim_bitcnt = 0; s->spim_txsh = 0; s->spim_replay = false;\n"
      << "            s->spim_sck_prev = sck; s->spim_mosi_prev = mosi;\n"
      << "            s->spim_snap_valid = false;   /* taken below, never on a request clock */\n"
      << "        }\n"
      << "        s->spim_active = active;\n"
      << "        s->spim_csb_prev = csb;\n"
      << "        if (!active) { s->spim_snap_valid = false; s->core._qp_hold_settle = 0; }\n"
      << "    }\n"
      << "    if (!s->spim_active) { s->spim_sck_prev = sck; s->spim_mosi_prev = mosi; return; }\n"
      << "    /* Between bytes (nothing in flight) an MMIO access invalidates the\n"
      << "     * snapshot (its effects would be undone by a rewind): retake it now,\n"
      << "     * still before the next byte's first sample edge. */\n"
      << "    if (s->spim_bitcnt == 0 && !s->spim_replay && !s->core._qp_in_request &&\n"
      << "        (!s->spim_snap_valid || s->spim_snap_gen != s->core._qp_access_gen)) {\n"
      << "        s->spim_sck_prev = sck; s->spim_mosi_prev = mosi;\n"
      << "        ot_" << devName << "_qp_spim_snapshot(s);\n"
      << "    }\n"
      << "    if (sck != s->spim_sck_prev) {\n"
      << "        bool rising = sck != 0;\n"
      << "        if (s->spim_first_edge) {\n"
      << "            s->spim_cpha = (oe && mosi != s->spim_mosi_prev) ? 1u : 0u;\n"
      << "            s->spim_first_edge = false;\n"
      << "        }\n"
      << "        bool sample_edge = (s->spim_cpol == s->spim_cpha) ? rising : !rising;\n"
      << "        if (sample_edge) {\n"
      << "            s->spim_txsh = (uint8_t)((s->spim_txsh << 1) | (mosi ? 1u : 0u));\n"
      << "            s->spim_bitcnt++;\n"
      << "            s->core._qp_hold_settle = 1;   /* byte in flight */\n"
      << "            if (s->spim_bitcnt < 8u) {\n"
      << "                if (s->spim_replay) ot_" << devName << "_qp_spim_present_miso(s, 7u - s->spim_bitcnt);\n"
      << "            } else if (!s->spim_replay) {\n"
      << "                /* first pass done: the MOSI byte is known -> byte-level transfer */\n"
      << "                s->spim_rx = (uint8_t)ssi_transfer(s->ssi, s->spim_txsh);\n"
      << "                if (s->spim_snap_valid && s->spim_snap_gen == s->core._qp_access_gen) {\n"
      << "                    /* rewind to the byte start and replay with the reply on MISO */\n"
      << "                    memcpy(&s->core, s->spim_snap, sizeof(s->core));\n"
      << "                    s->core._qp_rewound = 1;\n"
      << "                    s->core._qp_hold_settle = 1;\n"
      << "                    s->spim_sck_prev = s->spim_snap_sck_prev; s->spim_mosi_prev = s->spim_snap_mosi_prev;\n"
      << "                    s->spim_first_edge = s->spim_snap_first_edge;\n"
      << "                    s->spim_cpol = s->spim_snap_cpol; s->spim_cpha = s->spim_snap_cpha;\n"
      << "                    s->spim_bitcnt = 0; s->spim_txsh = 0; s->spim_replay = true;\n"
      << "                    ot_" << devName << "_qp_spim_present_miso(s, 7);\n"
      << "                    return;\n"
      << "                }\n"
      << "                qemu_log_mask(LOG_UNIMP, \"ot_" << devName << "_qp: SPI byte straddled an MMIO access; slave reply 0x%02x not replayed\\n\", s->spim_rx);\n"
      << "                s->spim_bitcnt = 0; s->spim_txsh = 0;\n"
      << "                s->core._qp_hold_settle = 0;\n"
      << "                ot_" << devName << "_qp_spim_snapshot(s);\n"
      << "            } else {\n"
      << "                /* replay pass complete: next byte starts from here */\n"
      << "                s->spim_bitcnt = 0; s->spim_txsh = 0; s->spim_replay = false;\n"
      << "                s->core._qp_hold_settle = 0;\n"
      << "                s->spim_sck_prev = sck; s->spim_mosi_prev = mosi;\n"
      << "                ot_" << devName << "_qp_spim_snapshot(s);\n"
      << "                return;\n"
      << "            }\n"
      << "        }\n"
      << "    }\n"
      << "    s->spim_sck_prev = sck;\n"
      << "    s->spim_mosi_prev = mosi;\n"
      << "}\n\n";
  }

  if (hasI2cWire) {
    c << "/* === I2C wire bridge ============================================ */\n"
      << "/* Generic open-drain, pin-level adapter.  The IP-specific port names\n"
      << " * below originate only from qemu.i2c_wire_blueprint. */\n"
      << "enum { I2CW_IDLE, I2CW_RECV, I2CW_ACK, I2CW_SEND, I2CW_MASTER_ACK };\n"
      << "static void ot_" << devName << "_qp_i2cw_on_tick(void *opaque)\n{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    bool scl = !(((s->core." << i2cSclOe << ") && !(s->core." << i2cSclOut << ")) || s->i2cw_master_scl_low);\n"
      << "    bool sda = !(((s->core." << i2cSdaOe << ") && !(s->core." << i2cSdaOut << ")) || s->i2cw_slave_sda_low || s->i2cw_master_sda_low);\n"
      << "    bool rising = !s->i2cw_scl && scl, falling = s->i2cw_scl && !scl;\n"
      << "    bool start = s->i2cw_sda && !sda && scl, stop = !s->i2cw_sda && sda && scl;\n"
      << "    /* Keep clocks flowing while the wire is changing.  If an active\n"
      << "     * transaction pauses between FIFO commands, the budget expires so\n"
      << "     * the device timer cannot starve the guest CPU; the next MMIO write\n"
      << "     * supplies a fresh budget. */\n"
      << "    if (!s->i2cw_external_master && (rising || falling || start || stop)) {\n"
      << "        s->i2cw_kick_ticks = 4096u;\n"
      << "        /* Re-arm: once an idle period drained the budget the timer\n"
      << "         * chain is dead — fresh wire activity must restart it or the\n"
      << "         * clock stops right after START. */\n"
      << "        if (s->i2cw_timer && !timer_pending(s->i2cw_timer))\n"
      << "            timer_mod(s->i2cw_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1);\n"
      << "    }\n"
      << "    if (!s->i2cw_external_master) {\n"
      << "    if (start) { qemu_log_mask(LOG_UNIMP, \"i2cw: START\\n\"); s->i2cw_wire_busy = true; s->i2cw_state = I2CW_RECV; s->i2cw_expect_address = true; s->i2cw_byte = s->i2cw_bit = 0; s->i2cw_slave_sda_low = false; }\n"
      << "    if (stop) { qemu_log_mask(LOG_UNIMP, \"i2cw: STOP\\n\"); if (s->i2cw_bus_active) { i2c_end_transfer(s->i2c_bus); i2c_schedule_pending_master(s->i2c_bus); } s->i2cw_bus_active = false; s->i2cw_wire_busy = false; s->i2cw_state = I2CW_IDLE; s->i2cw_slave_sda_low = false; s->i2cw_kick_ticks = 0; if (s->i2cw_timer) timer_del(s->i2cw_timer); }\n"
      << "    if (rising) switch (s->i2cw_state) {\n"
      << "    case I2CW_RECV: s->i2cw_byte = (uint8_t)((s->i2cw_byte << 1) | sda);\n"
      << "      if (++s->i2cw_bit == 8) { int rc; s->i2cw_bit = 0;\n"
      << "        if (s->i2cw_expect_address) { s->i2cw_next_read = s->i2cw_byte & 1u; s->i2cw_scan_from_rtl = true; rc = i2c_start_transfer(s->i2c_bus, s->i2cw_byte >> 1, s->i2cw_next_read); s->i2cw_scan_from_rtl = false; qemu_log_mask(LOG_UNIMP, \"i2cw: ADDR byte=0x%02x addr=0x%02x rw=%u rc=%d\\n\", s->i2cw_byte, s->i2cw_byte >> 1, s->i2cw_next_read, rc); s->i2cw_bus_active = rc == 0; s->i2cw_expect_address = false; }\n"
      << "        else { rc = i2c_send(s->i2c_bus, s->i2cw_byte); qemu_log_mask(LOG_UNIMP, \"i2cw: WRITE byte=0x%02x rc=%d\\n\", s->i2cw_byte, rc); }\n"
      << "        s->i2cw_ack = rc == 0; s->i2cw_state = I2CW_ACK; } break;\n"
      << "    case I2CW_ACK: qemu_log_mask(LOG_UNIMP, \"i2cw: ACK sampled low=%u\\n\", s->i2cw_slave_sda_low); /* Hold ACK through the complete high phase; the\n"
      << "       following falling edge releases SDA or presents read bit 7. */\n"
      << "      if (s->i2cw_next_read && s->i2cw_bus_active) { s->i2cw_byte = i2c_recv(s->i2c_bus); s->i2cw_bit = 0; s->i2cw_state = I2CW_SEND; } else s->i2cw_state = I2CW_RECV; break;\n"
      << "    case I2CW_SEND: if (++s->i2cw_bit == 8) s->i2cw_state = I2CW_MASTER_ACK; break;\n"
      << "    case I2CW_MASTER_ACK: if (!sda) { s->i2cw_byte = i2c_recv(s->i2c_bus); s->i2cw_bit = 0; s->i2cw_state = I2CW_SEND; } else { i2c_nack(s->i2c_bus); s->i2cw_state = I2CW_IDLE; } break;\n"
      << "    default: break; }\n"
      << "    if (falling) { if (s->i2cw_state == I2CW_ACK) { s->i2cw_slave_sda_low = s->i2cw_ack; qemu_log_mask(LOG_UNIMP, \"i2cw: ACK drive low=%u\\n\", s->i2cw_slave_sda_low); } else if (s->i2cw_state == I2CW_SEND) s->i2cw_slave_sda_low = !((s->i2cw_byte >> (7u - s->i2cw_bit)) & 1u); else if (s->i2cw_state == I2CW_RECV || s->i2cw_state == I2CW_MASTER_ACK) s->i2cw_slave_sda_low = false; }\n"
      << "    }\n"
      << "    s->i2cw_scl = scl; s->i2cw_sda = sda;\n"
      << "    s->core." << i2cSclIn << " = scl; s->core." << i2cSdaIn << " = sda;\n"
      << "}\n\n";

    c << "/* QEMU byte-level masters (including asynchronous masters such as\n"
      << " * i2c-echo) enter through a proxy I2CSlave.  Convert their callbacks\n"
      << " * to ordinary open-drain wire phases so address matching, ACK/NACK,\n"
      << " * target FIFOs and interrupts remain implemented by the generated\n"
      << " * hardware model rather than duplicated in this shim. */\n"
      << "#define I2CW_EXT_HALF_TICKS 16u\n\n"
      << "static void ot_" << devName << "_qp_i2cw_ext_clock_many("
      << d.structName << " *s, unsigned count)\n{\n"
      << "    /* Explicit wire time must also advance ACCUMULATE rings (input\n"
      << "     * filters/hold counters).  MMIO settle clocks intentionally do not. */\n"
      << "    s->core._qp_pump = 1;\n"
      << "    " << devName << "_step_many(&s->core, count);\n"
      << "    s->core._qp_pump = 0;\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_i2cw_ext_phase("
      << d.structName << " *s, bool scl, bool sda)\n{\n"
      << "    s->i2cw_master_scl_low = !scl;\n"
      << "    s->i2cw_master_sda_low = !sda;\n"
      << "    ot_" << devName << "_qp_i2cw_ext_clock_many(s, I2CW_EXT_HALF_TICKS);\n"
      << "}\n\n"
      << "static bool ot_" << devName << "_qp_i2cw_ext_write_byte("
      << d.structName << " *s, uint8_t value)\n{\n"
      << "    for (int bit = 7; bit >= 0; --bit) {\n"
      << "        bool level = (value >> bit) & 1u;\n"
      << "        ot_" << devName << "_qp_i2cw_ext_phase(s, false, level);\n"
      << "        ot_" << devName << "_qp_i2cw_ext_phase(s, true, level);\n"
      << "    }\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, true);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, true);\n"
      << "    bool ack = !s->i2cw_sda;\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, true);\n"
      << "    return ack;\n"
      << "}\n\n"
      << "static uint8_t ot_" << devName << "_qp_i2cw_ext_read_byte("
      << d.structName << " *s)\n{\n"
      << "    uint8_t value = 0;\n"
      << "    for (unsigned bit = 0; bit < 8; ++bit) {\n"
      << "        ot_" << devName << "_qp_i2cw_ext_phase(s, false, true);\n"
      << "        ot_" << devName << "_qp_i2cw_ext_phase(s, true, true);\n"
      << "        value = (uint8_t)((value << 1) | s->i2cw_sda);\n"
      << "    }\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, false);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, false);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, true);\n"
      << "    return value;\n"
      << "}\n\n"
      << "static bool ot_" << devName << "_qp_i2cw_ext_start("
      << d.structName << " *s, uint8_t address, bool read)\n{\n"
      << "    if (s->i2cw_timer) timer_del(s->i2cw_timer);\n"
      << "    s->i2cw_kick_ticks = 0;\n"
      << "    s->i2cw_external_master = true;\n"
      << "    s->i2cw_slave_sda_low = false;\n"
      << "    /* QEMU may schedule a pending master as soon as STOP is observed,\n"
      << "     * before the RTL host FSM completes its bus-free/release states. */\n"
      << "    s->i2cw_master_scl_low = false;\n"
      << "    s->i2cw_master_sda_low = false;\n"
      << "    ot_" << devName << "_qp_i2cw_ext_clock_many(s, 4096u);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, true);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, false);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, false);\n"
      << "    return ot_" << devName
      << "_qp_i2cw_ext_write_byte(s, (uint8_t)((address << 1) | read));\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_i2cw_ext_stop("
      << d.structName << " *s)\n{\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, false, false);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, false);\n"
      << "    ot_" << devName << "_qp_i2cw_ext_phase(s, true, true);\n"
      << "    s->i2cw_external_master = false;\n"
      << "    s->i2cw_master_scl_low = false;\n"
      << "    s->i2cw_master_sda_low = false;\n"
      << "    " << devName << "_step_many(&s->core, I2CW_EXT_HALF_TICKS);\n"
      << "}\n\n"
      << "static bool ot_" << devName << "_qp_target_match_and_add("
      << "I2CSlave *candidate, uint8_t address, bool broadcast,\n"
      << "                                            I2CNodeList *current_devs)\n{\n"
      << "    " << d.structName << "Target *target = " << d.typeMacroBase
      << "_TARGET(candidate);\n"
      << "    (void)broadcast;\n"
      << "    if (!target->owner || target->owner->i2cw_scan_from_rtl) return false;\n"
      << "    target->pending_address = address;\n"
      << "    I2CNode *node = g_new0(I2CNode, 1);\n"
      << "    node->elt = candidate;\n"
      << "    QLIST_INSERT_HEAD(current_devs, node, next);\n"
      << "    return true;\n"
      << "}\n\n"
      << "static int ot_" << devName << "_qp_target_event("
      << "I2CSlave *candidate, enum i2c_event event)\n{\n"
      << "    " << d.structName << "Target *target = " << d.typeMacroBase
      << "_TARGET(candidate);\n"
      << "    " << d.structName << " *s = target->owner;\n"
      << "    bool ack;\n"
      << "    switch (event) {\n"
      << "    case I2C_START_SEND:\n"
      << "    case I2C_START_SEND_ASYNC:\n"
      << "        ack = ot_" << devName
      << "_qp_i2cw_ext_start(s, target->pending_address, false);\n"
      << "        if (ack && event == I2C_START_SEND_ASYNC) i2c_ack(s->i2c_bus);\n"
      << "        return ack ? 0 : -1;\n"
      << "    case I2C_START_RECV:\n"
      << "        return ot_" << devName
      << "_qp_i2cw_ext_start(s, target->pending_address, true) ? 0 : -1;\n"
      << "    case I2C_FINISH:\n"
      << "        ot_" << devName << "_qp_i2cw_ext_stop(s);\n"
      << "        return 0;\n"
      << "    case I2C_NACK:\n"
      << "        return 0;\n"
      << "    default:\n"
      << "        return -1;\n"
      << "    }\n"
      << "}\n\n"
      << "static int ot_" << devName
      << "_qp_target_send(I2CSlave *candidate, uint8_t data)\n{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase
      << "_TARGET(candidate)->owner;\n"
      << "    return ot_" << devName
      << "_qp_i2cw_ext_write_byte(s, data) ? 0 : -1;\n"
      << "}\n\n"
      << "static void ot_" << devName
      << "_qp_target_send_async(I2CSlave *candidate, uint8_t data)\n{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase
      << "_TARGET(candidate)->owner;\n"
      << "    if (ot_" << devName
      << "_qp_i2cw_ext_write_byte(s, data)) i2c_ack(s->i2c_bus);\n"
      << "}\n\n"
      << "static uint8_t ot_" << devName
      << "_qp_target_recv(I2CSlave *candidate)\n{\n"
      << "    return ot_" << devName << "_qp_i2cw_ext_read_byte("
      << d.typeMacroBase << "_TARGET(candidate)->owner);\n"
      << "}\n\n"
      << "static void ot_" << devName
      << "_qp_target_class_init(ObjectClass *klass, const void *data)\n{\n"
      << "    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);\n"
      << "    (void)data;\n"
      << "    sc->match_and_add = ot_" << devName << "_qp_target_match_and_add;\n"
      << "    sc->event = ot_" << devName << "_qp_target_event;\n"
      << "    sc->send = ot_" << devName << "_qp_target_send;\n"
      << "    sc->send_async = ot_" << devName << "_qp_target_send_async;\n"
      << "    sc->recv = ot_" << devName << "_qp_target_recv;\n"
      << "}\n\n"
      << "static const TypeInfo ot_" << devName << "_qp_target_info = {\n"
      << "    .name = TYPE_" << d.typeMacroBase << "_TARGET,\n"
      << "    .parent = TYPE_I2C_SLAVE,\n"
      << "    .instance_size = sizeof(" << d.structName << "Target),\n"
      << "    .class_init = ot_" << devName << "_qp_target_class_init,\n"
      << "};\n\n"
      << "static void ot_" << devName << "_qp_target_register_types(void)\n{\n"
      << "    type_register_static(&ot_" << devName << "_qp_target_info);\n"
      << "}\n"
      << "type_init(ot_" << devName << "_qp_target_register_types)\n\n";

    c << "static void ot_" << devName << "_qp_i2cw_timer(void *opaque)\n{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    /* Batch model clocks per QEMU timer event.  _step invokes the\n"
      << "     * per-clock wire observer on every iteration, so no I2C edge is\n"
      << "     * skipped; batching only removes event-loop overhead. */\n"
      << "    unsigned batch = MIN(s->i2cw_kick_ticks, 4096u);\n"
      << "    s->i2cw_kick_ticks = s->i2cw_kick_ticks > batch ? s->i2cw_kick_ticks - batch : 0;\n"
      << "    /* Timer-pumped wire time must advance ACCUMULATE rings (the SCL\n"
      << "     * half-period dividers are pump-gated counters) — same rule as\n"
      << "     * the external-master clocking path. */\n"
      << "    if (batch) { s->core._qp_pump = 1; " << devName << "_step_many(&s->core, batch); s->core._qp_pump = 0; }\n"
      << "    s->i2cw_timer_ticks += batch;\n"
      << "    if (s->i2cw_kick_ticks) timer_mod(s->i2cw_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1);\n"
      << "}\n\n";
  }

  // SPI-slave transport organ: byte pump + spidev framing.
  if (hasSpiSlave) {
    c << "/* === SPI-slave transport ======================================== */\n"
      << "/* One full-duplex byte: 8 sck edges on the model's pins (mode 0, MSB\n"
      << " * first).  MOSI bit lane " << spiMosiBit << " of `" << spiSdIn << "`, MISO bit lane "
      << spiMisoBit << " of `" << spiSdOut << "`.\n"
      << " * Each setter runs one model tick (= one sck-domain clock); the trailing\n"
      << " * settle lets the sys-domain synchronisers / command queues catch up. */\n"
      << "static uint8_t ot_" << devName << "_qp_spi_xfer(" << d.structName << " *s, uint8_t mosi)\n"
      << "{\n"
      << "    uint8_t miso = 0;\n"
      << "    for (int i = 7; i >= 0; i--) {\n"
      << "        uint64_t sd = (uint64_t)s->core." << spiSdIn << " & ~(1ull << " << spiMosiBit << ");\n"
      << "        sd |= (uint64_t)((mosi >> i) & 1u) << " << spiMosiBit << ";\n"
      << "        " << devName << "_set_" << spiSdIn << "(&s->core, sd);\n"
      << "        " << devName << "_set_" << spiSck << "(&s->core, 1);\n"
      << "        miso |= (uint8_t)(((s->core." << spiSdOut << " >> " << spiMisoBit << ") & 1u) << i);\n"
      << "        " << devName << "_set_" << spiSck << "(&s->core, 0);\n"
      << "    }\n"
      << "    " << devName << "_settle(&s->core);\n"
      << "    return miso;\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_spi_cs(" << d.structName << " *s, bool low)\n"
      << "{\n"
      << "    if (s->spi_cs_low == low) return;\n"
      << "    s->spi_cs_low = low;\n"
      << "    " << devName << "_set_" << spiCsb << "(&s->core, low ? 0 : 1);\n"
      << "    " << devName << "_settle(&s->core);\n";
    if (hasIrqDrive)
      c << "    ot_" << devName << "_qp_update_irqs(s);\n";
    c << "}\n\n"
      << "static int ot_" << devName << "_qp_spi_can_receive(void *opaque)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    if (s->spi_remaining) return (int)(s->spi_remaining > 256u ? 256u : s->spi_remaining);\n"
      << "    return (int)(8u - s->spi_hdr_len);\n"
      << "}\n\n"
      << "static void ot_" << devName << "_qp_spi_receive(void *opaque, const uint8_t *buf, int size)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    while (size > 0) {\n"
      << "        if (s->spi_remaining == 0) {\n"
      << "            /* header phase */\n"
      << "            s->spi_hdr[s->spi_hdr_len++] = *buf++; size--;\n"
      << "            if (s->spi_hdr_len < 8) continue;\n"
      << "            s->spi_hdr_len = 0;\n"
      << "            if (s->spi_hdr[0] != '/' || s->spi_hdr[1] != 'C' || s->spi_hdr[2] != 'S' || s->spi_hdr[3] != 0) {\n"
      << "                qemu_log_mask(LOG_GUEST_ERROR, \"" << devName << "_qp: bad spidev header\\n\");\n"
      << "                continue;\n"
      << "            }\n"
      << "            s->spi_remaining = (unsigned)s->spi_hdr[6] | ((unsigned)s->spi_hdr[7] << 8);\n"
      << "            s->spi_release = !((s->spi_hdr[4] >> 7) & 1u);\n"
      << "            if (s->spi_remaining == 0) {\n"
      << "                if (s->spi_release) ot_" << devName << "_qp_spi_cs(s, false);\n"
      << "                continue;\n"
      << "            }\n"
      << "            ot_" << devName << "_qp_spi_cs(s, true);\n"
      << "            continue;\n"
      << "        }\n"
      << "        /* payload phase: pump bytes, answer with MISO bytes */\n"
      << "        uint8_t tx[256];\n"
      << "        unsigned n = 0;\n"
      << "        while (size > 0 && s->spi_remaining && n < sizeof(tx)) {\n"
      << "            tx[n++] = ot_" << devName << "_qp_spi_xfer(s, *buf++);\n"
      << "            size--; s->spi_remaining--;\n"
      << "        }\n"
      << "        if (qemu_chr_fe_backend_connected(&s->chr))\n"
      << "            qemu_chr_fe_write_all(&s->chr, tx, (int)n);\n"
      << "        if (s->spi_remaining == 0 && s->spi_release)\n"
      << "            ot_" << devName << "_qp_spi_cs(s, false);\n"
      << "    }\n";
    if (hasIrqDrive)
      c << "    ot_" << devName << "_qp_update_irqs(s);\n";
    c << "}\n\n";
  }

  // Pin-output export — generic, role-driven (qemu.pin_io_blueprint).  Push the
  // model's data-output bus onto the QEMU GPIO output lines, gated per-bit by
  // the output-enable bus.  The data_out field is computed by the model's
  // top-output bridge; this just copies it to the device boundary.
  if (hasPinOut) {
    c << "/* === Pin output export ========================================== */\n"
      << "static void ot_" << devName << "_qp_update_pins(" << d.structName
      << " *s)\n"
      << "{\n"
      << "    uint64_t data = (uint64_t)s->core." << pinDataOutPort << ";\n"
      << "    uint64_t oe   = (uint64_t)s->core." << pinOePort << ";\n"
      << "    for (unsigned i = 0; i < " << pinOutWidth << "; i++) {\n"
      << "        uint64_t bit = 1ull << i;\n"
      << "        uint64_t level = ((oe & bit) && (data & bit)) ? bit : 0;\n"
      << "        /* Only pulse lines whose level actually changed — avoids\n"
      << "         * O(width) redundant sink callbacks (and, under a pin loopback,\n"
      << "         * a storm of input re-injections + settles) on every write. */\n"
      << "        if ((s->pin_out_last & bit) != level) {\n"
      << "            qemu_set_irq(s->pin_out[i], level ? 1 : 0);\n"
      << "            s->pin_out_last = (s->pin_out_last & ~bit) | level;\n"
      << "        }\n"
      << "    }\n"
      << "}\n\n";
  }

  // Auxiliary named pin groups — same push/inject pattern as the primary
  // pin_io bus, one function pair per group, named qdev lines.
  for (const auto &g : auxGroups) {
    if (g.outW) {
      c << "/* === Aux pin group '" << g.name << "' output export ============ */\n"
        << "static void ot_" << devName << "_qp_update_aux_" << g.name
        << "(" << d.structName << " *s)\n"
        << "{\n"
        << "    __uint128_t data = (__uint128_t)s->core." << g.outPort << ";\n"
        << "    for (unsigned i = 0; i < " << g.outW << "; i++) {\n"
        << "        __uint128_t bit = ((__uint128_t)1) << i;\n"
        << "        __uint128_t level = (data & bit) ? bit : 0;\n"
        << "        if ((s->aux_" << g.name << "_out_last & bit) != level) {\n"
        << "            qemu_set_irq(s->aux_" << g.name << "_out[i], level ? 1 : 0);\n"
        << "            s->aux_" << g.name << "_out_last = (s->aux_" << g.name
        << "_out_last & ~bit) | level;\n"
        << "        }\n"
        << "    }\n"
        << "}\n\n";
    }
    if (g.inW) {
      c << "/* === Aux pin group '" << g.name << "' input path =============== */\n"
        << "static void ot_" << devName << "_qp_set_aux_" << g.name
        << "_in(void *opaque, int n, int level)\n"
        << "{\n"
        << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
        << "    if (level)\n"
        << "        s->aux_" << g.name << "_in_shadow |= ((__uint128_t)1) << n;\n"
        << "    else\n"
        << "        s->aux_" << g.name << "_in_shadow &= ~(((__uint128_t)1) << n);\n"
        << "    if (s->core._qp_busy) {\n"
        << "        /* Re-entered from our own settle: latch raw, outer loop\n"
        << "         * sees it next tick (asynchronous-input semantics). */\n"
        << "        s->core." << g.inPort << " = "
        << (g.inW > 64 ? "s->aux_" : "(uint64_t)s->aux_") << g.name
        << "_in_shadow;\n"
        << "        return;\n"
        << "    }\n"
        << "    " << devName << "_set_" << g.inPort << "(&s->core, "
        << (g.inW > 64 ? "s->aux_" : "(uint64_t)s->aux_") << g.name
        << "_in_shadow);\n";
      if (g.outW)
        c << "    ot_" << devName << "_qp_update_aux_" << g.name << "(s);\n";
      if (hasPinOut)
        c << "    ot_" << devName << "_qp_update_pins(s);\n";
      c << "}\n\n";
    }
  }

  // Alert-collector inputs (alert_in role): one named gpio-in per upstream
  // peripheral's diff pair — SoC alert wiring lands on OT_DEVICE_ALERT
  // unchanged.  Generic organ; count/prefix come from the binding.
  if (hasAlertIn) {
    c << "/* === Alert-source inputs (alert_in role) ======================== */\n"
      << "static void ot_" << devName << "_qp_set_alert_in(void *opaque, int n, int level)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    if (n < 0 || n >= " << alertInCount << ") return;\n"
      << "    switch (n) {\n";
    for (unsigned k = 0; k < alertInCount; ++k)
      c << "    case " << k << ": s->core." << alertInPrefix << "_" << k
        << "__alert_p = level ? 1 : 0; s->core." << alertInPrefix << "_" << k
        << "__alert_n = level ? 0 : 1; break;\n";
    c << "    }\n"
      << "    if (s->core._qp_busy) return;   /* asynchronous-input rule */\n"
      << "    " << devName << "_settle(&s->core);\n";
    if (hasIrqDrive)
      c << "    ot_" << devName << "_qp_update_irqs(s);\n";
    c << "}\n\n";
  }

  // Pin-input path — generic, role-driven.  A QEMU input line changed: update
  // the shadow bus value, inject it into the model (the generated setter settles
  // internally), then refresh IRQs so an input edge can raise an interrupt.
  // Deliberately does NOT call update_pins: data outputs are driven by register
  // writes, not by inputs, and re-driving pins here would form an infinite
  if (hasOutLines) {
    c << "/* === Declared output lines (out_lines role) ===================== */\n"
      << "static void ot_" << devName << "_qp_update_out_lines(" << d.structName << " *s)\n"
      << "{\n"
      << "    /* Settle first: a source that just arrived via set_pin_in has\n"
      << "     * only ticked once — synchronizer chains + the gateway need a\n"
      << "     * few more clocks before the line levels are meaningful (same\n"
      << "     * convention as update_irqs). */\n"
      << "    " << devName << "_settle(&s->core);\n";
    for (size_t i = 0; i < outLineFields.size(); ++i)
      c << "    ibex_irq_set(&s->out_lines[" << i << "], (int)(s->core."
        << outLineFields[i] << " & 1u));\n";
    c << "}\n\n";
  }

  // out->in->out feedback loop under a pin loopback (test or real).
  if (hasPinIn) {
    c << "/* === Pin input path ============================================= */\n"
      << "static void ot_" << devName
      << "_qp_set_pin_in(void *opaque, int n, int level)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n";
    if (pinInWidth > 64)
      c << "    if (level)\n"
        << "        s->pin_in_shadow[n >> 6] |= (1ull << (n & 63));\n"
        << "    else\n"
        << "        s->pin_in_shadow[n >> 6] &= ~(1ull << (n & 63));\n"
        << "    if (s->core._qp_busy) {\n"
        << "        /* Re-entered from our own settle (organ observer reached a\n"
        << "         * device that called back).  Latch the raw input field —\n"
        << "         * asynchronous-input semantics — and let the outer settle\n"
        << "         * loop see it on its next tick.  The outer caller refreshes\n"
        << "         * IRQs when its access completes. */\n"
        << "        memcpy(s->core." << pinDataInPort
        << ", s->pin_in_shadow, sizeof(s->pin_in_shadow));\n"
        << "        return;\n"
        << "    }\n"
        << "    " << devName << "_set_" << pinDataInPort
        << "(&s->core, s->pin_in_shadow);\n";
    else
      c << "    if (level)\n"
        << "        s->pin_in_shadow |= (1ull << n);\n"
        << "    else\n"
        << "        s->pin_in_shadow &= ~(1ull << n);\n"
        << "    if (s->core._qp_busy) {\n"
        << "        /* Re-entered from our own settle (organ observer reached a\n"
        << "         * device that called back).  Latch the raw input field —\n"
        << "         * asynchronous-input semantics — and let the outer settle\n"
        << "         * loop see it on its next tick.  The outer caller refreshes\n"
        << "         * IRQs when its access completes. */\n"
        << "        s->core." << pinDataInPort << " = s->pin_in_shadow;\n"
        << "        return;\n"
        << "    }\n"
        << "    " << devName << "_set_" << pinDataInPort
        << "(&s->core, s->pin_in_shadow);\n";
    if (hasIrqDrive)
      c << "    ot_" << devName << "_qp_update_irqs(s);\n";
    if (hasOutLines)
      c << "    ot_" << devName << "_qp_update_out_lines(s);\n";
    // A primary-pin injection can retarget aux outputs (pinmux: a pad
    // input routes to mio_to_periph) — push them too, or a pad-loopback
    // ring stalls one hop after the pads.
    for (const auto &g : auxGroups)
      if (g.outW)
        c << "    ot_" << devName << "_qp_update_aux_" << g.name << "(s);\n";
    c << "}\n\n";
  }

  // Chardev receive callbacks (only when blueprint has RX).
  if (hasRx) {
    c << "/* === Chardev RX path ============================================ */\n"
      << "/* QEMU calls `can_receive` to ask how many bytes the device can\n"
      << " * accept right now; we report free space in our shim-side Fifo8.\n"
      << " * Once `receive` is called with N bytes, we push them into the\n"
      << " * Fifo8.  Firmware drains them via R_RDATA reads, which the read\n"
      << " * callback below intercepts at the blueprint's `pop_offset`. */\n"
      << "static int ot_" << devName << "_qp_chr_can_receive(void *opaque)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    return (int)fifo8_num_free(&s->rx_buf);\n"
      << "}\n\n"
      << "static void ot_" << devName
      << "_qp_chr_receive(void *opaque, const uint8_t *buf, int size)\n"
      << "{\n"
      << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
      << "    for (int i = 0; i < size; i++) {\n"
      << "        if (fifo8_is_full(&s->rx_buf)) break;\n"
      << "        fifo8_push(&s->rx_buf, buf[i]);\n";
    c << "    }\n";
    if (fifoPtrs.rxValid) {
      c << "    /* Mirror occupancy: the shim Fifo8 is the SINGLE source of truth\n"
        << "     * for RX data; set the model RX-FIFO pointers so depth ==\n"
        << "     * fifo8_num_used (wptr = count, rptr = 0).  Re-deriving from the\n"
        << "     * Fifo8 each time (instead of incrementing an independent counter)\n"
        << "     * makes data and occupancy impossible to desync — e.g. a\n"
        << "     * FIFO_CTRL.RXRST that zeroes the model pointer in tick() is\n"
        << "     * harmlessly restored on the next sync.  Safe: wvalid_i stays 0 in\n"
        << "     * the chardev-bypass path, and count <= RX_BUF_DEPTH fits the mask. */\n"
        << "    s->core." << fifoPtrs.rxWptr << " = fifo8_num_used(&s->rx_buf) & 0x"
        << llvm::utohexstr(fifoPtrs.rxMask) << "u;\n"
        << "    s->core." << fifoPtrs.rxRptr << " = 0;\n";
    }
    if (fifoPtrs.rxValid && hasIrqDrive) {
      c << "    /* Settle (update_irqs runs the model + reads INTR_STATE/ENABLE)\n"
        << "     * so the new depth propagates to rx_watermark and drives the\n"
        << "     * PLIC line — this is how a real byte raises the interrupt. */\n"
        << "    ot_" << devName << "_qp_update_irqs(s);\n";
    }
    c << "}\n\n";
  }

  // read callback
  c << "/* Generic core accessor: SoC-integration bridges (device-to-device\n"
       " * signal links wired in the machine file) reach the generated state\n"
       " * through this + the <dev>.h field API. */\n"
       "void *ot_" << devName << "_qp_core(DeviceState *dev)\n"
       "{\n"
       "    return &" << d.typeMacroBase << "(dev)->core;\n"
       "}\n\n";
  c << "void ot_" << devName
    << "_qp_set_settle_hook(DeviceState *dev, int (*fn)(void *), void *ctx)\n"
       "{\n"
       "    " << d.typeMacroBase << "(dev)->core._qp_settle_hook = fn;\n"
       "    " << d.typeMacroBase << "(dev)->core._qp_settle_hook_ctx = ctx;\n"
       "}\n\n";
  // MMIO COVERAGE, opt-in via QP_COV and off by default.
  //
  // Nobody has ever measured which registers the firmware suite touches, and
  // every silent defect found so far lived in one that nothing touched:
  // pinmux's pad-attribute WARL masks (main_pinmux.c says in its own header
  // that the ATTR registers are "NOT exercised"), spi_device's passthrough
  // command filter, csrng's INT_STATE_VAL.  With QP_COV=<path> each device
  // appends `<dev> R|W <offset>` lines, which a script turns into a
  // per-register report against the model's own address decode.
  c << "/* Register coverage, opt-in via QP_COV=<path>.  Off by default. */\n"
    << "static void ot_" << devName << "_qp_cov(char rw, hwaddr addr)\n"
    << "{\n"
    << "    static FILE *covf;\n"
    << "    static int covtried;\n"
    << "    if (!covtried) {\n"
    << "        const char *p = getenv(\"QP_COV\");\n"
    << "        covtried = 1;\n"
    << "        if (p) covf = fopen(p, \"ae\");\n"
    << "    }\n"
    << "    if (covf) {\n"
    << "        fprintf(covf, \"" << devName << " %c 0x%04x\\n\", rw,\n"
    << "                (unsigned)addr);\n"
    << "        fflush(covf);\n"
    << "    }\n"
    << "}\n\n";
  c << "static uint64_t ot_" << devName << "_qp_read(void *opaque, hwaddr addr, unsigned size)\n"
    << "{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
    << "    ot_" << devName << "_qp_cov('R', addr);\n";
  if (hasRx) {
    c << "    /* Override R_RDATA reads to drain the shim-side Fifo8 instead of\n"
      << "     * the generated model's RDATA register.  Tell chardev we can\n"
      << "     * accept more bytes after popping (otherwise can_receive=0\n"
      << "     * stays sticky and the byte stream stalls). */\n"
      << "    if (addr == 0x" << llvm::utohexstr(rxPopOffset) << ") {\n"
      << "        uint64_t val = 0;\n"
      << "        if (!fifo8_is_empty(&s->rx_buf)) {\n"
      << "            val = fifo8_pop(&s->rx_buf);\n"
      << "        }\n";
    if (fifoPtrs.rxValid) {
      c << "        /* Re-mirror occupancy from the Fifo8 after the pop so depth\n"
        << "         * drops and rx_watermark de-asserts when drained. */\n"
        << "        s->core." << fifoPtrs.rxWptr << " = fifo8_num_used(&s->rx_buf) & 0x"
        << llvm::utohexstr(fifoPtrs.rxMask) << "u;\n"
        << "        s->core." << fifoPtrs.rxRptr << " = 0;\n";
    }
    c << "        qemu_chr_fe_accept_input(&s->chr);\n";
    if (fifoPtrs.rxValid && hasIrqDrive)
      c << "        ot_" << devName << "_qp_update_irqs(s);\n";
    c << "        return val;\n"
      << "    }\n";
  }
  if (hasOutLines)
    c << "    {\n"
      << "        uint64_t _v = " << devName << "_read(&s->core, addr, size);\n"
      << "        ot_" << devName << "_qp_update_out_lines(s);\n"
      << "        return _v;\n"
      << "    }\n"
      << "}\n\n";
  else
    c << "    return " << devName << "_read(&s->core, addr, size);\n"
      << "}\n\n";

  // write callback.  Second line of the signature aligned with first
  // "void *opaque" column — column = strlen("static void ot_<dev>_qp_write(").
  std::string writeIndent(
      std::string("static void ot_").size() + devName.size() +
      std::string("_qp_write(").size(),
      ' ');
  c << "static void ot_" << devName << "_qp_write(void *opaque, hwaddr addr, uint64_t value,\n"
    << writeIndent << "unsigned size)\n"
    << "{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(opaque);\n"
    << "    ot_" << devName << "_qp_cov('W', addr);\n"
    << "    " << devName << "_write(&s->core, addr, value, size);\n";
  if (hasOutLines)
    c << "    ot_" << devName << "_qp_update_out_lines(s);\n";
  if (hasTx) {
    c << "    /* Forward the byte the firmware just wrote to R_<TX_DATA> out\n"
      << "     * via chardev.  The generated model's TX FIFO simulation still\n"
      << "     * runs (we delegated above), but its serialized bit stream is\n"
      << "     * not connected to anything — the chardev gets the byte\n"
      << "     * directly here. */\n"
      << "    if (addr == 0x" << llvm::utohexstr(txTriggerOffset) << ") {\n"
      << "        uint8_t byte = (uint8_t)(value & 0xFFu);\n";
    if (hasLoopback) {
      // System loopback: when the model's internal TX->RX routing is active
      // (blueprint loopback_field nonzero), mirror the TX byte into the shim RX
      // buffer instead of the external chardev, so RDATA returns it and RXEMPTY
      // clears — matching the model's own `rx_in = <field> ? tx_out : ...` mux.
      // The trailing RX-occupancy resync + update_irqs below then de-assert
      // RXEMPTY; the explicit resync here keeps the branch self-contained.
      c << "        if (s->core." << loopbackField << ") {\n"
        << "            if (!fifo8_is_full(&s->rx_buf))\n"
        << "                fifo8_push(&s->rx_buf, byte);\n"
        << "            s->core." << fifoPtrs.rxWptr
        << " = fifo8_num_used(&s->rx_buf) & 0x" << llvm::utohexstr(fifoPtrs.rxMask)
        << "u;\n"
        << "            s->core." << fifoPtrs.rxRptr << " = 0;\n";
      if (hasIrqDrive)
        c << "            ot_" << devName << "_qp_update_irqs(s);\n";
      c << "        } else {\n"
        << "            (void)qemu_chr_fe_write(&s->chr, &byte, 1);\n"
        << "        }\n";
    } else {
      c << "        (void)qemu_chr_fe_write(&s->chr, &byte, 1);\n";
    }
    if (fifoPtrs.txValid) {
      // Instant serializer: the byte has already left through the chardev, so
      // the model's TX FIFO is drained on the spot (rptr catches up with wptr)
      // — occupancy/TXLVL/tx_empty track "sent immediately" instead of the
      // model's bit-serial drain (which only advances during MMIO settles).
      // Mirror image of the RX-side occupancy resync from the Fifo8.
      c << "        s->core." << fifoPtrs.txRptr << " = s->core." << fifoPtrs.txWptr
        << ";   /* TX FIFO drained: byte already sent */\n";
    }
    c << "    }\n";
  }
  if (hasAlert) {
    c << "    /* Alert line: a write to ALERT_TEST (IR-derived offset) pulses\n"
      << "     * the device alert — mirrors upstream ot_" << devName
      << " R_ALERT_TEST. */\n"
      << "    if (addr == 0x" << llvm::utohexstr(alertTestOff) << "u) {\n"
      << "        ibex_irq_set(&s->alert, (int)(value & 1u));\n"
      << "    }\n";
  }
  if (hasRx && fifoPtrs.rxValid) {
    c << "    /* Re-derive RX occupancy from the Fifo8 after EVERY write: a\n"
      << "     * FIFO_CTRL.RXRST zeroes the model RX pointer in tick(), which would\n"
      << "     * otherwise desync occupancy from the still-buffered data.  Since the\n"
      << "     * Fifo8 is the single source of truth, restoring depth == num_used\n"
      << "     * here keeps them consistent (RXRST is a no-op for the shim queue). */\n"
      << "    s->core." << fifoPtrs.rxWptr << " = fifo8_num_used(&s->rx_buf) & 0x"
      << llvm::utohexstr(fifoPtrs.rxMask) << "u;\n"
      << "    s->core." << fifoPtrs.rxRptr << " = 0;\n";
  }
  if (hasIrqDrive)
    c << "    ot_" << devName << "_qp_update_irqs(s);\n";
  if (hasPinOut)
    c << "    ot_" << devName << "_qp_update_pins(s);\n";
  for (const auto &g : auxGroups)
    if (g.outW)
      c << "    ot_" << devName << "_qp_update_aux_" << g.name << "(s);\n";
  if (hasI2cWire)
    c << "    /* Kick the pin model before START exists; START then switches the\n"
      << "     * timer to wire_busy-driven scheduling. */\n"
      << "    s->i2cw_kick_ticks = 4096u;\n"
      << "    timer_mod(s->i2cw_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1000);\n";
  c << "}\n\n";

  // MemoryRegionOps
  if (auxPorts)
    for (const auto &ap : *auxPorts) {
      c << "static uint64_t ot_" << devName << "_qp_" << ap.name
        << "_read(void *opaque, hwaddr addr, unsigned size)\n{\n"
        << "    " << d.structName << " *s = " << d.typeMacroBase
        << "(opaque);\n"
        << "    ot_" << devName << "_qp_cov('R', addr);   /* aux port */\n"
        << "    return " << devName << "_" << ap.name
        << "_read(&s->core, addr, size);\n}\n\n"
        << "static void ot_" << devName << "_qp_" << ap.name
        << "_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)\n{\n"
        << "    " << d.structName << " *s = " << d.typeMacroBase
        << "(opaque);\n"
        << "    ot_" << devName << "_qp_cov('W', addr);   /* aux port */\n"
        << "    " << devName << "_" << ap.name
        << "_write(&s->core, addr, value, size);\n}\n\n"
        << "static const MemoryRegionOps ot_" << devName << "_qp_"
        << ap.name << "_ops = {\n"
        << "    .read = ot_" << devName << "_qp_" << ap.name << "_read,\n"
        << "    .write = ot_" << devName << "_qp_" << ap.name << "_write,\n"
        << "    .endianness = DEVICE_NATIVE_ENDIAN,\n"
        << "    .impl.min_access_size = 1,\n"
        << "    .impl.max_access_size = 4,\n"
        << "};\n\n";
    }
  c << "static const MemoryRegionOps ot_" << devName << "_qp_ops = {\n"
    << "    .read = ot_" << devName << "_qp_read,\n"
    << "    .write = ot_" << devName << "_qp_write,\n"
    << "    .endianness = DEVICE_LITTLE_ENDIAN,\n"
    << "    .impl.min_access_size = 1,\n"   /* sub-word beats pass through (hmac MSG_FIFO) */
    << "    .impl.max_access_size = 4,\n"
    << "};\n\n";

  // Properties array
  c << "static const Property ot_" << devName << "_qp_properties[] = {\n";
  for (size_t bi = 0; bi < nBackingStores; ++bi)
    c << "    DEFINE_PROP_STRING(\"backing" << bi << "-image\", "
      << d.structName << ", backing" << bi << "_image),\n";
  for (const auto &p : d.properties) {
    c << "    " << p.macro << "(" << p.nameStr << ", " << d.structName
      << ", " << p.fieldName << p.extraArgs << "),\n";
  }
  c << "};\n\n";

  // realize — chardev handlers must be registered HERE (after properties
  // have been applied, so `s->chr` is bound to the SoC's `-serial` chardev).
  // If we call qemu_chr_fe_set_handlers() in `init` it runs BEFORE
  // qdev_prop_set_chr from the SoC config callback, so the chardev backend
  // is empty and chr_receive never fires.
  c << "static void ot_" << devName << "_qp_realize(DeviceState *dev, Error **errp)\n"
    << "{\n";
  bool realizeUsesS = (hasChardev && hasRx) || (emitPump && hasIrqDrive) || hasSpiSlave || hasSpiMaster || hasBusMaster || hasI2cWire || nBackingStores > 0;
  if (realizeUsesS)
    c << "    " << d.structName << " *s = " << d.typeMacroBase << "(dev);\n"
      << "    (void)errp;\n";
  else
    c << "    /* Backend hookup intentionally absent — frontend-only milestone. */\n"
      << "    (void)dev;\n"
      << "    (void)errp;\n";
  for (size_t bi = 0; bi < nBackingStores; ++bi) {
    c << "    if (s->backing" << bi << "_image) {\n"
      << "        gchar *_img; gsize _n;\n"
      << "        if (g_file_get_contents(s->backing" << bi
      << "_image, &_img, &_n, NULL)) {\n"
      << "            if (" << devName << "_load_backing(&s->core, " << bi
      << ", _img, _n) < 0)\n"
      << "                error_setg(errp, \"backing" << bi
      << " image too large\");\n"
      << "            g_free(_img);\n"
      << "        } else {\n"
      << "            error_setg(errp, \"cannot read backing" << bi
      << " image %s\", s->backing" << bi << "_image);\n"
      << "        }\n"
      << "    }\n";
  }
  if (hasChardev && hasRx) {
    c << "    qemu_chr_fe_set_handlers(&s->chr,\n"
      << "                              ot_" << devName << "_qp_chr_can_receive,\n"
      << "                              ot_" << devName << "_qp_chr_receive,\n"
      << "                              NULL, NULL,\n"
      << "                              s, NULL, true);\n";
  }
  if (hasI2cWire) {
    c << "    char *i2c_bus_name = g_strdup_printf(\"ot-%s\", s->ot_id);\n"
      << "    s->i2c_bus = i2c_init_bus(dev, i2c_bus_name);\n"
      << "    g_free(i2c_bus_name);\n"
      << "    s->i2cw_target = i2c_slave_create_simple(s->i2c_bus, TYPE_"
      << d.typeMacroBase << "_TARGET, 0xff);\n"
      << "    " << d.typeMacroBase
      << "_TARGET(s->i2cw_target)->owner = s;\n"
      << "    s->i2cw_scl = true; s->i2cw_sda = true;\n"
      << "    s->core." << i2cSclIn << " = 1; s->core." << i2cSdaIn << " = 1;\n"
      << "    s->i2cw_state = I2CW_IDLE;\n"
      << "    s->i2cw_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ot_" << devName << "_qp_i2cw_timer, s);\n"
      << "    s->core._qp_before_tick = ot_" << devName << "_qp_i2cw_on_tick;\n"
      << "    s->core._qp_before_tick_ctx = s;\n";
  }
  if (hasSpiSlave) {
    c << "    /* SPI-slave transport: bytes + chip-select from the spidev chardev. */\n"
      << "    s->spi_hdr_len = 0; s->spi_remaining = 0; s->spi_release = true; s->spi_cs_low = false;\n"
      << "    qemu_chr_fe_set_handlers(&s->chr,\n"
      << "                              ot_" << devName << "_qp_spi_can_receive,\n"
      << "                              ot_" << devName << "_qp_spi_receive,\n"
      << "                              NULL, NULL,\n"
      << "                              s, NULL, true);\n";
  }
  if (hasSpiMaster) {
    c << "    /* SPI-master bridge: SSI bus `spi<bus-num>` + CS lines (upstream\n"
      << "     * naming, so the board's spiflash<N> attach + CS wiring apply), and\n"
      << "     * the per-clock observer that drives them from the model's pins. */\n"
      << "    s->cs_lines = g_new0(IbexIRQ, (size_t)s->num_cs);\n"
      << "    ibex_qdev_init_irqs(OBJECT(dev), &s->cs_lines[0], SSI_GPIO_CS, s->num_cs);\n"
      << "    char busname[16u];\n"
      << "    if (snprintf(busname, sizeof(busname), \"spi%u\", s->bus_num) >= (int)sizeof(busname)) {\n"
      << "        error_setg(errp, \"Invalid SSI bus num %u\", s->bus_num);\n"
      << "        return;\n"
      << "    }\n"
      << "    s->ssi = ssi_create_bus(DEVICE(s), busname);\n"
      << "    s->spim_csb_prev = 0xFFFFFFFFu;   /* all deselected */\n"
      << "    s->spim_sck_prev = 0; s->spim_mosi_prev = 0; s->spim_active = false;\n"
      << "    s->spim_snap = g_malloc0(sizeof(s->core));\n"
      << "    s->spim_snap_valid = false; s->spim_replay = false;\n"
      << "    s->core._qp_on_tick = ot_" << devName << "_qp_spim_on_tick;\n"
      << "    s->core._qp_on_tick_ctx = s;\n";
  }
  if (hasBusMaster) {
    c << "    /* Bus-master bridge: bind each declared port's AddressSpace and\n"
      << "     * register the per-clock observer.  The SoC glue may later pass\n"
      << "     * ot_address_space links ([AI-2]); until then the system memory\n"
      << "     * address space is the functional default. */\n";
    for (unsigned i = 0; i < bmPorts.size(); ++i)
      c << "    s->bm_as_" << i << " = &address_space_memory;\n"
        << "    s->bm_rsp_pending_" << i << " = false;\n";
    c << "    s->core._qp_on_tick = ot_" << devName << "_qp_bm_on_tick;\n"
      << "    s->core._qp_on_tick_ctx = s;\n";
  }
  if (emitPump && hasIrqDrive) {
    c << "    /* Arm the virtual-time pump: a free-running periodic ptimer that\n"
      << "     * advances the model's counters + redelivers interrupts so the\n"
      << "     * device keeps time and fires autonomously (functional, not\n"
      << "     * cycle-accurate). */\n"
      << "    s->qp_pump = ptimer_init(ot_" << devName
      << "_qp_pump, s, PTIMER_POLICY_CONTINUOUS_TRIGGER);\n"
      << "    ptimer_transaction_begin(s->qp_pump);\n"
      << "    ptimer_set_freq(s->qp_pump, " << d.typeMacroBase << "_PUMP_HZ);\n"
      << "    ptimer_set_limit(s->qp_pump, 1, 1);\n"
      << "    ptimer_run(s->qp_pump, 0);\n"
      << "    ptimer_transaction_commit(s->qp_pump);\n";
  }
  c << "}\n\n";

  // init
  c << "static void ot_" << devName << "_qp_init(Object *obj)\n"
    << "{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(obj);\n\n";
  if (d.irqCount > 0) {
    c << "    for (unsigned i = 0; i < " << d.typeMacroBase << "_IRQ_NUM; i++) {\n"
      << "        ibex_sysbus_init_irq(obj, &s->irqs[i]);\n"
      << "    }\n";
  } else {
    c << "    /* This device has 0 IRQs — no IRQ init loop. */\n";
  }
  if (hasOutLines)
    c << "    /* Declared 1-bit output lines (out_lines role): exported as this\n"
      << "     * device's UNNAMED qdev gpio-outs in declaration order — the SoC\n"
      << "     * table's OT_EG_SOC_GPIO(n, ...) macro targets exactly those. */\n"
      << "    ibex_qdev_init_irqs(obj, &s->out_lines[0], NULL, "
      << outLineFields.size() << ");\n";
  if (hasAlertIn)
    c << "    qdev_init_gpio_in_named(DEVICE(obj), ot_" << devName
      << "_qp_set_alert_in, OT_DEVICE_ALERT, " << alertInCount << ");\n";

  // The alert COLLECTOR must not register its own OT_DEVICE_ALERT output:
  // qdev forbids mixing named gpio ins and outs on one list, and the
  // alert_in organ already claimed the name with 65 gpio-ins.
  if (!hasAlertIn)
    c << "    ibex_qdev_init_irq(obj, &s->alert, OT_DEVICE_ALERT);\n";
  c << "\n"
    << "    memory_region_init_io(&s->mmio, obj, &ot_" << devName << "_qp_ops, s,\n"
    << "                          TYPE_" << d.typeMacroBase << ", 0x" << llvm::utohexstr(mmioSize) << ");\n"
    << "    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);\n\n";
  if (auxPorts)
    for (const auto &ap : *auxPorts)
      c << "    memory_region_init_io(&s->mmio_" << ap.name
        << ", obj, &ot_" << devName << "_qp_" << ap.name << "_ops, s,\n"
        << "                          TYPE_" << d.typeMacroBase << " \"-"
        << ap.name << "\", 0x" << llvm::utohexstr(mmioSize) << ");\n"
        << "    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio_"
        << ap.name << ");\n\n";
  if (hasPinOut) {
    c << "    /* Generic data-pin output lines: firmware drives them by writing\n"
      << "     * the device's data-output register; update_pins pushes them out. */\n"
      << "    qdev_init_gpio_out(DEVICE(obj), s->pin_out, " << pinOutWidth << ");\n";
  }
  if (hasPinIn) {
    c << "    /* Generic data-pin input lines: external drivers/testbench toggle\n"
      << "     * them; the handler injects into the model + refreshes IRQs/pins. */\n"
      << "    qdev_init_gpio_in(DEVICE(obj), ot_" << devName << "_qp_set_pin_in, "
      << pinInWidth << ");\n";
  }
  for (const auto &g : auxGroups) {
    if (g.outW)
      c << "    qdev_init_gpio_out_named(DEVICE(obj), s->aux_" << g.name
        << "_out, \"" << g.name << "-out\", " << g.outW << ");\n";
    if (g.inW)
      c << "    qdev_init_gpio_in_named(DEVICE(obj), ot_" << devName
        << "_qp_set_aux_" << g.name << "_in, \"" << g.name << "-in\", "
        << g.inW << ");\n";
  }
  if (hasPinOut || hasPinIn || !auxGroups.empty())
    c << "\n";
  if (hasChardev && hasRx) {
    c << "    /* Chardev RX FIFO buffer init.  qemu_chr_fe_set_handlers is\n"
      << "     * deferred to realize() because s->chr isn't bound to the\n"
      << "     * SoC's chardev backend until properties are applied. */\n"
      << "    fifo8_create(&s->rx_buf, "
      << d.typeMacroBase << "_RX_BUF_DEPTH);\n\n";
  }
  auto emitTies = [&]() {
    if (inputTies)
      for (NamedAttribute tie : inputTies) {
      auto valAttr = dyn_cast<IntegerAttr>(tie.getValue());
      if (!valAttr)
        continue;
      c << "    " << devName << "_set_" << tie.getName().getValue()
        << "(&s->core, 0x"
        << llvm::utohexstr(valAttr.getValue().getZExtValue()) << "u);\n";
    }
    // aux_pin_groups tie_ones: constant all-ones on declared input ports
    // (peripheral-side output-enable buses and the like).
    for (const auto &g : auxGroups)
      for (const auto &t : g.tieOnes) {
        if (t.second > 64)
          c << "    " << devName << "_set_" << t.first
            << "(&s->core, (~(__uint128_t)0) >> " << (128 - t.second)
            << ");\n";
        else if (t.second == 64)
          c << "    " << devName << "_set_" << t.first
            << "(&s->core, ~(uint64_t)0);\n";
        else
          c << "    " << devName << "_set_" << t.first
            << "(&s->core, (1ull << " << t.second << ") - 1);\n";
      }
  };
  bool anyAuxTies = false;
  for (const auto &g : auxGroups)
    if (!g.tieOnes.empty())
      anyAuxTies = true;
  if (inputTies && !inputTies.empty()) {
    c << "    /* Binding-declared input ties: constants on top-level inputs the\n"
      << "     * SoC model does not integrate (e.g. an always-acking EDN\n"
      << "     * entropy bus, a lifecycle-escalate line held at Off) so\n"
      << "     * handshake-waiting FSMs are not deadlocked.  Applied BEFORE\n"
      << "     * the reset pulse as well: sparse security FSMs sample these\n"
      << "     * on the reset-release tick and latch a terminal error state\n"
      << "     * if a tied line still reads its (illegal) zero init. */\n";
    emitTies();
  } else if (anyAuxTies) {
    emitTies();
  }
  c << "    /* Pulse reset to commit RESVALs into every prim_subreg.\n"
    << "     * Pattern in generated code:  q = (~rst_ni) ? RESVAL : keep.\n"
    << "     * C-init leaves rst_ni at 0, so a settle round with rst\n"
    << "     * active forces q := RESVAL across every register.  Then\n"
    << "     * release reset by setting rst_ni high.  Without this pulse,\n"
    << "     * registers like REGWEN (RESVAL=1) stay at their C init=0. */\n"
    << "    " << devName << "_reset(&s->core);\n";
  if ((inputTies && !inputTies.empty()) || anyAuxTies) {
    emitTies();
    c << "    " << devName << "_settle(&s->core);\n";
  }
  if (!i2cResetWrites.empty()) {
    c << "    /* Binding-declared simulation defaults.  These are ordinary MMIO\n"
      << "     * writes, so firmware may replace them exactly as on hardware. */\n";
    for (auto [offset, value] : i2cResetWrites)
      c << "    " << devName << "_write(&s->core, 0x"
        << llvm::utohexstr(offset) << "u, 0x" << llvm::utohexstr(value)
        << "u, 4);\n";
  }
  c << "}\n\n";

  // finalize
  if (d.keySinkIf)
    c << "/* keymgr sideload sink: accept the pushed key silently — sideload\n"
      << " * key material is not modeled (the sink link must exist or the\n"
      << " * keymgr asserts at boot). */\n"
      << "static void ot_" << devName
      << "_qp_push_key(OtKeySinkIf *ifd, const uint8_t *share0,\n"
      << "              const uint8_t *share1, size_t key_len, bool valid)\n"
      << "{\n"
      << "    (void)ifd; (void)share0; (void)share1; (void)key_len; (void)valid;\n"
      << "}\n\n";

  c << "static void ot_" << devName << "_qp_finalize(Object *obj)\n"
    << "{\n";
  if (hasRx) {
    c << "    " << d.structName << " *s = " << d.typeMacroBase << "(obj);\n"
      << "    fifo8_destroy(&s->rx_buf);\n";
  } else {
    c << "    (void)obj;\n";
  }
  c << "}\n\n";

  // class_init
  c << "static void ot_" << devName << "_qp_class_init(ObjectClass *klass, const void *data)\n"
    << "{\n"
    << "    DeviceClass *dc = DEVICE_CLASS(klass);\n"
    << "    (void)data;\n\n"
    << "    dc->realize = ot_" << devName << "_qp_realize;\n"
    << "    device_class_set_props(dc, ot_" << devName << "_qp_properties);\n"
    << "    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);\n";
  if (d.keySinkIf)
    c << "\n    OtKeySinkIfClass *kc = OT_KEY_SINK_IF_CLASS(klass);\n"
      << "    kc->push_key = ot_" << devName << "_qp_push_key;\n";
  c << "}\n";
}

//===----------------------------------------------------------------------===//
// Legacy APB Mapping Extraction (Fallback)
//===----------------------------------------------------------------------===//

/// Extract APB register mappings from IR attributes or use default GPIO layout
static std::vector<clk_analysis::APBRegisterMapping>
extractAPBMappings(hw::HWModuleOp topModule, ModuleOp mod) {
  std::vector<clk_analysis::APBRegisterMapping> mappings;

  // Try to get from IR attribute
  if (auto apbAttr = topModule->getAttrOfType<ArrayAttr>("qemu.apb_mappings")) {
    for (Attribute elem : apbAttr) {
      auto dictAttr = dyn_cast<DictionaryAttr>(elem);
      if (!dictAttr) continue;

      clk_analysis::APBRegisterMapping mapping;

      if (auto addrAttr = dictAttr.getAs<IntegerAttr>("address")) {
        mapping.address = addrAttr.getInt();
      }
      if (auto nameAttr = dictAttr.getAs<StringAttr>("register")) {
        mapping.registerName = nameAttr.getValue().str();
      }
      if (auto widthAttr = dictAttr.getAs<IntegerAttr>("bitWidth")) {
        mapping.bitWidth = widthAttr.getInt();
      }
      if (auto writableAttr = dictAttr.getAs<BoolAttr>("writable")) {
        mapping.isWritable = writableAttr.getValue();
      }
      if (auto readableAttr = dictAttr.getAs<BoolAttr>("readable")) {
        mapping.isReadable = readableAttr.getValue();
      }
      if (auto w1cAttr = dictAttr.getAs<BoolAttr>("isW1C")) {
        mapping.isW1C = w1cAttr.getValue();
      }

      mappings.push_back(mapping);
    }
  }

  return mappings;
}

/// Detect address conflicts in APB mappings
static std::vector<clk_analysis::AddressConflict>
detectAddressConflicts(const std::vector<clk_analysis::APBRegisterMapping>& mappings) {
  std::vector<clk_analysis::AddressConflict> conflicts;

  std::map<uint32_t, std::vector<std::string>> addrToRegs;
  for (const auto& m : mappings) {
    addrToRegs[m.address].push_back(m.registerName);
  }

  for (const auto& pair : addrToRegs) {
    if (pair.second.size() > 1) {
      clk_analysis::AddressConflict conflict;
      conflict.address = pair.first;
      conflict.registerNames = pair.second;
      conflicts.push_back(conflict);
    }
  }

  return conflicts;
}

//===----------------------------------------------------------------------===//
// QEMUEmitCPass Implementation
//===----------------------------------------------------------------------===//

struct QEMUEmitCPass
    : public ::impl::QEMUEmitCBase<QEMUEmitCPass> {
  using QEMUEmitCBase::QEMUEmitCBase;

  void runOnOperation() override {
    ModuleOp mod = getOperation();

    llvm::errs() << "\n";
    llvm::errs() << "========================================\n";
    llvm::errs() << "QEMU C Code Emission Pass (v2 - Bus-Txn Driven)\n";
    llvm::errs() << "========================================\n";

    // Step 1: Find the public top module
    hw::HWModuleOp topModule = nullptr;
    mod.walk([&](hw::HWModuleOp hwMod) {
      if (!hwMod.isPrivate()) {
        if (!topModule) {
          topModule = hwMod;
        }
      }
    });

    if (!topModule) {
      llvm::errs() << "Error: No public hw.module found\n";
      return signalPassFailure();
    }

    std::string devName = deviceName.empty() ? topModule.getName().str() : std::string(deviceName);
    llvm::errs() << "Device name: " << devName << "\n";
    llvm::errs() << "Top module: @" << topModule.getName() << "\n";

    // Validate the complete catalog before creating any output files. A supplied
    // project catalog replaces the default; names never leak across projects.
    std::string catalogPath = deviceCatalog.empty()
                                  ? QP_DEFAULT_DEVICE_CATALOG
                                  : std::string(deviceCatalog);
    auto catalog = qemu_passes::DeviceCatalog::load(catalogPath);
    if (!catalog) {
      mod.emitError() << "qemu-emit-c: " << llvm::toString(catalog.takeError());
      return signalPassFailure();
    }
    unsigned inferredIrqs = 0;
    if (auto bp = topModule->getAttrOfType<DictionaryAttr>("qemu.irq_blueprint"))
      if (auto count = bp.getAs<IntegerAttr>("irq_count")) {
        int64_t n = count.getInt();
        if (n < 0 || n > 32) {
          mod.emitError("qemu-emit-c: irq_blueprint irq_count must be in [0, 32]");
          return signalPassFailure();
        }
        inferredIrqs = static_cast<unsigned>(n);
      }
    auto resolvedShim = catalog->resolve(topModule.getName(), devName, inferredIrqs);
    if (!resolvedShim) {
      mod.emitError() << "qemu-emit-c: " << llvm::toString(resolvedShim.takeError());
      return signalPassFailure();
    }
    const DeviceShim &shimSel = *resolvedShim;
    llvm::errs() << "  [device-catalog] " << catalogPath << ": @"
                 << topModule.getName() << " -> " << shimSel.typeNameMacro
                 << " (irqs=" << shimSel.irqCount << ")\n";

    qemu_passes::GenericSysBusConfig genericConfig;
    const bool genericBackend = shimSel.backend == "generic-sysbus";
    auto irqOutputs = topModule->getAttrOfType<ArrayAttr>("qemu.irq_outputs");
    if (irqOutputs && irqOutputs.size() != shimSel.irqCount) {
      mod.emitError("qemu-emit-c: IRQ count disagrees with irq_outputs mapping");
      return signalPassFailure();
    }
    if (!genericBackend && (irqOutputs || topModule->hasAttr("qemu.model_reset") ||
                            topModule->hasAttr("qemu.bus_controls"))) {
      mod.emitError("qemu-emit-c: port IRQ/reset/bus_controls bindings require generic-sysbus");
      return signalPassFailure();
    }
    if (genericBackend) {
      if (shimSel.irqCount && !irqOutputs) {
        mod.emitError("qemu-emit-c: generic-sysbus requires irq_outputs for each declared IRQ");
        return signalPassFailure();
      }
      for (StringRef attr : {"qemu.chardev_blueprint",
                            "qemu.out_lines_blueprint", "qemu.spi_slave_blueprint",
                            "qemu.spi_master_blueprint", "qemu.bus_master_blueprint",
                            "qemu.i2c_wire_blueprint", "qemu.alert_in_blueprint",
                            "qemu.aux_pin_groups"}) {
        if (topModule->hasAttr(attr)) {
          mod.emitError() << "qemu-emit-c: generic-sysbus does not yet implement " << attr;
          return signalPassFailure();
        }
      }
      for (const auto &p : shimSel.properties) {
        if (p.nameStr == "OT_COMMON_DEV_ID" || p.macro == "DEFINE_PROP_CHR" ||
            p.fieldName == "pump" || p.fieldName == "deadline" || p.fieldName == "phase") {
          mod.emitError("qemu-emit-c: incompatible generic-sysbus property");
          return signalPassFailure();
        }
      }
      auto portWidth = [&](StringRef name, bool output) -> unsigned {
        for (auto p : topModule.getPortList())
          if (p.getName() == name && (p.dir == hw::ModulePort::Direction::Output) == output)
            if (auto t = dyn_cast<IntegerType>(p.type)) return t.getWidth();
        return 0;
      };
      if (auto pins = topModule->getAttrOfType<DictionaryAttr>("qemu.pin_io_blueprint")) {
        auto pinRole = [&](StringRef role, bool output, std::string &field,
                           unsigned &width) -> bool {
          auto port = pins.getAs<StringAttr>((role + "_port").str());
          if (!port) return true;
          width = portWidth(port.getValue(), output);
          if (!width || width > 64) return false;
          field = sanitizeName(port.getValue());
          return true;
        };
        if (!pinRole("data_in", false, genericConfig.pinInput, genericConfig.pinInputWidth) ||
            !pinRole("data_out", true, genericConfig.pinOutput, genericConfig.pinOutputWidth) ||
            !pinRole("output_enable", true, genericConfig.pinEnable, genericConfig.pinEnableWidth) ||
            (genericConfig.pinEnableWidth &&
             genericConfig.pinEnableWidth != genericConfig.pinOutputWidth)) {
          mod.emitError("qemu-emit-c: pin_io requires integer ports <=64 bits and matching output/enable widths");
          return signalPassFailure();
        }
      }
      if (irqOutputs) {
        std::set<std::pair<std::string, unsigned>> used;
        for (Attribute a : irqOutputs) {
          auto entry = dyn_cast<DictionaryAttr>(a);
          auto port = entry ? entry.getAs<StringAttr>("port") : nullptr;
          auto bit = entry ? entry.getAs<IntegerAttr>("bit") : nullptr;
          unsigned width = port ? portWidth(port.getValue(), true) : 0;
          if (!width || width > 64 || !bit || bit.getInt() < 0 ||
              (uint64_t)bit.getInt() >= width ||
              !used.emplace(port.getValue().str(), (unsigned)bit.getInt()).second) {
            mod.emitError("qemu-emit-c: invalid or duplicate IRQ output port/bit");
            return signalPassFailure();
          }
          genericConfig.irqs.push_back({sanitizeName(port.getValue()), (unsigned)bit.getInt()});
        }
      }
      if (auto hz = topModule->getAttrOfType<IntegerAttr>("qemu.timer_pump")) {
        if (hz.getInt() < 1 || hz.getInt() > 1000000000) {
          mod.emitError("qemu-emit-c: generic timer.pump_hz must be in [1, 1000000000]");
          return signalPassFailure();
        }
        genericConfig.pumpHz = hz.getInt();
      }
      if (auto reset = topModule->getAttrOfType<DictionaryAttr>("qemu.model_reset")) {
        auto port = reset.getAs<StringAttr>("port");
        auto active = reset.getAs<IntegerAttr>("active_level");
        if (!port || portWidth(port.getValue(), false) != 1 || !active ||
            active.getValue().getLimitedValue() > 1) {
          mod.emitError("qemu-emit-c: invalid reset declaration");
          return signalPassFailure();
        }
        genericConfig.resetPort = sanitizeName(port.getValue());
        genericConfig.resetActive = active.getValue().getLimitedValue();
      }
      auto readInputs = [&](DictionaryAttr dict,
                            qemu_passes::GenericSysBusConfig::Inputs &values) -> bool {
        if (!dict) return true;
        for (auto entry : dict) {
          auto val = dyn_cast<IntegerAttr>(entry.getValue());
          unsigned width = portWidth(entry.getName().getValue(), false);
          if (!val || !width || width > 63 || val.getInt() < 0 ||
              (uint64_t)val.getInt() >= (uint64_t(1) << width)) return false;
          values.emplace_back(sanitizeName(entry.getName()), val.getInt());
        }
        return true;
      };
      bool validInputs = readInputs(topModule->getAttrOfType<DictionaryAttr>("qemu.input_ties"), genericConfig.ties);
      if (auto controls = topModule->getAttrOfType<DictionaryAttr>("qemu.bus_controls")) {
        validInputs &= readInputs(controls.getAs<DictionaryAttr>("read"), genericConfig.readInputs);
        validInputs &= readInputs(controls.getAs<DictionaryAttr>("write"), genericConfig.writeInputs);
        validInputs &= readInputs(controls.getAs<DictionaryAttr>("idle"), genericConfig.idleInputs);
      }
      if (!validInputs) {
        mod.emitError("qemu-emit-c: invalid generic input binding");
        return signalPassFailure();
      }
    }

    // Step 2: Create registry (FLAT naming)
    FlatSignalRegistry registry;

    // Step 3: Extract Bus Interface Mappings from Phase 1
    llvm::errs() << "\nExtracting bus interface mappings from qemu.functional_txns...\n";
    llvm::StringSet<> bipSignals;
    auto bips = extractBusInterfaceMappings(mod, bipSignals);

    // Supplying a profile is an explicit request to use its bus contract.
    // Never turn a broken/empty contract into a successful 114-byte TODO
    // stub: that masks model-generation failures in batch jobs.
    const bool hasDeclaredBusProfile = mod->hasAttr("qemu.bus_profile");
    if (hasDeclaredBusProfile && bips.empty()) {
      mod.emitError("qemu-emit-c: a bus profile was supplied, but it produced "
                    "zero functional transactions");
      return signalPassFailure();
    }

    llvm::errs() << "  Found " << bips.size() << " bus transaction candidates\n";
    for (size_t i = 0; i < bips.size(); ++i) {
      const auto &b = bips[i];
      llvm::errs() << "    [" << i << "] "
                   << (b.kind == BusInterfaceMapping::READ ? "READ" :
                       b.kind == BusInterfaceMapping::WRITE ? "WRITE" : "UNKNOWN")
                   << " conf=" << llvm::format("%.2f", b.confidence)
                   << (b.weak ? " [WEAK]" : "")
                   << (b.isBusWrite ? " [BUS]" : "")
                   << "\n";
      if (!b.addrSignal.empty())
        llvm::errs() << "         addr=" << b.addrSignal << "\n";
      if (!b.wdataSignal.empty())
        llvm::errs() << "         wdata=" << b.wdataSignal << "\n";
      if (!b.rdataSignal.empty())
        llvm::errs() << "         rdata=" << b.rdataSignal << "\n";
    }

    // Step 4: Merge BIPs into a unified bus interface
    MergedBusInterface mergedBus = mergeBusInterfaces(bips);
    if (!deviceCatalog.empty() && !mergedBus.valid) {
      mod.emitError("qemu-emit-c: --device-catalog requires usable bus "
                    "transactions; supply a bus profile or run inference");
      return signalPassFailure();
    }
    if (hasDeclaredBusProfile && !mergedBus.valid) {
      mod.emitError("qemu-emit-c: declared bus transactions do not form a "
                    "usable address/read-or-write interface");
      return signalPassFailure();
    }
    uint64_t mmioSizeV = computeMmioSize(mod, mergedBus.addrSignal);
    // Second evidence source: the address-decode offsets themselves (rv_plic
    // parks THRESHOLD/CC at 0x200000 and MSIP at 0x4000000 behind narrow
    // extracts — the extract-width heuristic alone reports 0x1000).
    {
      uint64_t mo = qemu_passes::maxAddrDecodeOffset(mod);
      while (mmioSizeV <= mo)
        mmioSizeV <<= 1;
    }
    const uint64_t mmioSize = shimSel.mmioSize.value_or(mmioSizeV);
    genericConfig.mmioSize = mmioSize;
    llvm::errs() << "  MMIO region size: 0x" << llvm::utohexstr(mmioSize)
                 << (shimSel.mmioSize ? " (from device catalog)\n"
                                      : " (from the address-field decode width)\n");

    bool useBusTxnPath = mergedBus.valid;
    llvm::errs() << "\nMerged bus interface: "
                 << (useBusTxnPath ? "VALID" : "INVALID (falling back to legacy)")
                 << "\n";
    if (useBusTxnPath) {
      llvm::errs() << "  addr_signal  = " << mergedBus.addrSignal
                   << " (" << mergedBus.addrWidth << "-bit)\n";
      llvm::errs() << "  wdata_signal = "
                   << (mergedBus.wdataSignal.empty() ? "(none)" : mergedBus.wdataSignal)
                   << " (" << mergedBus.wdataWidth << "-bit)\n";
      llvm::errs() << "  rdata_signal = "
                   << (mergedBus.rdataSignal.empty() ? "(none)" : mergedBus.rdataSignal)
                   << " (" << mergedBus.rdataWidth << "-bit)\n";
    }

    // Step 5: Build SymbolTable + register signals + accumulate
    // qemu.comb_logic via the instance tree (Phase 2.a).
    //
    // We register the active mergedBus BIP names FIRST so the
    // canonical sanitized form is locked in before renderModule's
    // port/sig walk sees them — top-level prefix is "" so BIP names
    // (e.g. `tl_i_a_address`) stay unchanged, matching what the MMIO
    // callbacks inject.  Phase 2.a does NOT yet bridge sub-instance
    // BIP names; if FunctionalBusTxnInferPass attached BIPs at a
    // sub-module level (currently rare for OT TL-UL where bus signals
    // surface at the top), those names would be misaligned.
    auto registerActiveBip = [&](StringRef name, unsigned width) {
      if (!name.empty())
        registry.registerSignal(name, width);
    };
    registerActiveBip(mergedBus.addrSignal,   mergedBus.addrWidth  > 0 ? mergedBus.addrWidth  : 32);
    registerActiveBip(mergedBus.wdataSignal,  mergedBus.wdataWidth > 0 ? mergedBus.wdataWidth : 32);
    registerActiveBip(mergedBus.rdataSignal,  mergedBus.rdataWidth > 0 ? mergedBus.rdataWidth : 32);
    registerActiveBip(mergedBus.enableSignal, 1);
    registerActiveBip(mergedBus.maskSignal,   4);

    llvm::errs() << "\nRendering hw.instance tree from @"
                 << topModule.getName() << " (Phase 2.a — per-instance prefix)...\n";

    SymbolTable symTable(mod);
    std::vector<clk_analysis::CombinationalAssignment> combLogicEntries;
    std::vector<clk_analysis::CombinationalAssignment> seqLogicEntries;
    std::vector<std::pair<std::string, uint64_t>> backingStores;
    EmitCtx ctx{/*instancePath=*/std::string(), registry,
                combLogicEntries, seqLogicEntries, &backingStores};
    renderModule(topModule, ctx, symTable);

    // Bridge the TOP module's own scalar boundary outputs (cio_*_o data pins,
    // intr_*_o, ...) — renderModule only bridges CHILD instance outputs, never
    // the root's own hw.output, so these were left zero-init.  Generic across
    // devices; struct bus outputs (tl_o) are left to applyTLULOverride below.
    emitTopOutputBridge(topModule, ctx);

    // After Phase 2.a/b render, the registry knows about TL-UL leaf
    // fields like `tl_i_a_data` / `u_reg_tl_o_d_data` (created by the
    // struct-walker bridges).  applyTLULOverride patches mergedBus to
    // reference those instead of the heuristic guesses from
    // FunctionalBusTxnInferPass — see the function comment for why.
    {
      MergedBusInterface before = mergedBus;  // for log diff
      if (qemu_passes::usesOpenTitanRTLAdapter(mod) && !hasDeclaredBusProfile)
        applyTLULOverride(mergedBus, topModule, registry);
      auto report = [&](const char *role, const std::string &was,
                         const std::string &now) {
        if (was != now) {
          llvm::errs() << "  [TL-UL override] " << role << ": '" << was
                       << "' -> '" << now << "'\n";
        }
      };
      report("addr",   before.addrSignal,   mergedBus.addrSignal);
      report("wdata",  before.wdataSignal,  mergedBus.wdataSignal);
      report("rdata",  before.rdataSignal,  mergedBus.rdataSignal);
      if (!mergedBus.validSignal.empty())
        llvm::errs() << "  [TL-UL override] valid:  '"
                     << mergedBus.validSignal << "' (NEW)\n";
      if (!mergedBus.opcodeSignal.empty())
        llvm::errs() << "  [TL-UL override] opcode: '"
                     << mergedBus.opcodeSignal << "' (NEW)\n";

      // TL-UL convention detected → suppress the cmd-integrity check.
      // Without this, every read returns -1 and every write trips
      // wr_err because our simulated TL-UL master doesn't compute
      // the OT-specific cmd_intg / data_intg ECC.  See
      // suppressTLULIntegrityCheck for details.
      if (qemu_passes::usesOpenTitanRTLAdapter(mod) && !mergedBus.validSignal.empty()) {
        size_t before = combLogicEntries.size();
        suppressTLULIntegrityCheck(combLogicEntries);
        (void)before;
        llvm::errs() << "  [TL-UL override] integrity-check suppressed "
                        "in combLogic\n";
      }
    }

    // update_state() is emitted as straight-line C, so place every producer
    // before consumers of its target signal.  This reduces dependence on the
    // outer fixed-point settle loop and makes acyclic combinational cones settle
    // in one update_state() call.  Cyclic SCCs retain their original order.
    CombTopoSortStats topoStats =
        stableTopologicalSortCombLogic(combLogicEntries);
    llvm::errs() << "  Comb dependency order: "
                 << topoStats.dependencyEdges << " edge(s), "
                 << topoStats.reorderedAssignments << " assignment(s) moved";
    if (topoStats.cyclicComponents > 0)
      llvm::errs() << ", " << topoStats.cyclicComponents << " cyclic SCC(s), "
                   << topoStats.cyclicAssignments << " assignment(s) retained "
                      "in source order";
    llvm::errs() << "\n";

    llvm::errs() << "  Registered signals: " << registry.getSignals().size() << "\n";
    llvm::errs() << "  Comb-logic entries (post-prefix): "
                 << combLogicEntries.size() << "\n";
    llvm::errs() << "  Seq-logic entries  (post-prefix, ACCUMULATE filtered): "
                 << seqLogicEntries.size() << "\n";
    llvm::errs() << "  BIP signals (extracted, union-of-modules): "
                 << bipSignals.size() << "\n";

    // ACCUMULATE counters: walked via the same instance tree so each
    // counter's state-struct field is independent per instance (matching
    // renderModule's prefixing).  Replaces the old module-flat walk.
    llvm::errs() << "\nProcessing ACCUMULATE counters (via instance tree)...\n";
    auto counters = collectAccumulateCounters(topModule, symTable, registry);
    llvm::errs() << "  Found " << counters.size() << " ACCUMULATE counter(s)\n";
    for (const auto &c : counters) {
      llvm::errs() << "    " << c.sanitizedName
                   << " (orig='" << c.originalName << "', step=" << c.step
                   << ", " << c.bitWidth << "-bit)\n";
    }

    // Phase 2.a: combLogic is now what renderModule produced
    // (already prefixed and accumulated from the instance tree).  The
    // pre-2.a flat module-walk + module-level reachability filter are
    // gone — renderModule's recursion is itself the reachability filter
    // (modules not transitively instantiated from @top are simply not
    // visited), and per-instance prefixing prevents the multi-instance
    // alias problem that the flat walk had.
    //
    // The `--no-live-target-prune` option is preserved for ABI but no
    // longer changes behaviour: there is no parallel "include all
    // modules" code path anymore.  Set-but-ignored is logged below.
    // REPRESENTATION COHERENCE.
    //
    // A wide port and its exploded leaves are the SAME RTL value under two C
    // names: `uint64_t u_aes_core_keymgr_key_i_key_0_[4]` and
    // `uint32_t u_aes_core_keymgr_key_i_key_0__0_ .. __7_` both exist, the
    // instance bridge fills the ARRAY, and the module body reads the SCALARS.
    // Nothing connects them, nothing complains, and the value the consumer
    // sees is zero forever.  That is the AES sideload key; the same shape
    // accounts for 115 of the 131 residual never-written fields (pinmux's pad
    // attributes 64, alert_handler's escalation state 35, aes 16).
    //
    // The rule is narrow on purpose: fill leaves ONLY when the wide field is
    // written, the leaves are written by nothing, and their widths tile the
    // wide value exactly.  Any of those failing means the two names are not
    // the same value and this must keep its hands off.
    {
      llvm::StringSet<> written;
      auto noteWrites = [&](const std::vector<clk_analysis::CombinationalAssignment> &v) {
        for (const auto &a : v) {
          written.insert(a.targetSignal);
          // Wide fills are emitted as __RAW__ blocks naming their destination
          // inside the text, so the target field is not in targetSignal.
          for (const char *fn : {"qpw_wide_insert(s->", "memcpy(s->"}) {
            size_t p = 0;
            while ((p = a.expression.find(fn, p)) != std::string::npos) {
              size_t b = p + strlen(fn), e = b;
              while (e < a.expression.size() &&
                     (isalnum((unsigned char)a.expression[e]) ||
                      a.expression[e] == '_'))
                ++e;
              written.insert(a.expression.substr(b, e - b));
              p = e;
            }
          }
        }
      };
      noteWrites(combLogicEntries);
      noteWrites(seqLogicEntries);

      unsigned aliasGroups = 0, aliasFields = 0;
      for (const auto &kv : registry.getSignals()) {
        const std::string &wide = kv.first;
        unsigned wideBits = kv.second.bitWidth;
        if (!kv.second.nWords || !wideBits || !written.count(wide))
          continue;
        llvm::SmallVector<std::pair<std::string, unsigned>, 16> leaves;
        uint64_t covered = 0;
        bool ok = true;
        for (unsigned k = 0;; ++k) {
          std::string leaf = wide + "_" + std::to_string(k) + "_";
          auto it = registry.getSignals().find(leaf);
          if (it == registry.getSignals().end())
            break;
          if (written.count(leaf) || it->second.nWords ||
              !it->second.bitWidth || it->second.bitWidth > 64) {
            ok = false;
            break;
          }
          leaves.push_back({leaf, it->second.bitWidth});
          covered += it->second.bitWidth;
          if (covered > wideBits) { ok = false; break; }
        }
        if (!ok || leaves.empty() || covered != wideBits)
          continue;
        uint64_t off = 0;
        for (auto &lf : leaves) {
          clk_analysis::CombinationalAssignment ca;
          ca.targetSignal = lf.first;
          ca.expression = "qpw_wide_extract(s->" + wide + ", " +
                          std::to_string(kv.second.nWords) + ", " +
                          std::to_string(off) + ", " +
                          std::to_string(lf.second) + ")";
          ca.bitWidth = lf.second;
          combLogicEntries.push_back(std::move(ca));
          off += lf.second;
          ++aliasFields;
        }
        ++aliasGroups;
        llvm::errs() << "  [ALIAS FILL] " << wide << " -> " << leaves.size()
                     << " leaf field(s) the body reads but nothing wrote\n";
      }
      if (aliasGroups)
        llvm::errs() << "  [ALIAS FILL] " << aliasGroups << " group(s), "
                     << aliasFields << " field(s)\n";

      // THE MIRROR: leaves written, packed form read.
      //
      // alert_handler's hw2reg.wrap.class_accum_cnt is four 16-bit counters.
      // The per-class writers fill `..._accum_cnt_0_ .. _3_`, and the four
      // class read-back paths slice the PACKED `..._accum_cnt` — which
      // nothing wrote, and which was registered 16 bits wide because the only
      // widths ever seen for that name came from 16-bit extracts.  So classd
      // did `(uint16_t) >> 48`, which is not merely zero but undefined.  Same
      // for esc_cnt and esc_state: the escalation counters and state a driver
      // reads back were all zero.
      //
      // Same narrowness as the fill direction: only when the packed form is
      // written by nothing, every leaf 0..n-1 exists AND is written, they are
      // equal width, and they tile something no wider than a C scalar.
      unsigned packGroups = 0, packFields = 0;
      for (const auto &kv : registry.getSignals()) {
        const std::string &packedName = kv.first;
        if (written.count(packedName) || kv.second.nWords)
          continue;
        llvm::SmallVector<std::string, 8> leaves;
        unsigned leafW = 0;
        bool ok = true;
        for (unsigned k = 0;; ++k) {
          std::string leaf = packedName + "_" + std::to_string(k) + "_";
          auto it = registry.getSignals().find(leaf);
          if (it == registry.getSignals().end())
            break;
          if (!written.count(leaf) || it->second.nWords ||
              !it->second.bitWidth || it->second.bitWidth > 64) {
            ok = false;
            break;
          }
          if (!leafW)
            leafW = it->second.bitWidth;
          else if (it->second.bitWidth != leafW) {
            ok = false;
            break;
          }
          leaves.push_back(leaf);
        }
        uint64_t total = (uint64_t)leaves.size() * leafW;
        if (!ok || leaves.size() < 2 || total > 64 ||
            kv.second.bitWidth > total)
          continue;
        std::string packed;
        for (size_t li = 0; li < leaves.size(); ++li) {
          std::string term = "(((uint64_t)(s->" + leaves[li] + ")) << " +
                             std::to_string(li * leafW) + ")";
          packed = packed.empty() ? term : (packed + " | " + term);
        }
        registry.registerSignal(packedName, (unsigned)total,
                                /*authoritative=*/true);
        clk_analysis::CombinationalAssignment ca;
        ca.targetSignal = packedName;
        ca.expression = "(" + packed + ")";
        ca.bitWidth = (unsigned)total;
        combLogicEntries.push_back(std::move(ca));
        ++packGroups;
        packFields += leaves.size();
        llvm::errs() << "  [PACK FILL] " << packedName << " <- "
                     << leaves.size() << " leaf field(s) nothing packed\n";
      }
      if (packGroups)
        llvm::errs() << "  [PACK FILL] " << packGroups << " group(s), "
                     << packFields << " leaf field(s)\n";
    }

    auto &combLogic = combLogicEntries;
    unsigned combCount = combLogic.size();
    bool foundCombAttr = !combLogic.empty();

    if (this->noLiveTargetPrune) {
      llvm::errs() << "  [INFO] --no-live-target-prune is now a no-op "
                      "post-Phase-2.a (renderModule does not over-include).\n";
    }

    llvm::errs() << "\nCombinational assignments after instance-tree render:\n";
    for (const auto &a : combLogic) {
      llvm::errs() << "    " << a.targetSignal << " = "
                   << comb_translator::brief(a.expression) << "\n";
    }
    llvm::errs() << "  Combinational assignments: " << combCount << "\n";
    if (!foundCombAttr) {
      llvm::errs() << "  WARNING: No qemu.comb_logic attribute reachable from @"
                   << topModule.getName() << ".\n"
                   << "           Did you run --comb-logic-extract before --qemu-emit-c?\n"
                   << "           update_state() will be empty.\n";
    }

    // Step 6.5: Collect ACCUMULATE counters (written by DrvClassificationPass).
    // These are sequential `reg = prb(reg) ± step` drvs inside llhd.process;
    // we emit ptimer-backed counter logic for each one.  Counters that we
    // find but cannot wire (e.g. no writable MMIO path) are still recorded —
    // they get a live ptimer but will never be reloaded; Phase 2 can refine.
    // (counters already collected earlier — see "Processing ACCUMULATE counters" above)

    // Step 7: Generate output files
    std::string baseDir = outputDir.empty() ? "qemu-passes/output" : std::string(outputDir);
    std::string outDir = baseDir + "/" + devName;
    llvm::sys::fs::create_directories(outDir);

    std::string headerPath = outDir + "/" + devName + ".h";
    std::string sourcePath = outDir + "/" + devName + ".c";

    llvm::errs() << "\nGenerating output files...\n";
    llvm::errs() << "  Header: " << headerPath << "\n";
    llvm::errs() << "  Source: " << sourcePath << "\n";

    if (useBusTxnPath) {
      // ============================================================
      // NEW PATH: Protocol-agnostic generation driven by bus txn info
      // ============================================================
      llvm::errs() << "  Mode: Protocol-agnostic (bus-txn driven)\n";

      // Phase 2.d: enumerate top-level non-BIP input ports → setter API.
      auto inputSetters = collectInputSetters(topModule, devName,
                                              bipSignals, registry);
      llvm::errs() << "  Input setters: " << inputSetters.size() << "\n";
      for (const auto &e : inputSetters) {
        llvm::errs() << "    " << e.setterFnName << " ("
                     << e.bitWidth << "-bit)\n";
      }

      // Timer pump opt-in (binding's `timer` block).  A free-running timer keeps
      // virtual time via the shim's periodic ptimer -> advance_tick.  This is by
      // DECLARATION only (structurally indistinguishable from e.g. i2c timeout
      // counters), and is independent of whether the device has ACCUMULATE
      // counters — aon_timer's count is a plain seq register but still needs the
      // pump to advance while firmware is parked.
      bool timerPump = topModule->hasAttr("qemu.timer_pump");

      // Declared benign reset values for undriven top inputs (binding's
      // `input_resets` block) → emitted at the top of <dev>_reset().
      std::vector<std::pair<std::string, int64_t>> inputResets;
      if (auto ir = topModule->getAttrOfType<DictionaryAttr>("qemu.input_resets")) {
        for (const auto &na : ir)
          if (auto v = dyn_cast<IntegerAttr>(na.getValue()))
            inputResets.emplace_back(na.getName().str(), v.getInt());
      }

      std::vector<AuxBusPort> auxPorts;
      if (qemu_passes::usesOpenTitanRTLAdapter(mod))
        auxPorts = detectAuxTlPorts(topModule, mergedBus);
      if (genericBackend) {
        if (!auxPorts.empty() || !backingStores.empty() || !counters.empty()) {
          mod.emitError("qemu-emit-c: generic-sysbus currently supports a single MMIO core without legacy ptimer counters or backing stores");
          return signalPassFailure();
        }
        for (auto &irq : genericConfig.irqs)
          if (!registry.getSignals().count(irq.field)) {
            mod.emitError() << "qemu-emit-c: IRQ field missing from generated core: " << irq.field;
            return signalPassFailure();
          }
      }
      // Generate header
      {
        std::error_code EC;
        llvm::raw_fd_ostream headerFile(headerPath, EC);
        if (EC) {
          llvm::errs() << "Error: Cannot create " << headerPath
                       << ": " << EC.message() << "\n";
          return signalPassFailure();
        }
        // Phase 2.a: header gen no longer prunes by liveTargets — the
        // instance-tree walk in renderModule is itself the pruning step
        // (modules unreachable from @top aren't visited, hence not in the
        // registry).  The trailing args are retained for ABI stability.
        llvm::StringSet<> emptyLive;
        generateProtocolAgnosticHeader(headerFile, devName, mergedBus,
                                       bipSignals, registry.getSignals(),
                                       counters, emptyLive,
                                       /*liveTargetPruneEnabled=*/true,
                                       inputSetters, timerPump,
                                       /*hasBusMaster=*/topModule->hasAttr("qemu.bus_master_blueprint"),
                                       auxPorts,
                                       /*hasBackingStores=*/!backingStores.empty());
      }

      // Generate source
      {
        std::error_code EC;
        llvm::raw_fd_ostream sourceFile(sourcePath, EC);
        if (EC) {
          llvm::errs() << "Error: Cannot create " << sourcePath
                       << ": " << EC.message() << "\n";
          return signalPassFailure();
        }
        ArrayAttr busMasterBp =
            topModule->getAttrOfType<ArrayAttr>("qemu.bus_master_blueprint");
        if (busMasterBp)
          llvm::errs() << "  [bus_master] blueprint present ("
                       << busMasterBp.size() << " port(s)) — progress-attested settle + shim bridge\n";
        generateProtocolAgnosticSource(sourceFile, devName, mergedBus,
                                       combLogic, seqLogicEntries,
                                       registry.getSignals(),
                                       counters, inputSetters,
                                       timerPump, inputResets, mmioSize,
                                       /*hasBusMaster=*/busMasterBp != nullptr,
                                       auxPorts, backingStores,
                                       qemu_passes::usesOpenTitanRTLAdapter(mod) && !genericBackend,
                                       genericBackend ? &genericConfig : nullptr);
      }

      // Emit the QOM wrapper selected from the external project catalog.
      if (genericBackend) {
        if (auto error = qemu_passes::emitGenericSysBus(devName, shimSel, genericConfig, outDir)) {
          mod.emitError() << llvm::toString(std::move(error));
          return signalPassFailure();
        }
      } else {
        llvm::errs() << "  Emitting QP shim: " << outDir << "/"
                     << devName << "_qp_shim.{c,h}\n";
        // Look up the chardev blueprint attribute that
        // BackendCharDevDetectPass left on the top-level public module.
        // Pass it through so generateQpShim can emit chardev hookup
        // (`qemu_chr_fe_*` API calls) for character-device peripherals.
        DictionaryAttr chardevBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>(
                "qemu.chardev_blueprint")) {
          chardevBp = attr;
          llvm::errs() << "  [chardev] blueprint present — will emit "
                          "char-fe.h hookup in shim\n";
        }
        // Look up the IRQ blueprint (INTR_STATE/ENABLE/ALERT_TEST MMIO
        // offsets, IR-derived by BackendCharDevDetect Phase 4).  Pass it
        // through so generateQpShim emits generic PLIC/alert driving.
        DictionaryAttr irqBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>(
                "qemu.irq_blueprint")) {
          irqBp = attr;
          llvm::errs() << "  [irq] blueprint present — will emit PLIC/alert "
                          "driving in shim\n";
        }
        // Resolve each chardev FIFO's wptr/rptr wrap-counter fields from the
        // registry so the shim can advance occupancy discretely per push/pop
        // (makes depth -> rx_watermark / STATUS track real chardev traffic).
        ShimFifoPtrs fifoPtrs;
        if (chardevBp) {
          if (auto rxAttr = chardevBp.getAs<DictionaryAttr>("rx"))
            if (auto fi = rxAttr.getAs<StringAttr>("fifo_instance"))
              resolveFifoPtrs(registry, fi.getValue(), fifoPtrs.rxWptr,
                              fifoPtrs.rxRptr, fifoPtrs.rxMask, fifoPtrs.rxValid);
          if (auto txAttr = chardevBp.getAs<DictionaryAttr>("tx"))
            if (auto fi = txAttr.getAs<StringAttr>("fifo_instance"))
              resolveFifoPtrs(registry, fi.getValue(), fifoPtrs.txWptr,
                              fifoPtrs.txRptr, fifoPtrs.txMask, fifoPtrs.txValid);
          if (fifoPtrs.rxValid)
            llvm::errs() << "  [chardev] RX FIFO occupancy wired (" << fifoPtrs.rxWptr
                         << ")\n";
          if (fifoPtrs.txValid)
            llvm::errs() << "  [chardev] TX FIFO instant drain wired (" << fifoPtrs.txRptr
                         << " = " << fifoPtrs.txWptr << ")\n";
        }
        // Validate the optional system-loopback field against the registry —
        // this is the AUTHORITATIVE check (the binding loader can't see flattened
        // state-field names).  A declared-but-unresolvable field is a hard error.
        std::string loopbackField;
        if (chardevBp) {
          if (auto lb = chardevBp.getAs<StringAttr>("loopback_field")) {
            std::string san = sanitizeName(lb.getValue());
            if (registry.getSignals().count(san)) {
              loopbackField = san;
              llvm::errs() << "  [chardev] system-loopback wired on field '" << san
                           << "'\n";
            } else {
              llvm::errs() << "  [chardev] ERROR: loopback_field '" << lb.getValue()
                           << "' does not resolve to a model state field — "
                              "loopback NOT emitted\n";
            }
          }
        }
        // Look up the pin-I/O blueprint (generic data-pin bus roles, IR-derived
        // by BackendCharDevDetect Phase 5 OR a binding).  Pass it through so
        // generateQpShim emits qdev_init_gpio_in/out wiring.
        DictionaryAttr pinIoBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>(
                "qemu.pin_io_blueprint")) {
          pinIoBp = attr;
          llvm::errs() << "  [pin_io] blueprint present — will emit gpio in/out "
                          "wiring in shim\n";
        }
        // Virtual-time pump opt-in.  "This device is a free-running timer that
        // must keep time autonomously" is a SEMANTIC property that is NOT
        // structurally inferable — e.g. i2c's timeout counters feed
        // counter>=threshold comparators that drive interrupts exactly like a
        // timer, yet must NOT be pumped (they advance with bus traffic, not
        // wall-clock).  So it is declared, not detected: a binding's `timer`
        // block sets qemu.timer_pump (computed above as `timerPump`).  Absent
        // => no pump.  Note: independent of ACCUMULATE counters — a timer whose
        // count is a plain seq register (aon_timer) still needs the pump.
        DictionaryAttr spiSlaveBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>("qemu.spi_slave_blueprint")) {
          spiSlaveBp = attr;
          llvm::errs() << "  [spi_slave] blueprint present — will emit spidev transport in shim\n";
        }
        ArrayAttr outLinesShimBp;
        if (auto attr = topModule->getAttrOfType<ArrayAttr>("qemu.out_lines_blueprint")) {
          outLinesShimBp = attr;
          llvm::errs() << "  [out_lines] blueprint present — will emit output-line wiring in shim\n";
        }
        DictionaryAttr spiMasterBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>("qemu.spi_master_blueprint")) {
          spiMasterBp = attr;
          llvm::errs() << "  [spi_master] blueprint present — will emit SSI bridge in shim\n";
        }
        DictionaryAttr i2cWireBp;
        if (auto attr = topModule->getAttrOfType<DictionaryAttr>("qemu.i2c_wire_blueprint")) {
          i2cWireBp = attr;
          llvm::errs() << "  [i2c_wire] blueprint present — will emit I2CBus transport base in shim\n";
        }
        ArrayAttr busMasterShimBp =
            topModule->getAttrOfType<ArrayAttr>("qemu.bus_master_blueprint");
        generateQpShim(devName, shimSel, outDir, chardevBp, irqBp,
                       fifoPtrs, pinIoBp, loopbackField,
                       /*hasPump=*/timerPump, spiSlaveBp, mmioSize, spiMasterBp,
                       busMasterShimBp, outLinesShimBp, i2cWireBp,
                       topModule->getAttrOfType<DictionaryAttr>(
                           "qemu.alert_in_blueprint"),
                       topModule->getAttrOfType<DictionaryAttr>(
                           "qemu.input_ties"),
                       topModule->getAttrOfType<ArrayAttr>(
                           "qemu.aux_pin_groups"),
                       &auxPorts, backingStores.size());
      }

    } else {
      // ============================================================
      // LEGACY PATH: APB-mapping driven (for backward compatibility)
      // ============================================================
      llvm::errs() << "  Mode: Legacy APB-mapping driven\n";

      qemu_codegen::QEMUDeviceGenerator gen(devName);

      // Extract APB mappings
      auto apbMappings = extractAPBMappings(topModule, mod);
      if (apbMappings.empty()) {
        llvm::errs() << "  [WARNING] No APB mappings and no bus txns found.\n";
        llvm::errs() << "  Generated code will have empty MMIO callbacks.\n";
      }
      auto conflicts = detectAddressConflicts(apbMappings);
      gen.setAPBMappings(apbMappings);
      gen.setAddressConflicts(conflicts);

      // Add signals
      for (const auto& pair : registry.getSignals()) {
        const auto& info = pair.second;
        gen.addSimpleReg(info.sanitizedName, info.bitWidth);
      }

      gen.setCombinationalLogic(combLogic);

      // (Removed a legacy `portName.find("gpio")` per-device-name special-case
      // for the deprecated QEMUCodeGen path — pin I/O is now handled generically
      // by the role-based qemu.pin_io_blueprint in the active shim emitter.)

      // Generate using legacy QEMUCodeGen
      {
        std::error_code EC;
        llvm::raw_fd_ostream headerFile(headerPath, EC);
        if (EC) {
          llvm::errs() << "Error: Cannot create " << headerPath
                       << ": " << EC.message() << "\n";
          return signalPassFailure();
        }
        gen.generateHeader(headerFile);
      }
      {
        std::error_code EC;
        llvm::raw_fd_ostream sourceFile(sourcePath, EC);
        if (EC) {
          llvm::errs() << "Error: Cannot create " << sourcePath
                       << ": " << EC.message() << "\n";
          return signalPassFailure();
        }
        gen.generateSource(sourceFile);
      }
    }

    llvm::errs() << "\n========================================\n";
    llvm::errs() << "Summary:\n";
    llvm::errs() << "  Device: " << devName << "\n";
    llvm::errs() << "  State struct fields: " << registry.getSignals().size() << "\n";
    llvm::errs() << "  Bus txn candidates: " << bips.size() << "\n";
    llvm::errs() << "  Bus interface valid: " << (useBusTxnPath ? "YES" : "NO") << "\n";
    llvm::errs() << "  Combinational logic: " << combCount << "\n";
    // ACCUMULATE counters wired to ptimer only on the protocol-agnostic path.
    // The legacy stub path doesn't consume them (and is itself already dead).
    llvm::errs() << "  ACCUMULATE counters: " << counters.size()
                 << " (wired to ptimer: "
                 << (useBusTxnPath ? counters.size() : 0) << ")\n";
    llvm::errs() << "  Output: " << outDir << "/\n";
    llvm::errs() << "========================================\n";

    {
      size_t stateFieldCount = registry.getSignals().size();
      size_t bipCount = bips.size();
      size_t counterCount = counters.size();
      size_t wiredPtimer = useBusTxnPath ? counterCount : 0;
      std::string outDirCopy = outDir;
      std::string devNameCopy = devName;
      qemu_passes::writePassReport(
          "qemu_emit_c",
          [&,stateFieldCount,bipCount,counterCount,wiredPtimer,
           outDirCopy,devNameCopy,combCount,useBusTxnPath]
          (llvm::raw_ostream &os) {
            os << "QEMU C Emission — summary\n";
            os << "=========================\n";
            os << "Device:                  " << devNameCopy << "\n";
            os << "State-struct fields:     " << stateFieldCount << "\n";
            os << "Bus transaction candidates: " << bipCount << "\n";
            os << "Bus interface valid:     "
               << (useBusTxnPath ? "YES (protocol-agnostic)"
                                  : "NO (legacy stub path)")
               << "\n";
            os << "Combinational logic assignments: " << combCount << "\n";
            os << "ACCUMULATE counters:     " << counterCount
               << " (wired to ptimer: " << wiredPtimer << ")\n";
            os << "Output directory:        " << outDirCopy << "/\n";
          });
    }
  }
};

} // anonymous namespace
