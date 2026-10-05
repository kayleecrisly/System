//===- BusProfileResolvePass.cpp - Resolve bus_profile into a driving sequence ===//
//
// Pass 11 in the v2 13-step pipeline.  Reads the (already loaded and
// constraint-folded) `qemu.bus_profile` DictionaryAttr from the top
// ModuleOp, then for each declared bus transaction:
//
//   - WRITE: forward-trace from the wr_enable / addr / wdata role signals
//            into every register llhd.drv they sensitize.  Collect the
//            (target_register, address_match_expr, value_expr) tuples
//            into a `write_drive` array.
//
//   - READ:  forward-trace from the addr role and reach the rdata role's
//            drv.  Capture the per-address-hit value expression chain
//            (or the path-conditioned mux) into a `read_drive` array.
//
// The pass replaces the old TLULControlInferencePass + FunctionalBusTxnInferPass
// pair.  Both of those used heuristic structural pattern matching; this pass
// is schema-driven: the user-supplied bus.json declares what counts as a bus
// transaction, and we materialise the IR-level driving sequence.
//
// Output:  `qemu.bus_profile_resolved` DictionaryAttr on the top ModuleOp.
//
// Schema of the resolved attribute (DictionaryAttr):
//   {
//     "top_module": StringAttr,
//     "transactions": ArrayAttr<DictAttr>, one entry per resolved txn:
//       {
//         "kind":           StringAttr,    // "READ" / "WRITE"
//         "guard":          ArrayAttr<DictAttr>, copy of bus_profile guard
//                                            (role/op/value) for trace context
//         "read_drive":     ArrayAttr<DictAttr>,   only for READ
//           [{ "target": "<rdata-sanitised>", "expression": "<C expr>",
//              "bitWidth": IntAttr, "guard_expr": StringAttr (optional) }]
//         "write_drive":    ArrayAttr<DictAttr>,   only for WRITE
//           [{ "target": "<reg-sanitised>",   "expression": "<C expr>",
//              "bitWidth": IntAttr, "guard_expr": StringAttr (optional) }]
//         "deassert":       ArrayAttr<StringAttr>  (optional; signals that
//                                            must be 0 in the next bus cycle)
//         "audit":          DictAttr,        // counters for diagnosability
//       }
//   }
//
// Prerequisites:
//   - BusProfileLoadPass has run and attached qemu.bus_profile (including
//     transactions[].kind and per-txn guards).
//   - ExplodeStructSigs / LowerValueStructs have run; the IR uses scalar
//     llhd.sig only.
//   - ForwardConstrainPass has folded noise signals into constants (the
//     trace can therefore ignore protocol-noise side conditions).
//
// Consumer:
//   - QEMUEmitCPass reads `qemu.bus_profile_resolved.transactions[*]` to
//     emit the *_read / *_write MMIO callbacks.
//
//===----------------------------------------------------------------------===//

#include "BusProfileQuery.h"
#include "CombTranslator.h"
#include "PassReports.h"

#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"

#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/Support/raw_ostream.h"

#include <optional>
#include <string>

#define GEN_PASS_DECL_BUSPROFILERESOLVE
#define GEN_PASS_DEF_BUSPROFILERESOLVE
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Helpers
//===----------------------------------------------------------------------===//

/// Get the originating signal name for a Value, following sig.extract and
/// prb chains back to the underlying llhd.sig / module port.  Returns empty
/// string if the value does not flow from a named signal.
static std::string getOriginatingSignalName(Value v) {
  // Strip sig.extract chains first.
  while (auto ex = v.getDefiningOp<llhd::SigExtractOp>())
    v = ex.getInput();

  if (auto sigOp = v.getDefiningOp<llhd::SignalOp>())
    if (auto name = sigOp.getName())
      return name->str();

  if (auto prb = v.getDefiningOp<llhd::ProbeOp>())
    return getOriginatingSignalName(prb.getSignal());

  if (auto bbarg = dyn_cast<BlockArgument>(v)) {
    Block *bb = bbarg.getOwner();
    Region *region = bb ? bb->getParent() : nullptr;
    if (region && &region->front() == bb) {
      if (auto hwMod = dyn_cast<hw::HWModuleOp>(region->getParentOp())) {
        unsigned idx = bbarg.getArgNumber();
        if (idx < hwMod.getNumInputPorts())
          return hwMod.getInputNameAttr(idx).getValue().str();
      }
    }
  }
  return {};
}

/// Bit width of a signal value (peels !hw.inout).
static unsigned getBitWidth(Value v) {
  Type ty = v.getType();
  if (auto inout = dyn_cast<llhd::RefType>(ty))
    ty = inout.getNestedType();
  if (auto intTy = dyn_cast<IntegerType>(ty))
    return intTy.getWidth();
  return 0;
}

/// Sanitize a name to a valid C identifier — matches QEMUEmitC's
/// sanitization so resolved drive entries reference the same field names
/// that EmitC's state struct will declare.
static std::string sanitizeName(llvm::StringRef name) {
  std::string out = name.str();
  for (char &c : out) {
    if (c == '.' || c == '[' || c == ']' || c == '-' || c == ' ' || c == ':')
      c = '_';
  }
  if (!out.empty() && std::isdigit((unsigned char)out[0]))
    out = "_" + out;
  return out;
}

/// Translate a Value to a C expression via CombTranslator.  Returns the
/// fallback string `"/* untranslatable */"` if translation fails — callers
/// inspect `ok` to decide whether to drop the entry.
static std::pair<std::string, bool> tryTranslate(Value v) {
  auto r = comb_translator::translateValue(v, /*maxDepth=*/16);
  if (r.success && !r.expr.empty())
    return {r.expr, true};
  return {std::string("/* untranslatable: ") + r.errorMsg + " */", false};
}

/// Build a C-expression string equivalent to "<role_signal_C_name> <op> <value>"
/// for a single guard clause.  Used to compose the per-txn guard_expr that
/// QEMUEmitC wraps each drive entry in.
static std::string formatGuardClause(StringRef sigName, StringRef op,
                                     int64_t value) {
  std::string sig = sanitizeName(sigName);
  std::string oper = "==";
  if (op == "eq")      oper = "==";
  else if (op == "neq") oper = "!=";
  else if (op == "gt")  oper = ">";
  else if (op == "lt")  oper = "<";
  else if (op == "ge")  oper = ">=";
  else if (op == "le")  oper = "<=";
  return "((s->" + sig + ") " + oper + " " + std::to_string(value) + ")";
}

//===----------------------------------------------------------------------===//
// Per-transaction trace context
//===----------------------------------------------------------------------===//

/// A single resolved drive — covers both READ and WRITE entries.
struct ResolvedDrive {
  std::string target;       // sanitised C name of the driven signal
  std::string expression;   // RHS C expression (already includes operand refs)
  unsigned bitWidth = 0;
  std::string guardExpr;    // additional path condition (may be empty)
};

/// Walks the IR for one transaction and accumulates its drive list.
class TxnResolver {
public:
  TxnResolver(ModuleOp mod, DictionaryAttr profile, hw::HWModuleOp topMod)
      : mod_(mod), profile_(profile), topMod_(topMod) {}

  /// Resolve a WRITE transaction: produce one ResolvedDrive per register
  /// llhd.drv that fires when the txn's guard holds.  We do not re-derive
  /// the guard from IR — the trace assumes ForwardConstrain has already
  /// folded the noise signals listed in `bus_profile.noise_signals` to
  /// constants, so the surviving drv conditions reflect only meaningful
  /// inputs (address-decode + write-strobe).
  SmallVector<ResolvedDrive> resolveWrite(DictionaryAttr txn) {
    SmallVector<ResolvedDrive> drives;
    audit_writeRegs = 0;
    audit_writeSkipped = 0;

    // Collect all llhd.drv inside the top module (and its instances, via
    // walk into nested ops).  Filter to drvs that target a sig declared
    // in this module hierarchy (i.e. not a transient temp).
    topMod_.walk([&](llhd::DriveOp drv) {
      // Skip drvs whose target is an unnamed temp.
      Value sig = drv.getSignal();
      std::string sigName = getOriginatingSignalName(sig);
      if (sigName.empty()) {
        audit_writeSkipped++;
        return;
      }

      // Skip drvs that are part of the bus interface itself — they're not
      // register state, they're the bus protocol.  Use the role signal
      // name set to filter.
      if (isBusProfileSignal(sigName)) {
        audit_writeSkipped++;
        return;
      }

      // A WRITE transaction's driving register set is everything outside
      // an llhd.process (those are clock-triggered = comb logic feeding
      // registers) AND everything inside a clock-triggered process whose
      // value depends on the wdata role.
      // Simpler heuristic for v2: emit every register drv we can translate
      // and tag each one with its own path condition (already encoded by
      // CombLogicExtract via the gatedCondition mechanism).  QEMUEmitC
      // multiplexes them through the same guard wrapper.
      Value valueIn = drv.getValue();
      auto [expr, ok] = tryTranslate(valueIn);
      if (!ok) {
        audit_writeSkipped++;
        return;
      }

      ResolvedDrive d;
      d.target = sanitizeName(sigName);
      d.expression = expr;
      d.bitWidth = getBitWidth(sig);
      drives.push_back(std::move(d));
      audit_writeRegs++;
    });

    return drives;
  }

  /// Resolve a READ transaction.
  ///
  /// Two code paths depending on the rdata binding's `kind`:
  ///
  ///   kind = "signal": there is a real llhd.sig in the IR whose name
  ///     matches the binding's `.name`.  We walk all llhd.drv targeting
  ///     that sig and translate each operand to a C expression.  This
  ///     path was the original v2 implementation and is correct for
  ///     APB/AHB designs where prdata/hrdata is a top-level scalar
  ///     output backed by an llhd.sig.
  ///
  ///   kind = "struct_field": the rdata lives as one field of a
  ///     struct-typed module output port (TL-UL `tl_o.d_data` is the
  ///     canonical case).  The struct port survives struct-lowering
  ///     because LowerValueStructs intentionally does NOT flatten
  ///     module signatures.  So there is no llhd.drv whose target
  ///     matches the field name — the field is produced by a
  ///     hw.struct_create / hw.instance chain that feeds hw.output.
  ///
  ///     We walk hw.output's operand at the carrier port's index,
  ///     follow it back through any hw.instance / hw.struct_create
  ///     layers, and synthesise a C expression of the form
  ///         s->{instance}_{port}_{field}
  ///     which references the per-instance-prefixed state field that
  ///     QEMUEmitC's renderModule already creates for every leaf
  ///     field of a struct-typed instance port.
  SmallVector<ResolvedDrive> resolveRead(DictionaryAttr txn,
                                         DictionaryAttr rdataBinding) {
    SmallVector<ResolvedDrive> drives;
    audit_readDrives = 0;
    audit_readSkipped = 0;

    if (!rdataBinding)
      return drives;
    auto kindAttr = rdataBinding.getAs<StringAttr>("kind");
    if (!kindAttr)
      return drives;
    StringRef kind = kindAttr.getValue();

    if (kind == "signal") {
      auto nameAttr = rdataBinding.getAs<StringAttr>("name");
      if (!nameAttr) return drives;
      return resolveReadFromSignal(nameAttr.getValue());
    }
    if (kind == "struct_field") {
      auto carrierAttr = rdataBinding.getAs<StringAttr>("carrier");
      auto fieldAttr   = rdataBinding.getAs<StringAttr>("field");
      auto widthAttr   = rdataBinding.getAs<IntegerAttr>("width");
      if (!carrierAttr || !fieldAttr) return drives;
      return resolveReadFromStructField(carrierAttr.getValue(),
                                        fieldAttr.getValue(),
                                        widthAttr ? (unsigned)widthAttr.getInt()
                                                  : 0u);
    }
    return drives;
  }

  /// Legacy path: rdata is a named scalar signal (kind="signal").
  SmallVector<ResolvedDrive> resolveReadFromSignal(StringRef rdataSigName) {
    SmallVector<ResolvedDrive> drives;
    if (rdataSigName.empty())
      return drives;

    topMod_.walk([&](llhd::DriveOp drv) {
      Value sig = drv.getSignal();
      std::string name = getOriginatingSignalName(sig);
      if (name != rdataSigName)
        return;
      Value valueIn = drv.getValue();
      auto [expr, ok] = tryTranslate(valueIn);
      if (!ok) {
        audit_readSkipped++;
        return;
      }
      ResolvedDrive d;
      d.target = sanitizeName(name);
      d.expression = expr;
      d.bitWidth = getBitWidth(sig);
      drives.push_back(std::move(d));
      audit_readDrives++;
    });
    return drives;
  }

  /// New path: rdata is a struct field on a module output port
  /// (typical for TL-UL `tl_o.d_data`).  We synthesise a C reference
  /// to the per-instance-prefixed state field that QEMUEmitC's
  /// renderModule will have created for the same field on the
  /// underlying hw.instance result.
  SmallVector<ResolvedDrive>
  resolveReadFromStructField(StringRef carrier, StringRef field,
                             unsigned width) {
    SmallVector<ResolvedDrive> drives;

    // 1. Locate the top module's hw.output operation.
    hw::OutputOp output;
    topMod_.walk([&](hw::OutputOp op) {
      output = op;
      return WalkResult::interrupt();
    });
    if (!output) {
      audit_readSkipped++;
      return drives;
    }

    // 2. Find the index of `carrier` in the top module's output port list.
    unsigned carrierIdx = ~0u;
    auto outNames = topMod_.getOutputNames();
    for (unsigned i = 0, e = outNames.size(); i < e; ++i) {
      auto sa = dyn_cast<StringAttr>(outNames[i]);
      if (sa && sa.getValue() == carrier) {
        carrierIdx = i;
        break;
      }
    }
    if (carrierIdx == ~0u) {
      audit_readSkipped++;
      return drives;
    }

    // 3. Walk the operand back through the local def-use graph until we
    //    find a hw.instance result (the common case for OT TL-UL where
    //    the top module just passes tl_o through from a register-top
    //    instance) or a hw.struct_create (the case where the top
    //    constructs tl_o locally).
    Value structVal = output.getOperand(carrierIdx);
    auto [expr, ok] = deriveStructFieldExpr(structVal, field);
    if (!ok) {
      audit_readSkipped++;
      return drives;
    }

    ResolvedDrive d;
    d.target = sanitizeName(field);
    d.expression = expr;
    // Prefer width from the binding (authoritative); fall back to the
    // SSA value type when bus.json omitted it.
    d.bitWidth = width ? width : getBitWidth(structVal);
    drives.push_back(std::move(d));
    audit_readDrives++;
    return drives;
  }

  /// Walk an SSA value back to either a hw.instance result (returns
  /// "s->{inst}_{port}_{field}") or a hw.struct_create (returns the
  /// translated field operand).
  std::pair<std::string, bool>
  deriveStructFieldExpr(Value v, StringRef field) {
    // Case A: instance result — the typical OT TL-UL shape.
    if (auto inst = v.getDefiningOp<hw::InstanceOp>()) {
      // Find which result index v is at.
      unsigned resIdx = ~0u;
      for (unsigned i = 0, e = inst.getNumResults(); i < e; ++i) {
        if (inst.getResult(i) == v) { resIdx = i; break; }
      }
      if (resIdx == ~0u) return {"", false};

      // Get the port name at that index from the instance's result
      // names attribute.  This is the inner-module port name (e.g.
      // "tl_o"), which is what QEMUEmitC's per-instance prefix walker
      // uses to derive C state-field names.
      auto resNames = inst.getResultNames();
      if (resIdx >= resNames.size()) return {"", false};
      auto portNameAttr = dyn_cast<StringAttr>(resNames[resIdx]);
      if (!portNameAttr) return {"", false};

      std::string instName = inst.getInstanceName().str();
      std::string portName = portNameAttr.getValue().str();
      std::string out =
          "s->" + sanitizeName(instName) + "_" +
          sanitizeName(portName) + "_" + sanitizeName(field);
      return {std::move(out), true};
    }

    // Case B: struct_create — top module assembles tl_o locally.  Pull
    // the field's operand and translate it directly.
    if (auto create = v.getDefiningOp<hw::StructCreateOp>()) {
      auto sty = dyn_cast<hw::StructType>(v.getType());
      if (!sty) return {"", false};
      unsigned fieldIdx = ~0u;
      auto elements = sty.getElements();
      for (unsigned i = 0, e = elements.size(); i < e; ++i) {
        if (elements[i].name.getValue() == field) { fieldIdx = i; break; }
      }
      if (fieldIdx == ~0u) return {"", false};
      Value fv = create.getOperand(fieldIdx);
      return tryTranslate(fv);
    }

    // Case C: struct_extract on another struct — chase upstream.  Rare
    // in practice for top-level rdata, but worth handling so we don't
    // silently drop legitimate paths.
    if (auto extract = v.getDefiningOp<hw::StructExtractOp>()) {
      // Pull the field from the inner struct and recurse.  Note we
      // recurse with the SAME field name we were asked about — the
      // extract just rewraps a sub-struct; the named field lives
      // within whatever the extract's input was.
      return deriveStructFieldExpr(extract.getInput(), field);
    }

    return {"", false};
  }

  unsigned auditWriteRegs() const   { return audit_writeRegs; }
  unsigned auditWriteSkipped() const { return audit_writeSkipped; }
  unsigned auditReadDrives() const  { return audit_readDrives; }
  unsigned auditReadSkipped() const { return audit_readSkipped; }

  /// Cache the set of role signal names (addr / wdata / rdata / wr_enable
  /// + any noise_signals) so we can skip them when listing register drives.
  void seedBusSignalSet() {
    busSignalNames_.clear();
    auto profileQuery = qemu_passes::BusProfileQuery::fromModule(mod_);
    if (!profileQuery) return;
    for (StringRef role : {"addr", "wdata", "rdata", "wr_enable"}) {
      if (auto n = profileQuery->getSignalName(role))
        busSignalNames_.insert(n->str());
    }
    for (StringRef noise : profileQuery->getNoiseSignals())
      busSignalNames_.insert(noise.str());
  }

private:
  bool isBusProfileSignal(StringRef name) const {
    return busSignalNames_.contains(name);
  }

  ModuleOp mod_;
  DictionaryAttr profile_;
  hw::HWModuleOp topMod_;
  llvm::StringSet<> busSignalNames_;

  unsigned audit_writeRegs = 0;
  unsigned audit_writeSkipped = 0;
  unsigned audit_readDrives = 0;
  unsigned audit_readSkipped = 0;
};

//===----------------------------------------------------------------------===//
// Pass
//===----------------------------------------------------------------------===//

struct BusProfileResolvePass
    : public ::impl::BusProfileResolveBase<BusProfileResolvePass> {

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();

    auto profile = mod->getAttrOfType<DictionaryAttr>("qemu.bus_profile");
    if (!profile) {
      // Quiet no-op when the user did not run --bus-profile-load: the
      // pipeline can still produce C code from qemu.comb_logic alone.
      llvm::errs() << "[bus-profile-resolve] no qemu.bus_profile present; "
                   << "skipping (no-op).\n";
      return;
    }

    auto profileQuery = qemu_passes::BusProfileQuery::fromModule(mod);
    if (!profileQuery) {
      mod.emitError("bus-profile-resolve: qemu.bus_profile present but "
                    "malformed or top_module not found");
      return signalPassFailure();
    }
    auto topMod = profileQuery->getTopModule();
    if (!topMod) {
      mod.emitError("bus-profile-resolve: top_module not in IR");
      return signalPassFailure();
    }

    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass 11: Bus Profile Resolve\n";
    llvm::outs() << "========================================\n";
    llvm::outs() << "Top module: @" << profileQuery->getTopModuleName() << "\n";

    // ---- 1. Read transactions[] from bus_profile ----
    // BusProfileLoadPass v2 stores the original transactions array under
    // bus_profile["transactions"].  Older bus_profile data (without
    // transactions) is treated as "no resolved drives" — emit a warning
    // and continue with an empty resolved attr so downstream EmitC keeps
    // working off qemu.comb_logic alone.
    auto txnsAttr = profile.getAs<ArrayAttr>("transactions");
    if (!txnsAttr || txnsAttr.empty()) {
      mod.emitWarning(
          "bus-profile-resolve: no transactions[] in qemu.bus_profile; "
          "skipping resolution (QEMUEmitC will fall back to comb_logic)");
      // Still attach an empty resolved entry so downstream code can detect
      // that resolve ran without finding anything.
      attachEmpty(mod, ctx, profileQuery->getTopModuleName());
      return;
    }

    // ---- 2. For each transaction, run forward-trace ----
    TxnResolver resolver(mod, profile, topMod);
    resolver.seedBusSignalSet();

    // Pick up the rdata binding directly so resolveRead can branch on
    // kind=signal vs kind=struct_field.  getSignalName() flattens both
    // to a single name string and loses the carrier/kind information
    // we need for struct_field walking.
    auto bindings = profile.getAs<DictionaryAttr>("bindings");
    DictionaryAttr rdataBinding =
        bindings ? bindings.getAs<DictionaryAttr>("rdata") : DictionaryAttr();

    // We only synthesise a comb_logic bridge when rdata is a struct
    // field on a module port — that's the case CombLogicExtract cannot
    // cover on its own (no llhd.drv exists for a struct port field
    // because LowerValueStructs preserves module-signature structs).
    //
    // For kind=signal rdata (APB / AHB / scalar rdata ports), there
    // IS an llhd.drv that CombLogicExtract already picks up; adding
    // our own would duplicate the assignment in update_state.
    bool rdataIsStructField = false;
    if (rdataBinding) {
      if (auto kindA = rdataBinding.getAs<StringAttr>("kind"))
        rdataIsStructField = (kindA.getValue() == "struct_field");
    }

    SmallVector<Attribute, 4> resolvedTxns;
    // Synthetic comb_logic entries that bridge the BIP rdata field
    // (e.g. s->d_data) to the per-instance-prefixed field
    // (e.g. s->u_reg_tl_o_d_data) that update_state actually drives.
    // Accumulated across all READ transactions and appended to the
    // top module's qemu.comb_logic at the end of this pass.
    SmallVector<Attribute, 4> syntheticCombEntries;
    unsigned auditReadsTotal = 0;
    unsigned auditWritesTotal = 0;

    for (Attribute txnAttr : txnsAttr) {
      auto txn = dyn_cast<DictionaryAttr>(txnAttr);
      if (!txn) continue;
      auto kindAttr = txn.getAs<StringAttr>("kind");
      if (!kindAttr) continue;
      StringRef kind = kindAttr.getValue();

      SmallVector<NamedAttribute, 6> txnEntries;
      txnEntries.emplace_back(StringAttr::get(ctx, "kind"), kindAttr);

      // Preserve the original guard array (copy reference; immutable).
      if (auto guardArr = txn.getAs<ArrayAttr>("guard"))
        txnEntries.emplace_back(StringAttr::get(ctx, "guard"), guardArr);

      // Build the txn's compact C-expression guard (a single &&-joined
      // expression) so EmitC has a ready-to-use predicate for the drive.
      std::string compactGuard = buildCompactGuardExpr(*profileQuery, txn);
      if (!compactGuard.empty())
        txnEntries.emplace_back(StringAttr::get(ctx, "guard_expr"),
                                StringAttr::get(ctx, compactGuard));

      SmallVector<ResolvedDrive> drives;
      if (kind == "READ") {
        drives = resolver.resolveRead(txn, rdataBinding);
        auditReadsTotal += drives.size();
        // Only emit synthetic comb_logic entries for struct_field
        // rdata (TL-UL).  For kind=signal rdata, CombLogicExtract
        // will pick up the existing llhd.drv driving s->{rdata} and
        // duplicating it here would just emit the same assignment
        // twice in update_state().  Keep read_drive[] populated
        // either way so external consumers (audit, debugging) see
        // the resolved trace.
        if (rdataIsStructField) {
          for (const ResolvedDrive &d : drives) {
            SmallVector<NamedAttribute, 3> fields;
            fields.emplace_back(StringAttr::get(ctx, "target"),
                                StringAttr::get(ctx, d.target));
            fields.emplace_back(StringAttr::get(ctx, "expression"),
                                StringAttr::get(ctx, d.expression));
            fields.emplace_back(
                StringAttr::get(ctx, "bitWidth"),
                IntegerAttr::get(IntegerType::get(ctx, 32),
                                 (int64_t)d.bitWidth));
            syntheticCombEntries.push_back(DictionaryAttr::get(ctx, fields));
          }
        }
      } else if (kind == "WRITE") {
        drives = resolver.resolveWrite(txn);
        auditWritesTotal += drives.size();
      } else {
        llvm::errs() << "[bus-profile-resolve] unknown txn kind '" << kind
                     << "', skipping.\n";
        continue;
      }

      // Convert ResolvedDrive list into ArrayAttr<DictAttr>.
      SmallVector<Attribute, 16> driveAttrs;
      for (const ResolvedDrive &d : drives) {
        SmallVector<NamedAttribute, 4> fields;
        fields.emplace_back(StringAttr::get(ctx, "target"),
                            StringAttr::get(ctx, d.target));
        fields.emplace_back(StringAttr::get(ctx, "expression"),
                            StringAttr::get(ctx, d.expression));
        fields.emplace_back(
            StringAttr::get(ctx, "bitWidth"),
            IntegerAttr::get(IntegerType::get(ctx, 32), d.bitWidth));
        if (!d.guardExpr.empty())
          fields.emplace_back(StringAttr::get(ctx, "guard_expr"),
                              StringAttr::get(ctx, d.guardExpr));
        driveAttrs.push_back(DictionaryAttr::get(ctx, fields));
      }
      StringRef driveKey = (kind == "READ") ? "read_drive" : "write_drive";
      txnEntries.emplace_back(StringAttr::get(ctx, driveKey),
                              ArrayAttr::get(ctx, driveAttrs));

      // Audit counters.
      SmallVector<NamedAttribute, 4> auditEntries;
      auditEntries.emplace_back(
          StringAttr::get(ctx, "drive_count"),
          IntegerAttr::get(IntegerType::get(ctx, 32),
                           (int64_t)drives.size()));
      auditEntries.emplace_back(
          StringAttr::get(ctx, "skipped"),
          IntegerAttr::get(IntegerType::get(ctx, 32),
                           (int64_t)(kind == "READ"
                                         ? resolver.auditReadSkipped()
                                         : resolver.auditWriteSkipped())));
      txnEntries.emplace_back(StringAttr::get(ctx, "audit"),
                              DictionaryAttr::get(ctx, auditEntries));

      resolvedTxns.push_back(DictionaryAttr::get(ctx, txnEntries));
      llvm::outs() << "  [TXN " << kind << "] drives=" << drives.size()
                   << " skipped=" << (kind == "READ"
                                          ? resolver.auditReadSkipped()
                                          : resolver.auditWriteSkipped())
                   << "\n";
    }

    // ---- 3. Attach the resolved attribute on the top ModuleOp ----
    SmallVector<NamedAttribute, 4> resolved;
    resolved.emplace_back(StringAttr::get(ctx, "top_module"),
                          StringAttr::get(ctx, profileQuery->getTopModuleName()));
    resolved.emplace_back(StringAttr::get(ctx, "transactions"),
                          ArrayAttr::get(ctx, resolvedTxns));
    mod->setAttr("qemu.bus_profile_resolved",
                 DictionaryAttr::get(ctx, resolved));

    // ---- 4. Append synthetic comb_logic entries to the top hw.module ----
    // These bridge the BIP rdata field (e.g. s->d_data) to the
    // per-instance-prefixed state field (e.g. s->u_reg_tl_o_d_data)
    // that update_state actually maintains.  CombLogicExtract (step 12)
    // will see these existing entries and preserve them when it appends
    // its own walk-derived drvs.
    if (!syntheticCombEntries.empty()) {
      SmallVector<Attribute, 8> finalComb;
      // Order matters: existing entries first (whatever was already
      // attached by earlier passes), synthetic entries last.  The
      // synthetic entries reference upstream state fields and need to
      // run AFTER those are refreshed.
      if (auto existing =
              topMod->getAttrOfType<ArrayAttr>("qemu.comb_logic")) {
        for (Attribute a : existing) finalComb.push_back(a);
      }
      for (Attribute a : syntheticCombEntries) finalComb.push_back(a);
      topMod->setAttr("qemu.comb_logic", ArrayAttr::get(ctx, finalComb));
    }

    llvm::outs() << "----------------------------------------\n";
    llvm::outs() << "Summary:\n";
    llvm::outs() << "  Transactions resolved: " << resolvedTxns.size() << "\n";
    llvm::outs() << "  READ drives total:     " << auditReadsTotal << "\n";
    llvm::outs() << "  WRITE drives total:    " << auditWritesTotal << "\n";
    llvm::outs() << "  Synthetic comb drvs:   " << syntheticCombEntries.size()
                 << "\n";
    llvm::outs() << "========================================\n\n";

    qemu_passes::writePassReport(
        "bus_profile_resolve",
        [&](llvm::raw_ostream &os) {
          os << "Bus Profile Resolve — summary\n";
          os << "=============================\n";
          os << "Top module:            "
             << profileQuery->getTopModuleName() << "\n";
          os << "Transactions resolved: " << resolvedTxns.size() << "\n";
          os << "READ drives total:     " << auditReadsTotal << "\n";
          os << "WRITE drives total:    " << auditWritesTotal << "\n";
        });
  }

private:
  /// Compose the "all guard clauses AND-joined" C expression for a single
  /// transaction, based on the role signal names in bus_profile.bindings.
  static std::string
  buildCompactGuardExpr(const qemu_passes::BusProfileQuery &profile,
                        DictionaryAttr txn) {
    auto guardArr = txn.getAs<ArrayAttr>("guard");
    if (!guardArr) return {};
    SmallVector<std::string, 6> clauses;
    for (Attribute g : guardArr) {
      auto gd = dyn_cast<DictionaryAttr>(g);
      if (!gd) continue;
      auto roleAttr = gd.getAs<StringAttr>("role");
      auto opAttr   = gd.getAs<StringAttr>("op");
      auto valAttr  = gd.getAs<IntegerAttr>("value");
      if (!roleAttr || !opAttr || !valAttr) continue;
      auto sig = profile.getSignalName(roleAttr.getValue());
      if (!sig) continue;
      clauses.push_back(formatGuardClause(*sig, opAttr.getValue(),
                                          valAttr.getInt()));
    }
    if (clauses.empty()) return {};
    std::string joined = clauses[0];
    for (size_t i = 1; i < clauses.size(); ++i)
      joined = "(" + joined + ") && (" + clauses[i] + ")";
    return joined;
  }

  static void attachEmpty(ModuleOp mod, MLIRContext *ctx, StringRef topName) {
    SmallVector<NamedAttribute, 2> resolved;
    resolved.emplace_back(StringAttr::get(ctx, "top_module"),
                          StringAttr::get(ctx, topName));
    resolved.emplace_back(StringAttr::get(ctx, "transactions"),
                          ArrayAttr::get(ctx, {}));
    mod->setAttr("qemu.bus_profile_resolved",
                 DictionaryAttr::get(ctx, resolved));
  }
};

} // namespace
