#include "RTLAdapter.h"
#ifndef QEMU_PASSES_COMB_TRANSLATOR_H
#define QEMU_PASSES_COMB_TRANSLATOR_H

//===----------------------------------------------------------------------===//
// CombTranslator.h - Comb Dialect to C Expression Translator
//
// Ported from qemu-output/src/lib/CombTranslator.h
// This is a direct port to ensure behavioral consistency with the old framework.
//===----------------------------------------------------------------------===//

#include "mlir/IR/Value.h"
#include "mlir/IR/Operation.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/IR/SymbolTable.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/DenseSet.h"
#include <string>
#include <optional>
#include <functional>

namespace comb_translator {

// Optional callback to resolve a non-entry CFG-join BlockArgument to a C
// expression.  Set by CombLogicExtract (which owns resolveBlockArgViaCFG); lets
// translateValue resolve FSM / phi join args nested inside expressions instead
// of falling back to the `_unknown_arg` sentinel (=0).  Returns nullopt to keep
// the legacy fallback.
inline std::function<std::optional<std::string>(mlir::BlockArgument)> &
blockArgResolver() {
  static std::function<std::optional<std::string>(mlir::BlockArgument)> r;
  return r;
}

// Bindings for func.func block arguments while a func.call is being inlined
// (callee arg → translated actual).  Mirrors QEMUEmitC's resolveValueExpr
// func.call expansion, which CombTranslator lacked: aon_timer's prescaler
// enable / next-count are `mux(lc_tx_test_false_strict(...), ...)` and were
// dropped wholesale as "unsupported op: func.call" — the prescaler was dead.
inline std::string sanitizeSignalName(const std::string &name);

/// Maps a signal's LOCAL name to the state field that actually holds it.
///
/// translateValue names signals from the IR, which gives the name as written
/// inside its own module.  The emitter, though, flattens the hierarchy: the
/// same signal lives in a field prefixed by its instance path.  Without a
/// mapper, translateValue is unusable anywhere below the top module — which is
/// why the instance-port bridge grew its own, weaker resolver instead of
/// calling this one, and why ops this file has supported for months
/// (comb.icmp, func.call, hw.bitcast) were being refused there.
///
/// Set it around a call, restore it after.  Returning nullopt means "no such
/// field", which lets the caller fail rather than emit a name that does not
/// exist.
/// Shorten an expression for a DIAGNOSTIC line.
///
/// Generated expressions can be megabytes.  pinmux's register read mux renders
/// as a single 4.3 MB line, and the pass diagnostics that echo every
/// combinational assignment brought its generation log to 5.4 GB across 81k
/// lines.  That is not merely large: it silently BREAKS the tools that read
/// these logs.  A fleet-wide `grep` over the log directory returned an EMPTY
/// result rather than an error, so a bridge census read as zero recoveries
/// when there were fifteen — the same shape of failure the M-track keeps
/// hitting, where the measuring instrument is the thing that is broken.
///
/// A diagnostic's job is to say WHICH signal and HOW BIG, not to reproduce the
/// text; the full expression is in the emitted C, which is where anyone
/// reading it would go anyway.
inline std::string brief(llvm::StringRef s, size_t n = 160) {
  if (s.size() <= n)
    return s.str();
  return (s.take_front(n) + llvm::Twine(" \u2026 <+") +
          llvm::Twine(s.size() - n) + " bytes>")
      .str();
}

/// The one spelling of the unresolved-block-argument sentinel.
///
/// It is minted in exactly one place and tested in seven others, in another
/// file, by SUBSTRING SEARCH over already-rendered C.  That means the guards
/// are coupled to this text and nothing enforces the coupling: renaming the
/// sentinel would leave all seven silently passing, and DYN-SLICE / DYN-SHL
/// would start emitting `qpw_wide_insert` with a phantom operand while the
/// build stayed green.  A shared constant makes the coupling a compile-time
/// fact instead of a convention.
///
/// (The stronger fix is a give-up flag carried on TranslateResult, so no
/// decision is made from rendered text at all.  That needs the flag to
/// propagate only through sub-results actually spliced into the returned
/// string — translateStructFieldOf discards a successful sub-result, so a
/// naive "any bit set during this translation" rule reports false positives
/// on correct constructions.  Deliberately not attempted here; this removes
/// the silent-desynchronisation hazard, which is the part that bites.)
inline constexpr const char *kUnresolvedArgSentinel = "_unknown_arg";

inline std::function<std::optional<std::string>(llvm::StringRef)> &
signalFieldMapper() {
  static std::function<std::optional<std::string>(llvm::StringRef)> fn;
  return fn;
}

/// Apply the mapper (if installed) to a raw local signal name.
inline std::optional<std::string> mapSignalField(const std::string &raw) {
  if (auto &fn = signalFieldMapper())
    return fn(raw);
  return "s->" + sanitizeSignalName(raw);
}

inline llvm::DenseMap<mlir::BlockArgument, std::string> &callArgBindings() {
  static llvm::DenseMap<mlir::BlockArgument, std::string> m;
  return m;
}
/// Local `llhd.sig` values inside an inlined func.func body, bound to the C
/// expression of their CURRENT symbolic value (the inliner evaluates the
/// body's drvs in order).  Consulted by the prb handler.
inline llvm::DenseMap<mlir::Value, std::string> &localSigBindings() {
  static llvm::DenseMap<mlir::Value, std::string> m;
  return m;
}
/// AGGREGATE call arguments (an hw.array-typed actual, e.g. the hash state
/// passed to prim_sha2_pkg::compress_*) cannot be carried as one C string —
/// the block arg is bound to the caller's VALUE instead, and the body's
/// `array_get(%arg, i)` resolves through it back to the caller's
/// array_create operand.
inline llvm::DenseMap<mlir::BlockArgument, mlir::Value> &callArgValueBindings() {
  static llvm::DenseMap<mlir::BlockArgument, mlir::Value> m;
  return m;
}

//===----------------------------------------------------------------------===//
// Comb Dialect to C Expression Translator
//
// Supported operations:
//   Arithmetic: add, sub, mul, divs, divu, mods, modu
//   Bitwise: and, or, xor, shl, shrs, shru
//   Compare: icmp (eq, ne, slt, sle, sgt, sge, ult, ule, ugt, uge)
//   Data: extract, concat, replicate, mux, reverse, parity
//
// Reference: https://circt.llvm.org/docs/Dialects/Comb/
//===----------------------------------------------------------------------===//

/// Translation result
/// OPT-IN size budget for one translation, in bytes of C expression.
///
/// Zero means unlimited, which is the normal emission path: pinmux's register
/// read mux legitimately renders as a 4.3 MB expression and must not be
/// refused.  A budget is installed only by callers that are SPECULATING — the
/// instance-port bridge asks CombTranslator "can you express this?" and must
/// be able to take no for an answer.  Without one, the input-bridge delegation
/// walked a pinmux combinational cone and the process was OOM-killed (exit
/// 137) before it could decide anything.
///
/// The check lives in TranslateResult::ok() because that is the single funnel
/// every rule returns through, so one test bounds the whole recursion: a rule
/// that concatenates N oversized children fails at the parent, and peak memory
/// stays within a small multiple of the budget.
inline size_t &exprSizeBudget() {
  static size_t b = 0;
  return b;
}

struct ExprBudgetScope {
  size_t saved;
  explicit ExprBudgetScope(size_t bytes) : saved(exprSizeBudget()) {
    exprSizeBudget() = bytes;
  }
  ~ExprBudgetScope() { exprSizeBudget() = saved; }
};

struct TranslateResult {
  bool success;           // Whether translation succeeded
  std::string expr;       // C expression string
  std::string errorMsg;   // Error message on failure

  static TranslateResult ok(const std::string &e) {
    size_t budget = exprSizeBudget();
    if (budget && e.size() > budget)
      return {false, "",
              "expression exceeds the caller's " + std::to_string(budget) +
                  "-byte budget (" + std::to_string(e.size()) + " bytes)"};
    return {true, e, ""};
  }
  static TranslateResult fail(const std::string &msg) {
    return {false, "", msg};
  }
};

//===----------------------------------------------------------------------===//
// Helper Functions
//===----------------------------------------------------------------------===//

/// Get name from SSA value (for signals without name attribute)
inline std::string getSSANameFromValue(mlir::Value val) {
  if (auto opResult = mlir::dyn_cast<mlir::OpResult>(val)) {
    mlir::Operation *defOp = opResult.getOwner();
    if (auto nameAttr = defOp->getAttrOfType<mlir::StringAttr>("name")) {
      return nameAttr.getValue().str();
    }
    if (auto symName = defOp->getAttrOfType<mlir::StringAttr>("sym_name")) {
      return symName.getValue().str();
    }
    std::string str;
    llvm::raw_string_ostream os(str);
    val.print(os);
    os.flush();
    if (!str.empty() && str[0] == '%') {
      size_t end = str.find_first_of(" :");
      if (end != std::string::npos) {
        return str.substr(1, end - 1);
      }
      return str.substr(1);
    }
  }
  return "";
}

/// Bit extraction pattern detection result
struct BitExtractPattern {
  bool isPattern;           // Whether it matches bit extraction pattern
  std::string signalName;   // Extracted signal name
  bool usesBlockArgument;   // Whether index is BlockArgument

  static BitExtractPattern none() {
    return {false, "", false};
  }
  static BitExtractPattern match(const std::string &sig, bool usesArg) {
    return {true, sig, usesArg};
  }
};

/// Detect (signal >> index) & 1 pattern
inline BitExtractPattern detectBitExtractPattern(mlir::Value val) {
  // Pattern: comb.extract (signal >> blockArg) from 0 : (i32) -> i1
  if (auto extractOp = val.getDefiningOp<circt::comb::ExtractOp>()) {
    if (extractOp.getLowBit() == 0 &&
        extractOp.getType().getIntOrFloatBitWidth() == 1) {
      mlir::Value input = extractOp.getInput();

      if (auto shruOp = input.getDefiningOp<circt::comb::ShrUOp>()) {
        mlir::Value signal = shruOp.getLhs();
        mlir::Value index = shruOp.getRhs();

        if (auto prbOp = signal.getDefiningOp<circt::llhd::ProbeOp>()) {
          mlir::Value sig = prbOp.getSignal();
          std::string sigName;
          if (auto sigOp = sig.getDefiningOp()) {
            if (auto nameAttr = sigOp->getAttrOfType<mlir::StringAttr>("name")) {
              sigName = nameAttr.getValue().str();
            } else {
              sigName = getSSANameFromValue(sig);
            }
          }

          bool usesBlockArg = mlir::isa<mlir::BlockArgument>(index);

          if (!usesBlockArg) {
            if (auto idxPrb = index.getDefiningOp<circt::llhd::ProbeOp>()) {
              mlir::Value idxSig = idxPrb.getSignal();
              if (auto idxSigOp = idxSig.getDefiningOp()) {
                std::string idxName;
                if (auto nameAttr = idxSigOp->getAttrOfType<mlir::StringAttr>("name")) {
                  idxName = nameAttr.getValue().str();
                } else {
                  idxName = getSSANameFromValue(idxSig);
                }
                if (idxName.find("int_k") != std::string::npos ||
                    idxName.find("_k") != std::string::npos ||
                    idxName.find("_i") != std::string::npos) {
                  usesBlockArg = true;
                }
              }
            }
          }

          if (!sigName.empty()) {
            return BitExtractPattern::match(sigName, usesBlockArg);
          }
        }
      }
    }
  }
  return BitExtractPattern::none();
}

/// Sanitize signal name (replace . [] etc with _)
inline std::string sanitizeSignalName(const std::string &name) {
  std::string result = name;
  for (char &c : result) {
    if (c == '.' || c == '[' || c == ']' || c == '-' || c == ' ') {
      c = '_';
    }
  }
  if (!result.empty() && std::isdigit(static_cast<unsigned char>(result[0]))) {
    result = "_" + result;
  }
  return result;
}

/// Get signal name (penetrate llhd.prb)
inline std::string getSignalName(mlir::Value val) {
  // Direct llhd.prb
  if (auto prbOp = val.getDefiningOp<circt::llhd::ProbeOp>()) {
    mlir::Value sig = prbOp.getSignal();
    if (auto sigOp = sig.getDefiningOp()) {
      // A probe of a SELECTED signal reference (`assign x = c ? a : b` on
      // nets lowers to arith.select over !hw.inout) or of a block argument
      // of inout type is NOT a named field: leave it to translateValue,
      // which pushes the probe through the select / resolves the arg via the
      // CFG.  Returning "s->unnamed" here folded every such probe onto one
      // bogus shared field (spi_device internal_sd_en_out read a stranger).
      if (mlir::isa<mlir::arith::SelectOp>(sigOp)) return "";
      if (auto nameAttr = sigOp->getAttrOfType<mlir::StringAttr>("name")) {
        { auto _m = mapSignalField(nameAttr.getValue().str()); return _m ? *_m : std::string(); }
      }
      std::string ssaName = getSSANameFromValue(sig);
      if (!ssaName.empty()) {
        { auto _m = mapSignalField(ssaName); return _m ? *_m : std::string(); }
      }
    }
    if (mlir::isa<mlir::BlockArgument>(sig)) return "";
    return "s->unnamed";
  }

  // Constant
  if (auto constOp = val.getDefiningOp<circt::hw::ConstantOp>()) {
    llvm::APInt v = constOp.getValue();
    if (v.getBitWidth() <= 64) {
      uint64_t u = v.getZExtValue();
      // Bare literals above INT_MAX trip -Werror in the QEMU build
      // ("integer constant is so large that it is unsigned") — the
      // SHA-384 IVs were the first >2^63 constants through here.
      if (u > 0x7FFFFFFFull)
        return std::to_string(u) + "ULL";
      return std::to_string(u);
    }
    if (v.getBitWidth() <= 128) {
      // Legal C spelling for a 65..128-bit constant: two 64-bit halves.
      uint64_t lo = v.extractBitsAsZExtValue(64, 0);
      uint64_t hi = v.extractBitsAsZExtValue(
          std::min(64u, v.getBitWidth() - 64), 64);
      return "((((__uint128_t)0x" + llvm::utohexstr(hi) + "ULL) << 64) | 0x" +
             llvm::utohexstr(lo) + "ULL)";
    }
    // >128 bits: zero and all-ones still have per-word-identical C
    // spellings the wordwise rewriter understands (kmac's 1600-bit
    // `reg_state_tl = valid ? state : '0` gate died when plain zero was
    // rejected here).  Anything else has no scalar C carrier — an empty
    // name makes the caller fail loudly instead of emitting an
    // uncompilable literal (the 352-bit cSHAKE prefix constants).
    if (v.isZero())
      return "0";
    if (v.isAllOnes())
      return "-1";
    // Non-trivial wide constant (kmac_app's 352-bit AppPfx cSHAKE
    // prefix): spell the full hex literal.  It is NOT legal scalar C —
    // but the wordwise rewriter recognizes >18-char hex literals and
    // expands non-periodic ones into a per-word array literal; a leak
    // into a genuinely scalar context fails loudly at C compile time.
    llvm::SmallString<96> hexStr;
    v.toString(hexStr, 16, /*Signed=*/false);
    return "0x" + std::string(hexStr) + "ULL";
  }
  // arith.constant — mixed-dialect residue (the canonicalizer rewrites the
  // odd comb op into arith form, e.g. hmac's `arith.xori %x, true`).
  if (auto ac = val.getDefiningOp<mlir::arith::ConstantOp>()) {
    if (auto ia = mlir::dyn_cast<mlir::IntegerAttr>(ac.getValue())) {
      llvm::APInt v = ia.getValue();
      if (v.getBitWidth() <= 64) {
        uint64_t u = v.getZExtValue();
        if (u > 0x7FFFFFFFull)
          return std::to_string(u) + "ULL";
        return std::to_string(u);
      }
    }
  }

  // BlockArgument — Fix 1 (P0):
  // For `hw.module` input ports, use the declared port name so the emitted
  // C expression references a real state-struct field (e.g. `s->tl_i`)
  // instead of a meaningless SSA name (`arg2`).  For other block arg
  // sources (e.g. inside an `llhd.process` body) we keep a fallback that
  // is grep-able rather than passable as a real signal name.
  if (auto blockArg = mlir::dyn_cast<mlir::BlockArgument>(val)) {
    // func.func argument bound by an in-flight func.call inline expansion
    {
      auto &b = callArgBindings();
      auto it = b.find(blockArg);
      if (it != b.end()) return it->second;
    }
    if (auto hwMod = mlir::dyn_cast<circt::hw::HWModuleOp>(
            blockArg.getOwner()->getParentOp())) {
      unsigned idx = blockArg.getArgNumber();
      if (idx < hwMod.getNumInputPorts()) {
        { auto _m = mapSignalField(hwMod.getInputName(idx).str()); return _m ? *_m : std::string(); }
      }
    }
    // Non-entry CFG-join BlockArgument (e.g. an FSM next-state / output phi).
    // Resolve via the injected CFG resolver if available, else fall back to the
    // grep-able sentinel.
    if (auto &resolve = blockArgResolver()) {
      if (auto e = resolve(blockArg))
        return *e;
    }
    // NEITHER RESOLVED NOR REFUSED — say so.
    //
    // This fallback invents a state field that nothing ever writes and reads
    // as 0, so the expression around it is computed with a wrong operand and
    // NOTHING says anything.  It is the one give-up in the translator that
    // leaves no marker, and it is why keymgr's u_checks.rom_digest_vld_o (the
    // ROM digest validity feeding CreatorRootKey) was derived from a constant
    // zero for months.  The value is unchanged — turning it into a failure
    // would drop the whole drive and change behaviour — but it is now
    // countable and greppable like every other give-up.
    {
      static llvm::DenseSet<void *> announced;
      if (announced.insert(blockArg.getAsOpaquePointer()).second)
        llvm::errs() << "  [UNRESOLVED PHI] block arg #"
                     << blockArg.getArgNumber()
                     << " has no CFG resolution; emitting s->_unknown_arg"
                     << blockArg.getArgNumber() << " (reads 0)\n";
    }
    return std::string("s->") + kUnresolvedArgSentinel +
           std::to_string(blockArg.getArgNumber());
  }

  // llhd.sig — used as a value, this is an `!hw.inout<T>` reference to
  // the state-struct field.  Treat as if probed (the field name is the
  // sig name).  Needed when CFG-aware blockarg resolution traces a
  // cf.cond_br operand back to a sig declaration that's passed by ref.
  if (auto sigOp = val.getDefiningOp<circt::llhd::SignalOp>()) {
    if (auto name = sigOp.getName())
      return "s->" + sanitizeSignalName(name->str());
  }

  // llhd.sig.extract — slice of a sig.  Same reasoning: emit as the
  // base sig with a bit-field shift+mask wrapper so the value reads
  // out the right slice.  We don't know the slice offset/width here in
  // a name-only context; drop to the base name and let the caller's
  // wrapper apply the slice (typically via the caller's downstream
  // bit-update path).
  if (auto extractOp = val.getDefiningOp<circt::llhd::SigExtractOp>()) {
    mlir::Value baseSig = extractOp.getInput();
    if (auto baseSigOp = baseSig.getDefiningOp<circt::llhd::SignalOp>()) {
      if (auto name = baseSigOp.getName())
        return "s->" + sanitizeSignalName(name->str());
    }
  }

  return "";
}

/// Generate bit mask

inline std::string genMask(unsigned width) {
  if (width > 64 && width < 128) {
    // 65..127-bit truncation: a 64-bit literal here silently zeroed the
    // high half (csrng's `pdata[127:0]` INS-seed window).
    return "((~(__uint128_t)0) >> " + std::to_string(128 - width) + ")";
  }
  if (width >= 128) {
    return "(~(__uint128_t)0)";
  }
  if (width >= 64) {
    return "0xFFFFFFFFFFFFFFFFULL";
  }
  uint64_t mask = (1ULL << width) - 1;
  if (mask <= 0xFFFF) {
    return "0x" + llvm::utohexstr(mask);
  }
  return "0x" + llvm::utohexstr(mask) + "ULL";
}

/// Bug G: detect "expr is exactly `s->NAME`" (no operators, parens trimmed).
/// Used to switch wide-input comb ops to array-indexed forms.
inline bool isPlainSignalRef(const std::string &expr,
                             std::string *outName = nullptr) {
  // Allow surrounding ( ) layers and leading/trailing whitespace.
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
}

/// Parity of a value WIDER than 64 bits.  __builtin_parityll's argument is an
/// `unsigned long long`; a wider argument is truncated silently (no warning,
/// even under -Wall -Wextra), which quietly deletes every bit above 63 from
/// the XOR-reduction.  Fold the value down to 64 bits first — parity is
/// associative, so XOR-ing the 64-bit chunks preserves it exactly.  Widths
/// above 128 have no C carrier here and are left to the caller.
inline std::string parityFold(const std::string &expr, unsigned width) {
  if (width <= 64)
    return "(__builtin_parityll(" + expr + "))";
  if (width <= 128)
    return "(__builtin_parityll((uint64_t)(" + expr + ") ^ (uint64_t)((" +
           expr + ") >> 64)))";
  // Above 128 bits there is no C scalar carrier: the value lives in a
  // `uint64_t name[nWords]` field, which `>>` cannot shift and a cast would
  // decay to a pointer.  XOR the words through the same accessor every other
  // wide read uses.  Only a plain signal reference can be served this way;
  // anything else returns empty so the caller fails LOUDLY rather than
  // emitting a parity over a truncated or fabricated value.
  std::string base;
  if (!isPlainSignalRef(expr, &base))
    return std::string();
  unsigned nWords = (width + 63) / 64;
  std::string acc;
  for (unsigned i = 0; i < nWords; ++i) {
    std::string wexp = "qpw_wide_extract(s->" + base + ", " +
                       std::to_string(nWords) + ", " +
                       std::to_string(i * 64) + ", " +
                       std::to_string(std::min(64u, width - i * 64)) + ")";
    acc = acc.empty() ? wexp : (acc + " ^ " + wexp);
  }
  return "(__builtin_parityll(" + acc + "))";
}


//===----------------------------------------------------------------------===//
// Expression Translator (recursive)
//===----------------------------------------------------------------------===//

/// Recursively translate Value to C expression
/// A memory array sig (`llhd.sig : !hw.inout<array<N x iW>>`, integer
/// elements, left whole because it is runtime-indexed and larger than the
/// explode cap).  The emitter registers it as an N*W-bit wide field
/// (`uint64_t name[words]`).
struct MemoryArrayRef {
  std::string name;      // sanitized field name (without "s->")
  unsigned elems = 0, elemWidth = 0, words = 0;
  unsigned idxMask = 0;  // (elems-1) when elems is a power of two, else 0xFFFFFFFF (caller uses %)
};
inline std::optional<MemoryArrayRef> memoryArrayRef(mlir::Value arrSig) {
  auto sigOp = arrSig.getDefiningOp<circt::llhd::SignalOp>();
  if (!sigOp || !sigOp.getName()) return std::nullopt;
  auto inout = mlir::dyn_cast<circt::llhd::RefType>(sigOp.getType());
  if (!inout) return std::nullopt;
  auto arr = mlir::dyn_cast<circt::hw::ArrayType>(inout.getNestedType());
  if (!arr) return std::nullopt;
  auto el = mlir::dyn_cast<mlir::IntegerType>(arr.getElementType());
  if (!el || el.getWidth() > 64) return std::nullopt;
  MemoryArrayRef r;
  r.name = sanitizeSignalName(sigOp.getName()->str());
  r.elems = arr.getNumElements();
  r.elemWidth = el.getWidth();
  r.words = (unsigned)(((uint64_t)r.elems * r.elemWidth + 63) / 64);
  r.idxMask = (r.elems & (r.elems - 1)) == 0 ? (r.elems - 1) : 0xFFFFFFFFu;
  return r;
}

inline TranslateResult translateValue(mlir::Value val, unsigned maxDepth);

/// Inline-expand a single-block func.func call: bind the callee's block args
/// to the translated actuals, symbolically evaluate the body's local signals
/// (llhd.sig / drv / prb — the importer's encoding of SV function locals,
/// e.g. prim_sha2_pkg::compress_multi_256's working vars), then hand the
/// ReturnOp's operand to `consume` WHILE the bindings are still active.
/// `consume` decides what to translate from it: the whole scalar (classic
/// helper functions) or one element of a returned hw.array_create (the
/// array_get(func.call) shape at sha2's compression call sites).
inline TranslateResult inlineFuncCallWith(
    mlir::func::CallOp call, unsigned maxDepth,
    llvm::function_ref<TranslateResult(mlir::Value)> consume) {
  auto callee = mlir::SymbolTable::lookupNearestSymbolFrom<mlir::func::FuncOp>(
      call, call.getCalleeAttr());
  if (!callee || callee.getBody().empty())
    return TranslateResult::fail("func.call: callee not inlinable");
  mlir::Region &creg = callee.getBody();
  mlir::Block &body = creg.front();

  // ACYCLIC MULTI-BLOCK bodies are inlinable.  A package function whose loop
  // the unroller has already flattened still leaves if/else DIAMONDS —
  // lc_ctrl_pkg::lc_tx_and picks and-vs-or per bit, prim_fifo_async's
  // gray2dec has an MSB fix-up — and requiring ONE block refused all of them,
  // silently deleting the drives that call them (spi_device's FIFO read/write
  // pointers among them).  Nothing new is needed to express this: a block's
  // drives simply happen under that block's PATH CONDITION, and folding a
  // condition into a drive is what the enable handling below already does.
  // Cyclic bodies are still refused — loop flattening is the unroller's job.
  llvm::SmallVector<mlir::Block *, 8> border;
  {
    llvm::DenseMap<mlir::Block *, int> color;   // 0 white, 1 grey, 2 black
    bool cyclic = false;
    std::function<void(mlir::Block *)> dfs = [&](mlir::Block *b) {
      color[b] = 1;
      for (mlir::Block *sc : b->getSuccessors()) {
        int c = color.lookup(sc);
        if (c == 1) { cyclic = true; return; }
        if (c == 0) { dfs(sc); if (cyclic) return; }
      }
      color[b] = 2;
      border.push_back(b);
    };
    dfs(&body);
    if (cyclic)
      return TranslateResult::fail("func.call: callee body is cyclic");
    std::reverse(border.begin(), border.end());   // reverse post-order
  }

  mlir::func::ReturnOp ret;
  for (mlir::Block *b : border)
    if (auto r = mlir::dyn_cast<mlir::func::ReturnOp>(b->getTerminator())) {
      if (ret)
        return TranslateResult::fail("func.call: multiple return sites");
      ret = r;
    }
  if (!ret || ret.getNumOperands() != 1 ||
      call.getNumOperands() != body.getNumArguments())
    return TranslateResult::fail("func.call: unexpected callee shape");
  auto &bind = callArgBindings();
  auto &vbind = callArgValueBindings();
  llvm::SmallVector<std::pair<mlir::BlockArgument, std::optional<std::string>>, 4> saved;
  llvm::SmallVector<std::pair<mlir::BlockArgument, mlir::Value>, 2> savedV;
  for (unsigned i = 0; i < call.getNumOperands(); ++i) {
    mlir::BlockArgument ba = body.getArgument(i);
    if (mlir::isa<circt::hw::ArrayType>(call.getOperand(i).getType())) {
      // Aggregate actual: bind the VALUE; the body's array_get resolves
      // through it (no single C string can carry the whole array).
      auto vit = vbind.find(ba);
      savedV.push_back({ba, vit == vbind.end() ? mlir::Value() : vit->second});
      vbind[ba] = call.getOperand(i);
      continue;
    }
    auto argExpr = translateValue(call.getOperand(i), maxDepth - 1);
    if (!argExpr.success) return argExpr;
    auto it = bind.find(ba);
    saved.push_back({ba, it == bind.end() ? std::nullopt : std::optional<std::string>(it->second)});
    bind[ba] = argExpr.expr;
  }
  auto &ls = localSigBindings();
  llvm::SmallVector<mlir::Value, 4> localSigs;
  TranslateResult failure = TranslateResult::ok("");
  bool failed = false;

  // Path condition per block, as a C expression.  Reverse post-order on an
  // acyclic CFG guarantees every predecessor is finished before its successor
  // is reached, so the OR over incoming edges is complete when it is used.
  llvm::DenseMap<mlir::Block *, std::string> pcond;
  pcond[&body] = "1";
  // BLOCK ARGUMENTS ARE PHIs, AND A PHI IS A SELECT OVER THE INCOMING EDGES.
  //
  // This used to refuse any branch carrying operands, which is where
  // entropy_src's and kmac's `u_sha3.sha3_fsm_o` died — the SHA-3 FSM state
  // the output bridge needs.  Refusing was right while there was nothing to
  // merge WITH, but the loop already computes a path condition per block, and
  // reverse post-order guarantees every predecessor is finished before its
  // successor is reached.  So by the time a block is visited, all of its
  // incoming edges are known and each block argument can be spelled as a
  // ternary chain over them.  phiIn[B][i] collects (edge condition, value).
  llvm::DenseMap<mlir::Block *,
                 llvm::SmallVector<llvm::SmallVector<
                     std::pair<std::string, std::string>, 2>, 2>> phiIn;
  for (mlir::Block *b : border) {
    // Materialise this block's phis first: its predecessors are all behind us.
    if (b != &body && b->getNumArguments()) {
      auto pit = phiIn.find(b);
      for (unsigned ai = 0; ai < b->getNumArguments(); ++ai) {
        if (pit == phiIn.end() || ai >= pit->second.size() ||
            pit->second[ai].empty()) {
          failure = TranslateResult::fail(
              "func.call: block argument with no incoming edge value");
          failed = true;
          break;
        }
        const auto &ins = pit->second[ai];
        std::string e = ins.back().second;          // last edge is the default
        for (int k = (int)ins.size() - 2; k >= 0; --k)
          e = "((" + ins[k].first + ") ? (" + ins[k].second + ") : (" + e + "))";
        mlir::BlockArgument ba = b->getArgument(ai);
        auto itb = bind.find(ba);
        saved.push_back({ba, itb == bind.end()
                                 ? std::nullopt
                                 : std::optional<std::string>(itb->second)});
        bind[ba] = e;
      }
      if (failed) break;
    }
    auto itc = pcond.find(b);
    std::string bc = itc == pcond.end() ? std::string("0") : itc->second;
    auto addEdge = [&](mlir::Block *dst, const std::string &c) {
      auto it2 = pcond.find(dst);
      if (it2 == pcond.end()) pcond[dst] = c;
      else it2->second = "((" + it2->second + ") || (" + c + "))";
    };
    auto addArgs = [&](mlir::Block *dst, const std::string &c,
                       mlir::OperandRange ops) -> bool {
      if (ops.empty())
        return true;
      auto &slots = phiIn[dst];
      if (slots.size() < ops.size())
        slots.resize(ops.size());
      for (unsigned i = 0; i < ops.size(); ++i) {
        auto oE = translateValue(ops[i], maxDepth - 1);
        if (!oE.success) { failure = oE; return false; }
        slots[i].push_back({c, oE.expr});
      }
      return true;
    };
    mlir::Operation *term = b->getTerminator();
    if (auto br = mlir::dyn_cast<mlir::cf::BranchOp>(term)) {
      if (!addArgs(br.getDest(), bc, br.getDestOperands())) {
        failed = true; break;
      }
      addEdge(br.getDest(), bc);
    } else if (auto cbr = mlir::dyn_cast<mlir::cf::CondBranchOp>(term)) {
      auto cE = translateValue(cbr.getCondition(), maxDepth - 1);
      if (!cE.success) { failure = cE; failed = true; break; }
      std::string tc = "((" + bc + ") && (" + cE.expr + "))";
      std::string fc = "((" + bc + ") && !(" + cE.expr + "))";
      if (!addArgs(cbr.getTrueDest(), tc, cbr.getTrueDestOperands()) ||
          !addArgs(cbr.getFalseDest(), fc, cbr.getFalseDestOperands())) {
        failed = true; break;
      }
      addEdge(cbr.getTrueDest(), tc);
      addEdge(cbr.getFalseDest(), fc);
    } else if (!mlir::isa<mlir::func::ReturnOp>(term)) {
      failure = TranslateResult::fail(
          "func.call: unsupported terminator " +
          term->getName().getStringRef().str());
      failed = true; break;
    }
  }

  for (mlir::Block *blk : border) {
   if (failed) break;
   std::string blockCond = pcond.lookup(blk);
   for (mlir::Operation &op : *blk) {
    if (auto sg = mlir::dyn_cast<circt::llhd::SignalOp>(op)) {
      auto initE = translateValue(sg.getInit(), maxDepth - 1);
      if (!initE.success) { failure = initE; failed = true; break; }
      ls[sg.getResult()] = initE.expr;
      localSigs.push_back(sg.getResult());
      continue;
    }
    if (auto d = mlir::dyn_cast<circt::llhd::DriveOp>(op)) {
      mlir::Value tgt = d.getSignal();
      mlir::Value base = tgt;
      std::optional<std::string> loExpr; unsigned sliceW = 0;
      if (auto ex = tgt.getDefiningOp<circt::llhd::SigExtractOp>()) {
        base = ex.getInput();
        auto lo = translateValue(ex.getLowBit(), maxDepth - 1);
        if (!lo.success) { failure = lo; failed = true; break; }
        loExpr = lo.expr;
        sliceW = mlir::cast<circt::llhd::RefType>(ex.getType()).getNestedType().getIntOrFloatBitWidth();
      }
      auto it = ls.find(base);
      if (it == ls.end()) continue;   // not a local sig: out of scope for a comb func
      auto v = translateValue(d.getValue(), maxDepth - 1);
      if (!v.success) { failure = v; failed = true; break; }
      std::string enExpr;
      if (d.getEnable()) {
        auto en = translateValue(d.getEnable(), maxDepth - 1);
        if (!en.success) { failure = en; failed = true; break; }
        enExpr = en.expr;
      }
      // The block's path condition is just another enable.  "1" (the entry
      // block) folds away, so a single-block callee is spelled exactly as
      // before this became multi-block-aware.
      if (blockCond != "1")
        enExpr = enExpr.empty() ? blockCond
                                : ("(" + blockCond + ") && (" + enExpr + ")");
      if (!enExpr.empty())
        v.expr = "((" + enExpr + ") ? (" + v.expr + ") : (" + it->second + "))";
      if (!loExpr) { it->second = "(" + v.expr + ")"; continue; }
      std::string mask = sliceW >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                                      : ("((1ULL << " + std::to_string(sliceW) + ") - 1)");
      it->second = "((((uint64_t)(" + it->second + ")) & ~(" + mask + " << (" + *loExpr + "))) | ((((uint64_t)(" +
                   v.expr + ")) & " + mask + ") << (" + *loExpr + ")))";
      continue;
    }
   }
  }
  TranslateResult res = failed ? failure : consume(ret.getOperand(0));
  for (mlir::Value sv : localSigs) ls.erase(sv);
  for (auto &[ba, old] : saved) { if (old) bind[ba] = *old; else bind.erase(ba); }
  for (auto &[ba, old] : savedV) { if (old) vbind[ba] = old; else vbind.erase(ba); }
  if (!res.success) return res;
  return TranslateResult::ok("(" + res.expr + ")");
}
/// Bit-slice [off, off+width) of a packed integer VALUE `v` (already
/// translated to `inExpr`), width-aware: constants are folded from the APInt,
/// <=64-bit inputs use shift/mask, <=128-bit go through __uint128_t, wider
/// named signals use the word-array helper.  Returns nullopt when it cannot be
/// expressed.
inline std::optional<std::string> packedSliceExpr(mlir::Value v, const std::string &inExpr,
                                                  unsigned inWidth, unsigned off,
                                                  unsigned width) {
  // Spell the mask exactly as genMask() does below 64 bits: slicePacked's
  // scalar bottom uses genMask, so aligning here makes "route the wide bottom
  // through packedSliceExpr" a TEXTUALLY NEUTRAL change for expressions that
  // already translate, instead of a fleet-wide re-spelling of masks.
  // The >= 64 branch keeps the literal on purpose: genMask(65..127) returns a
  // __uint128_t form, which would change the TYPE of the masked result here.
  std::string mask = width >= 64 ? "0xFFFFFFFFFFFFFFFFULL" : genMask(width);
  // `v` is optional: a caller may hold the element's EXPRESSION without a live
  // Value (e.g. after translating a synthesised access and erasing it).  Only
  // the constant fold needs the Value.
  if (auto c = v ? v.getDefiningOp<circt::hw::ConstantOp>() : nullptr) {
    llvm::APInt bits = c.getValue().lshr(off).zextOrTrunc(std::max(width, 1u));
    llvm::SmallString<32> hex;
    bits.zextOrTrunc(64).toString(hex, 16, false);
    return "((uint64_t)0x" + std::string(hex) + "ULL)";
  }
  if (inWidth <= 64)
    return "((((uint64_t)(" + inExpr + ")) >> " + std::to_string(off) + ") & " + mask + ")";
  if (inWidth <= 128)
    return "(((uint64_t)(((__uint128_t)(" + inExpr + ")) >> " + std::to_string(off) + ")) & " + mask + ")";
  std::string baseName;
  if (isPlainSignalRef(inExpr, &baseName) && width <= 64)
    // ceil, NOT floor: FlatSignalRegistry allocates nWords = ceil(bitWidth/64),
    // and qpw_wide_extract returns 0 for wordIdx >= nWords — with floor, the
    // TOP word of any signal whose width is not a multiple of 64 read as a
    // silent ZERO.
    return "qpw_wide_extract(s->" + baseName + ", " +
           std::to_string((inWidth + 63) / 64) + ", " + std::to_string(off) +
           ", " + std::to_string(width) + ")";
  return std::nullopt;
}


/// Spell a type for a diagnostic.  The lost-arm audit is driven entirely by
/// these strings, so a failure that does not say WHAT it landed on costs hours
/// of re-derivation later.
inline std::string tyStr(mlir::Type t) {
  std::string out;
  llvm::raw_string_ostream os(out);
  os << t;
  return os.str();
}

/// Bit-range ROUTER over a VALUE: a C expression for bits [off, off+w) of `v`
/// (w <= 64), obtained by pushing the request DOWN the expression tree rather
/// than demanding one expression for the whole — possibly thousands of bits
/// wide — value.  This lived as a lambda inside translateValue's hw.array_get
/// handler; it is hoisted verbatim so the WIDE-DRIVE channel in
/// CombLogicExtractPass can reach the same rules instead of carrying its own
/// weaker hand-rolled copy of them.  The body below is a PURE MOVE.
inline TranslateResult sliceValue(mlir::Value v0, uint64_t off0, unsigned w0,
                                  int maxDepth) {
      std::string selErr;  // why a two-way select could not be split, if any
      std::function<TranslateResult(mlir::Value, uint64_t, unsigned)>
          slicePacked = [&](mlir::Value v, uint64_t off,
                            unsigned w) -> TranslateResult {
        if (auto bc2 = v.getDefiningOp<circt::hw::BitcastOp>())
          return slicePacked(bc2.getInput(), off, w);
        // comb.extract is bit-transparent, exactly like the bitcast above:
        //   slice(extract(x, lowBit), off, w) == slice(x, lowBit + off, w)
        // On failure fall THROUGH to the rules below, so nothing that already
        // translated can lose its handler.
        if (auto ex2 = v.getDefiningOp<circt::comb::ExtractOp>()) {
          auto rr = slicePacked(ex2.getInput(), off + ex2.getLowBit(), w);
          if (rr.success)
            return rr;
        }
        // Nested constant array_get folds into the offset: element k of the
        // OUTER array occupies [k*elemBW, (k+1)*elemBW) of its input.  aes's
        // add_round_key lands here: array_get(array_get(bitcast(xor : i128)))
        // — the outer get's result is itself an aggregate, so the caller's
        // per-element route can't finish; the offset math can.
        if (auto ag2 = v.getDefiningOp<circt::hw::ArrayGetOp>()) {
          if (auto idxC =
                  ag2.getIndex().getDefiningOp<circt::hw::ConstantOp>()) {
            int64_t ebw = circt::hw::getBitWidth(ag2.getType());
            if (ebw > 0)
              return slicePacked(ag2.getInput(),
                                 off + idxC.getValue().getZExtValue() *
                                           (uint64_t)ebw,
                                 w);
          } else if (auto aTy = mlir::dyn_cast<circt::hw::ArrayType>(
                         ag2.getInput().getType())) {
            // RUNTIME index: the offset cannot be folded, but the element set
            // is FINITE, so ask for the same window of every element and pick
            // with a select chain — the same shape translateValue already
            // emits on the read side.  keymgr's KeyUpdateKmac else-arm
            // (`key_state_q[cdi_sel_o]`, cdi_sel_o being a probed signal)
            // lands here.  Bounded on purpose: the chain is O(N) in code
            // size, and a SILENT cap would be a wrong answer, so past the
            // bound we fail loudly and the drop stays visible in the log.
            int64_t ebw = circt::hw::getBitWidth(ag2.getType());
            uint64_t n = aTy.getNumElements();
            if (ebw > 0 && n >= 1 && n <= 64) {
              auto ix = translateValue(ag2.getIndex(), maxDepth - 1);
              if (ix.success) {
                std::string ixe = "((unsigned)(" + ix.expr + "))";
                std::string acc;
                bool chained = true;
                // Highest element first so it ends up as the innermost
                // default, matching the read-side convention.
                for (int64_t k = (int64_t)n - 1; k >= 0; --k) {
                  auto part = slicePacked(
                      ag2.getInput(), off + (uint64_t)k * (uint64_t)ebw, w);
                  if (!part.success) {
                    // WHICH element and WHICH window, not just "it failed".
                    // Without this the caller reports the shape of the whole
                    // array_get and the real blocker stays hidden behind it.
                    selErr = "array_get elem " + std::to_string(k) + " @" +
                             std::to_string(off + (uint64_t)k * (uint64_t)ebw) +
                             " w=" + std::to_string(w) + ": " + part.errorMsg;
                    chained = false;
                    break;
                  }
                  acc = acc.empty()
                            ? ("(" + part.expr + ")")
                            : ("((" + ixe + " == " + std::to_string(k) +
                               "u) ? (" + part.expr + ") : " + acc + ")");
                }
                if (chained)
                  return TranslateResult::ok(acc);
              }
            }
          }
        }
        // comb.mux distributes over the slice exactly like the bitwise ops
        // below: slice(mux(c,a,b), off, w) == c ? slice(a) : slice(b).  Its
        // absence was what dropped keymgr's ENTIRE digest-absorption arm
        // (`key_state_d[cdi_sel_o] = (adv_op||dis_op) ? kmac_data_i
        // : key_state_q[cdi_sel_o]`): the i512 mux fell through to the scalar
        // bottom, which handed the whole 512-bit value to translateValue, and
        // that failed.  Distributing is also what lets the two arms live in
        // DIFFERENT storage tiers (a 256-bit-element wide array on one side,
        // 64-bit words on the other) without a common wide temporary.
        // BOTH spellings of a two-way select must be covered.  A runtime index
        // into an array signal is lowered by ExplodeStructSigsPass into a
        // select CHAIN over the exploded per-element probes, and that pass
        // picks comb.mux for INTEGER elements but arith.select for AGGREGATE
        // ones.  Matching only comb.mux therefore catches half the shape and
        // silently misses every wide aggregate case — which is exactly what
        // kept keymgr's `key_state_q[cdi_sel_o]` arm unreachable.
        mlir::Value selC, selT, selF;
        if (auto mx2 = v.getDefiningOp<circt::comb::MuxOp>()) {
          selC = mx2.getCond();
          selT = mx2.getTrueValue();
          selF = mx2.getFalseValue();
        } else if (auto as2 = v.getDefiningOp<mlir::arith::SelectOp>()) {
          selC = as2.getCondition();
          selT = as2.getTrueValue();
          selF = as2.getFalseValue();
        }
        if (selC) {
          auto c = translateValue(selC, maxDepth - 1);
          if (!c.success) {
            selErr = "select cond: " + c.errorMsg;
          } else {
            auto tv2 = slicePacked(selT, off, w);
            if (!tv2.success) {
              selErr = "select true-arm: " + tv2.errorMsg;
            } else {
              auto fv2 = slicePacked(selF, off, w);
              if (fv2.success)
                return TranslateResult::ok("((" + c.expr + ") ? (" + tv2.expr +
                                           ") : (" + fv2.expr + "))");
              selErr = "select false-arm: " + fv2.errorMsg;
            }
          }
          // fall through: a mux we cannot split is still eligible for the
          // whole-value rules below, exactly as before this rule existed.
          // selErr is carried down so the reason is not ERASED: a silently
          // swallowed arm failure is what made the first pass of this
          // diagnosis blame the wrong op entirely.
        }
        // Bitwise element-wise ops distribute over the slice:
        // slice(xor(a,b), off, w) == xor(slice(a), slice(b)).  This is what
        // lets a >64-bit xor bottom (aes's 128-bit state ^ round_key, packed
        // by the canonicalizer) resolve without a wide temporary.
        if (auto *bop = v.getDefiningOp()) {
          const char *cop = llvm::isa<circt::comb::XorOp>(bop)   ? " ^ "
                            : llvm::isa<circt::comb::AndOp>(bop) ? " & "
                            : llvm::isa<circt::comb::OrOp>(bop)  ? " | "
                                                                 : nullptr;
          if (cop && bop->getNumOperands() >= 2) {
            std::string expr;
            for (mlir::Value o : bop->getOperands()) {
              auto part = slicePacked(o, off, w);
              if (!part.success)
                return part;
              expr = expr.empty() ? ("(" + part.expr + ")")
                                  : (expr + cop + "(" + part.expr + ")");
            }
            return TranslateResult::ok("(" + expr + ")");
          }
        }
        if (auto cc = v.getDefiningOp<circt::comb::ConcatOp>()) {
          // Gather every operand fragment overlapping [off, off+w) and
          // shift-OR them together — a straddling range (the W-extension
          // arm packs unequal-width pieces) is handled, not refused.
          uint64_t pos = 0;
          std::string expr;
          for (int i = (int)cc.getNumOperands() - 1; i >= 0; --i) {
            mlir::Value o = cc.getOperand(i);
            uint64_t ow = o.getType().getIntOrFloatBitWidth();
            uint64_t lo = std::max<uint64_t>(off, pos);
            uint64_t hi = std::min<uint64_t>(off + w, pos + ow);
            if (lo < hi) {
              auto part = slicePacked(o, lo - pos, (unsigned)(hi - lo));
              if (!part.success)
                return part;
              std::string piece =
                  "(((uint64_t)(" + part.expr + ")) << " +
                  std::to_string(lo - off) + ")";
              expr = expr.empty() ? piece : (expr + " | " + piece);
            }
            pos += ow;
          }
          if (expr.empty())
            return TranslateResult::fail("slicePacked: empty concat range");
          return TranslateResult::ok("((" + expr + ") & " + genMask(w) + ")");
        }
        // A CONSTANT-amount shift is pure offset arithmetic on the window,
        // so routing through it costs nothing — and WITHOUT it a wide shifted
        // value falls to the scalar bottom, where nothing above 128 bits has
        // a carrier.  (Runtime shift amounts are a different problem and keep
        // their own dedicated channel in the extract pass.)
        if (auto shl = v.getDefiningOp<circt::comb::ShlOp>()) {
          if (auto kc =
                  shl.getOperand(1).getDefiningOp<circt::hw::ConstantOp>()) {
            uint64_t k = kc.getValue().getZExtValue();
            if (off + w <= k)
              return TranslateResult::ok("0");    // window is below the fill
            if (off >= k)
              return slicePacked(shl.getOperand(0), off - k, w);
            unsigned lowZ = (unsigned)(k - off);  // straddles the fill edge
            auto hi = slicePacked(shl.getOperand(0), 0, w - lowZ);
            if (!hi.success)
              return hi;
            return TranslateResult::ok("((((uint64_t)(" + hi.expr + ")) << " +
                                       std::to_string(lowZ) + ") & " +
                                       genMask(w) + ")");
          }
        }
        if (auto shr = v.getDefiningOp<circt::comb::ShrUOp>()) {
          if (auto kc =
                  shr.getOperand(1).getDefiningOp<circt::hw::ConstantOp>()) {
            uint64_t k = kc.getValue().getZExtValue();
            uint64_t iw2 = shr.getOperand(0).getType().getIntOrFloatBitWidth();
            if (off + k >= iw2)
              return TranslateResult::ok("0");   // window shifted past the top
            unsigned take =
                (unsigned)std::min<uint64_t>(w, iw2 - (off + k));
            auto p = slicePacked(shr.getOperand(0), off + k, take);
            if (!p.success)
              return p;
            if (take == w)
              return p;
            // the window's top bits are the logical-shift zero fill
            return TranslateResult::ok("(((uint64_t)(" + p.expr + ")) & " +
                                       genMask(take) + ")");
          }
        }
        if (auto rep = v.getDefiningOp<circt::comb::ReplicateOp>()) {
          uint64_t iw = rep.getInput().getType().getIntOrFloatBitWidth();
          if (!iw)
            return TranslateResult::fail("slicePacked: zero-width replicate");
          if ((off % iw) + w <= iw)
            return slicePacked(rep.getInput(), off % iw, w);
          // THE WINDOW CROSSES COPY BOUNDARIES.  Refusing here used to be the
          // end of the road, and it cost keymgr's 800-bit
          // u_kmac_if.gen_data_i: the KMAC application-channel payload
          // reached the input bridge as a mux whose arm contained a
          // replicate, every 64-bit word request crossed copies, and the
          // whole key-derivation message arrived as zeros.
          //
          // A 1-bit input is the dominant shape (a valid/mubi bit fanned out
          // as a mask), and there every bit of the window is that same bit.
          if (iw == 1) {
            auto b = slicePacked(rep.getInput(), 0, 1);
            if (!b.success)
              return b;
            return TranslateResult::ok("((" + b.expr + ") ? " + genMask(w) +
                                       " : 0)");
          }
          // Otherwise gather the overlapping copies exactly as the concat
          // rule does.  Bounded on purpose: a 64-bit window over a narrow
          // input would otherwise expand into dozens of terms, and an
          // expression that large is a different problem from a correct one.
          uint64_t firstC = off / iw, lastC = (off + w - 1) / iw;
          if (lastC - firstC + 1 > 8)
            return TranslateResult::fail(
                "slicePacked: replicate window spans " +
                std::to_string(lastC - firstC + 1) + " copies of " +
                std::to_string(iw) + " bits");
          std::string gathered;
          for (uint64_t k = firstC; k <= lastC; ++k) {
            uint64_t lo = std::max<uint64_t>(off, k * iw);
            uint64_t hi = std::min<uint64_t>(off + w, (k + 1) * iw);
            auto p = slicePacked(rep.getInput(), lo - k * iw, hi - lo);
            if (!p.success)
              return p;
            std::string term = "(((uint64_t)(" + p.expr + ")) << " +
                               std::to_string(lo - off) + ")";
            gathered = gathered.empty() ? term : (gathered + " | " + term);
          }
          return TranslateResult::ok("((" + gathered + ") & " + genMask(w) +
                                     ")");
        }
        if (auto arrTy = mlir::dyn_cast<circt::hw::ArrayType>(v.getType())) {
          // Aggregate-element array_create (array<N x array<...>>): locate
          // the element owning the range and recurse with a local offset.
          if (auto acAgg = v.getDefiningOp<circt::hw::ArrayCreateOp>()) {
            int64_t ebw = circt::hw::getBitWidth(arrTy.getElementType());
            if (ebw > 0 && !mlir::isa<mlir::IntegerType>(
                               arrTy.getElementType())) {
              uint64_t k = off / (uint64_t)ebw;
              unsigned n2 = acAgg.getNumOperands();
              if (k < n2 && (off % ebw) + w <= (uint64_t)ebw)
                return slicePacked(acAgg.getOperand(n2 - 1 - k),
                                   off % (uint64_t)ebw, w);
            }
          }
          auto eTy =
              mlir::dyn_cast<mlir::IntegerType>(arrTy.getElementType());
          // A slice spanning MULTIPLE integer elements (aes's data_out
          // words: 32-bit slices over array<16xi8>): stitch per-element
          // slices together shift-OR-wise, LSB element first.
          if (eTy && eTy.getWidth() && w > eTy.getWidth() &&
              off % eTy.getWidth() == 0 && w % eTy.getWidth() == 0) {
            unsigned ew = eTy.getWidth();
            std::string expr;
            for (unsigned p = 0; p < w / ew; ++p) {
              auto part = slicePacked(v, off + (uint64_t)p * ew, ew);
              if (!part.success)
                return part;
              std::string piece = "(((uint64_t)(" + part.expr + ")) << " +
                                  std::to_string(p * ew) + ")";
              expr = expr.empty() ? piece : (expr + " | " + piece);
            }
            return TranslateResult::ok("((" + expr + ") & " + genMask(w) +
                                       ")");
          }
          // Sub-element slice (aes's iv_d: 16-bit lanes over array<4xi32> —
          // the slice lives INSIDE one integer element at a non-zero
          // offset): slice the owning element's expression.
          if (eTy && eTy.getWidth() && w < eTy.getWidth() &&
              (off % eTy.getWidth()) + w <= eTy.getWidth()) {
            unsigned ew = eTy.getWidth();
            uint64_t k = off / ew, inOff = off % ew;
            std::optional<TranslateResult> elem;
            mlir::Value elemVal;   // set only when we have the element's Value
            if (auto acOp = v.getDefiningOp<circt::hw::ArrayCreateOp>()) {
              unsigned n2 = acOp.getNumOperands();
              if (k < n2) {
                elemVal = acOp.getOperand(n2 - 1 - k);
                elem = translateValue(elemVal, maxDepth - 1);
              }
            } else {
              std::string nm = getSignalName(v);
              // "s->unnamed" is getSignalName's SENTINEL for a probe it could
              // not name, not a field.  Appending an index to it fabricates
              // `s->unnamed_0_`, which either fails to compile or — worse —
              // aliases onto a real field of that name.  Treat it as no name
              // and let the delegation below do the work.
              if (!nm.empty() && nm != "s->unnamed") {
                std::string raw =
                    nm.compare(0, 3, "s->") == 0 ? nm.substr(3) : nm;
                elem = TranslateResult::ok(
                    "s->" + sanitizeSignalName(raw + "[" +
                                               std::to_string(k) + "]"));
              }
            }
            // Last resort for an element we cannot NAME here: synthesise the
            // element access and let translateValue's full hw.array_get
            // machinery resolve it — struct-field naming, memory arrays,
            // exploded aggregates.  Duplicating that knowledge in the router
            // is how it drifts.  keymgr's `flash_i.seeds[CreatorSeedIdx]` is
            // the case that needed it: an array<2xi256> reached through
            // hw.struct_extract, a shape getSignalName has no rule for, which
            // left the OwnerInt/Owner ADVANCE message vectors dropped.
            if ((!elem || !elem->success) && v.getDefiningOp()) {
              mlir::Operation *dv = v.getDefiningOp();
              mlir::OpBuilder b(dv);
              b.setInsertionPointAfter(dv);
              unsigned nEl = arrTy.getNumElements();
              unsigned iw = nEl > 1 ? llvm::Log2_64_Ceil(nEl) : 1;
              auto kc = b.create<circt::hw::ConstantOp>(
                  dv->getLoc(), b.getIntegerType(iw), (int64_t)k);
              auto tg = b.create<circt::hw::ArrayGetOp>(dv->getLoc(), v,
                                                        kc.getResult());
              auto r = translateValue(tg.getResult(), maxDepth - 1);
              tg->erase();
              kc->erase();
              if (r.success) {
                elem = r;
                elemVal = mlir::Value();   // the Value is gone; expr remains
              }
            }
            if (elem && elem->success) {
              // An element WIDER than 64 bits cannot go through the uint64_t
              // cast below: above 128 bits the emitter stores the element as
              // `uint64_t name[nWords]`, and casting that field to uint64_t
              // decays the ARRAY TO A POINTER — it compiles, and it yields
              // silent garbage.  Nothing reached here before (the comb.mux
              // gap upstream refused first), so this is a latent trap being
              // closed, not a live bug.  packedSliceExpr knows the tiers.
              if (ew > 64) {
                // ASK THE ROUTER BEFORE DEMANDING A NAMED STORAGE TIER.
                //
                // packedSliceExpr can only work from a plain signal
                // reference, so an element that is itself a computed
                // aggregate — `hw.bitcast(hw.array_create(...))` — could
                // never satisfy it, and the request died as "no storage
                // tier".  The router has a struct landing that slices the
                // already-exploded leaf probes, which is exactly what such an
                // element is made of.
                //
                // csrng is the case: its DRBG state element is a 418-bit
                // struct (fips + inst_state + key256 + v128 + rs_ctr32), so
                // `state_reg_readout` was read once and written never, and
                // INT_STATE_VAL at offset 0x44 returned zeros.
                // dif_csrng_get_internal_state() therefore reports kDifOk
                // with a plausible-looking all-zero DRBG state, while
                // RESEED_COUNTER_* stays correct on a different path — a
                // localised wrong answer, which is the hardest kind to spot.
                if (elemVal) {
                  auto r = slicePacked(elemVal, inOff, w);
                  if (r.success)
                    return r;
                }
                if (auto ps = packedSliceExpr(elemVal, elem->expr, ew,
                                              (unsigned)inOff, w))
                  return TranslateResult::ok(*ps);
                return TranslateResult::fail(
                    "slicePacked: wide array element (ew=" +
                    std::to_string(ew) + ") with no storage tier");
              }
              return TranslateResult::ok(
                  "((((uint64_t)(" + elem->expr + ")) >> " +
                  std::to_string(inOff) + ") & " + genMask(w) + ")");
            }
          }
          // A WINDOW INSIDE ONE ELEMENT, not only a whole element.
          //
          // The rule below folds `off` to an element index but insists the
          // request be exactly one element wide, so a 64-bit word inside a
          // 418-bit element had no rule and the router gave up with
          // "aggregate landing ... from hw.array_create".  csrng is the case:
          // its DRBG state is array<3 x struct<fips, inst_state, key:i256,
          // v:i128, rs_ctr:i32>>, the readout indexes it at runtime, and the
          // per-element select chain right above asks for a 64-bit window of
          // each element in turn.  So `state_reg_readout` was never written
          // and INT_STATE_VAL at offset 0x44 read zeros —
          // dif_csrng_get_internal_state() returning kDifOk with a
          // plausible all-zero DRBG state.
          if (eTy && eTy.getWidth() && w <= eTy.getWidth() &&
              (off % eTy.getWidth()) + w <= eTy.getWidth() &&
              !(off % eTy.getWidth() == 0 && w == eTy.getWidth())) {
            uint64_t ew2 = eTy.getWidth();
            uint64_t k2 = off / ew2;
            if (auto acOp = v.getDefiningOp<circt::hw::ArrayCreateOp>()) {
              unsigned n3 = acOp.getNumOperands();
              if (k2 < n3)
                return slicePacked(acOp.getOperand(n3 - 1 - k2), off % ew2, w);
            }
          }
          if (eTy && eTy.getWidth() && off % eTy.getWidth() == 0 &&
              w == eTy.getWidth()) {
            uint64_t k = off / eTy.getWidth();
            if (auto acOp = v.getDefiningOp<circt::hw::ArrayCreateOp>()) {
              unsigned n2 = acOp.getNumOperands();
              if (k < n2)
                return translateValue(acOp.getOperand(n2 - 1 - k),
                                      maxDepth - 1);
              return TranslateResult::fail("slicePacked: element range");
            }
            std::string nm = getSignalName(v);
            if (!nm.empty()) {
              std::string raw =
                  nm.compare(0, 3, "s->") == 0 ? nm.substr(3) : nm;
              return TranslateResult::ok(
                  "s->" + sanitizeSignalName(raw + "[" + std::to_string(k) +
                                             "]"));
            }
          }
          return TranslateResult::fail(
              "slicePacked: aggregate landing on " + tyStr(v.getType()) +
              (v.getDefiningOp()
                   ? (" from " + v.getDefiningOp()->getName().getStringRef().str())
                   : std::string(" from block-arg")));
        }
        // STRUCT landing, the twin of the array landing above.  hw.struct
        // packs MSB-FIRST — the first declared field owns the TOP bits — so
        // walk down from the top, find the field owning [off, off+w), and
        // recurse into it with a local offset.  csrng's 448-bit
        // state_reg_readout muxes whole DRBG state structs; without this the
        // router hits a struct and gives up, and the readout is dropped.
        if (auto stTy = mlir::dyn_cast<circt::hw::StructType>(v.getType())) {
          int64_t total = circt::hw::getBitWidth(stTy);
          if (total > 0) {
            // GATHER every field overlapping [off, off+w) and shift-OR the
            // pieces, exactly as the comb.concat rule does.  A 64-bit window
            // routinely STRADDLES fields (csrng's word 0 spans rs_ctr[31:0]
            // and the bottom 32 bits of v), so an owning-field-only rule
            // matches almost nothing.
            uint64_t pos = (uint64_t)total;
            auto flds = stTy.getElements();
            std::string expr, stErr;
            bool okAll = true;
            for (size_t fi = 0; fi < flds.size() && okAll; ++fi) {
              int64_t fw = circt::hw::getBitWidth(flds[fi].type);
              if (fw <= 0) { okAll = false; break; }
              uint64_t lo = pos - (uint64_t)fw;   // field owns [lo, pos)
              pos = lo;
              uint64_t sLo = std::max<uint64_t>(off, lo);
              uint64_t sHi = std::min<uint64_t>(off + w, lo + (uint64_t)fw);
              if (sLo >= sHi)
                continue;
              TranslateResult part = TranslateResult::fail("no field access");
              if (auto sc = v.getDefiningOp<circt::hw::StructCreateOp>()) {
                if (fi < sc.getNumOperands())
                  part = slicePacked(sc.getOperand(fi), sLo - lo,
                                     (unsigned)(sHi - sLo));
              } else if (mlir::Operation *dv = v.getDefiningOp()) {
                // Synthesise the field access and let the rest of the
                // machinery name it, rather than duplicating struct naming
                // here (same delegation as the array element path).
                mlir::OpBuilder b(dv);
                b.setInsertionPointAfter(dv);
                auto se = b.create<circt::hw::StructExtractOp>(
                    dv->getLoc(), v, flds[fi].name);
                part = slicePacked(se.getResult(), sLo - lo,
                                   (unsigned)(sHi - sLo));
                se->erase();
              }
              if (!part.success) {
                okAll = false;
                stErr = "struct field '" + flds[fi].name.str() + "': " +
                        part.errorMsg;
                break;
              }
              std::string piece = "(((uint64_t)(" + part.expr + ")) << " +
                                  std::to_string(sLo - off) + ")";
              expr = expr.empty() ? piece : (expr + " | " + piece);
            }
            if (okAll && !expr.empty())
              return TranslateResult::ok("((" + expr + ") & " + genMask(w) +
                                         ")");
            // No later rule can serve a struct, so report WHY rather than
            // falling through to a generic "non-integer bottom" that names
            // the type but not the obstacle.
            return TranslateResult::fail(
                "slicePacked: struct landing on " + tyStr(v.getType()) + " (" +
                (stErr.empty() ? ("no field covered [" + std::to_string(off) +
                                  "," + std::to_string(off + w) + ") of " +
                                  std::to_string(total))
                               : stErr) + ")");
          }
        }
        if (!v.getType().isIntOrFloat())
          return TranslateResult::fail("slicePacked: non-integer bottom " +
                                       tyStr(v.getType()));
        uint64_t vw = v.getType().getIntOrFloatBitWidth();
        // A WIDE CONSTANT folds straight out of its APInt and needs no carrier
        // expression, so ask packedSliceExpr BEFORE translateValue — whose
        // wide-literal spelling is not valid C.  hmac's HMAC padding makes
        // this concrete: `key ^ {64{8'h36}}` has a 512-bit constant operand,
        // and translateValue renders it as "0x3636…36ULL", a 128-hex-digit
        // literal with a `unsigned long long` suffix.  Reaching the fold
        // first turns that into the correct per-word constant instead.
        if (vw > 64 && v.getDefiningOp<circt::hw::ConstantOp>())
          if (auto pc = packedSliceExpr(v, std::string(), (unsigned)vw,
                                        (unsigned)off, w))
            return TranslateResult::ok(*pc);
        auto e = translateValue(v, maxDepth - 1);
        if (!e.success)
          // Say WHAT the router handed off and failed on.  A bare
          // translateValue message names the whole-drive op, which tells you
          // nothing about which sub-value inside a 1152-bit expression beat
          // the router — that opacity is what kept these families unread.
          return TranslateResult::fail(
              e.errorMsg + " [router bottom: " +
              (v.getDefiningOp()
                   ? v.getDefiningOp()->getName().getStringRef().str()
                   : std::string("block-arg")) +
              " w=" + std::to_string(vw) +
              (selErr.empty() ? std::string() : ("; " + selErr)) + "]");
        if (vw <= 64) {
          if (off == 0 && w == vw)
            return e;
          return TranslateResult::ok("((((uint64_t)(" + e.expr + ")) >> " +
                                     std::to_string(off) + ") & " +
                                     genMask(w) + ")");
        }
        // A >64-bit bottom used to be REFUSED outright — the old message
        // ("wide unnamed bottom") was a misnomer: the branch never looked at
        // the name, only the width.  packedSliceExpr, in this same file,
        // already knows the three storage tiers the emitter actually
        // allocates (wide constant fold / __uint128_t / named word array), so
        // this is the DELETION of a width guard, not new machinery.
        if (auto ps = packedSliceExpr(v, e.expr, (unsigned)vw, (unsigned)off, w))
          return TranslateResult::ok(*ps);
        return TranslateResult::fail(
            "slicePacked: wide bottom with no storage tier (w=" +
            std::to_string(vw) + ", expr=" + e.expr.substr(0, 60) + ")");
      };
  return slicePacked(v0, off0, w0);
}

/// Field `field` of a struct-typed VALUE, pushed through value-level
/// constructors (struct_create / mux / array_get-of-array_create).  Returns
/// nullopt when the input is not such a constructor (caller falls back to the
/// name-based path).
inline std::optional<TranslateResult> translateStructFieldOf(mlir::Value v,
                                                             llvm::StringRef field,
                                                             int maxDepth) {
  if (maxDepth <= 0) return std::nullopt;
  mlir::Operation *def = v.getDefiningOp();
  if (!def) return std::nullopt;
  if (auto sc = mlir::dyn_cast<circt::hw::StructCreateOp>(def)) {
    auto st = mlir::dyn_cast<circt::hw::StructType>(sc.getResult().getType());
    if (!st) return std::nullopt;
    auto elems = st.getElements();
    for (unsigned i = 0; i < elems.size(); ++i)
      if (elems[i].name.getValue() == field)
        return translateValue(sc.getOperand(i), maxDepth - 1);
    return std::nullopt;
  }
  // hw.bitcast from a PACKED integer (LowerValueStructs form): the field is
  // a bit-slice.  hw.struct packing: field 0 is the MSB, so
  // offset(field i) = sum of widths of the fields AFTER it.
  if (auto bc = mlir::dyn_cast<circt::hw::BitcastOp>(def)) {
    auto st = mlir::dyn_cast<circt::hw::StructType>(bc.getResult().getType());
    if (!st || !mlir::isa<mlir::IntegerType>(bc.getInput().getType()))
      return std::nullopt;
    // A probe (or extract-of-probe) source names an EXPLODED aggregate
    // sig: its "integer" translation is the aggregate ROOT name, which
    // has no scalar state field — the slice would read a fabricated
    // zero field (and lc_ctrl's it OVERRODE the real a_ready bridge,
    // killing the whole regs TL port).  Decline; the struct_extract
    // main path spells `s->root_field` from the exploded leaves.
    {
      mlir::Value bi = bc.getInput();
      while (auto ex2 = bi.getDefiningOp<circt::comb::ExtractOp>())
        bi = ex2.getInput();
      if (bi.getDefiningOp<circt::llhd::ProbeOp>())
        return std::nullopt;
    }
    auto elems = st.getElements();
    unsigned off = 0, width = 0; bool found = false;
    for (int i = (int)elems.size() - 1; i >= 0; --i) {
      unsigned w = circt::hw::getBitWidth(elems[i].type);
      if (elems[i].name.getValue() == field) { width = w; found = true; break; }
      off += w;
    }
    if (!found || width == 0) return std::nullopt;
    auto in = translateValue(bc.getInput(), maxDepth - 1);
    if (!in.success) return std::nullopt;
    unsigned inWidth = mlir::cast<mlir::IntegerType>(bc.getInput().getType()).getWidth();
    auto sl = packedSliceExpr(bc.getInput(), in.expr, inWidth, off, width);
    if (!sl) return std::nullopt;
    return TranslateResult::ok(*sl);
  }
  if (auto mux = mlir::dyn_cast<circt::comb::MuxOp>(def)) {
    auto c = translateValue(mux.getCond(), maxDepth - 1);
    auto a = translateStructFieldOf(mux.getTrueValue(), field, maxDepth - 1);
    auto b = translateStructFieldOf(mux.getFalseValue(), field, maxDepth - 1);
    if (!c.success || !a || !b || !a->success || !b->success) return std::nullopt;
    return TranslateResult::ok("((" + c.expr + ") ? (" + a->expr + ") : (" + b->expr + "))");
  }
  if (auto ag = mlir::dyn_cast<circt::hw::ArrayGetOp>(def)) {
    auto st = mlir::dyn_cast<circt::hw::StructType>(ag.getResult().getType());
    mlir::Value input = ag.getInput();
    // Peel casts: unrealized_conversion_cast and hw.bitcast (LowerValueStructs
    // packs the elements to integers and bitcasts the whole array back).
    for (;;) {
      if (auto cast = input.getDefiningOp<mlir::UnrealizedConversionCastOp>()) {
        if (cast.getNumOperands() != 1) break;
        input = cast.getOperand(0); continue;
      }
      if (auto bc = input.getDefiningOp<circt::hw::BitcastOp>()) { input = bc.getInput(); continue; }
      break;
    }
    auto ac = input.getDefiningOp<circt::hw::ArrayCreateOp>();
    if (!ac) return std::nullopt;
    unsigned n = ac.getNumOperands();
    // element -> field expression: struct-typed element → recurse; packed
    // integer element → bit-slice at the field offset.
    auto elemField = [&](mlir::Value e) -> std::optional<TranslateResult> {
      if (mlir::isa<circt::hw::StructType>(e.getType()))
        return translateStructFieldOf(e, field, maxDepth - 1);
      if (!st || !mlir::isa<mlir::IntegerType>(e.getType())) return std::nullopt;
      auto elems = st.getElements();
      unsigned off = 0, width = 0; bool found = false;
      for (int i = (int)elems.size() - 1; i >= 0; --i) {
        unsigned w = circt::hw::getBitWidth(elems[i].type);
        if (elems[i].name.getValue() == field) { width = w; found = true; break; }
        off += w;
      }
      if (!found || width == 0) return std::nullopt;
      auto in = translateValue(e, maxDepth - 1);
      if (!in.success) return std::nullopt;
      unsigned inWidth = mlir::cast<mlir::IntegerType>(e.getType()).getWidth();
      auto sl = packedSliceExpr(e, in.expr, inWidth, off, width);
      if (!sl) return std::nullopt;
      return TranslateResult::ok(*sl);
    };
    if (auto ic = ag.getIndex().getDefiningOp<circt::hw::ConstantOp>()) {
      unsigned idx = ic.getValue().getZExtValue();
      if (idx >= n) return std::nullopt;
      return elemField(ac.getOperand(n - 1 - idx));
    }
    auto ix = translateValue(ag.getIndex(), maxDepth - 1);
    if (!ix.success) return std::nullopt;
    auto last = elemField(ac.getOperand(0));
    if (!last || !last->success) return std::nullopt;
    std::string tail = "(" + last->expr + ")";
    for (int i = (int)n - 2; i >= 0; --i) {
      auto ei = elemField(ac.getOperand(n - 1 - i));
      if (!ei || !ei->success) return std::nullopt;
      tail = "(((" + ix.expr + ") == (" + std::to_string(i) + ")) ? (" + ei->expr + ") : " + tail + ")";
    }
    return TranslateResult::ok(tail);
  }
  return std::nullopt;
}

// Default depth 24: kmac's MsgFIFO read is a 5-deep storage mux whose
// element expressions overflow the old limit of 10 ("max recursion depth
// exceeded" dropped storage_rdata — every queued message beat read zero).
// Kept well under the exponential blowup regime (1024 hung spi_device).
inline TranslateResult translateValue(mlir::Value val, unsigned maxDepth = 24) {
  if (maxDepth == 0) {
    return TranslateResult::fail("max recursion depth exceeded");
  }

  // A COMPUTED value wider than 128 bits has no scalar C carrier — refuse
  // loudly so the caller drops the drv (kmac's 256-bit keymgr-key XOR was
  // silently emitted as `arrA ^ arrB`, which does not compile).  Named
  // wide storage (probe of a wide signal) stays legal: consumers like the
  // wide-extract paths read it via qpw_wide_extract.
  if (auto intTy = mlir::dyn_cast<mlir::IntegerType>(val.getType()))
    if (intTy.getWidth() > 128) {
      mlir::Operation *d = val.getDefiningOp();
      // POINTWISE ops (mux with scalar cond, xor/and/or) pass through:
      // their textual form over `s->wide` refs is exactly what the
      // wide-destination wordwise rewriter consumes — rv_plic's 186-bit
      // `ip & le` interrupt tree lives on this (blocking and/or/xor here
      // killed every *-irq target in the fleet, the second all-interrupts
      // outage from over-guarding a wide operator).  Only NON-pointwise
      // ops (arithmetic carries, cross-word shifts) have no per-word
      // form; those fail loudly.  A pointwise chain leaking into a
      // genuinely scalar context fails at C compile time (array as
      // scalar), which is loud, not silent.
      if (d && mlir::isa<circt::comb::AddOp, circt::comb::SubOp,
                         circt::comb::MulOp,
                         circt::comb::ShlOp, circt::comb::ShrUOp,
                         circt::comb::ShrSOp>(d))
        return TranslateResult::fail(
            "wide (>128-bit) operator result in scalar context");
    }

  // 0. Probe of a LOCAL sig inside an inlined func body: its current symbolic
  //    value (bound by the func.call inliner), never a state field.
  if (auto prb0 = val.getDefiningOp<circt::llhd::ProbeOp>()) {
    auto &ls = localSigBindings();
    auto it = ls.find(prb0.getSignal());
    if (it != ls.end()) return TranslateResult::ok("(" + it->second + ")");
    if (auto ex = prb0.getSignal().getDefiningOp<circt::llhd::SigExtractOp>()) {
      auto it2 = ls.find(ex.getInput());
      if (it2 != ls.end()) {
        auto lo = translateValue(ex.getLowBit(), maxDepth - 1);
        if (!lo.success) return lo;
        unsigned w = mlir::cast<circt::llhd::RefType>(ex.getType()).getNestedType().getIntOrFloatBitWidth();
        std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL" : ("((1ULL << " + std::to_string(w) + ") - 1)");
        return TranslateResult::ok("((((uint64_t)(" + it2->second + ")) >> (" + lo.expr + ")) & " + mask + ")");
      }
    }
  }

  // 1. Get name directly (signal or constant)
  std::string name = getSignalName(val);
  if (!name.empty()) {
    return TranslateResult::ok(name);
  }

  // 2. Get defining operation
  mlir::Operation *defOp = val.getDefiningOp();
  if (!defOp) {
    return TranslateResult::fail("no defining op");
  }

  // llhd.prb of a non-sig signal reference:
  //   · arith.select over !hw.inout  → (c) ? prb(a) : prb(b)  (push the probe
  //     through the select; a/b are sig refs, translated "as values" = their
  //     fields, recursively for nested selects)
  //   · block argument of inout type → the CFG resolver picks, per
  //     predecessor, which sig ref flowed in.
  if (auto prbOp = mlir::dyn_cast<circt::llhd::ProbeOp>(defOp)) {
    mlir::Value sig = prbOp.getSignal();
    {
      auto &ls = localSigBindings();
      auto it = ls.find(sig);
      if (it != ls.end()) return TranslateResult::ok("(" + it->second + ")");
    }
    if (auto sel = sig.getDefiningOp<mlir::arith::SelectOp>()) {
      auto c = translateValue(sel.getCondition(), maxDepth - 1);
      auto a = translateValue(sel.getTrueValue(), maxDepth - 1);
      auto b = translateValue(sel.getFalseValue(), maxDepth - 1);
      if (!c.success) return c;
      if (!a.success) return a;
      if (!b.success) return b;
      return TranslateResult::ok("((" + c.expr + ") ? (" + a.expr + ") : (" + b.expr + "))");
    }
    if (auto ba = mlir::dyn_cast<mlir::BlockArgument>(sig)) {
      if (auto &resolve = blockArgResolver())
        if (auto e = resolve(ba)) return TranslateResult::ok(*e);
      return TranslateResult::fail("prb of unresolved inout block argument");
    }
    // Memory array read: prb(sig.array_get %mem[%idx]) on an array sig that was
    // left whole (runtime index, > explode cap).  The emitter stores it as one
    // wide bitvector (`uint64_t name[words]`); read element idx via
    // qpw_wide_extract with a runtime bit offset.
    if (auto ag = sig.getDefiningOp<circt::llhd::SigArrayGetOp>()) {
      if (auto memRef = memoryArrayRef(ag.getInput())) {
        auto idx = translateValue(ag.getIndex(), maxDepth - 1);
        if (!idx.success) return idx;
        return TranslateResult::ok("qpw_wide_extract(s->" + memRef->name + ", " +
                                   std::to_string(memRef->words) + ", ((unsigned)(" +
                                   idx.expr + ") & " + std::to_string(memRef->idxMask) + ") * " +
                                   std::to_string(memRef->elemWidth) + ", " +
                                   std::to_string(memRef->elemWidth) + ")");
      }
    }
  }
  // A selected signal reference used AS a value (from the case above), and
  // plain VALUE selects (`if (c) x = A; else x = B;` with constant arms is
  // lowered by Moore to `arith.select %c, A, B` rather than comb.mux —
  // spi_host_fsm's `next_state_after_idle_csb_active`): same ternary.
  if (auto sel = mlir::dyn_cast<mlir::arith::SelectOp>(defOp)) {
    if (mlir::isa<circt::llhd::RefType>(sel.getType()) ||
        mlir::isa<mlir::IntegerType>(sel.getType())) {
      auto c = translateValue(sel.getCondition(), maxDepth - 1);
      auto a = translateValue(sel.getTrueValue(), maxDepth - 1);
      auto b = translateValue(sel.getFalseValue(), maxDepth - 1);
      if (!c.success) return c;
      if (!a.success) return a;
      if (!b.success) return b;
      return TranslateResult::ok("((" + c.expr + ") ? (" + a.expr + ") : (" + b.expr + "))");
    }
  }

  // ========== func.call: inline-expand a scalar single-block func.func ==========
  if (auto call = mlir::dyn_cast<mlir::func::CallOp>(defOp)) {
    if (call.getNumResults() != 1 ||
        !mlir::isa<mlir::IntegerType>(call.getResult(0).getType()))
      return TranslateResult::fail("func.call: non-scalar result");
    // lc_ctrl_pkg::lc_tx_or(a, b, on): the standard life-cycle mubi OR —
    // per bit, out[i] = on[i] ? a[i]|b[i] : a[i]&b[i].  The package
    // implements it as a 4-iteration cf loop (multi-block, so the
    // single-block inliner refuses) — emit the closed form instead.
    // Protocol-level knowledge of the shared lc_ctrl package, no device
    // names involved.
    // sha3_pkg::encode_bytepad_len — 5-entry strength lookup (multi-block
    // case body); closed form, mirrored from the emitter-side resolver.
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("encode_bytepad_len") &&
        call.getNumOperands() == 1) {
      auto k = translateValue(call.getOperand(0), maxDepth - 1);
      if (!k.success) return k;
      std::string K = "((unsigned)(" + k.expr + "))";
      return TranslateResult::ok(
          "((" + K + ") == 0u ? 0xA801u : (" + K + ") == 1u ? 0x9001u : (" +
          K + ") == 2u ? 0x8801u : (" + K + ") == 3u ? 0x6801u : (" + K +
          ") == 4u ? 0x4801u : 0u)");
    }
    // keymgr_pkg::valid_data_chk — see the emitter-resolver twin.
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("valid_chk") &&
        call.getNumOperands() == 1) {
      mlir::Value a0 = call.getOperand(0);
      unsigned w = a0.getType().getIntOrFloatBitWidth();
      auto ae = translateValue(a0, maxDepth - 1);
      if (ae.success && w > 64) {
        std::string nm;
        if (isPlainSignalRef(ae.expr, &nm)) {
          unsigned nW = (w + 63) / 64;
          unsigned tail = w % 64;
          std::string orE, andE;
          for (unsigned i = 0; i < nW; ++i) {
            std::string word = "s->" + nm + "[" + std::to_string(i) + "]";
            orE += (i ? " | " : "") + word;
            std::string ones =
                (i + 1 == nW && tail)
                    ? "((1ULL << " + std::to_string(tail) + ") - 1)"
                    : "0xFFFFFFFFFFFFFFFFULL";
            andE += std::string(i ? " & " : "") + "(" + word +
                    " == " + ones + ")";
          }
          return TranslateResult::ok("((((" + orE + ") != 0)) && (!(" +
                                     andE + ")))");
        }
      }
      return TranslateResult::fail("valid_chk: arg not a plain wide field");
    }
    // prim_mubi_pkg::mubi4_or / mubi4_and (3-operand, arbitrary act
    // value) — same closed form as lc_tx_or, 4 bits wide.  The *_hi
    // wrappers inline down to these via the generic inliner.
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        (call.getCallee().contains("mubi4_or") ||
         call.getCallee().contains("mubi4_and")) &&
        call.getNumOperands() == 3 && !call.getCallee().contains("_hi")) {
      auto a3 = translateValue(call.getOperand(0), maxDepth - 1);
      if (!a3.success) return a3;
      auto b3 = translateValue(call.getOperand(1), maxDepth - 1);
      if (!b3.success) return b3;
      auto c3 = translateValue(call.getOperand(2), maxDepth - 1);
      if (!c3.success) return c3;
      std::string A = "(" + a3.expr + ")", B = "(" + b3.expr + ")",
                  C = "(" + c3.expr + ")";
      if (call.getCallee().contains("mubi4_or"))
        return TranslateResult::ok("(((" + C + " & (" + A + " | " + B +
                                   ")) | (~" + C + " & " + A + " & " + B +
                                   ")) & 0xFULL)");
      return TranslateResult::ok("(((" + C + " & " + A + " & " + B +
                                 ") | (~" + C + " & (" + A + " | " + B +
                                 "))) & 0xFULL)");
    }
    // prim_mubi_pkg::mubi4_or_hi / mubi4_and_hi — the mubi4 twins of
    // lc_tx_or (True = 4'h6): per bit, or_hi: True[i] ? a|b : a&b;
    // and_hi: True[i] ? a&b : a|b.
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("mubi4_or_hi") &&
        call.getNumOperands() == 2) {
      auto a = translateValue(call.getOperand(0), maxDepth - 1);
      if (!a.success) return a;
      auto b = translateValue(call.getOperand(1), maxDepth - 1);
      if (!b.success) return b;
      std::string A = "(" + a.expr + ")", B = "(" + b.expr + ")";
      return TranslateResult::ok("(((0x6u & (" + A + " | " + B +
                                 ")) | (0x9u & " + A + " & " + B +
                                 ")) & 0xFULL)");
    }
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("mubi4_and_hi") &&
        call.getNumOperands() == 2) {
      auto a = translateValue(call.getOperand(0), maxDepth - 1);
      if (!a.success) return a;
      auto b = translateValue(call.getOperand(1), maxDepth - 1);
      if (!b.success) return b;
      std::string A = "(" + a.expr + ")", B = "(" + b.expr + ")";
      return TranslateResult::ok("(((0x6u & " + A + " & " + B +
                                 ") | (0x9u & (" + A + " | " + B +
                                 "))) & 0xFULL)");
    }
    if (qemu_passes::usesOpenTitanRTLAdapter(call) &&
        call.getCallee().contains("lc_ctrl_pkg::lc_tx_or") &&
        call.getNumOperands() == 3) {
      auto a = translateValue(call.getOperand(0), maxDepth - 1);
      if (!a.success) return a;
      auto b = translateValue(call.getOperand(1), maxDepth - 1);
      if (!b.success) return b;
      auto on = translateValue(call.getOperand(2), maxDepth - 1);
      if (!on.success) return on;
      std::string A = "(" + a.expr + ")", B = "(" + b.expr + ")",
                  C = "(" + on.expr + ")";
      return TranslateResult::ok("(((" + C + " & (" + A + " | " + B +
                                 ")) | (~" + C + " & " + A + " & " + B +
                                 ")) & 0xFULL)");
    }
    return inlineFuncCallWith(call, maxDepth, [&](mlir::Value retV) {
      return translateValue(retV, maxDepth - 1);
    });
  }

  // ========== Arithmetic operations ==========

  // comb.add
  // qemu.pump_acc_operand (AccumulateRingDetect): this add closes an
  // accumulate ring (q -> +step -> back to q).  The accumulator operand passes
  // through; every other operand is the STEP and is gated by the pump pulse
  // `s->_qp_pump`, so MMIO settles hold the counter and <dev>_advance_tick
  // steps it exactly once.  Reset / wrap / SW-write arms of the register stay
  // untouched (they live in the drv, not here).
  if (auto addOp = mlir::dyn_cast<circt::comb::AddOp>(defOp)) {
    std::string result;
    int accIdx = -1;
    if (auto a = addOp->getAttrOfType<mlir::IntegerAttr>("qemu.pump_acc_operand"))
      accIdx = (int)a.getInt();
    for (unsigned i = 0; i < addOp.getNumOperands(); ++i) {
      auto sub = translateValue(addOp.getOperand(i), maxDepth - 1);
      if (!sub.success) return sub;
      if (i > 0) result += " + ";
      if (accIdx >= 0 && (int)i != accIdx)
        result += "((s->_qp_pump) ? (" + sub.expr + ") : 0)";
      else
        result += "(" + sub.expr + ")";
    }
    return TranslateResult::ok(result);
  }

  // comb.sub  (pump_acc_operand == 0: lhs is the accumulator, rhs the step)
  if (auto subOp = mlir::dyn_cast<circt::comb::SubOp>(defOp)) {
    auto lhs = translateValue(subOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(subOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (subOp->hasAttr("qemu.pump_acc_operand") && rhs.success)
      rhs.expr = "((s->_qp_pump) ? (" + rhs.expr + ") : 0)";
    if (!rhs.success) return rhs;
    return TranslateResult::ok("(" + lhs.expr + ") - (" + rhs.expr + ")");
  }

  // comb.mul
  if (auto mulOp = mlir::dyn_cast<circt::comb::MulOp>(defOp)) {
    std::string result;
    for (unsigned i = 0; i < mulOp.getNumOperands(); ++i) {
      auto sub = translateValue(mulOp.getOperand(i), maxDepth - 1);
      if (!sub.success) return sub;
      if (i > 0) result += " * ";
      result += "(" + sub.expr + ")";
    }
    return TranslateResult::ok(result);
  }

  // comb.divu
  if (auto divuOp = mlir::dyn_cast<circt::comb::DivUOp>(defOp)) {
    auto lhs = translateValue(divuOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(divuOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("(" + lhs.expr + ") / (" + rhs.expr + ")");
  }

  // comb.divs
  if (auto divsOp = mlir::dyn_cast<circt::comb::DivSOp>(defOp)) {
    auto lhs = translateValue(divsOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(divsOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("((int64_t)(" + lhs.expr + ")) / ((int64_t)(" + rhs.expr + "))");
  }

  // comb.modu
  if (auto moduOp = mlir::dyn_cast<circt::comb::ModUOp>(defOp)) {
    auto lhs = translateValue(moduOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(moduOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("(" + lhs.expr + ") % (" + rhs.expr + ")");
  }

  // comb.mods
  if (auto modsOp = mlir::dyn_cast<circt::comb::ModSOp>(defOp)) {
    auto lhs = translateValue(modsOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(modsOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("((int64_t)(" + lhs.expr + ")) % ((int64_t)(" + rhs.expr + "))");
  }

  // ========== Bitwise operations ==========

  // comb.and
  if (auto andOp = mlir::dyn_cast<circt::comb::AndOp>(defOp)) {
    std::string result;
    for (unsigned i = 0; i < andOp.getNumOperands(); ++i) {
      auto sub = translateValue(andOp.getOperand(i), maxDepth - 1);
      if (!sub.success) return sub;
      if (i > 0) result += " & ";
      result += "(" + sub.expr + ")";
    }
    return TranslateResult::ok(result);
  }

  // comb.or
  if (auto orOp = mlir::dyn_cast<circt::comb::OrOp>(defOp)) {
    std::string result;
    for (unsigned i = 0; i < orOp.getNumOperands(); ++i) {
      auto sub = translateValue(orOp.getOperand(i), maxDepth - 1);
      if (!sub.success) return sub;
      if (i > 0) result += " | ";
      result += "(" + sub.expr + ")";
    }
    return TranslateResult::ok(result);
  }

  // arith.xori — mixed-dialect residue (the canonicalizer rewrites an odd
  // comb.xor into arith form; hmac's prim_packer flush_valid = !(pos == 0)
  // reaches exactly this).  Mask keeps a NOT-via-all-ones clean in storage
  // wider than the logical width.
  if (auto axor = mlir::dyn_cast<mlir::arith::XOrIOp>(defOp)) {
    auto a = translateValue(axor.getLhs(), maxDepth - 1);
    if (!a.success) return a;
    auto b = translateValue(axor.getRhs(), maxDepth - 1);
    if (!b.success) return b;
    unsigned w = axor.getType().getIntOrFloatBitWidth();
    return TranslateResult::ok("(((" + a.expr + ") ^ (" + b.expr + ")) & " +
                               genMask(w) + ")");
  }

  // arith.extui / arith.extsi / arith.trunci — width casts, the other
  // mixed-dialect residue the canonicalizer leaves behind.  It merges an
  // if/else that assigns two different constants into ONE drive of the form
  // `zext(cond)` (csrng's ctr_drbg: `pdata != 0 ? UPD_BEGIN : GEN_LOOP`
  // became `extui(!(pdata != 0))`).  Without these handlers translation
  // fails and CombLogicExtract DELETES the whole drive — a silent lost arm
  // (see README, the gen_subcmd conviction).  Zero-extend needs the source
  // masked to its own width; sign-extend must replicate the sign bit inside
  // the destination width; truncate is a mask.
  if (auto ext = mlir::dyn_cast<mlir::arith::ExtUIOp>(defOp)) {
    auto in = translateValue(ext.getIn(), maxDepth - 1);
    if (!in.success) return in;
    unsigned sw = ext.getIn().getType().getIntOrFloatBitWidth();
    return TranslateResult::ok("((" + in.expr + ") & " + genMask(sw) + ")");
  }
  if (auto ext = mlir::dyn_cast<mlir::arith::ExtSIOp>(defOp)) {
    auto in = translateValue(ext.getIn(), maxDepth - 1);
    if (!in.success) return in;
    unsigned sw = ext.getIn().getType().getIntOrFloatBitWidth();
    unsigned dw = ext.getType().getIntOrFloatBitWidth();
    if (sw == 0 || sw >= dw || dw > 64) {
      return TranslateResult::fail("extsi: unsupported widths");
    }
    // ((x & srcMask) ^ signBit) - signBit  — branch-free sign extension
    std::string sign = "(1ULL << " + std::to_string(sw - 1) + ")";
    return TranslateResult::ok("(((((" + in.expr + ") & " + genMask(sw) +
                               ") ^ " + sign + ") - " + sign + ") & " +
                               genMask(dw) + ")");
  }
  if (auto trunc = mlir::dyn_cast<mlir::arith::TruncIOp>(defOp)) {
    auto in = translateValue(trunc.getIn(), maxDepth - 1);
    if (!in.success) return in;
    unsigned dw = trunc.getType().getIntOrFloatBitWidth();
    return TranslateResult::ok("((" + in.expr + ") & " + genMask(dw) + ")");
  }

  // comb.xor
  if (auto xorOp = mlir::dyn_cast<circt::comb::XorOp>(defOp)) {
    // Special case: XOR 1 = NOT
    if (xorOp.getNumOperands() == 2) {
      if (auto constOp = xorOp.getOperand(1).getDefiningOp<circt::hw::ConstantOp>()) {
        if (constOp.getValue().isAllOnes()) {
          auto inner = translateValue(xorOp.getOperand(0), maxDepth - 1);
          if (!inner.success) return inner;
          // For i1 inputs we use `(x ^ 1)` instead of `~x` because the
          // C-level state-struct fields are uint8_t-or-wider — bitwise
          // `~` flips all storage bits (e.g. ~1 == 0xFE), turning a
          // `!~rst_ni`-shaped path-condition gate into a permanent
          // false.  XOR-with-1 keeps the result a clean 0/1 boolean
          // regardless of the storage container's width.  The outer
          // parens matter: `^` has lower precedence than `|`/`&`, and
          // expressions composed via comb_translator don't add their
          // own grouping around sub-results.
          auto resTy = mlir::dyn_cast<mlir::IntegerType>(xorOp.getType());
          if (resTy && resTy.getWidth() == 1)
            return TranslateResult::ok("((" + inner.expr + ") ^ 1)");
          // Same storage-container hazard for multi-bit NOT: C integer
          // promotion makes `~` flip ALL bits (~(3-bit 0x6) == 0xFFFFFFF9),
          // so an unmasked NOT poisons any comparison against an in-range
          // value — aes's shadowed-register storage check (~shadow_q !=
          // committed_q) read as a permanent mismatch and latched a fatal
          // alert at reset.  Mask the result back to the operand width.
          if (resTy && resTy.getWidth() < 64) {
            uint64_t mask = (1ULL << resTy.getWidth()) - 1;
            return TranslateResult::ok("((~(" + inner.expr + ")) & 0x" +
                                       llvm::utohexstr(mask) + "ULL)");
          }
          // Width >= 64 (or untyped): emit the plain NOT.  Do NOT fail here:
          // wide (>64-bit) NOTs are consumed by the per-word array paths
          // (rv_plic's 186-bit gateway edge-detect `src & ~(q & le)` loops
          // over uint64_t words), where flipping every storage bit is exactly
          // right — failing killed the interrupt gateways machine-wide.
          return TranslateResult::ok("~(" + inner.expr + ")");
        }
      }
    }
    std::string result;
    for (unsigned i = 0; i < xorOp.getNumOperands(); ++i) {
      auto sub = translateValue(xorOp.getOperand(i), maxDepth - 1);
      if (!sub.success) return sub;
      if (i > 0) result += " ^ ";
      result += "(" + sub.expr + ")";
    }
    return TranslateResult::ok(result);
  }

  // comb.shl
  if (auto shlOp = mlir::dyn_cast<circt::comb::ShlOp>(defOp)) {
    auto lhs = translateValue(shlOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(shlOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("(" + lhs.expr + ") << (" + rhs.expr + ")");
  }

  // comb.shru
  if (auto shruOp = mlir::dyn_cast<circt::comb::ShrUOp>(defOp)) {
    unsigned shruWidth =
        shruOp.getLhs().getType().getIntOrFloatBitWidth();
    // Bug G: shifting a wide-array as a whole is not a valid scalar C
    // expression.  Callers that need this must either consume via a
    // comb.extract (handled in the extract case) or refactor.
    if (shruWidth > 128) {
      return TranslateResult::fail(
          "comb.shru on wide operand only supported via (extract . shru) chain");
    }
    auto lhs = translateValue(shruOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(shruOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("(" + lhs.expr + ") >> (" + rhs.expr + ")");
  }

  // comb.shrs
  if (auto shrsOp = mlir::dyn_cast<circt::comb::ShrSOp>(defOp)) {
    auto lhs = translateValue(shrsOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(shrsOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;
    return TranslateResult::ok("((int64_t)(" + lhs.expr + ")) >> (" + rhs.expr + ")");
  }

  // ========== Data operations ==========

  // comb.extract
  if (auto extractOp = mlir::dyn_cast<circt::comb::ExtractOp>(defOp)) {
    unsigned lowBit = extractOp.getLowBit();
    unsigned width = extractOp.getType().getIntOrFloatBitWidth();
    unsigned inputWidth =
        extractOp.getInput().getType().getIntOrFloatBitWidth();

    // Bug G: input wider than 128 bits → its storage is `uint64_t arr[N]`.
    // Special-case extract chains with constant lowBit so the simple
    // single-word case avoids cross-word complexity.
    if (inputWidth > 128 && width <= 64) {
      // Try direct extract from a wide signal reference: `s->X`.  A
      // FAILED inner translate does not return: the input may be the
      // wide shru the entry guard refuses (its (extract . shru) chain
      // form below is the supported carrier — compare's 256-bit
      // `digest_i[idx -: 32]` died on the early return here).
      auto inner = translateValue(extractOp.getInput(), maxDepth - 1);
      std::string sigName;
      if (inner.success && isPlainSignalRef(inner.expr, &sigName)) {
        unsigned wordLo = lowBit / 64;
        unsigned bitLo  = lowBit % 64;
        unsigned wordHi = (lowBit + width - 1) / 64;
        if (wordLo == wordHi) {
          // Within a single 64-bit word.
          if (bitLo == 0) {
            return TranslateResult::ok("((s->" + sigName + "[" +
                                        std::to_string(wordLo) + "]) & " +
                                        genMask(width) + ")");
          }
          return TranslateResult::ok("(((s->" + sigName + "[" +
                                      std::to_string(wordLo) + "]) >> " +
                                      std::to_string(bitLo) + ") & " +
                                      genMask(width) + ")");
        }
        // Cross-word constant-position extract — combine two halves.
        unsigned hiBits = (lowBit + width) - wordHi * 64;
        unsigned loBits = width - hiBits;
        return TranslateResult::ok(
            "((((s->" + sigName + "[" + std::to_string(wordLo) +
            "]) >> " + std::to_string(bitLo) + ") | "
            "((s->" + sigName + "[" + std::to_string(wordHi) +
            "]) << " + std::to_string(loBits) + ")) & " +
            genMask(width) + ")");
      }
      // Try the (extract . shru) chain pattern: `(s->X) >> dyn` then
      // narrow.  Use a runtime helper for the dynamic-shift case.
      if (auto shruDef = extractOp.getInput().getDefiningOp<circt::comb::ShrUOp>()) {
        auto shruLhs = translateValue(shruDef.getLhs(), maxDepth - 1);
        // The shift amount is usually the zero-extension of a narrow
        // index (`concat(0_iN, sel)`), and the concat itself is as wide
        // as the wide value — peel it down to the payload before
        // translating, or the >128-bit concat rule rejects it.
        mlir::Value shVal = shruDef.getRhs();
        std::string shSuffix;
        if (auto scc = shVal.getDefiningOp<circt::comb::ConcatOp>()) {
          mlir::Value payload;
          unsigned lowZ = 0;
          bool okPeel = true;
          for (auto o : scc.getOperands()) {
            auto k = o.getDefiningOp<circt::hw::ConstantOp>();
            if (k && k.getValue().isZero()) {
              if (payload) lowZ += o.getType().getIntOrFloatBitWidth();
              continue;
            }
            if (payload) { okPeel = false; break; }
            payload = o;
          }
          if (okPeel && payload &&
              payload.getType().getIntOrFloatBitWidth() <= 64) {
            shVal = payload;
            if (lowZ) shSuffix = " << " + std::to_string(lowZ);
          }
        }
        auto shruRhs = translateValue(shVal, maxDepth - 1);
        // The shift amount computes in the payload's narrow width
        // (compare's `digest_idx + (-31)` wraps mod 2^8); C's 64-bit
        // arithmetic does not wrap, so mask before shifting.
        if (shruRhs.success) {
          unsigned shW = shVal.getType().getIntOrFloatBitWidth();
          if (shW < 64)
            shruRhs.expr = "((" + shruRhs.expr + ") & " +
                           std::to_string((1ULL << shW) - 1) + "ULL)";
          if (!shSuffix.empty())
            shruRhs.expr = "(((unsigned)(" + shruRhs.expr + "))" + shSuffix + ")";
        }
        if (shruLhs.success && shruRhs.success) {
          std::string baseName;
          if (isPlainSignalRef(shruLhs.expr, &baseName)) {
            // Compose total shift = shru rhs + extract lowBit.
            std::string totalShift = shruRhs.expr;
            if (lowBit != 0) {
              totalShift = "((" + totalShift + ") + " +
                           std::to_string(lowBit) + ")";
            }
            return TranslateResult::ok(
                "qpw_wide_extract(s->" + baseName + ", " +
                std::to_string((inputWidth + 63) / 64) + ", " + totalShift +
                ", " + std::to_string(width) + ")");
          }
        }
      }
      return TranslateResult::fail(
          "comb.extract on wide input not in `s->X` or `(s->X) >> dyn` form");
    }

    auto input = translateValue(extractOp.getInput(), maxDepth - 1);
    if (!input.success) return input;

    if (lowBit == 0 && width == 1) {
      return TranslateResult::ok("((" + input.expr + ") & 1)");
    } else if (lowBit == 0) {
      return TranslateResult::ok("((" + input.expr + ") & " + genMask(width) + ")");
    } else {
      return TranslateResult::ok("(((" + input.expr + ") >> " +
                                  std::to_string(lowBit) + ") & " + genMask(width) + ")");
    }
  }

  // comb.concat
  if (auto concatOp = mlir::dyn_cast<circt::comb::ConcatOp>(defOp)) {
    if (concatOp.getNumOperands() == 0) {
      return TranslateResult::fail("empty concat");
    }

    std::string result;
    unsigned accumulatedWidth = 0;
    unsigned totalW = concatOp.getType().getIntOrFloatBitWidth();
    if (totalW > 128)
      return TranslateResult::fail("concat wider than 128 bits");
    // Every shifted term must be computed in a type at least as wide as the
    // RESULT: C integer promotion evaluates `u8 << 74` in 32-bit int
    // (undefined), which silently zeroed the write/addr fields of
    // spi_device's 75-bit packed SRAM-arbiter requests — the SFDP egress
    // buffer never saw a write.
    const char *castTy = totalW > 64 ? "__uint128_t" : "uint64_t";

    for (int i = concatOp.getNumOperands() - 1; i >= 0; --i) {
      mlir::Value operand = concatOp.getOperand(i);
      auto sub = translateValue(operand, maxDepth - 1);
      if (!sub.success) return sub;

      unsigned opWidth = operand.getType().getIntOrFloatBitWidth();

      std::string term = "((" + std::string(castTy) + ")(" + sub.expr + "))";
      if (result.empty()) {
        result = term;
      } else {
        result = "(" + term + " << " + std::to_string(accumulatedWidth) +
                 ") | " + result;
      }
      accumulatedWidth += opWidth;
    }
    return TranslateResult::ok("(" + result + ")");
  }

  // comb.replicate %v : (iA) -> iB — concatenate B/A copies of v.  The 1-bit
  // case is the familiar boolean fan-out (0 / all-ones); a WIDER operand
  // must be genuinely tiled ({4{byte}} lane replication in dma's read-return
  // path was silently turned into (byte ? 0xFFFFFFFF : 0) by the old code —
  // every DMA'd byte came out 0xFF).
  if (auto repOp = mlir::dyn_cast<circt::comb::ReplicateOp>(defOp)) {
    auto input = translateValue(repOp.getInput(), maxDepth - 1);
    if (!input.success) return input;

    unsigned resultWidth = repOp.getType().getIntOrFloatBitWidth();
    unsigned inWidth = repOp.getInput().getType().getIntOrFloatBitWidth();
    std::string allOnes = genMask(resultWidth);

    if (inWidth == 1)
      return TranslateResult::ok("((" + input.expr + ") ? " + allOnes + " : 0)");
    if (inWidth == 0 || resultWidth == 0 || (resultWidth % inWidth) != 0)
      return TranslateResult::fail("replicate: bad widths");
    if (resultWidth > 64)
      return TranslateResult::fail("replicate: result wider than 64 bits "
                                   "(uint64 expression cannot carry it)");
    unsigned mult = resultWidth / inWidth;
    if (mult == 1)
      return input;
    std::string base =
        "(((uint64_t)(" + input.expr + ")) & " + genMask(inWidth) + ")";
    std::string result;
    for (unsigned i = 0; i < mult; ++i) {
      std::string term =
          i == 0 ? base
                 : "(" + base + " << " + std::to_string(i * inWidth) + ")";
      result = result.empty() ? term : result + " | " + term;
    }
    return TranslateResult::ok("((" + result + ") & " + allOnes + ")");
  }

  // comb.mux
  if (auto muxOp = mlir::dyn_cast<circt::comb::MuxOp>(defOp)) {
    auto truePattern = detectBitExtractPattern(muxOp.getTrueValue());
    auto falsePattern = detectBitExtractPattern(muxOp.getFalseValue());

    if (truePattern.isPattern && falsePattern.isPattern &&
        truePattern.usesBlockArgument && falsePattern.usesBlockArgument) {
      auto cond = translateValue(muxOp.getCond(), maxDepth - 1);
      if (!cond.success) return cond;
      return TranslateResult::ok("((" + cond.expr + ") ? (s->" +
                                  sanitizeSignalName(truePattern.signalName) + ") : (s->" +
                                  sanitizeSignalName(falsePattern.signalName) + "))");
    }

    auto cond = translateValue(muxOp.getCond(), maxDepth - 1);
    auto trueVal = translateValue(muxOp.getTrueValue(), maxDepth - 1);
    auto falseVal = translateValue(muxOp.getFalseValue(), maxDepth - 1);
    if (!cond.success) return cond;
    if (!trueVal.success) return trueVal;
    if (!falseVal.success) return falseVal;

    return TranslateResult::ok("((" + cond.expr + ") ? (" + trueVal.expr + ") : (" + falseVal.expr + "))");
  }

  // comb.reverse
  if (auto revOp = mlir::dyn_cast<circt::comb::ReverseOp>(defOp)) {
    auto input = translateValue(revOp.getInput(), maxDepth - 1);
    if (!input.success) return input;
    unsigned width = revOp.getType().getIntOrFloatBitWidth();
    return TranslateResult::ok("bit_reverse" + std::to_string(width) + "(" + input.expr + ")");
  }

  // comb.parity — XOR-reduce.  WIDTH MATTERS: __builtin_parityll takes an
  // `unsigned long long`, so handing it a __uint128_t SILENTLY TRUNCATES to
  // the low 64 bits, with no warning under -Wall -Wextra.  keymgr's SECDED
  // (72,64) decoder is built entirely from parity over 72-bit words whose
  // masks deliberately set bit 64, so every one of those syndrome bits was
  // being computed with bit 64 discarded.  Fold the high half in first.
  if (auto parOp = mlir::dyn_cast<circt::comb::ParityOp>(defOp)) {
    auto input = translateValue(parOp.getInput(), maxDepth - 1);
    if (!input.success) return input;
    unsigned pw = parOp.getInput().getType().getIntOrFloatBitWidth();
    if (pw > 64) {
      std::string f = parityFold(input.expr, pw);
      if (f.empty())
        return TranslateResult::fail(
            "comb.parity: " + std::to_string(pw) +
            "-bit operand has no C carrier for an exact fold");
      return TranslateResult::ok(f);
    }
    return TranslateResult::ok("(__builtin_parityll(" + input.expr + "))");
  }

  // ========== Compare operations ==========

  // comb.icmp
  if (auto icmpOp = mlir::dyn_cast<circt::comb::ICmpOp>(defOp)) {
    unsigned operandWidth =
        icmpOp.getLhs().getType().getIntOrFloatBitWidth();
    // WIDE eq/ne WITHOUT A WHOLE-VALUE CARRIER.  The existing >128-bit path
    // below first translates both operands, which cannot work when an operand
    // is a wide concat: no single C expression holds it.  But equality does
    // not need the whole value — it is a conjunction over 64-bit windows, and
    // the bit-range router serves one window of an arbitrary expression.
    // alert_handler's shadow-CSR comparison is exactly this shape, and its two
    // error outputs were dropped for want of it.
    if (operandWidth > 128) {
      auto p0 = icmpOp.getPredicate();
      if (p0 == circt::comb::ICmpPredicate::eq ||
          p0 == circt::comb::ICmpPredicate::ne) {
        unsigned nWords = (operandWidth + 63) / 64;
        std::string acc;
        bool wordwise = true;
        for (unsigned w = 0; w < nWords; ++w) {
          unsigned take = std::min(64u, operandWidth - w * 64);
          auto a = sliceValue(icmpOp.getLhs(), (uint64_t)w * 64, take,
                              maxDepth - 1);
          auto b = sliceValue(icmpOp.getRhs(), (uint64_t)w * 64, take,
                              maxDepth - 1);
          if (!a.success || !b.success) { wordwise = false; break; }
          std::string t = "((" + a.expr + ") == (" + b.expr + "))";
          acc = acc.empty() ? t : (acc + " && " + t);
        }
        if (wordwise && !acc.empty())
          return TranslateResult::ok(
              p0 == circt::comb::ICmpPredicate::eq ? ("(" + acc + ")")
                                                   : ("(!(" + acc + "))"));
      }
    }
    auto lhs = translateValue(icmpOp.getLhs(), maxDepth - 1);
    auto rhs = translateValue(icmpOp.getRhs(), maxDepth - 1);
    if (!lhs.success) return lhs;
    if (!rhs.success) return rhs;

    // Bug G: operands wider than 128 bits are stored as uint64_t arr[N].
    // Only handle eq/ne against a literal that contains no `s->` references
    // (typically zero or all-ones).  Use OR-reduce when comparing to zero.
    if (operandWidth > 128) {
      auto pred = icmpOp.getPredicate();
      bool isEq = (pred == circt::comb::ICmpPredicate::eq) ||
                  (pred == circt::comb::ICmpPredicate::ceq) ||
                  (pred == circt::comb::ICmpPredicate::weq);
      bool isNe = (pred == circt::comb::ICmpPredicate::ne) ||
                  (pred == circt::comb::ICmpPredicate::cne) ||
                  (pred == circt::comb::ICmpPredicate::wne);
      if (!(isEq || isNe))
        return TranslateResult::fail(
            "comb.icmp on wide operands: only eq/ne supported");
      std::string lhsName;
      bool lhsPlain = isPlainSignalRef(lhs.expr, &lhsName);
      bool rhsHasState = rhs.expr.find("s->") != std::string::npos;
      if (!lhsPlain || rhsHasState)
        return TranslateResult::fail(
            "comb.icmp on wide operands: lhs must be `s->X`, rhs literal");
      unsigned nWords = (operandWidth + 63) / 64;
      // NON-ZERO literal: compare word by word against the constant's
      // 64-bit segments, taken from the IR constant itself (an OR-reduce
      // against a big literal is semantically wrong — lc_ctrl's state
      // decoder compares the 320-bit life-cycle word against 21 distinct
      // encodings and every one of them was collapsing to `|... == huge`).
      if (auto rk = icmpOp.getRhs().getDefiningOp<circt::hw::ConstantOp>()) {
        llvm::APInt cv = rk.getValue();
        if (!cv.isZero()) {
          std::string andExpr;
          for (unsigned i = 0; i < nWords; ++i) {
            unsigned take = std::min<unsigned>(64, operandWidth - 64 * i);
            uint64_t w = cv.extractBitsAsZExtValue(take, 64 * i);
            std::string one = "(s->" + lhsName + "[" + std::to_string(i) +
                              "] == 0x" + llvm::utohexstr(w) + "ULL)";
            andExpr = andExpr.empty() ? one : (andExpr + " && " + one);
          }
          std::string eqExpr = "(" + andExpr + ")";
          return TranslateResult::ok(isEq ? eqExpr : ("(!" + eqExpr + ")"));
        }
      }
      // Zero comparison: OR-reduce is exact.
      std::string orExpr;
      for (unsigned i = 0; i < nWords; ++i) {
        if (i == 0) {
          orExpr = "s->" + lhsName + "[0]";
        } else {
          orExpr = "(" + orExpr + " | s->" + lhsName + "[" +
                   std::to_string(i) + "])";
        }
      }
      const char *cop = isEq ? "==" : "!=";
      return TranslateResult::ok("((" + orExpr + ") " + cop + " (" +
                                  rhs.expr + "))");
    }

    std::string op;
    bool isSigned = false;
    switch (icmpOp.getPredicate()) {
      case circt::comb::ICmpPredicate::eq:  op = "=="; break;
      case circt::comb::ICmpPredicate::ne:  op = "!="; break;
      case circt::comb::ICmpPredicate::slt: op = "<";  isSigned = true; break;
      case circt::comb::ICmpPredicate::sle: op = "<="; isSigned = true; break;
      case circt::comb::ICmpPredicate::sgt: op = ">";  isSigned = true; break;
      case circt::comb::ICmpPredicate::sge: op = ">="; isSigned = true; break;
      case circt::comb::ICmpPredicate::ult: op = "<";  break;
      case circt::comb::ICmpPredicate::ule: op = "<="; break;
      case circt::comb::ICmpPredicate::ugt: op = ">";  break;
      case circt::comb::ICmpPredicate::uge: op = ">="; break;
      // SystemVerilog case-equal `===` / `!==` (4-state X/Z aware).  Our
      // simulation model has no X/Z, so map to plain `==` / `!=`.
      case circt::comb::ICmpPredicate::ceq: op = "=="; break;
      case circt::comb::ICmpPredicate::cne: op = "!="; break;
      // Wildcard equality `==?` / `!=?` (X/Z in the literal are don't-cares).
      // No X/Z in the model: same as ==/!= (tlul_adapter_sram's we_o opcode test).
      case circt::comb::ICmpPredicate::weq: op = "=="; break;
      case circt::comb::ICmpPredicate::wne: op = "!="; break;
      default:
        return TranslateResult::fail("unknown icmp predicate");
    }

    if (isSigned) {
      return TranslateResult::ok("(((int64_t)(" + lhs.expr + ")) " + op +
                                  " ((int64_t)(" + rhs.expr + ")))");
    }
    return TranslateResult::ok("((" + lhs.expr + ") " + op + " (" + rhs.expr + "))");
  }

  // hw.struct_extract — Fix 5A (P2):
  // Residual struct field reads at module signature boundaries (where
  // LowerValueStructs left the struct intact, e.g. extract on a port
  // input still typed as struct) get translated to a per-field state
  // reference.  We trace the input recursively to reuse the
  // BlockArgument → port-name path from Fix 1, then append "." + field
  // name and let sanitizeSignalName collapse "." to "_" so the result
  // matches the per-field naming convention used by ExplodeStructSigs
  // (Fix 2) and by FlatSignalRegistry's regex-driven registration.
  // hw.bitcast — pass-through (same value, just retypes).  Required for
  // path-condition translation in pinmux: cond_br guards on
  // `comb.icmp eq (hw.bitcast %addr_hit) , 0` and the bitcast wrapper
  // would otherwise drop the gating, causing the default `rdata = -1`
  // drv to emit unconditionally.
  if (auto bcOp = mlir::dyn_cast<circt::hw::BitcastOp>(defOp)) {
    // struct VALUE → packed integer: fields concatenated MSB-first (hw
    // packing: field 0 is the MSB).  tlul_socket_1n bitcasts the a_user
    // struct_create to i23 to mux it against the blanked copy.
    if (auto sc = bcOp.getInput().getDefiningOp<circt::hw::StructCreateOp>()) {
      auto st = mlir::dyn_cast<circt::hw::StructType>(sc.getResult().getType());
      if (st && circt::hw::getBitWidth(st) <= 64) {
        auto elems = st.getElements();
        unsigned total = circt::hw::getBitWidth(st);
        std::string expr; unsigned consumed = 0;
        for (unsigned i = 0; i < elems.size(); ++i) {
          unsigned w = circt::hw::getBitWidth(elems[i].type);
          consumed += w;
          unsigned off = total - consumed;
          auto f = translateValue(sc.getOperand(i), maxDepth - 1);
          if (!f.success) return f;
          std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL" : ("((1ULL << " + std::to_string(w) + ") - 1)");
          std::string piece = "((((uint64_t)(" + f.expr + ")) & " + mask + ") << " + std::to_string(off) + ")";
          expr = expr.empty() ? piece : (expr + " | " + piece);
        }
        return TranslateResult::ok("(" + expr + ")");
      }
    }
    // Integer-element array VALUE → packed integer: elements concatenated
    // with element 0 at the LSBs (array_create operand 0 = element N-1 =
    // the MSBs — comb.concat convention).  aes_control_fsm packs the two
    // key-qe bytes into an i16 before muxing against the sideload replicate.
    if (auto ac = bcOp.getInput().getDefiningOp<circt::hw::ArrayCreateOp>()) {
      auto dstInt = mlir::dyn_cast<mlir::IntegerType>(bcOp.getType());
      auto elTy = mlir::dyn_cast<mlir::IntegerType>(
          mlir::cast<circt::hw::ArrayType>(ac.getType()).getElementType());
      if (dstInt && elTy && dstInt.getWidth() <= 64 &&
          elTy.getWidth() * ac.getNumOperands() == dstInt.getWidth()) {
        unsigned n = ac.getNumOperands(), w = elTy.getWidth();
        std::string expr;
        for (unsigned i = 0; i < n; ++i) {
          auto f = translateValue(ac.getOperand(i), maxDepth - 1);
          if (!f.success) return f;
          unsigned off = (n - 1 - i) * w;
          std::string mask = w >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                                     : ("((1ULL << " + std::to_string(w) + ") - 1)");
          std::string piece = "((((uint64_t)(" + f.expr + ")) & " + mask +
                              ") << " + std::to_string(off) + ")";
          expr = expr.empty() ? piece : (expr + " | " + piece);
        }
        return TranslateResult::ok("(" + expr + ")");
      }
    }
    return translateValue(bcOp.getInput(), maxDepth - 1);
  }

  // hw.array_create of integer elements as a packed VALUE: spell the
  // concatenation directly (MSB-first: operand 0 is the highest
  // element).  lc_ctrl packs `{DecLcStateNumRep{dec_lc_state}}` into
  // the 30-bit LC_STATE CSR through bitcast(array_create(...)).
  if (auto acv = mlir::dyn_cast<circt::hw::ArrayCreateOp>(defOp)) {
    auto at = mlir::dyn_cast<circt::hw::ArrayType>(acv.getType());
    auto et = at ? mlir::dyn_cast<mlir::IntegerType>(at.getElementType())
                 : nullptr;
    if (et) {
      unsigned n = acv.getNumOperands(), ew = et.getWidth();
      unsigned total = n * ew;
      if (total <= 64) {
        std::string expr;
        std::string mask = ew >= 64
            ? "0xFFFFFFFFFFFFFFFFULL"
            : ("((1ULL << " + std::to_string(ew) + ") - 1)");
        for (unsigned i = 0; i < n; ++i) {
          auto ei = translateValue(acv.getOperand(i), maxDepth - 1);
          if (!ei.success) return ei;
          unsigned sh = (n - 1 - i) * ew;
          std::string piece = "((((uint64_t)(" + ei.expr + ")) & " + mask +
                              ") << " + std::to_string(sh) + ")";
          expr = expr.empty() ? piece : (expr + " | " + piece);
        }
        return TranslateResult::ok("(" + expr + ")");
      }
    }
  }

  if (auto extractOp = mlir::dyn_cast<circt::hw::StructExtractOp>(defOp)) {
    // Field extraction from a struct VALUE built by struct_create / selected
    // by mux / picked out of an hw.array_create by a (possibly runtime)
    // index: push the field extraction into the leaves instead of treating
    // the (expression) input as a field NAME.
    {
      auto pushed = translateStructFieldOf(extractOp.getInput(),
                                          extractOp.getFieldNameAttr().getValue(),
                                          maxDepth - 1);
      if (pushed) return *pushed;
    }
    std::string base = getSignalName(extractOp.getInput());
    // Fall back to recursive translateValue when getSignalName couldn't
    // name the input directly (e.g. nested struct_extract chains).
    if (base.empty()) {
      auto baseRes = translateValue(extractOp.getInput(), maxDepth - 1);
      if (!baseRes.success) return baseRes;
      base = baseRes.expr;
    }
    if (base.empty())
      return TranslateResult::fail("struct_extract: cannot name input");
    std::string fieldName = extractOp.getFieldNameAttr().getValue().str();
    // base that is an EXPRESSION (parens, calls, operators) is a packed
    // struct VALUE, not a state-field name — sanitizing it into a name
    // fabricated fields like `s->qpw_wide_extract(...)_d` (lc_ctrl's
    // hw2reg.device_id[k].d fed by a 256-bit otp_device_id slice).
    // Extract the field as a BIT SLICE of the packed value instead:
    // hw.struct packing is MSB-first, so the first field owns the top
    // bits.  A parenthesized PLAIN `s->NAME` (translateValue wraps its
    // results) is still a name — unwrap it first, or the aggregate-root
    // reference gets a bogus scalar bit-slice that OVERRODE the real
    // per-leaf bridge (lc_ctrl's rsp_intg_gen a_ready went to 0 and the
    // whole regs TL port played dead).
    std::string pnPlain;
    bool basePlain = isPlainSignalRef(base, &pnPlain);
    if (basePlain)
      base = "s->" + pnPlain;
    // If the input chains down to a PROBE of an (exploded) aggregate
    // sig, its scalar translation is the aggregate ROOT name — a state
    // field that does not exist.  The per-leaf instance bridge already
    // carries this connection; fail so the bogus duplicate drv is
    // dropped instead of overriding the bridge (lc_ctrl's
    // rsp_intg_gen.tl_i.a_ready double-drive).
    {
      mlir::Value probe = extractOp.getInput();
      for (;;) {
        if (auto ex3 = probe.getDefiningOp<circt::comb::ExtractOp>()) {
          probe = ex3.getInput();
          continue;
        }
        if (auto bc3 = probe.getDefiningOp<circt::hw::BitcastOp>()) {
          probe = bc3.getInput();
          continue;
        }
        if (auto uc3 =
                probe.getDefiningOp<mlir::UnrealizedConversionCastOp>()) {
          if (uc3.getNumOperands() == 1) {
            probe = uc3.getOperand(0);
            continue;
          }
        }
        break;
      }
      if (auto prb3 = probe.getDefiningOp<circt::llhd::ProbeOp>())
        if (!mlir::isa<mlir::IntegerType>(
                mlir::cast<circt::llhd::RefType>(prb3.getSignal().getType())
                    .getNestedType()))
          return TranslateResult::fail(
              "struct_extract of aggregate probe: leaf bridge covers it");
    }
    if (!basePlain) {
      auto stTy = mlir::dyn_cast<circt::hw::StructType>(
          extractOp.getInput().getType());
      if (!stTy)
        return TranslateResult::fail("struct_extract: expr base, no type");
      int64_t total = circt::hw::getBitWidth(stTy);
      if (total <= 0 || total > 128)
        return TranslateResult::fail(
            "struct_extract: expr base wider than 128 bits");
      int64_t off = total;
      int64_t fw = 0;
      for (auto el : stTy.getElements()) {
        int64_t w = circt::hw::getBitWidth(el.type);
        off -= w;
        if (el.name.getValue() == fieldName) { fw = w; break; }
      }
      if (fw <= 0 || fw > 64)
        return TranslateResult::fail("struct_extract: field shape");
      std::string cast = total > 64 ? "__uint128_t" : "uint64_t";
      std::string mask = fw >= 64
          ? "0xFFFFFFFFFFFFFFFFULL"
          : ("((1ULL << " + std::to_string(fw) + ") - 1)");
      return TranslateResult::ok("((uint64_t)((( " + cast + ")(" + base +
                                 ") >> " + std::to_string(off) + ") & " +
                                 mask + "))");
    }
    // base is typically "s->name" — strip prefix, append, re-add, sanitize.
    if (base.compare(0, 3, "s->") == 0) {
      std::string raw = base.substr(3);
      return TranslateResult::ok("s->" + sanitizeSignalName(raw + "." +
                                                              fieldName));
    }
    // Non-`s->` base (rare): just sanitize and return as a state field.
    return TranslateResult::ok("s->" + sanitizeSignalName(base + "." +
                                                            fieldName));
  }

  // hw.instance — Fix 5B (P2):
  // An instance result corresponds to a specific output port of the
  // called sub-module.  We synthesize a state field `<inst>.<port>` so
  // the parent's update_state() at least references a named slot.
  // CAVEAT: this slot is never updated by the parent's update_state()
  // (the sub-module's internal computation isn't translated into the
  // parent device).  Generated C therefore COMPILES but reads stale
  // data at runtime.  Full correctness would require running each
  // sub-module's update_state from the parent — out of scope here.
  if (auto opResult = mlir::dyn_cast<mlir::OpResult>(val)) {
    if (auto instOp = mlir::dyn_cast<circt::hw::InstanceOp>(
            opResult.getOwner())) {
      unsigned resIdx = opResult.getResultNumber();
      auto resultNamesAttr = instOp.getResultNames();
      if (resIdx < resultNamesAttr.size()) {
        auto portNameAttr = mlir::cast<mlir::StringAttr>(
            resultNamesAttr[resIdx]);
        std::string instName = instOp.getInstanceName().str();
        std::string portName = portNameAttr.getValue().str();
        // SYNTHESISED, not looked up — so it must be offered to the field
        // mapper like any other name.  When a caller (the emitter's
        // instance-port bridge) installs a mapper, it is translating an
        // expression from INSIDE a child module, and this name is relative to
        // that child; without the mapper it would name a field of the wrong
        // scope.  That is exactly how `u_sync_rptr_gray_q_o` reached the
        // emitted C and broke spi_device's build.
        // mapSignalField returns nullopt ONLY when a mapper is installed and
        // rejected the name, so falling through on nullopt would reinstate the
        // wrong-scope name the mapper just refused.
        { auto _m = mapSignalField(instName + "." + portName);
          if (!_m) return TranslateResult::fail(
              "instance port not in caller scope: " + instName + "." + portName);
          return TranslateResult::ok(*_m); }
      }
    }
  }

  // builtin.unrealized_conversion_cast — pass-through for the common
  // case of bridging between array<NxT> ↔ array<MxT> in OT IR (e.g.
  // mtimecmp_update casts between array<1xarray<1xi1>> and array<1xi1>).
  // We translate the underlying operand and trust the field name path
  // collapses to a scalar at the end of the chain.
  if (auto castOp = mlir::dyn_cast<mlir::UnrealizedConversionCastOp>(defOp)) {
    if (castOp.getNumOperands() == 1) {
      return translateValue(castOp.getOperand(0), maxDepth - 1);
    }
  }

  // hw.array_get %arr[%c] — element extraction.  Constant index required;
  // dynamic indexing into a state-struct array isn't generally
  // expressible as a single C expression.  Resolves the result via:
  //   - if input is hw.array_create, fold to the matching operand
  //     (CIRCT MSB-first convention: operand[N-1-i] = element i)
  //   - else treat the input as a named base and append "[i]"
  if (auto agOp = mlir::dyn_cast<circt::hw::ArrayGetOp>(defOp)) {
    auto idxConst = agOp.getIndex().getDefiningOp<circt::hw::ConstantOp>();
    mlir::Value input = agOp.getInput();
    // Inside an inlined func.func body: an array-typed block arg is bound
    // to the CALLER's aggregate value — resolve through it.
    if (auto ba = mlir::dyn_cast<mlir::BlockArgument>(input)) {
      auto &vbind = callArgValueBindings();
      auto it = vbind.find(ba);
      if (it != vbind.end())
        input = it->second;
    }
    // Peel through unrealized_conversion_cast chains — but ONLY while the
    // element type is preserved.
    //
    // A cast that CHANGES the element type RE-INDEXES the array: element k of
    // an `array<16 x i8>` view is not element k of the `array<8 x i16>` it was
    // cast from.  Peeling it applies the destination's index to the source's
    // shape, and nothing downstream can tell.  aes_ctr paid for this: its
    // 128-bit counter is `[7:0][15:0]`, the byte-reversal that feeds the
    // increment takes a 16-byte view, and every byte index landed on the
    // word of the same number — so the reversal produced a value built from
    // the wrong bytes, the incremented counter was garbage, and AES-CTR
    // returned wrong ciphertext from the SECOND block onward while the
    // single-block KAT stayed green.
    while (auto cast =
               input.getDefiningOp<mlir::UnrealizedConversionCastOp>()) {
      if (cast.getNumOperands() != 1) break;
      auto dstA = mlir::dyn_cast<circt::hw::ArrayType>(input.getType());
      auto srcA =
          mlir::dyn_cast<circt::hw::ArrayType>(cast.getOperand(0).getType());
      if (dstA && srcA && dstA.getElementType() != srcA.getElementType())
        break;
      input = cast.getOperand(0);
    }
    // Shape-changing cast left in place above: ask the bit-range router for
    // the element instead of indexing the wrong shape.  Element k of an
    // array<N x iW> occupies bits [k*W, (k+1)*W) of the packed value, which
    // is exactly what sliceValue resolves.
    if (idxConst) {
      if (auto cast =
              input.getDefiningOp<mlir::UnrealizedConversionCastOp>()) {
        auto dstA = mlir::dyn_cast<circt::hw::ArrayType>(input.getType());
        auto elI = dstA ? mlir::dyn_cast<mlir::IntegerType>(
                              dstA.getElementType())
                        : nullptr;
        if (cast.getNumOperands() == 1 && elI && elI.getWidth() &&
            elI.getWidth() <= 64) {
          uint64_t k = idxConst.getValue().getZExtValue();
          auto r = sliceValue(cast.getOperand(0), k * elI.getWidth(),
                              elI.getWidth(), maxDepth - 1);
          if (r.success) return r;
        }
      }
    }
    if (!idxConst) {
      // RUNTIME index into an hw.array_create (the canonicalizer folds a
      // `idx==0 ? e0 : idx==1 ? e1 : ...` mux chain — e.g. the read-mux join
      // produced by the inout-block-arg lowering — into exactly this shape).
      // Emit it back as a ternary chain over the operands (element i =
      // operand[N-1-i]); the last element is the default.
      // Runtime index into a CONSTANT table (hw.aggregate_constant — e.g.
      // prim_sha2_pkg's CubicRootPrime round-constant ROMs, indexed by
      // round_q).  Emit a C99 compound-literal lookup: elements are attr
      // order = element 0 first.  Out-of-range indices (the RTL never
      // produces one) read as 0 instead of overrunning.
      if (auto aggc = input.getDefiningOp<circt::hw::AggregateConstantOp>()) {
        auto arrTy = mlir::dyn_cast<circt::hw::ArrayType>(aggc.getType());
        auto elTy = arrTy ? mlir::dyn_cast<mlir::IntegerType>(
                                arrTy.getElementType())
                          : nullptr;
        if (elTy && elTy.getWidth() <= 64) {
          auto ix = translateValue(agOp.getIndex(), maxDepth - 1);
          if (!ix.success) return ix;
          auto elems = mlir::cast<mlir::ArrayAttr>(aggc.getFields());
          std::string tbl = "(const uint64_t[" +
                            std::to_string(elems.size()) + "]){";
          // aggregate_constant lists fields MSB-first (attribute entry 0 =
          // HIGHEST element index — same convention as array_create
          // operands).  Emit the C table REVERSED so tbl[i] == element i:
          // straight emission handed SHA-256 K[63-t] instead of K[t] and
          // round 0 added 0xc67178f2 in place of 0x428a2f98 (the
          // single-bit-e fingerprint experiment caught it).
          for (size_t i = 0, n = elems.size(); i < n; ++i) {
            auto iv = mlir::cast<mlir::IntegerAttr>(elems[n - 1 - i])
                          .getValue();
            llvm::SmallString<24> hex;
            iv.toStringUnsigned(hex, 16);
            tbl += (i ? ",0x" : "0x") + std::string(hex) + "ULL";
          }
          tbl += "}";
          std::string ixe = "((unsigned)(" + ix.expr + "))";
          return TranslateResult::ok(
              "((" + ixe + " < " + std::to_string(elems.size()) + "u) ? (" +
              tbl + ")[" + ixe + "] : 0)");
        }
      }

      // Distribute array_get over a mux of arrays:
      // get(mux(c, A, B))[k] == c ? get(A)[k] : get(B)[k]
      // (kmac_core's `kmac_data = en_key_write ? key_sliced : '{default:0}`
      // reaches here as array_get(mux(...))[0]).
      if (auto mx = input.getDefiningOp<circt::comb::MuxOp>()) {
        auto c = translateValue(mx.getCond(), maxDepth - 1);
        if (!c.success) return c;
        auto mkGet = [&](mlir::Value arr) -> TranslateResult {
          mlir::OpBuilder b(agOp);
          auto tmp = b.create<circt::hw::ArrayGetOp>(
              agOp.getLoc(), arr, agOp.getIndex());
          auto r = translateValue(tmp.getResult(), maxDepth - 1);
          tmp->erase();
          return r;
        };
        auto tv = mkGet(mx.getTrueValue());
        if (!tv.success) return tv;
        auto fv = mkGet(mx.getFalseValue());
        if (!fv.success) return fv;
        return TranslateResult::ok("((" + c.expr + ") ? (" + tv.expr +
                                   ") : (" + fv.expr + "))");
      }
      auto acOp = input.getDefiningOp<circt::hw::ArrayCreateOp>();
      if (!acOp) {
        // Memory-array read through a whole-array probe:
        //   %v = llhd.prb %mem ; hw.array_get %v[%idx]   (prim_ram_2p RMW /
        // registered read).  Same wide-bitvector element extract as the
        // prb(sig.array_get) form.
        if (auto prb = input.getDefiningOp<circt::llhd::ProbeOp>())
          if (auto memRef = memoryArrayRef(prb.getSignal())) {
            auto ix2 = translateValue(agOp.getIndex(), maxDepth - 1);
            if (!ix2.success) return ix2;
            return TranslateResult::ok("qpw_wide_extract(s->" + memRef->name + ", " +
                                       std::to_string(memRef->words) + ", ((unsigned)(" +
                                       ix2.expr + ") & " + std::to_string(memRef->idxMask) + ") * " +
                                       std::to_string(memRef->elemWidth) + ", " +
                                       std::to_string(memRef->elemWidth) + ")");
          }
        // Dynamic index over an array VIEW of a scalar (hw.bitcast of an
        // integer, e.g. tlul_adapter_sram's `rdata_reshaped[woffset]` where
        // reshaped = bitcast(rdata_i) : array<N x DataWidth>): a plain
        // dynamic bit-slice of the underlying scalar.
        if (auto bcIn = input.getDefiningOp<circt::hw::BitcastOp>()) {
          auto arrTy = mlir::dyn_cast<circt::hw::ArrayType>(input.getType());
          auto baseInt =
              mlir::dyn_cast<mlir::IntegerType>(bcIn.getInput().getType());
          auto elTy = arrTy ? mlir::dyn_cast<mlir::IntegerType>(
                                  arrTy.getElementType())
                            : nullptr;
          if (arrTy && baseInt && elTy && baseInt.getWidth() <= 64 &&
              elTy.getWidth() <= 64) {
            auto be = translateValue(bcIn.getInput(), maxDepth - 1);
            if (!be.success) return be;
            auto ix3 = translateValue(agOp.getIndex(), maxDepth - 1);
            if (!ix3.success) return ix3;
            unsigned ew = elTy.getWidth();
            std::string mask =
                ew >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                         : ("((1ULL << " + std::to_string(ew) + ") - 1)");
            return TranslateResult::ok(
                "((((uint64_t)(" + be.expr + ")) >> (((unsigned)(" +
                ix3.expr + ") % " + std::to_string(arrTy.getNumElements()) +
                "u) * " + std::to_string(ew) + "u)) & " + mask + ")");
          }
        }
        // TWO-LEVEL constant table: get(get(aggregate_constant_2d, i), j)
        // — lc_ctrl's TransTokenIdxMatrix[dec_state][target] (21x21xi3).
        // Flatten into one C table with both aggregate layers reversed
        // (attr entry 0 = HIGHEST index at every level).
        if (auto innerGet =
                input.getDefiningOp<circt::hw::ArrayGetOp>()) {
          if (auto aggc2 = innerGet.getInput()
                               .getDefiningOp<circt::hw::AggregateConstantOp>()) {
            auto outTy = mlir::dyn_cast<circt::hw::ArrayType>(
                aggc2.getType());
            auto rowTy = outTy ? mlir::dyn_cast<circt::hw::ArrayType>(
                                     outTy.getElementType())
                               : nullptr;
            auto elI = rowTy ? mlir::dyn_cast<mlir::IntegerType>(
                                   rowTy.getElementType())
                             : nullptr;
            if (elI && elI.getWidth() <= 64) {
              unsigned N2 = outTy.getNumElements(),
                       M2 = rowTy.getNumElements();
              auto io = translateValue(innerGet.getIndex(), maxDepth - 1);
              auto ij = translateValue(agOp.getIndex(), maxDepth - 1);
              if (io.success && ij.success && N2 * M2 <= 4096) {
                auto rows = mlir::cast<mlir::ArrayAttr>(aggc2.getFields());
                std::string tbl = "(const uint64_t[" +
                                  std::to_string(N2 * M2) + "]){";
                bool first = true;
                for (unsigned i2 = 0; i2 < N2; ++i2) {
                  auto row = mlir::cast<mlir::ArrayAttr>(rows[N2 - 1 - i2]);
                  for (unsigned j2 = 0; j2 < M2; ++j2) {
                    auto iv = mlir::cast<mlir::IntegerAttr>(row[M2 - 1 - j2])
                                  .getValue();
                    llvm::SmallString<24> hex;
                    iv.toStringUnsigned(hex, 16);
                    tbl += (first ? "0x" : ",0x") + std::string(hex) + "ULL";
                    first = false;
                  }
                }
                tbl += "}";
                std::string ioe = "((unsigned)(" + io.expr + ") % " +
                                  std::to_string(N2) + "u)";
                std::string ije = "((unsigned)(" + ij.expr + ") % " +
                                  std::to_string(M2) + "u)";
                return TranslateResult::ok("((" + tbl + ")[" + ioe + " * " +
                                           std::to_string(M2) + "u + " +
                                           ije + "])");
              }
            }
          }
        }
        // Dynamic index over a probed array SIG whose elements were
        // exploded into `<name>_k_` leaves (lc_ctrl's token-index lookup
        // `hashed_tokens_lower[token_idx]`): a small select chain over
        // the leaf fields.  Bounded at 8 elements like the projector's
        // N-way select.
        if (auto prb2 = input.getDefiningOp<circt::llhd::ProbeOp>()) {
          auto arrTy2 = mlir::dyn_cast<circt::hw::ArrayType>(input.getType());
          auto elTy2 = arrTy2 ? mlir::dyn_cast<mlir::IntegerType>(
                                    arrTy2.getElementType())
                              : nullptr;
          if (arrTy2 && elTy2 && elTy2.getWidth() <= 64 &&
              arrTy2.getNumElements() >= 2 && arrTy2.getNumElements() <= 8) {
            auto basePrb = translateValue(input, maxDepth - 1);
            std::string baseName;
            // translateValue on the whole-array probe yields the exploded
            // base name; peel `s->NAME` even when it failed by trying the
            // signal directly.
            if (basePrb.success && isPlainSignalRef(basePrb.expr, &baseName)) {
              // fallthrough with baseName
            } else {
              if (auto sg2 =
                      prb2.getSignal().getDefiningOp<circt::llhd::SignalOp>())
                if (auto nm2 = sg2.getName())
                  baseName = sanitizeSignalName(nm2->str());
            }
            if (!baseName.empty()) {
              auto ixd = translateValue(agOp.getIndex(), maxDepth - 1);
              if (ixd.success) {
                unsigned n2 = arrTy2.getNumElements();
                std::string chain =
                    "s->" + baseName + "_" + std::to_string(n2 - 1) + "_";
                for (int k2 = (int)n2 - 2; k2 >= 0; --k2)
                  chain = "((((unsigned)(" + ixd.expr + ")) == " +
                          std::to_string(k2) + "u) ? s->" + baseName + "_" +
                          std::to_string(k2) + "_ : " + chain + ")";
                return TranslateResult::ok("(" + chain + ")");
              }
            }
          }
        }
        {
          std::string shape = "array_get dyn: input=";
          if (mlir::Operation *d3 = input.getDefiningOp())
            shape += d3->getName().getStringRef().str();
          else
            shape += "block-arg";
          if (auto at3 = mlir::dyn_cast<circt::hw::ArrayType>(input.getType()))
            shape += " n=" + std::to_string(at3.getNumElements());
          llvm::errs() << "  [DYN-GET-FAIL] " << shape << "\n";
        }
        return TranslateResult::fail("array_get with non-constant index on non-array_create");
      }
      auto ix = translateValue(agOp.getIndex(), maxDepth - 1);
      if (!ix.success) return ix;
      unsigned n = acOp.getNumOperands();
      std::string expr;
      // Build from the last element outward: ((ix==0)?e0:((ix==1)?e1:...:e_{n-1}))
      std::string tail;
      {
        auto last = translateValue(acOp.getOperand(0), maxDepth - 1);   // element n-1
        if (!last.success) return last;
        tail = "(" + last.expr + ")";
      }
      for (int i = (int)n - 2; i >= 0; --i) {
        auto ei = translateValue(acOp.getOperand(n - 1 - i), maxDepth - 1);
        if (!ei.success) return ei;
        tail = "(((" + ix.expr + ") == (" + std::to_string(i) + ")) ? (" + ei.expr + ") : " + tail + ")";
      }
      return TranslateResult::ok(tail);
    }
    unsigned idx = idxConst.getValue().getZExtValue();
    if (auto acOp = input.getDefiningOp<circt::hw::ArrayCreateOp>()) {
      unsigned n = acOp.getNumOperands();
      if (idx >= n)
        return TranslateResult::fail("array_get index out of range");
      // operand[N-1-i] → element i
      return translateValue(acOp.getOperand(n - 1 - idx), maxDepth - 1);
    }
    // Element width (needed by the expression-input paths below).
    unsigned elemW = 0;
    if (auto arrTy = mlir::dyn_cast<circt::hw::ArrayType>(input.getType()))
      if (auto eTy = mlir::dyn_cast<mlir::IntegerType>(arrTy.getElementType()))
        elemW = eTy.getWidth();

    // GENERIC BIT PROJECTION fallback: a constant array_get chain over
    // any number of width-changing array<->array bitcasts of a probe of
    // a NAMED aggregate sig resolves to a stitched read of the exploded
    // leaves at the要求 bit offset.  (keymgr views its 8xi32 key_state_d
    // as 4xi64 ECC words; the old "peel the bitcast" behavior zipped by
    // INDEX and silently dropped the high half of every word.)
    {
      unsigned projOff = 0;
      unsigned projW =
          (unsigned)std::max<int64_t>(circt::hw::getBitWidth(agOp.getType()), 0);
      mlir::Value curV = agOp.getResult();
      bool chainOk = projW > 0 && projW <= 64;
      while (chainOk) {
        if (auto g2 = curV.getDefiningOp<circt::hw::ArrayGetOp>()) {
          auto k2 = g2.getIndex().getDefiningOp<circt::hw::ConstantOp>();
          int64_t eb2 = circt::hw::getBitWidth(g2.getType());
          if (!k2 || eb2 <= 0) { chainOk = false; break; }
          projOff += (unsigned)(k2.getValue().getZExtValue() * eb2);
          curV = g2.getInput();
          continue;
        }
        if (auto b2 = curV.getDefiningOp<circt::hw::BitcastOp>()) {
          curV = b2.getInput();
          continue;
        }
        break;
      }
      auto prj = curV.getDefiningOp<circt::llhd::ProbeOp>();
      if (chainOk && prj) {
        std::string base = getSignalName(prj.getSignal());
        mlir::Type st3 =
            mlir::cast<circt::llhd::RefType>(prj.getSignal().getType())
                .getNestedType();
        if (!base.empty() && base != "unnamed" && base != "s->unnamed") {
          std::function<std::optional<std::string>(std::string, mlir::Type,
                                                   unsigned, unsigned)>
              sigProj = [&](std::string b, mlir::Type t, unsigned off,
                            unsigned w) -> std::optional<std::string> {
            if (auto at4 = mlir::dyn_cast<circt::hw::ArrayType>(t)) {
              int64_t eb = circt::hw::getBitWidth(at4.getElementType());
              if (eb <= 0) return std::nullopt;
              unsigned i4 = off / (unsigned)eb, rem = off - i4 * (unsigned)eb;
              if (rem + w <= (unsigned)eb)
                return sigProj(b + "[" + std::to_string(i4) + "]",
                               at4.getElementType(), rem, w);
              if (i4 + 1 >= at4.getNumElements()) return std::nullopt;
              unsigned lowW = (unsigned)eb - rem;
              auto a4 = sigProj(b + "[" + std::to_string(i4) + "]",
                                at4.getElementType(), rem, lowW);
              auto b4 = sigProj(b + "[" + std::to_string(i4 + 1) + "]",
                                at4.getElementType(), 0, w - lowW);
              if (!a4 || !b4) return std::nullopt;
              return "((" + *a4 + ") | ((" + *b4 + ") << " +
                     std::to_string(lowW) + "))";
            }
            if (auto it4 = mlir::dyn_cast<mlir::IntegerType>(t)) {
              if (off + w > it4.getWidth()) return std::nullopt;
              std::string leaf = sanitizeSignalName(b);
              if (it4.getWidth() > 64 && it4.getWidth() <= 128) {
                // __uint128_t SCALAR storage — no array decay for qpw
                std::string e5 = "((uint64_t)(((__uint128_t)s->" + leaf +
                                 ") >> " + std::to_string(off) + "))";
                if (w < 64)
                  e5 = "(" + e5 + " & ((1ULL << " + std::to_string(w) +
                       ") - 1))";
                return "(" + e5 + ")";
              }
              if (it4.getWidth() > 128)
                return "qpw_wide_extract(s->" + leaf + ", " +
                       std::to_string((it4.getWidth() + 63) / 64) + ", " +
                       std::to_string(off) + ", " + std::to_string(w) + ")";
              std::string e4 = "((uint64_t)s->" + leaf + ")";
              if (off) e4 = "(" + e4 + " >> " + std::to_string(off) + ")";
              if (w < 64)
                e4 = "(" + e4 + " & ((1ULL << " + std::to_string(w) +
                     ") - 1))";
              return "(" + e4 + ")";
            }
            return std::nullopt;
          };
          // Only take this path when a width-CHANGING bitcast is actually
          // present (otherwise the specialized paths below are fine).
          bool sawReshape = false;
          {
            mlir::Value scan = agOp.getInput();
            while (true) {
              if (auto g3 = scan.getDefiningOp<circt::hw::ArrayGetOp>()) {
                scan = g3.getInput();
                continue;
              }
              if (auto b3 = scan.getDefiningOp<circt::hw::BitcastOp>()) {
                sawReshape = true;
                scan = b3.getInput();
                continue;
              }
              break;
            }
          }
          if (sawReshape)
            if (auto r4 = sigProj(base.compare(0, 3, "s->") == 0
                                      ? base.substr(3)
                                      : base,
                                  st3, projOff, projW))
              return TranslateResult::ok(*r4);
        }
      }
    }

    // get(bitcast(iN -> array<M x elemW>))[constK]: pure reinterpretation —
    // element K is bits [K*elemW +: elemW] of the scalar source.
    // aes_control_fsm's key-write-enable path muxes an i16 (sideload
    // replicate vs the packed qe pair) and then views it as 2 bytes; without
    // this the whole IDLE-arm drv failed and software key loads never
    // registered.
    if (auto bc = input.getDefiningOp<circt::hw::BitcastOp>()) {
      if (auto srcInt =
              mlir::dyn_cast<mlir::IntegerType>(bc.getInput().getType())) {
        if (elemW && elemW <= 64 && srcInt.getWidth() <= 64 &&
            (uint64_t)(idx + 1) * elemW <= srcInt.getWidth()) {
          auto inner = translateValue(bc.getInput(), maxDepth - 1);
          if (!inner.success)
            return inner;
          std::string mask =
              elemW >= 64 ? "0xFFFFFFFFFFFFFFFFULL"
                          : ("((1ULL << " + std::to_string(elemW) + ") - 1)");
          return TranslateResult::ok(
              "((((uint64_t)(" + inner.expr + ")) >> " +
              std::to_string((uint64_t)idx * elemW) + ") & " + mask + ")");
        }
      }
    }

    // Same rule when the bitcast SOURCE is an AGGREGATE rather than a scalar:
    // element K of the destination view is still bits [K*elemW +: elemW] of
    // the packed source, and sliceValue knows how to fetch those from an
    // array/struct.  Without this the bitcast got peeled and K was applied to
    // the SOURCE's shape — silently, because both sides are arrays and the
    // index is in range.
    //
    // aes_ctr is what this cost.  Its counter is `[7:0][15:0]`; the RTL views
    // it as 16 bytes (`hw.bitcast : array<8xi16> -> array<16xi8>`) to reverse
    // the byte order before incrementing.  Byte 14 resolved to WORD 14 -> 1,
    // so the reversal was assembled from the wrong bytes, the incremented
    // counter was garbage, and AES-CTR produced wrong ciphertext from the
    // SECOND block onward.  The single-block KAT could not see it: block 1
    // uses the counter software wrote.  See firmware_test/main_aes_ctr.c.
    if (auto bc = input.getDefiningOp<circt::hw::BitcastOp>()) {
      if (!mlir::isa<mlir::IntegerType>(bc.getInput().getType()) && elemW &&
          elemW <= 64) {
        auto r = sliceValue(bc.getInput(), (uint64_t)idx * elemW, elemW,
                            maxDepth - 1);
        if (r.success)
          return r;
      }
    }

    // Two-level get through an array→array reshape:
    //   get( get( bitcast(srcArr -> array<N x array<M x elemW>>) )[outer] )[idx]
    // When the reshape's OUTER element width equals the source element width
    // (4xi32 viewed as 4x(4xi8)), outer element k is exactly source element k
    // reinterpreted, and the inner get is a bit slice of it.  aes_core's
    // data_in_state / key mirrors are this shape (the importer's assignment
    // conversion for `state_t = [3:0][31:0]`).
    if (auto outerGet = input.getDefiningOp<circt::hw::ArrayGetOp>()) {
      auto outerIdxC =
          outerGet.getIndex().getDefiningOp<circt::hw::ConstantOp>();
      auto bc = outerGet.getInput().getDefiningOp<circt::hw::BitcastOp>();
      if (outerIdxC && bc && elemW && elemW <= 64) {
        auto srcArr =
            mlir::dyn_cast<circt::hw::ArrayType>(bc.getInput().getType());
        auto srcEl = srcArr ? mlir::dyn_cast<mlir::IntegerType>(
                                  srcArr.getElementType())
                            : nullptr;
        unsigned outerW =
            circt::hw::getBitWidth(outerGet.getType()) > 0
                ? (unsigned)circt::hw::getBitWidth(outerGet.getType())
                : 0;
        if (srcEl && srcEl.getWidth() == outerW && srcEl.getWidth() <= 64 &&
            (uint64_t)(idx + 1) * elemW <= outerW) {
          unsigned outerIdx = outerIdxC.getValue().getZExtValue();
          TranslateResult elemExpr = TranslateResult::fail("no source elem");
          if (auto srcAc =
                  bc.getInput().getDefiningOp<circt::hw::ArrayCreateOp>()) {
            unsigned n = srcAc.getNumOperands();
            if (outerIdx < n)
              elemExpr = translateValue(srcAc.getOperand(n - 1 - outerIdx),
                                        maxDepth - 1);
          }
          if (elemExpr.success) {
            std::string mask =
                elemW >= 64
                    ? "0xFFFFFFFFFFFFFFFFULL"
                    : ("((1ULL << " + std::to_string(elemW) + ") - 1)");
            return TranslateResult::ok(
                "((((uint64_t)(" + elemExpr.expr + ")) >> " +
                std::to_string((uint64_t)idx * elemW) + ") & " + mask + ")");
          }
        }
      }
    }

    // array_get(func.call(...), const idx) — an ARRAY-returning SV function
    // consumed element-wise (prim_sha2_pkg::compress_* at sha2's compression
    // step: hash_d[i] = compress(w, k, hash_q)[i]).  Inline the callee with
    // the shared machinery and translate exactly the selected element of its
    // returned hw.array_create (operand N-1-idx = element idx).
    if (auto call = input.getDefiningOp<mlir::func::CallOp>()) {
      return inlineFuncCallWith(call, maxDepth, [&](mlir::Value retV)
                                    -> TranslateResult {
        auto ac = retV.getDefiningOp<circt::hw::ArrayCreateOp>();
        if (!ac)
          return TranslateResult::fail(
              "array_get(func.call): return is not array_create");
        unsigned n = ac.getNumOperands();
        if (idx >= n)
          return TranslateResult::fail("array_get(func.call): index range");
        return translateValue(ac.getOperand(n - 1 - idx), maxDepth - 1);
      });
    }

    // bitcast(replicate(x)) — every element is identical: x tiled to the
    // element width.  hmac's prim_sha2 wipe path is exactly this shape
    // (w_d = wipe ? bitcast({32{wipe_v}} : i1024) : keep, then array_get).
    // The whole-array value is >64 bits so no single C expression carries
    // it, but each ELEMENT does.
    {
      mlir::Value src = input;
      while (auto bc = src.getDefiningOp<circt::hw::BitcastOp>())
        src = bc.getInput();
      if (auto rep = src.getDefiningOp<circt::comb::ReplicateOp>()) {
        auto repInTy =
            mlir::dyn_cast<mlir::IntegerType>(rep.getInput().getType());
        if (repInTy && elemW && elemW <= 64 &&
            (elemW % repInTy.getWidth()) == 0) {
          auto inner = translateValue(rep.getInput(), maxDepth - 1);
          if (!inner.success) return inner;
          unsigned a = repInTy.getWidth();
          std::string b =
              "(((uint64_t)(" + inner.expr + ")) & " + genMask(a) + ")";
          std::string result;
          for (unsigned i = 0; i < elemW / a; ++i) {
            std::string t =
                i == 0 ? b : "(" + b + " << " + std::to_string(i * a) + ")";
            result = result.empty() ? t : result + " | " + t;
          }
          return TranslateResult::ok("((" + result + ") & " + genMask(elemW) +
                                     ")");
        }
      }
    }

    // array_create with a constant index: take the matching operand
    // directly (operand[N-1-i] = element i).  rv_plic's per-source prio
    // array (186 prb elements gathered by one array_create) rides this —
    // dropping the branch in a refactor reclassified the top-level
    // prio[i] drvs as COMPLEX and their comb rows vanished (every *-irq
    // test failed).
    if (auto acOp = input.getDefiningOp<circt::hw::ArrayCreateOp>()) {
      unsigned n = acOp.getNumOperands();
      if (idx >= n)
        return TranslateResult::fail("array_get index out of range");
      return translateValue(acOp.getOperand(n - 1 - idx), maxDepth - 1);
    }

    std::string base = getSignalName(input);
    if (base.empty()) {
      // Input didn't name directly — but its TRANSLATION may still be a
      // clean field reference (`s->name` with no operators): struct_extract
      // of an instance result resolves to exactly that (rv_plic's
      // reg2hw.prio -> s->u_reg_reg2hw_prio), and indexing a clean
      // reference by name is the established field-naming convention.
      // Only a COMPUTED expression must never be glued into a field name
      // (that manufactured garbage like `s->(..._expr..)_0_` on hmac);
      // those go through the arithmetic path below or fail loudly.
      auto baseRes = translateValue(input, maxDepth - 1);
      if (!baseRes.success)
        baseRes.expr.clear();   // fall through to the packed slicer below
      auto isCleanRef = [](const std::string &e) {
        if (e.rfind("s->", 0) != 0 || e.size() <= 3)
          return false;
        for (size_t i = 3; i < e.size(); ++i) {
          char c = e[i];
          if (!(isalnum(static_cast<unsigned char>(c)) || c == '_'))
            return false;
        }
        return true;
      };
      if (isCleanRef(baseRes.expr)) {
        base = baseRes.expr;
        std::string idxBracket = "[" + std::to_string(idx) + "]";
        return TranslateResult::ok(
            "s->" + sanitizeSignalName(base.substr(3) + idxBracket));
      }
      int64_t totalW = 0;
      if (auto arrTy = mlir::dyn_cast<circt::hw::ArrayType>(input.getType()))
        totalW = (int64_t)elemW * (int64_t)arrTy.getNumElements();
      if (baseRes.success && elemW && totalW > 0 && totalW <= 64)
        return TranslateResult::ok(
            "((((uint64_t)(" + baseRes.expr + ")) >> " +
            std::to_string(idx * elemW) + ") & " + genMask(elemW) + ")");
      // fall through: the packed-aggregate slicer below is the last resort
    }

    // LAST RESORT — static packed-aggregate slicing.  The canonicalizer
    // renders prim_sha2's W-pipeline shift/load as
    //   array_get(bitcast(concat(new_word, bitcast(array_create(w_q...)))))
    // over an i1024: no single C expression carries the whole value, but
    // the REQUESTED ELEMENT is statically locatable.  Route the bit range
    // [idx*elemW, (idx+1)*elemW) down the tree: bitcast is bit-transparent,
    // concat routes to the operand that owns the range (MSB-first: operand
    // 0 owns the top), replicate folds the offset, an aggregate landing
    // point at element granularity recurses into array_create / named
    // storage, and a <=64-bit scalar bottom falls back to translateValue
    // plus shift/mask.  Bit convention (self-consistent with the shift
    // semantics w_d[0] = w_q[1] this very chain implements): array element
    // k occupies bits [k*elemW, (k+1)*elemW) — element 0 in the LSBs.
    if (elemW && elemW <= 64) {
      auto sr = sliceValue(input, (uint64_t)idx * elemW, elemW, maxDepth);
      if (sr.success)
        return sr;
      // Fallback: distribute over a mux of arrays —
      // get(mux(c, A, B))[k] == c ? get(A)[k] : get(B)[k]
      // (kmac_core's `kmac_data = en_key_write ? key_sliced : '{default:0}`).
      if (auto mx = input.getDefiningOp<circt::comb::MuxOp>()) {
        auto c = translateValue(mx.getCond(), maxDepth - 1);
        if (c.success) {
          auto mkGet = [&](mlir::Value arr) -> TranslateResult {
            if (auto agg =
                    arr.getDefiningOp<circt::hw::AggregateConstantOp>()) {
              bool allZ = true;
              for (auto f : agg.getFields())
                if (auto ia = mlir::dyn_cast<mlir::IntegerAttr>(f))
                  { if (!ia.getValue().isZero()) { allZ = false; break; } }
                else { allZ = false; break; }
              if (allZ) return TranslateResult::ok("0");
            }
            mlir::OpBuilder b(agOp);
            auto tmp = b.create<circt::hw::ArrayGetOp>(
                agOp.getLoc(), arr, agOp.getIndex());
            auto r = translateValue(tmp.getResult(), maxDepth - 1);
            tmp->erase();
            return r;
          };
          auto tv = mkGet(mx.getTrueValue());
          if (tv.success) {
            auto fv = mkGet(mx.getFalseValue());
            if (fv.success)
              return TranslateResult::ok("((" + c.expr + ") ? (" + tv.expr +
                                         ") : (" + fv.expr + "))");
          }
        }
      }
      return TranslateResult::fail(
          "array_get: packed slice failed (" + sr.errorMsg + ")");
    }
    if (base.empty())
      return TranslateResult::fail(
          "array_get: unnameable input, no slicing channel applied");
    std::string idxBracket = "[" + std::to_string(idx) + "]";
    if (base.compare(0, 3, "s->") == 0) {
      std::string raw = base.substr(3);
      return TranslateResult::ok("s->" + sanitizeSignalName(raw + idxBracket));
    }
    return TranslateResult::ok("s->" + sanitizeSignalName(base + idxBracket));
  }

  // hw.array_create — single-element form pass-through.  Multi-element
  // array_create only makes sense paired with a constant array_get
  // (handled above).  A bare array_create reaching here is unusual; we
  // pass through the single-element case (`array_create %x` → `%x`) to
  // support the OT pattern of wrapping a scalar to fit an array-typed
  // port, then immediately unwrapping with array_get[0] downstream.
  if (auto acOp = mlir::dyn_cast<circt::hw::ArrayCreateOp>(defOp)) {
    if (acOp.getNumOperands() == 1) {
      return translateValue(acOp.getOperand(0), maxDepth - 1);
    }
  }

  // Unsupported operation
  return TranslateResult::fail("unsupported op: " + defOp->getName().getStringRef().str());
}

/// Translate llhd.drv value to C expression
inline TranslateResult translateDrvValue(circt::llhd::DriveOp drv) {
  return translateValue(drv.getValue());
}

} // namespace comb_translator

#endif // QEMU_PASSES_COMB_TRANSLATOR_H
