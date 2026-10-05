//===----------------------------------------------------------------------===//
// CombLogicExtractPass.cpp - Combinational Logic Extraction Pass
//
// This pass extracts combinational logic (llhd.drv outside of llhd.process)
// and translates it to C expressions for QEMU update_state().
//
// Design aligns with qemu-output/src/lib/ClkAnalysisResult.cpp
// Key change: qemu.comb_logic is now per hw.module, not on ModuleOp
//===----------------------------------------------------------------------===//

#include "CombTranslator.h"
#include "PassReports.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"
#include <optional>
#include <vector>

// TableGen-generated pass declaration and definition
#define GEN_PASS_DECL_COMBLOGICEXTRACT
#define GEN_PASS_DEF_COMBLOGICEXTRACT
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Data Structures (aligned with old framework)
//===----------------------------------------------------------------------===//

/// Combinational logic assignment (for update_state)
struct CombinationalAssignment {
  std::string targetSignal;   // Target signal name (sanitized)
  std::string expression;     // C expression string
  unsigned bitWidth;          // Signal bit width
  // Bug G: when target is a wide-array (>128bit), wordIndex selects which
  // 64-bit word this assignment writes.  -1 = whole signal.
  int wordIndex = -1;
  // Sequential-domain id (see ClkAnalysisResult.h).
  int seqDomain = -1;
};

/// Per-module combinational logic collection
struct ModuleCombLogic {
  std::string moduleName;
  std::vector<CombinationalAssignment> assignments;
};

/// Action types for expression generation
enum class ActionType {
  ASSIGN_CONST,     // target = constant
  ASSIGN_SIGNAL,    // target = source_signal
  ACCUMULATE,       // target = target +/- step
  COMPUTE,          // target = complex_expression
  UNKNOWN
};

/// Event action (simplified from old framework)
struct EventAction {
  ActionType type = ActionType::UNKNOWN;
  std::string targetSignal;
  std::string expression;
  std::string sourceSignal;
  int64_t constValue = 0;
  // Path condition that must hold for this drv to fire — populated when
  // the drv lives inside a non-entry basic block reached via cf.cond_br.
  // Empty string means "always" (no gating).  Emit code wraps the
  // expression in `(cond ? new : old)` so multiple drvs to the same
  // sig from different conditional blocks compose correctly: only the
  // one whose path condition is true takes effect.
  std::string gatedCondition;
};

//===----------------------------------------------------------------------===//
// Helper Functions
//===----------------------------------------------------------------------===//

/// Get signal name from llhd.sig or llhd.sig.extract.  For sig.extract
/// we return the BASE sig name — slice metadata is queried separately
/// via `getSliceInfo`.
static std::string getSignalNameFromValue(Value signal) {
  // Handle llhd.sig.extract — peel back to the underlying sig.
  if (auto sigExtract = signal.getDefiningOp<llhd::SigExtractOp>()) {
    Value baseSig = sigExtract.getInput();
    if (auto sigOp = baseSig.getDefiningOp<llhd::SignalOp>()) {
      if (auto name = sigOp.getName()) {
        return name->str();
      }
    }
    return "unnamed";
  }

  // Regular signal
  if (auto sigOp = signal.getDefiningOp<llhd::SignalOp>()) {
    if (auto name = sigOp.getName()) {
      return name->str();
    }
    // Fallback to SSA name
    std::string str;
    llvm::raw_string_ostream os(str);
    signal.print(os);
    os.flush();
    if (!str.empty() && str[0] == '%') {
      size_t end = str.find_first_of(" :");
      if (end != std::string::npos) {
        return str.substr(1, end - 1);
      }
      return str.substr(1);
    }
  }
  return "unnamed";
}

/// Slice info for an llhd.sig.extract drv — needed to emit per-bit
/// updates of a multi-bit sig (typical for OT register-decode `addr_hit`
/// vectors that are driven one bit at a time from 13 separate drvs all
/// targeting the same i13 sig).
///
/// Returns `(0, 0)` when the drv targets the whole sig (no extract).
struct SliceInfo {
  unsigned offset;     // bit offset of the slice into the base sig
  unsigned width;      // slice width (= base width when not sliced)
  unsigned baseWidth;  // total width of the base sig
  bool sliced;         // true iff drv goes through llhd.sig.extract
};

static SliceInfo getSliceInfo(Value signal) {
  SliceInfo info{0, 0, 0, false};
  Value baseSig = signal;
  if (auto sigExtract = signal.getDefiningOp<llhd::SigExtractOp>()) {
    info.sliced = true;
    baseSig = sigExtract.getInput();
    // The offset operand is the lowest-bit index, typically a constant
    // produced by `hw.constant`.  If it can't be folded statically, we
    // bail — leaves dedup falling back to the sigName-only key, which
    // matches pre-fix behaviour for that drv.
    Value offV = sigExtract.getLowBit();
    if (auto cst = offV.getDefiningOp<hw::ConstantOp>())
      info.offset = static_cast<unsigned>(cst.getValue().getZExtValue());
    else
      info.sliced = false;
    // Slice width comes from the result inout element type.
    if (auto inout = dyn_cast<llhd::RefType>(sigExtract.getResult().getType())) {
      if (auto intTy = dyn_cast<IntegerType>(inout.getNestedType()))
        info.width = intTy.getWidth();
    }
  }
  // Base width
  if (auto sigOp = baseSig.getDefiningOp<llhd::SignalOp>()) {
    Type ty = sigOp.getType();
    if (auto inout = dyn_cast<llhd::RefType>(ty))
      ty = inout.getNestedType();
    if (auto intTy = dyn_cast<IntegerType>(ty))
      info.baseWidth = intTy.getWidth();
  }
  if (!info.sliced) {
    info.offset = 0;
    info.width = info.baseWidth;
  }
  return info;
}

/// Get signal bit width
static unsigned getSignalBitWidth(Value signal) {
  Type ty = signal.getType();
  if (auto inoutTy = dyn_cast<llhd::RefType>(ty)) {
    ty = inoutTy.getNestedType();
  }
  if (auto intTy = dyn_cast<IntegerType>(ty)) {
    return intTy.getWidth();
  }
  return 0;
}

//===----------------------------------------------------------------------===//
// CFG-aware register-read-mux translation
//
// OT register read mux uses the pattern:
//
//   ^bb_check_N:
//     cf.cond_br %addr_hit_bit_N, ^bb_hit_N(%reg_qs_a, %reg_qs_b, ...), ^bb_check_next
//   ^bb_hit_N(%a: !hw.inout<i1>, %b: !hw.inout<i1>, ...):
//     %sliceA = llhd.sig.extract %reg_rdata_next from %offsetA
//     %valA   = llhd.prb %a            <-- prb of BlockArgument
//     llhd.drv %sliceA, %valA          <-- per-bit drv
//     ...
//
// Pre-fix CombLogicExtract returned "unnamed" for the prb of a non-entry
// BlockArg, so all per-bit drvs read from a dangling field.  We resolve
// these by walking predecessors:
//   - cf.br ^bb_hit_N(...)         : take dest_operand[argIdx], cond = "1"
//   - cf.cond_br c, ^bb_hit_N, _   : take true_dest_operand[argIdx], cond = c
//   - cf.cond_br c, _, ^bb_hit_N   : take false_dest_operand[argIdx], cond = !c
//
// Tier 1 limit: only handles single-predecessor blocks.  Multi-pred /
// nested CFG returns nullopt and the drv falls back to the old
// "unnamed" path (same as pre-fix — no regression).
//===----------------------------------------------------------------------===//

/// True if this BlockArgument is the entry block of an HWModuleOp.
/// Those represent module input ports and have separate handling.
static bool isModuleEntryBlockArg(BlockArgument bbarg) {
  Block *bb = bbarg.getOwner();
  Region *region = bb->getParent();
  if (!region) return false;
  if (&region->front() != bb) return false;
  Operation *parentOp = region->getParentOp();
  return parentOp && isa<hw::HWModuleOp>(parentOp);
}

/// True if `bb` is the entry block of its enclosing region (typically
/// the entry of an llhd.process body).  Drvs in the entry block fire
/// unconditionally — no gating needed.
static bool isEntryBlock(Block *bb) {
  Region *region = bb->getParent();
  return region && &region->front() == bb;
}

/// Translate a path-condition Value (typically the operand of a
/// cf.cond_br) to a C expression string.  Reuses CombTranslator's
/// `translateValue` for the heavy lifting — OT cond_br conditions are
/// always shapes like `comb.icmp ceq (comb.extract %addr_hit, N), %true`
/// which translateValue already covers.  Returns nullopt on failure.
static std::optional<std::string> serializeCondExpr(Value cond) {
  auto r = comb_translator::translateValue(cond, /*maxDepth=*/16);
  if (!r.success || r.expr.empty())
    return std::nullopt;
  return r.expr;
}

/// Carry result of resolving a non-entry BlockArgument: the C expression
/// for the value passed by the predecessor, and the path condition that
/// gated reaching this block.  `ok=false` means resolution failed and
/// the caller should fall back to the legacy "unnamed" path.
struct ResolvedBlockArg {
  std::string condExpr;     // path condition; "1" for unconditional cf.br
  std::string valueExpr;    // C expression of the value passed
  bool ok = false;
};

/// Compute the path condition that must hold for control to reach `bb`
/// from the entry block of its enclosing region.  Used to gate every
/// drv inside a non-entry block (the OT register read mux has a
/// "default = -1" drv in the no-hit-fallthrough block; without
/// gating it unconditionally overwrites all the conditional bit-update
/// drvs from the matched register).
///
/// Algorithm: recursively walk back through predecessors.  For a
/// single-predecessor block with cf.cond_br terminator, the path cond
/// is `(parent_path_cond) AND (cond_or_!cond_depending_on_side)`.
/// For multiple predecessors, the path cond is the OR of each
/// predecessor's contribution (any one of them firing reaches us).
///
/// Bounded by `depth` — typical OT chain is ~13 deep (default
/// fallthrough at end of register-hit ladder).  Returns nullopt on
/// failure (unsupported terminator, infinite cycle, depth exhausted).
/// Memoized path-condition computation.
/// Cache lives across all calls inside a single tryGenerateAction
/// invocation chain.  Use std::optional inside DenseMap value to
/// distinguish "computed and failed" from "not yet computed".
//===----------------------------------------------------------------------===//
// Path conditions as DNF (disjunction of conjunctions of cond_br hops).
//
// A block's path condition = OR over predecessors of (pred's path condition
// AND the hop taken).  Kept STRUCTURED (not as a string) so joins can be
// simplified algebraically:
//   · duplicate terms collapse (two wait-fed "1"s),
//   · absorption (T ⊂ U  ⇒  drop U),
//   · adjacent merge (T ∪ {h}, T ∪ {¬h}  ⇒  T)   — the reconverging diamond,
//     iterated to a fixpoint so nested/partial diamonds ("if (X) M else if
//     (Y) M else …", both arms into one block, then joining the else and an
//     outer guard) still collapse back to the dominator's condition.
// Without this an unrolled per-entry loop (spi_passthrough's 28-entry
// cmd_info match, pinmux's 47-pad retention loop) copied the whole prefix
// into every contribution: 3^N text, OOM.
//===----------------------------------------------------------------------===//

struct PathLit { std::string hop; bool pos; };
using PathTerm = SmallVector<PathLit, 8>;    // conjunction
using PathDNF  = SmallVector<PathTerm, 4>;   // disjunction; one empty term = TRUE

static bool litEq(const PathLit &a, const PathLit &b) { return a.pos == b.pos && a.hop == b.hop; }
static bool termEq(const PathTerm &a, const PathTerm &b) {
  if (a.size() != b.size()) return false;
  for (size_t i = 0; i < a.size(); ++i) if (!litEq(a[i], b[i])) return false;
  return true;
}
static bool termHasLit(const PathTerm &t, const PathLit &l) {
  for (auto &x : t) if (litEq(x, l)) return true;
  return false;
}
/// a ⊆ b as sets of literals
static bool termSubset(const PathTerm &a, const PathTerm &b) {
  for (auto &l : a) if (!termHasLit(b, l)) return false;
  return true;
}
/// If a and b differ only in the polarity of ONE literal, return the merged
/// term (that literal dropped).
static std::optional<PathTerm> mergeAdjacent(const PathTerm &a, const PathTerm &b) {
  if (a.size() != b.size()) return std::nullopt;
  int diffIdx = -1;
  for (size_t i = 0; i < a.size(); ++i) {
    if (termHasLit(b, a[i])) continue;
    // a[i] not in b: must be present negated, and it must be the only diff
    PathLit neg{a[i].hop, !a[i].pos};
    if (!termHasLit(b, neg) || diffIdx >= 0) return std::nullopt;
    diffIdx = (int)i;
  }
  if (diffIdx < 0) return std::nullopt;   // identical
  // every literal of b must be in a or be the negated diff
  for (auto &l : b) {
    if (termHasLit(a, l)) continue;
    if (l.hop == a[diffIdx].hop && l.pos != a[diffIdx].pos) continue;
    return std::nullopt;
  }
  PathTerm m;
  for (size_t i = 0; i < a.size(); ++i) if ((int)i != diffIdx) m.push_back(a[i]);
  return m;
}
static void simplifyDNF(PathDNF &d) {
  bool changed = true;
  while (changed) {
    changed = false;
    // dedupe
    for (size_t i = 0; i < d.size(); ++i)
      for (size_t j = i + 1; j < d.size();) {
        if (termEq(d[i], d[j])) { d.erase(d.begin() + j); changed = true; } else ++j;
      }
    // absorption
    for (size_t i = 0; i < d.size(); ++i)
      for (size_t j = 0; j < d.size();) {
        if (i != j && termSubset(d[i], d[j])) { d.erase(d.begin() + j); if (j < i) --i; changed = true; }
        else ++j;
      }
    // adjacent merge
    for (size_t i = 0; i < d.size() && !changed; ++i)
      for (size_t j = i + 1; j < d.size(); ++j)
        if (auto m = mergeAdjacent(d[i], d[j])) {
          d.erase(d.begin() + j); d.erase(d.begin() + i);
          d.push_back(*m); changed = true; break;
        }
    if (d.size() > 512) break;   // safety valve: give up simplifying pathological joins
  }
}
static std::string renderDNF(const PathDNF &d) {
  if (d.empty()) return "0";
  std::string out;
  for (size_t i = 0; i < d.size(); ++i) {
    std::string t;
    if (d[i].empty()) t = "1";
    else for (size_t k = 0; k < d[i].size(); ++k) {
      std::string l = d[i][k].pos ? d[i][k].hop : ("!(" + d[i][k].hop + ")");
      t = k == 0 ? l : ("(" + t + ") && (" + l + ")");
    }
    out = i == 0 ? t : ("(" + out + ") || (" + t + ")");
  }
  return out;
}

using PathCondCache = DenseMap<Block *, std::optional<PathDNF>>;

static std::optional<PathDNF>
getBlockPathConditionImpl(Block *bb, PathCondCache &cache,
                          DenseSet<Block *> &visiting, unsigned depth) {
  if (depth == 0)
    return std::nullopt;
  if (isEntryBlock(bb))
    return PathDNF{PathTerm{}};   // TRUE
  auto cit = cache.find(bb);
  if (cit != cache.end())
    return cit->second;
  if (!visiting.insert(bb).second)
    return std::nullopt;

  std::optional<PathDNF> result;
  PathDNF contributions;
  bool failed = false;
  for (Block *pred : bb->getPredecessors()) {
    Operation *term = pred->getTerminator();
    // llhd.wait is the process-loop barrier: under the MMIO-driven model,
    // tick() runs once per bus cycle, advancing the process through one
    // wait→body iteration.  Treat the post-wait edge as entry-equivalent —
    // unconditionally taken on every tick — and contribute TRUE.
    if (isa<llhd::WaitOp>(term)) {
      contributions.push_back(PathTerm{});
      continue;
    }
    auto parentCond = getBlockPathConditionImpl(pred, cache, visiting, depth - 1);
    // Cyclic predecessor contributions (back-edges into a wait-bearing head)
    // are NOT-A-PATH: skip them; if every predecessor is cyclic we end up
    // with no contributions and return nullopt.
    if (!parentCond)
      continue;
    if (isa<cf::BranchOp>(term)) {
      for (auto &t : *parentCond) contributions.push_back(t);
      continue;
    }
    if (auto cbr = dyn_cast<cf::CondBranchOp>(term)) {
      // Wait-edge synthesis: a cond_br whose block is reached only from
      // llhd.wait AND whose condition compares a PRE-wait sample (a prb
      // defined in the wait block) with the post-wait value is the "did the
      // wait event fire" edge check (posedge/negedge-derived) — by definition
      // true on entry to the body under the once-per-tick model.  A post-wait
      // cond_br that does NOT look at a pre-wait sample is an ordinary guard
      // and must be kept: a reset-less `always_ff` body (`if (fifo_incr_wptr)
      // storage[wptr] <= wdata`) has its user `if` as the very first cond_br
      // once the clock gate is removed — treating it as the trigger made
      // FIFO storage writes unconditional.
      bool postWait = true;
      for (Block *predPred : pred->getPredecessors()) {
        if (!isa<llhd::WaitOp>(predPred->getTerminator())) { postWait = false; break; }
      }
      if (postWait) {
        Block *waitBlk = *pred->getPredecessors().begin();
        // does the condition's comb cone reach a value defined in the wait block?
        bool usesPreWait = false;
        {
          SmallVector<Value, 8> wl{cbr.getCondition()};
          DenseSet<void *> seen;
          unsigned budget = 128;
          while (!wl.empty() && budget--) {
            Value x = wl.pop_back_val();
            if (!seen.insert(x.getAsOpaquePointer()).second) continue;
            Operation *dop = x.getDefiningOp();
            if (!dop) continue;
            if (dop->getBlock() == waitBlk) { usesPreWait = true; break; }
            if (isa<llhd::ProbeOp>(dop)) continue;
            for (Value o : dop->getOperands()) wl.push_back(o);
          }
        }
        if (usesPreWait) {
          for (auto &t : *parentCond) contributions.push_back(t);
          continue;
        }
        // else: fall through — a real guard, handled like any cond_br
      }
      // Same-destination cond_br (`cond_br %c, ^bb(x), ^bb(y)` — an inlined
      // select on the block operands): BOTH edges reach `bb`, so this hop
      // adds no condition — contribute the parent's condition unchanged.
      // (Treating it as a failure made the whole path condition nullopt and
      // the drv was emitted UNGATED: spi_readcmd's `addr_inc = 1` fired
      // every tick and the SFDP read pointer raced ahead.)
      if (cbr.getTrueDest() == cbr.getFalseDest()) {
        for (auto &t : *parentCond) contributions.push_back(t);
        continue;
      }
      auto condRes = serializeCondExpr(cbr.getCondition());
      if (!condRes) { failed = true; break; }
      bool isTrue = (cbr.getTrueDest() == bb);
      for (auto t : *parentCond) {
        // drop a literal that is already present (same hop, same polarity);
        // a contradictory one (same hop, opposite polarity) makes the term
        // unsatisfiable — skip it
        PathLit l{*condRes, isTrue};
        if (termHasLit(t, PathLit{*condRes, !isTrue})) continue;
        if (!termHasLit(t, l)) t.push_back(l);
        contributions.push_back(t);
      }
      continue;
    }
    failed = true;
    break;
  }
  visiting.erase(bb);

  if (!failed && !contributions.empty()) {
    simplifyDNF(contributions);
    result = contributions;
  }
  cache[bb] = result;
  return result;
}

static std::optional<std::string>
getBlockPathCondition(Block *bb) {
  PathCondCache cache;
  DenseSet<Block *> visiting;
  // Depth limit needs to cover the longest cf.cond_br chain in any device.
  // Pinmux has ~568 register-hit blocks chained one-per-register; memoization
  // makes the total work linear in the number of blocks, so a generous limit
  // is cheap.
  auto r = getBlockPathConditionImpl(bb, cache, visiting, /*depth=*/2048);
  if (!r) return std::nullopt;
  return renderDNF(*r);
}

/// Set when a drive's path condition could not be resolved.  Emitting the
/// write anyway is a wrong answer, so the pass fails.
static bool g_pathCondRefused = false;

/// The path condition guarding a drive, as a C expression.
///
/// FIVE SITES USED TO SPELL THIS INLINE, ALL WITH THE SAME HOLE:
///
///     if (drvBlock && !isEntryBlock(drvBlock))
///       if (auto cond = getBlockPathCondition(drvBlock))
///         if (*cond != "1") gate = *cond;
///
/// The middle `if` has no else.  When the condition is unresolvable the gate
/// stays EMPTY and the write is emitted UNCONDITIONALLY — a RAM write that
/// the RTL performs only under a guard becomes one the model performs always.
/// That is the compiler believing it succeeded, not the compiler giving up,
/// and it is the shape that leaves no marker anywhere.
///
/// Returning "0" rather than restructuring five different control flows is
/// deliberate: it is the safe direction (the write cannot fire), and the
/// refusal flag fails the pass, so no model is emitted from it either way.
static std::string resolveDriveGate(Block *drvBlock, const char *site) {
  if (!drvBlock || isEntryBlock(drvBlock))
    return std::string();
  auto cond = getBlockPathCondition(drvBlock);
  if (!cond) {
    llvm::errs() << "  [PATH-COND FAIL] " << site
                 << ": the drive's block path condition is unresolvable; "
                    "emitting it ungated would make a guarded write "
                    "unconditional\n";
    g_pathCondRefused = true;
    return std::string("0");
  }
  if (*cond != "1")
    return *cond;
  return std::string();
}


//===----------------------------------------------------------------------===//
// One-hot read-mux detection — priority-chain → else-if collapse
//
// The OT register read mux merges N register-qs values into a join block
// with N predecessors, each reached via the TRUE edge of
//   cf.cond_br (addr_hit[k] == 1), ^bb_hit_k(...), ^bb_next
// where `addr_hit` is a ONE-HOT address decode (at most one bit set — an
// access address matches at most one register offset).
//
// resolveBlockArgViaCFG builds a nested ternary over these preds.  Using
// each pred's FULL path condition (`!h[0] && ... && !h[k-1] && h[k]`)
// makes every one of the N conditions O(N) long → O(N²) C text (pinmux:
// 9.6 MB on one line: 301 preds × ~530-term chains).  But a nested ternary
// ALREADY encodes priority via its else-nesting, so when the decode is
// provably one-hot we can use just the LOCAL per-edge condition (`h[k]`,
// O(1)) at each level: under one-hot exactly one local cond is true, so
// the nested ternary selects the same branch regardless of order — bit-
// identical in behavior to the full-path-condition form, but O(N).  The
// outer disjunction gate (`h[0] || … || h[N-1]`) preserves the no-hit
// pass-through (keep old rdata).
//
// Detection is purely structural (NO device names): every predecessor must
// be a TRUE-edge cf.cond_br whose condition is `icmp eq (extract 1-bit_k
// of S), 1` for a COMMON base signal S at PAIRWISE-DISTINCT bits k.  Any
// deviation (mixed edges, non-bit-test conds, differing base, repeated
// bit) fails detection → we keep the exact full-path-condition behavior
// (correct for non-decode joins like prim_reg_cdc, which are tiny anyway).
//===----------------------------------------------------------------------===//

/// Per-predecessor resolution carrying both the full priority path
/// condition and the local per-edge condition, so the read-mux collapse
/// can pick the cheaper local form when the decode is provably one-hot.
struct PredInfo {
  std::string fullCond;    // parentPath && localCond — order-independent
  std::string localCond;   // just this edge's cf.cond_br condition (O(1))
  std::string parentCond;  // path condition to REACH this pred ("1" if none)
  Value passed;            // value forwarded on this edge
  Value condVal;           // the cond_br condition Value (null for cf.br)
  bool trueEdge = false;   // reached via the true edge of the cond_br
  // Pre-built C expression for this pred's value (overrides translateValue of
  // `passed`).  Used for a same-destination cond_br (`cond ? trueOp : falseOp`,
  // an inlined select — the common LLHD-canonicalized FSM next-state/output
  // pattern), which has two operand lists into the same join block.
  std::string prebuiltExpr;
};

/// Parse a one-hot bit-test condition `icmp eq (extract<1> bit_k of S), 1`.
/// On success fills `baseSig` (the underlying SIGNAL Value of S) and `bit` (k).
/// We key the base on the llhd.sig Value (shared by every llhd.prb of it),
/// NOT on the C name string: distinct prb nodes of the same signal still map
/// to one base, and two *different* signals can never alias (name/sanitization
/// collisions cannot cause a false "common base").
static bool parseOneHotBitTest(Value cond, Value &baseSig, unsigned &bit) {
  auto icmp = cond.getDefiningOp<comb::ICmpOp>();
  if (!icmp)
    return false;
  // Accept any equality flavor — two-state (eq), four-state case (ceq), and
  // weak (weq).  For a 1-bit extract compared to constant 1 they coincide;
  // OT's register decode emits `comb.icmp ceq`.
  switch (icmp.getPredicate()) {
  case comb::ICmpPredicate::eq:
  case comb::ICmpPredicate::ceq:
  case comb::ICmpPredicate::weq:
    break;
  default:
    return false;
  }
  Value lhs = icmp.getLhs(), rhs = icmp.getRhs();
  Value valSide, cstSide;
  if (lhs.getDefiningOp<hw::ConstantOp>()) {
    cstSide = lhs;
    valSide = rhs;
  } else if (rhs.getDefiningOp<hw::ConstantOp>()) {
    cstSide = rhs;
    valSide = lhs;
  } else {
    return false;
  }
  auto cst = cstSide.getDefiningOp<hw::ConstantOp>();
  if (!cst || !cst.getValue().isOne())
    return false;  // must compare against `1` (true)
  auto ext = valSide.getDefiningOp<comb::ExtractOp>();
  if (!ext || ext.getType().getIntOrFloatBitWidth() != 1)
    return false;
  bit = ext.getLowBit();
  // Resolve the base to the underlying signal Value (shared) when the extract
  // reads a probe; otherwise use the extracted value itself.  Either way the
  // identity is an SSA Value, never a name string.
  Value in = ext.getInput();
  if (auto prb = in.getDefiningOp<llhd::ProbeOp>())
    baseSig = prb.getSignal();
  else
    baseSig = in;
  return baseSig != nullptr;
}

/// True iff `cond` references no state-struct signal other than `baseField`
/// (every "s->IDENT" has IDENT == baseField).  Whitespace/operators/constants
/// are ignored — we only care that no FOREIGN signal appears.
static bool referencesOnlySignal(const std::string &cond,
                                 const std::string &baseField) {
  auto isIdentChar = [](char c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
           (c >= '0' && c <= '9') || c == '_';
  };
  size_t pos = 0;
  while ((pos = cond.find("s->", pos)) != std::string::npos) {
    size_t s = pos + 3, e = s;
    while (e < cond.size() && isIdentChar(cond[e]))
      ++e;
    if (cond.compare(s, e - s, baseField) != 0)
      return false;  // a different signal is referenced
    pos = e;
  }
  return true;
}

/// Decide whether the multi-predecessor join is a one-hot read mux that can be
/// safely collapsed to local conditions.  Two requirements:
///
///  (1) STRUCTURE — every predecessor is a TRUE-edge cond_br testing a DISTINCT
///      bit of a COMMON base signal S (resolved by SSA Value identity, not by
///      name).  Under the one-hot invariant of S, exactly one local condition
///      is true, so the nested ternary's else-nesting selects the same branch
///      as the full path-condition form, regardless of predecessor order.
///
///  (2) UNCONDITIONAL ENTRY — no OUTER gate guards the decode.  The collapse
///      drops each pred's parent path condition; that is sound ONLY when the
///      parent paths contain no signal other than S (their content is just
///      negations of other S-bits from the shared address ladder, which are
///      all true when one S-bit is hot — so they do not change the gate).  If a
///      parent path referenced a *foreign* signal G (e.g. an enable guarding
///      the whole decode), the collapsed disjunction gate would drop G and fire
///      the assignment even when the decode is unreachable.  We reject that case
///      and fall back to the exact full-condition form (correct, just O(N²) —
///      and it does not arise in OT, whose decodes are reached unconditionally).
///
/// This is a SUFFICIENT (conservative) test: a false negative only forgoes the
/// optimization; it never changes emitted behavior.  No device names or magic
/// numbers — purely structural / IR-derived.
static bool canCollapseOneHotReadMux(const SmallVectorImpl<PredInfo> &preds) {
  if (preds.size() < 2)
    return false;
  Value base;
  DenseSet<unsigned> bits;
  for (const PredInfo &p : preds) {
    if (!p.trueEdge || !p.condVal)
      return false;
    Value b;
    unsigned bit = 0;
    if (!parseOneHotBitTest(p.condVal, b, bit))
      return false;
    if (!base)
      base = b;
    else if (b != base)
      return false;
    if (!bits.insert(bit).second)
      return false;  // repeated bit → not a clean one-hot decode
  }
  // The C field name of the base signal (drop the "s->" prefix), used to verify
  // the parent paths reference no other signal.
  std::string baseRef = comb_translator::getSignalName(base);
  std::string baseField =
      (baseRef.rfind("s->", 0) == 0) ? baseRef.substr(3) : baseRef;
  if (baseField.empty())
    return false;
  for (const PredInfo &p : preds)
    if (!referencesOnlySignal(p.parentCond, baseField))
      return false;  // an outer gate (foreign signal) guards the decode
  return true;
}


/// Memoize resolveBlockArgViaCFG results.  Without this, the translateValue
/// <-> resolveBlockArgViaCFG resolver re-resolves the same join args over and
/// over (a big read-mux / FSM join feeds many consumers), blowing up time and
/// memory on large devices (pinmux OOMs).  Cleared per pass run; keyed on the
/// BlockArgument (stable within one runOnOperation).
static llvm::DenseMap<mlir::BlockArgument, ResolvedBlockArg> g_cfgArgCache;

/// Recursion guard / nesting depth for the translateValue <->
/// resolveBlockArgViaCFG cycle.  depth>0 means we're resolving a blockarg
/// nested inside an expression (vs. the top-level drv-value/prb path at 0).
static int g_resolverDepth = 0;

/// Walk the predecessors of a non-entry BlockArgument and resolve which
/// value was passed in.  Tier 1: only single-predecessor blocks succeed.
static ResolvedBlockArg resolveBlockArgViaCFG(BlockArgument bbarg) {
  ResolvedBlockArg out;
  if (isModuleEntryBlockArg(bbarg)) {
    return out;  // ok=false; caller treats as legacy
  }
  if (auto it = g_cfgArgCache.find(bbarg); it != g_cfgArgCache.end())
    return it->second;

  Block *bb = bbarg.getOwner();
  unsigned argIdx = bbarg.getArgNumber();

  // Collect (condition_expr, value_passed) for each predecessor.  Tier 1
  // bails on the first unsupported terminator shape.
  //
  // Each pred's condition is the FULL path condition reaching the join:
  //   pred_path_cond AND local_cond_br_branch_cond
  // Using only the local cond_br cond would be incorrect when two preds'
  // local conds are both true under some inputs but their actual paths
  // are mutually exclusive due to upstream cond_br choices (e.g. the OT
  // reg_top read-mux default-fallback chain emits one drv per "no-hit"
  // bucket, with each bucket reached only via a unique upstream predicate
  // chain).  Without path conditioning, our merged ternary would select
  // the first textually-emitted pred when local conds overlap, returning
  // wrong values for any read that happens to satisfy multiple local
  // conds.
  SmallVector<PredInfo, 4> preds;
  // A same-destination cond_br lists its predecessor block twice in
  // getPredecessors() (one per edge); process each terminator once.
  llvm::SmallPtrSet<Operation *, 4> seenTerms;
  for (Block *pred : bb->getPredecessors()) {
    Operation *term = pred->getTerminator();
    if (!seenTerms.insert(term).second)
      continue;
    Value passed;
    std::string localCond;
    std::string prebuiltExpr;
    Value condVal;          // cond_br condition (null for unconditional br)
    bool trueEdge = false;  // reached via the cond_br's true edge

    if (auto br = dyn_cast<cf::BranchOp>(term)) {
      if (argIdx >= br.getDestOperands().size()) {
          return out;
        }
      passed = br.getDestOperands()[argIdx];
      localCond = "1";
    } else if (auto cbr = dyn_cast<cf::CondBranchOp>(term)) {
      auto condRes = serializeCondExpr(cbr.getCondition());
      if (!condRes) {
        return out;
      }
      if (cbr.getTrueDest() == cbr.getFalseDest()) {
        // Same-dest cond_br = an inlined select into the join:
        //   arg = cond ? trueOp[argIdx] : falseOp[argIdx]
        // (the LLHD-canonicalized FSM next-state / output mux).  Both edges
        // reach bb, so this pred is unconditional (localCond = "1") and its
        // value is the ternary.
        auto tOps = cbr.getTrueDestOperands();
        auto fOps = cbr.getFalseDestOperands();
        if (argIdx >= tOps.size() || argIdx >= fOps.size()) {
          return out;
        }
        auto tv = comb_translator::translateValue(tOps[argIdx], /*maxDepth=*/8);
        auto fv = comb_translator::translateValue(fOps[argIdx], /*maxDepth=*/8);
        if (!tv.success || tv.expr.empty() || !fv.success || fv.expr.empty()) {
          return out;
        }
        prebuiltExpr = "((" + *condRes + ") ? (" + tv.expr + ") : (" +
                       fv.expr + "))";
        localCond = "1";
      } else {
        bool isTrue = (cbr.getTrueDest() == bb);
        auto operands = isTrue ? cbr.getTrueDestOperands()
                               : cbr.getFalseDestOperands();
        if (argIdx >= operands.size()) {
            return out;
          }
        passed = operands[argIdx];
        localCond = isTrue ? *condRes : ("!(" + *condRes + ")");
        condVal = cbr.getCondition();
        trueEdge = isTrue;
      }
    } else {
      // Other terminators (llhd.wait at process boundary, etc.): bail.
      return out;
    }

    // Combine with the parent's path condition for full mutual-exclusivity.
    auto parentCondOpt = getBlockPathCondition(pred);
    std::string fullCond;
    if (!parentCondOpt) {
      // Path condition unknown — fall back to legacy behavior (local cond
      // only) rather than dropping the resolution entirely.  Less precise
      // but matches pre-fix.
      fullCond = localCond;
    } else if (*parentCondOpt == "1") {
      // Pred is reached unconditionally from entry; no path prefix needed.
      fullCond = localCond;
    } else if (localCond == "1") {
      fullCond = *parentCondOpt;
    } else {
      fullCond = "(" + *parentCondOpt + ") && (" + localCond + ")";
    }
    // parentCond is "1" when the pred is reached unconditionally (or the path
    // is unknown — matching the legacy fullCond=localCond choice above).
    std::string parentCond = parentCondOpt.value_or("1");
    preds.push_back(
        {fullCond, localCond, parentCond, passed, condVal, trueEdge,
         prebuiltExpr});
  }

  if (preds.empty()) {
      return out;
    }

  // When invoked NESTED (via the translateValue resolver, depth>0), only
  // resolve small joins (FSM selects, typically 1 pred).  Bail on wide joins
  // (the one-hot register read-mux, ~hundreds of preds): resolving it nested
  // would inline a huge expression into many consumers and blow up time/memory
  // (pinmux OOM).  The wide read-mux is still resolved at the drv level via the
  // prb-of-blockarg path (depth==0), where it's emitted exactly once.
  if (g_resolverDepth > 0 && preds.size() > 32) {
    return out;
  }

  // Translate each predecessor's passed value to a C expression upfront.
  // If any fails, bail (legacy fallback).
  SmallVector<std::string, 4> valExprs;
  for (auto &p : preds) {
    if (!p.prebuiltExpr.empty()) {
      valExprs.push_back(p.prebuiltExpr);  // same-dest select
      continue;
    }
    auto valRes = comb_translator::translateValue(p.passed, /*maxDepth=*/8);
    if (!valRes.success || valRes.expr.empty()) {
      llvm::errs() << "[comb-extract DROP] value untranslatable: "
                   << valRes.errorMsg << " (op: "
                   << (p.passed.getDefiningOp()
                           ? p.passed.getDefiningOp()->getName().getStringRef()
                           : llvm::StringRef("<blockarg>"))
                   << ")\n";
      return out;
    }
    valExprs.push_back(valRes.expr);
  }

  if (preds.size() == 1) {
    // Common case (most OT register-hit blocks).
    out.condExpr  = preds[0].fullCond;
    out.valueExpr = valExprs[0];
    out.ok = true;
    g_cfgArgCache[bbarg] = out;
    return out;
  }

  // Multi-predecessor: build nested ternary chain so the value matches
  // whichever predecessor fired (LLHD process semantics: at most one
  // predecessor actually fires per cycle, so the order of the chain is
  // immaterial as long as no two conditions are simultaneously true —
  // which is the case for OT one-hot addr_hit decoding).
  //   value = (cond_0) ? val_0 : ((cond_1) ? val_1 : (... ? ... : val_{N-1}))
  // For the gate condition (the OR of all predecessor conditions), we
  // emit the disjunction so the wrapping `(cond ? new : old)` only
  // disturbs the field when at least one predecessor's branch triggered.
  //
  // Priority-chain collapse: when the predecessors form a provably one-hot
  // address decode (isOneHotDecode), each level only needs its LOCAL edge
  // condition — the nested ternary's else-nesting supplies the priority and
  // exactly one local cond is true under one-hot, so the selection is
  // identical while the text shrinks from O(N²) to O(N).  Otherwise we use
  // the full path conditions (order-independent, correct for non-decode
  // joins like prim_reg_cdc).
  // Collapse to local conditions only when the decode is provably one-hot AND
  // reached unconditionally (no outer gate hidden in the parent paths) — see
  // allParentPathsArePureSiblingNegations.  Otherwise keep the exact full
  // path-condition form (order-independent, correct for nested/non-decode
  // joins like prim_reg_cdc).
  const bool oneHot = canCollapseOneHotReadMux(preds);
  auto condOf = [&](size_t i) -> const std::string & {
    return oneHot ? preds[i].localCond : preds[i].fullCond;
  };

  // Group predecessors that pass the SAME value: emit each distinct value
  // once, its condition = OR of its preds' conditions, and use the largest
  // group as the trailing else (no condition text at all).  Without this a
  // chained phi — an unrolled loop passing the accumulated value through
  // every iteration, where the "keep" arms of each join carry the previous
  // level's value — duplicated that value in two arms per level: 2^N text
  // (spi_passthrough's cmd_info match loop: 131071 ORs, 25 MB per line).
  // Semantics are unchanged: at most one predecessor fires per cycle, and
  // when none fires the whole phi is masked by the gate condition below.
  SmallVector<std::pair<std::string, SmallVector<size_t, 4>>, 8> groups;
  for (size_t i = 0; i < preds.size(); ++i) {
    bool found = false;
    for (auto &g : groups)
      if (g.first == valExprs[i]) { g.second.push_back(i); found = true; break; }
    if (!found) groups.push_back({valExprs[i], {i}});
  }
  size_t elseIdx = groups.size() - 1;
  for (size_t g = 0; g < groups.size(); ++g)
    if (groups[g].second.size() > groups[elseIdx].second.size()) elseIdx = g;
  auto groupCond = [&](const SmallVector<size_t, 4> &idxs) {
    std::string c = condOf(idxs[0]);
    for (size_t k = 1; k < idxs.size(); ++k)
      c = "(" + c + ") || (" + condOf(idxs[k]) + ")";
    return c;
  };
  if (getenv("QP_PHI_DEBUG")) {
    static int n = 0;
    if (n++ < 60) {
      llvm::errs() << "[phi] arg" << argIdx << " preds=" << preds.size() << " groups=" << groups.size() << " vals:";
      for (auto &g : groups) llvm::errs() << " " << g.first.size() << "(x" << g.second.size() << ")";
      llvm::errs() << " conds:";
      for (size_t i = 0; i < preds.size(); ++i) llvm::errs() << " " << condOf(i).size();
      llvm::errs() << "\n";
      if (n <= 4) for (auto &g : groups) llvm::errs() << "     val: " << g.first.substr(0, 200) << "\n";
    }
  }
  std::string ternary = groups[elseIdx].first;
  for (int g = static_cast<int>(groups.size()) - 1; g >= 0; --g) {
    if ((size_t)g == elseIdx) continue;
    ternary = "((" + groupCond(groups[g].second) + ") ? (" + groups[g].first +
              ") : (" + ternary + "))";
  }
  std::string disjunction = condOf(0);
  for (size_t i = 1; i < preds.size(); ++i) {
    disjunction = "(" + disjunction + ") || (" + condOf(i) + ")";
  }
  out.condExpr  = disjunction;
  out.valueExpr = ternary;
  out.ok = true;
  g_cfgArgCache[bbarg] = out;
  return out;
}

/// Install the CFG block-arg resolver into the comb translator so that
/// BlockArguments nested INSIDE an expression (FSM next-state / output phis)
/// resolve to their CFG-join ternary instead of the `_unknown_arg` sentinel.
/// (The direct drv-value-is-blockarg case is still handled in tryGenerateAction.)
static void installBlockArgResolver() {
  if (comb_translator::blockArgResolver())
    return;  // already installed
  comb_translator::blockArgResolver() =
      [](mlir::BlockArgument ba) -> std::optional<std::string> {
        if (isModuleEntryBlockArg(ba))
          return std::nullopt;
        if (g_resolverDepth >= 4)
          return std::nullopt;  // cycle / deep-nesting blow-up guard (pinmux)
        ++g_resolverDepth;
        ResolvedBlockArg r = resolveBlockArgViaCFG(ba);
        --g_resolverDepth;
        if (r.ok && !r.valueExpr.empty())
          return r.valueExpr;
        return std::nullopt;
      };
}

/// Try to generate action from drv operation (aligned with old framework)
static EventAction tryGenerateAction(llhd::DriveOp drv) {
  EventAction action;
  action.targetSignal = getSignalNameFromValue(drv.getSignal());

  Value value = drv.getValue();

  // Check if constant assignment
  if (auto constOp = value.getDefiningOp<hw::ConstantOp>()) {
    action.type = ActionType::ASSIGN_CONST;
    action.constValue = constOp.getValue().getSExtValue();
    return action;
  }

  // CFG-aware resolve when the drv's value is itself a non-entry BlockArg.
  // MLIR canonicalize collapses prim_reg_cdc-style multi-driver patterns
  //   ^bb_rst:  drv X, %false       (rst case)
  //   ^bb_req:  drv X, %true        (req case)
  //   ^bb_ack:  drv X, %false       (ack case)
  // into a single drv-of-blockarg in a join block:
  //   ^bb_join(%24: i1):  drv X, %24
  // Without this branch, translateValue() falls back to `_unknown_arg0`
  // and the storage update silently drops to 0.  Mirrors the prb-of-
  // blockarg path below.
  if (auto bbarg = dyn_cast<BlockArgument>(value)) {
    if (!isModuleEntryBlockArg(bbarg)) {
      ResolvedBlockArg r = resolveBlockArgViaCFG(bbarg);
      if (r.ok) {
        action.type = ActionType::COMPUTE;
        action.expression = r.valueExpr;
        action.gatedCondition = r.condExpr;
        return action;
      }
    }
  }

  // Check if simple signal assignment
  if (auto prb = value.getDefiningOp<llhd::ProbeOp>()) {
    Value sigOperand = prb.getSignal();
    // CFG-aware resolve when the prb reads a non-entry-block BlockArg
    // (e.g. OT register read mux pattern: cf.cond_br routes the chosen
    // register's qs into the hit-block as a BlockArgument).  Falls
    // back to the legacy ASSIGN_SIGNAL path when resolution fails so
    // unsupported shapes don't regress.
    if (auto bbarg = dyn_cast<BlockArgument>(sigOperand)) {
      if (!isModuleEntryBlockArg(bbarg)) {
        ResolvedBlockArg r = resolveBlockArgViaCFG(bbarg);
        if (r.ok) {
          action.type = ActionType::COMPUTE;
          action.expression = r.valueExpr;
          action.gatedCondition = r.condExpr;
          return action;
        }
      }
    }
    // prb of a selected signal reference (arith.select over inout) is not a
    // plain field copy — let the expression translator push the probe
    // through the select (otherwise it became `s->unnamed`).
    if (!mlir::isa_and_nonnull<mlir::arith::SelectOp>(sigOperand.getDefiningOp())) {
      action.type = ActionType::ASSIGN_SIGNAL;
      action.sourceSignal = getSignalNameFromValue(prb.getSignal());
      return action;
    }
  }

  // Check if accumulate (signal = signal + const)
  // (a pump-gated accumulate ring — qemu.pump_acc_operand — must NOT become a
  //  raw `+= const` action; it goes through the expression translator, which
  //  emits `acc + (s->_qp_pump ? step : 0)`.)
  if (auto addOp = value.getDefiningOp<comb::AddOp>();
      addOp && !addOp->hasAttr("qemu.pump_acc_operand")) {
    for (Value operand : addOp.getOperands()) {
      if (auto prb = operand.getDefiningOp<llhd::ProbeOp>()) {
        std::string prbSig = getSignalNameFromValue(prb.getSignal());
        if (prbSig == action.targetSignal) {
          for (Value op2 : addOp.getOperands()) {
            if (auto constOp = op2.getDefiningOp<hw::ConstantOp>()) {
              action.type = ActionType::ACCUMULATE;
              action.constValue = constOp.getValue().getSExtValue();
              return action;
            }
          }
        }
      }
    }
  }

  // Check if subtract (signal = signal - const)
  if (auto subOp = value.getDefiningOp<comb::SubOp>()) {
    Value lhs = subOp.getLhs();
    Value rhs = subOp.getRhs();
    if (auto prb = lhs.getDefiningOp<llhd::ProbeOp>()) {
      std::string prbSig = getSignalNameFromValue(prb.getSignal());
      if (prbSig == action.targetSignal) {
        if (auto constOp = rhs.getDefiningOp<hw::ConstantOp>()) {
          action.type = ActionType::ACCUMULATE;
          action.constValue = -constOp.getValue().getSExtValue();
          return action;
        }
      }
    }
  }

  // Use CombTranslator for complex expressions
  auto translateResult = comb_translator::translateValue(value);
  if (translateResult.success) {
    action.type = ActionType::COMPUTE;
    action.expression = action.targetSignal + " = " + translateResult.expr;
    return action;
  }

  // Truly complex expression (cannot generate)
  action.type = ActionType::COMPUTE;
  action.expression = "/* complex expression: " + translateResult.errorMsg + " */";
  return action;
}

/// Check if action is complex (cannot generate code)
static bool isComplexAction(const EventAction &action) {
  return action.type == ActionType::COMPUTE &&
         action.expression.find("/* complex expression") != std::string::npos;
}

/// Escape string for JSON output
static std::string escapeJsonString(const std::string &s) {
  std::string result;
  for (char c : s) {
    switch (c) {
      case '"': result += "\\\""; break;
      case '\\': result += "\\\\"; break;
      case '\n': result += "\\n"; break;
      case '\r': result += "\\r"; break;
      case '\t': result += "\\t"; break;
      default: result += c; break;
    }
  }
  return result;
}

//===----------------------------------------------------------------------===//
// CombLogicExtractPass Implementation
//===----------------------------------------------------------------------===//

struct CombLogicExtractPass
    : public ::impl::CombLogicExtractBase<CombLogicExtractPass> {

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();
    g_cfgArgCache.clear();
    g_pathCondRefused = false;   // file static; the pass runs more than once
    installBlockArgResolver();

    // Per-module collection for JSON output
    std::vector<ModuleCombLogic> allModules;
    unsigned totalAssignments = 0;

    llvm::errs() << "\n";
    llvm::errs() << "========================================\n";
    llvm::errs() << "Combinational Logic Extraction Pass\n";
    llvm::errs() << "(Per-module scope - aligned with old framework)\n";
    llvm::errs() << "========================================\n";
    llvm::errs() << "\n";

    // Process each hw.module separately
    mod.walk([&](hw::HWModuleOp hwMod) {
      llvm::errs() << "Module: @" << hwMod.getName() << "\n";

      // Per-module data structures
      ModuleCombLogic moduleComb;
      moduleComb.moduleName = hwMod.getName().str();

      llvm::StringSet<> modulePortNames;
      llvm::StringSet<> processedCombSignals;
      llvm::StringSet<> processedSeqSignals;
      // Sequential-domain ids for comb-class (non-clocked) processes —
      // see CombinationalAssignment::seqDomain.
      llvm::DenseMap<Operation *, int> combProcDomain;
      SmallVector<Attribute> combAttrs;
      SmallVector<Attribute> seqAttrs;   // Phase 1: sequential drvs

      // Collect module port names for filtering
      for (auto port : hwMod.getPortList()) {
        modulePortNames.insert(port.getName());
      }

      // Walk all drv operations in this module — both comb (outside
      // llhd.process) AND seq (inside llhd.process).  Phase 1 of the
      // boundary-fix work: seq drvs become a separate qemu.seq_logic
      // attribute; emit-c will (in a later commit) generate a tick()
      // function from them so register state actually updates between
      // MMIO operations.
      // Process drvs in EXECUTION order, not textual order.  A plain
      // walk visits blocks textually; LLHD's same-cycle semantics are
      // last-write-wins in CONTROL-FLOW order.  In prim_sha2_pad the
      // join block bb15 (handshake advance, st_d=5) textually precedes
      // its predecessor bb21 (hold, st_d=4): textual emission put the
      // hold arm AFTER the advance arm and the pad FSM never left
      // StPadLenHi -- the length word never reached the SHA block.
      // Reverse post-order per process region restores execution order.
      auto processDrv = [&](llhd::DriveOp drv) {
        // Determine seq vs comb by walking up to the first ProcessOp
        // or HWModuleOp ancestor.
        Operation *parent = drv->getParentOp();
        while (parent && !isa<llhd::ProcessOp>(parent) && !isa<hw::HWModuleOp>(parent)) {
          parent = parent->getParentOp();
        }
        // Sequential = inside a CLOCK-TRIGGERED process.  LLHD lowers
        // `always_comb` to an llhd.process too (wait on its data inputs, no
        // clock); treating those drvs as tick()-updated gave every always_comb
        // output a one-cycle lag — e.g. reg_top's `racl_addr_hit_write` lagged
        // the (combinational) bus wdata by a tick, so back-to-back writes to
        // two registers clobbered the FIRST register with the SECOND's data
        // for one tick (REGWEN=1 then PARAM=0x1234 → REGWEN W0C-cleared by
        // bit0=0).  Non-clock processes are combinational: emit them in
        // update_state (their CFG path conditions still apply).
        bool isSeq = isa<llhd::ProcessOp>(parent) &&
                     parent->hasAttr("qemu.clock_triggered");

        Value signal = drv.getSignal();
        if (getenv("QP_DEBUG_DYN2"))
          if (Operation *sd = signal.getDefiningOp())
            if (isa<llhd::SigArrayGetOp, llhd::SigStructExtractOp,
                    llhd::SigExtractOp>(sd)) {
              llvm::errs() << "  [DRV-SIG] ";
              sd->print(llvm::errs());
              llvm::errs() << "\n";
            }

        // Memory-array write: `drv (sig.array_get %mem[%idx]), v` on an array
        // sig left whole (runtime index, > explode cap — prim_ram_2p `mem`).
        // The emitter keeps it as one wide bitvector; emit a verbatim block
        // (`__RAW__`) that inserts the element under the drv's gate.
        if (auto ag = signal.getDefiningOp<llhd::SigArrayGetOp>()) {
          if (auto mem = comb_translator::memoryArrayRef(ag.getInput())) {
            auto val = comb_translator::translateValue(drv.getValue(), 12);
            auto idx = comb_translator::translateValue(ag.getIndex(), 12);
            if (!val.success || !idx.success) {
              llvm::errs() << "  [MEM-WRITE] cannot translate " << mem->name
                           << " write: " << (val.success ? idx.errorMsg : val.errorMsg) << "\n";
              return;
            }
            std::string gate;
            gate = resolveDriveGate(drv->getBlock(), "MEM-WRITE");
            if (Value en = drv.getEnable()) {
              auto e = comb_translator::translateValue(en, 12);
              if (!e.success) { llvm::errs() << "  [MEM-WRITE] enable untranslatable\n"; return; }
              gate = gate.empty() ? "(" + e.expr + ")" : "(" + gate + ") && (" + e.expr + ")";
            }
            std::string blk = "    { /* memory write: " + mem->name + " */\n";
            if (!gate.empty()) blk += "        if (" + gate + ")\n    ";
            blk += "        qpw_wide_insert(s->" + mem->name + ", " + std::to_string(mem->words) +
                   ", ((unsigned)(" + idx.expr + ") & " + std::to_string(mem->idxMask) + ") * " +
                   std::to_string(mem->elemWidth) + ", " + std::to_string(mem->elemWidth) +
                   ", (uint64_t)(" + val.expr + "));\n    }";
            SmallVector<NamedAttribute> fields;
            fields.push_back(NamedAttribute(StringAttr::get(ctx, "target"), StringAttr::get(ctx, "__RAW__")));
            fields.push_back(NamedAttribute(StringAttr::get(ctx, "expression"), StringAttr::get(ctx, blk)));
            fields.push_back(NamedAttribute(StringAttr::get(ctx, "bitWidth"),
                                            IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
            if (isSeq) seqAttrs.push_back(DictionaryAttr::get(ctx, fields));
            else combAttrs.push_back(DictionaryAttr::get(ctx, fields));
            llvm::errs() << "  [" << (isSeq ? "SEQ" : "COMB") << " MEM] " << mem->name
                         << "[" << idx.expr << "] = " << val.expr << "\n";
            return;
          }
        }

        // DYNAMIC-OFFSET slice write: `drv (sig.extract %wide from %dynOff), v`
        // — csrng ctr_drbg's lane steer
        // (`concat_key_v_d[(NumBlk-1-ctr)*BlkLen +: BlkLen] = rsp`).
        // getSliceInfo cannot fold the offset, and the old fallback
        // demoted this to a WHOLE-signal drv: the block landed truncated
        // in every word and the lane offset evaporated.  Emit a verbatim
        // runtime insert under the drv's gate instead (same recipe as the
        // memory write above).
        if (auto sx = signal.getDefiningOp<llhd::SigExtractOp>()) {
          if (!sx.getLowBit().getDefiningOp<hw::ConstantOp>()) {
            Value base = sx.getInput();
            auto baseSig = base.getDefiningOp<llhd::SignalOp>();
            unsigned sliceW = 0, baseW = 0;
            if (auto ref = dyn_cast<llhd::RefType>(sx.getResult().getType()))
              if (auto it2 = dyn_cast<IntegerType>(ref.getNestedType()))
                sliceW = it2.getWidth();
            if (baseSig)
              if (auto ref2 = dyn_cast<llhd::RefType>(baseSig.getType()))
                if (auto it3 = dyn_cast<IntegerType>(ref2.getNestedType()))
                  baseW = it3.getWidth();
            // sliceW > 64 ONLY: narrow dynamic bit-sets (rv_plic's
            // claim[id]=1) already translate correctly through the
            // DYN-ELEM enumeration path — intercepting them here tore the
            // RTL's default-clear + set pairing apart and the claim pulse
            // never reached the gateway (interrupt storm, three targets
            // down).  The wide-block lane steer (csrng's 128-bit) is the
            // shape the old path provably truncates.
            if (baseSig && baseSig.getName() && sliceW > 64 && sliceW <= 128 &&
                baseW > 128) {
              auto val = comb_translator::translateValue(drv.getValue(), 12);
              auto offE = comb_translator::translateValue(sx.getLowBit(), 12);
              if (!val.success || !offE.success) {
                llvm::errs() << "  [DYN-SLICE] cannot translate "
                             << *baseSig.getName() << " write: "
                             << (val.success ? offE.errorMsg : val.errorMsg)
                             << "\n";
                return;
              }
              if (val.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos ||
                  offE.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos) {
                // Ghost name from an unnamed inlined-function argument: the
                // expression would not compile.  Keep the pre-fix behavior
                // (drop loudly) — spi_device's cmd_filter unrolled-loop
                // slice writes ride on this.
                llvm::errs() << "  [DYN-SLICE] ghost arg in "
                             << *baseSig.getName() << " — dropped\n";
                return;
              }
              std::string gate;
              gate = resolveDriveGate(drv->getBlock(), "DYN-SLICE");
              if (Value en = drv.getEnable()) {
                auto e2 = comb_translator::translateValue(en, 12);
                if (!e2.success) {
                  llvm::errs() << "  [DYN-SLICE] enable untranslatable\n";
                  return;
                }
                gate = gate.empty() ? "(" + e2.expr + ")"
                                    : "(" + gate + ") && (" + e2.expr + ")";
              }
              if (gate.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos) {
                llvm::errs() << "  [DYN-SLICE] ghost arg in gate — dropped\n";
                return;
              }
              unsigned nWords = (baseW + 63) / 64;
              std::string nm = baseSig.getName()->str();
              std::string blk =
                  "    { /* dyn-slice write: " + nm + " */\n";
              if (!gate.empty())
                blk += "        if (" + gate + ") {\n";
              blk += "        unsigned _qpo = (unsigned)(" + offE.expr +
                     ");\n";
              if (sliceW <= 64) {
                blk += "        qpw_wide_insert(s->" + nm + ", " +
                       std::to_string(nWords) + ", _qpo, " +
                       std::to_string(sliceW) + ", (uint64_t)(" + val.expr +
                       "));\n";
              } else {
                blk += "        __uint128_t _qpv = (__uint128_t)(" +
                       val.expr + ");\n";
                blk += "        qpw_wide_insert(s->" + nm + ", " +
                       std::to_string(nWords) + ", _qpo, 64, (uint64_t)_qpv);\n";
                blk += "        qpw_wide_insert(s->" + nm + ", " +
                       std::to_string(nWords) + ", _qpo + 64, " +
                       std::to_string(sliceW - 64) +
                       ", (uint64_t)(_qpv >> 64));\n";
              }
              if (!gate.empty())
                blk += "        }\n";
              blk += "    }";
              SmallVector<NamedAttribute> fields;
              fields.push_back(NamedAttribute(StringAttr::get(ctx, "target"),
                                              StringAttr::get(ctx, "__RAW__")));
              fields.push_back(NamedAttribute(StringAttr::get(ctx, "expression"),
                                              StringAttr::get(ctx, blk)));
              fields.push_back(
                  NamedAttribute(StringAttr::get(ctx, "bitWidth"),
                                 IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
              if (isSeq) seqAttrs.push_back(DictionaryAttr::get(ctx, fields));
              else combAttrs.push_back(DictionaryAttr::get(ctx, fields));
              llvm::errs() << "  [" << (isSeq ? "SEQ" : "COMB")
                           << " DYN-SLICE] " << nm << "["
                           << comb_translator::brief(offE.expr, 60)
                           << " +: " << sliceW << "] = "
                           << comb_translator::brief(val.expr) << "\n";
              return;
            }
          }
        }

        // WIDE DYNAMIC SHIFT-LEFT of a narrow value onto a whole wide sig:
        // `wdata_shifted = {'0, wdata} << (depth * InW)` — prim_packer_fifo's
        // accumulation lane.  The >128-bit shl has no scalar C carrier and
        // used to drop as COMPLEX (csrng's 384-bit adata packer stayed
        // empty, the DRBG seed never arrived).  Semantically this is
        // "clear + insert narrow at runtime offset".
        if (auto sigW = signal.getDefiningOp<llhd::SignalOp>()) {
          unsigned baseW2 = 0;
          if (auto refW = dyn_cast<llhd::RefType>(sigW.getType()))
            if (auto itW = dyn_cast<IntegerType>(refW.getNestedType()))
              baseW2 = itW.getWidth();
          if (baseW2 > 128 && sigW.getName() && !sigW.getName()->empty()) {
            if (auto shl = drv.getValue().getDefiningOp<comb::ShlOp>()) {
              Value narrow;
              unsigned nw = 0;
              if (auto cc2 = shl.getLhs().getDefiningOp<comb::ConcatOp>()) {
                bool zerosOk = cc2.getNumOperands() >= 2;
                for (unsigned i2 = 0; zerosOk && i2 + 1 < cc2.getNumOperands();
                     ++i2) {
                  auto k2 =
                      cc2.getOperand(i2).getDefiningOp<hw::ConstantOp>();
                  if (!k2 || !k2.getValue().isZero()) zerosOk = false;
                }
                if (zerosOk) {
                  narrow = cc2.getOperand(cc2.getNumOperands() - 1);
                  if (auto nT = dyn_cast<IntegerType>(narrow.getType()))
                    nw = nT.getWidth();
                }
              }
              if (narrow && nw > 0 && nw <= 64) {
                auto valN = comb_translator::translateValue(narrow, 12);
                auto shE = comb_translator::translateValue(shl.getRhs(), 12);
                if (valN.success &&
                    valN.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos)
                  valN.success = false;  // ghost name — keep pre-fix drop
                if (shE.success &&
                    shE.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos)
                  shE.success = false;
                if (valN.success && shE.success) {
                  std::string gate;
                  gate = resolveDriveGate(drv->getBlock(), "DYN-SHL");
                  if (Value en2 = drv.getEnable()) {
                    auto e3 = comb_translator::translateValue(en2, 12);
                    if (e3.success)
                      gate = gate.empty()
                                 ? "(" + e3.expr + ")"
                                 : "(" + gate + ") && (" + e3.expr + ")";
                    else {
                      // NO ELSE HERE MEANT THE ENABLE WAS SILENTLY DROPPED and
                      // the wide write became unconditional — the same wrong
                      // answer as an unresolved path condition, reached from
                      // the other side.
                      llvm::errs() << "  [PATH-COND FAIL] DYN-SHL: enable is "
                                      "untranslatable (" << e3.errorMsg
                                   << "); emitting it ungated would make a "
                                      "guarded write unconditional\n";
                      g_pathCondRefused = true;
                      gate = "0";
                    }
                  }
                  unsigned nWords2 = (baseW2 + 63) / 64;
                  std::string nm2 = sigW.getName()->str();
                  std::string blk2 =
                      "    { /* wide dyn-shl: " + nm2 + " */\n";
                  if (!gate.empty()) blk2 += "        if (" + gate + ") {\n";
                  blk2 += "        unsigned _qpo = (unsigned)(" + shE.expr +
                          ");\n";
                  blk2 += "        memset(s->" + nm2 + ", 0, sizeof(s->" +
                          nm2 + "));\n";
                  blk2 += "        qpw_wide_insert(s->" + nm2 + ", " +
                          std::to_string(nWords2) + ", _qpo, " +
                          std::to_string(nw) + ", (uint64_t)(" + valN.expr +
                          "));\n";
                  if (!gate.empty()) blk2 += "        }\n";
                  blk2 += "    }";
                  SmallVector<NamedAttribute> f2;
                  f2.push_back(NamedAttribute(StringAttr::get(ctx, "target"),
                                              StringAttr::get(ctx, "__RAW__")));
                  f2.push_back(NamedAttribute(StringAttr::get(ctx, "expression"),
                                              StringAttr::get(ctx, blk2)));
                  f2.push_back(NamedAttribute(
                      StringAttr::get(ctx, "bitWidth"),
                      IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
                  if (isSeq) seqAttrs.push_back(DictionaryAttr::get(ctx, f2));
                  else combAttrs.push_back(DictionaryAttr::get(ctx, f2));
                  llvm::errs() << "  [" << (isSeq ? "SEQ" : "COMB")
                               << " DYN-SHL] " << nm2 << " = zext("
                               << comb_translator::brief(valN.expr)
                               << ") << " << comb_translator::brief(shE.expr, 60)
                               << "\n";
                  return;
                }
              }
            }
          }
        }

        // EXPLODED nested array-element drv with DYNAMIC index layer(s):
        // keymgr's key_state_d[cdi][share][word] write indexes the word
        // layer with a runtime counter probe, so the element has no
        // static leaf name (it fell through to `unnamed` and the whole
        // update arm vanished).  Enumerate every dynamic layer value
        // (product capped at 64) into per-leaf actions gated on
        // `idxExpr == k` — the normal gated-ternary machinery composes
        // them with the other arms.
        bool dynWholeWide = false;
        if (auto s0 = signal.getDefiningOp<llhd::SignalOp>()) {
          Type n0 = cast<llhd::RefType>(signal.getType()).getNestedType();
          if (isa<hw::ArrayType>(n0)) dynWholeWide = true;
          if (auto i0 = dyn_cast<IntegerType>(n0))
            if (i0.getWidth() > 64 && i0.getWidth() % 64 == 0)
              dynWholeWide = true;
        }
        if (signal.getDefiningOp<llhd::SigArrayGetOp>() || dynWholeWide) {
          SmallVector<Value> idxChain;
          SmallVector<unsigned> sizes;
          std::string structPath;
          Value cur = signal;
          bool shapeOk = true;
          while (true) {
            if (auto ag2 = cur.getDefiningOp<llhd::SigArrayGetOp>()) {
              idxChain.push_back(ag2.getIndex());
              auto arT3 = dyn_cast<hw::ArrayType>(
                  cast<llhd::RefType>(ag2.getInput().getType())
                      .getNestedType());
              if (!arT3) { shapeOk = false; break; }
              sizes.push_back(arT3.getNumElements());
              cur = ag2.getInput();
              continue;
            }
            if (auto se2 = cur.getDefiningOp<llhd::SigStructExtractOp>()) {
              structPath = "." + se2.getField().str() + structPath;
              cur = se2.getInput();
              continue;
            }
            break;
          }
          std::reverse(idxChain.begin(), idxChain.end());
          std::reverse(sizes.begin(), sizes.end());
          auto sigOp = cur.getDefiningOp<llhd::SignalOp>();
          // Name: the sig's name attribute, else the SSA-name fallback
          // (importer leaves plenty of sigs — keymgr's key_o — unnamed).
          std::string dynBase;
          if (sigOp)
            dynBase = sigOp.getName() ? sigOp.getName()->str()
                                      : getSignalNameFromValue(cur);
          // Constant chains land here too: getSignalNameFromValue has no
          // array_get support, so without this they fell to `unnamed`.
          if (sigOp && !dynBase.empty() && dynBase != "unnamed") {
            Type nt = cast<llhd::RefType>(signal.getType()).getNestedType();
            if (getenv("QP_DEBUG_DYN"))
              llvm::errs() << "  [DYN-ENTER] " << dynBase
                           << structPath << " layers=" << idxChain.size()
                           << " shapeOk=" << shapeOk << "\n";
            uint64_t combos = 1;
            if (shapeOk)
              for (size_t L = 0; L < idxChain.size(); ++L)
                if (!idxChain[L].getDefiningOp<hw::ConstantOp>())
                  combos *= sizes[L];
            // Element may itself be an ARRAY (keymgr's share/cdi-level
            // arms write whole sub-arrays).  Flatten the inner static
            // dims into per-word leaves; each word expression comes from
            // a recursive WIDE-VALUE WORD PROJECTOR that understands the
            // importer's spellings: bitcast wrappers, muxes, pointwise
            // xor/and/or, replicate broadcasts, and probes of named
            // (exploded or wide) signals / their constant array_gets.
            unsigned innerElems = 1, innerW = 0;
            SmallVector<unsigned> innerDims;
            {
              Type it2 = nt;
              while (auto at2 = dyn_cast<hw::ArrayType>(it2)) {
                innerElems *= at2.getNumElements();
                innerDims.push_back(at2.getNumElements());
                it2 = at2.getElementType();
              }
              if (auto ii = dyn_cast<IntegerType>(it2)) innerW = ii.getWidth();
            }
            auto elemInt = dyn_cast_or_null<IntegerType>(nt);
            // A WIDE integer element (keymgr's key_o.key[i] : i256) has
            // no scalar carrier either — project per 64-bit word,
            // emitted as wordIndex entries against the one wide leaf.
            // Storage rule: 65..128-bit fields are a __uint128_t SCALAR
            // (no [] indexing); only >128-bit fields are uint64_t arrays
            // that accept wordIndex entries.
            bool wideIntElem = elemInt && elemInt.getWidth() > 128 &&
                               elemInt.getWidth() % 64 == 0;
            bool midIntElem = elemInt && elemInt.getWidth() > 64 &&
                              elemInt.getWidth() <= 128;
            if (wideIntElem) {
              innerW = 64;
              innerElems = elemInt.getWidth() / 64;
            }
            if (midIntElem) { innerW = 64; innerElems = 2; }
            if (shapeOk && (wideIntElem || midIntElem || !elemInt) && innerW &&
                innerElems > 1 && combos * innerElems <= 64) {
              // leafAt: name of the exploded integer leaf holding bit
              // range [off, off+w) of a named signal of type `t`
              // (HW packing: array element 0 = LSBs).  Returns the C
              // expression reading those bits.
              std::function<std::optional<std::string>(
                  std::string, Type, unsigned, unsigned)>
                  leafAt = [&](std::string base, Type t, unsigned off,
                               unsigned w) -> std::optional<std::string> {
                if (auto at3 = dyn_cast<hw::ArrayType>(t)) {
                  int64_t eb = hw::getBitWidth(at3.getElementType());
                  if (eb <= 0) return std::nullopt;
                  unsigned idx = off / (unsigned)eb;
                  unsigned rem = off - idx * (unsigned)eb;
                  if (rem + w <= (unsigned)eb)
                    return leafAt(base + "[" + std::to_string(idx) + "]",
                                  at3.getElementType(), rem, w);
                  // Window straddles two elements (a 64-bit read over
                  // 32-bit leaves: keymgr's 4xi64 ECC view of the
                  // 8xi32 key_state_d): stitch the halves.
                  if (idx + 1 >= at3.getNumElements()) return std::nullopt;
                  unsigned lowW = (unsigned)eb - rem;
                  auto a = leafAt(base + "[" + std::to_string(idx) + "]",
                                  at3.getElementType(), rem, lowW);
                  auto b = leafAt(base + "[" + std::to_string(idx + 1) + "]",
                                  at3.getElementType(), 0, w - lowW);
                  if (!a || !b) return std::nullopt;
                  return "((" + *a + ") | ((" + *b + ") << " +
                         std::to_string(lowW) + "))";
                }
                if (auto it3 = dyn_cast<IntegerType>(t)) {
                  std::string leaf =
                      comb_translator::sanitizeSignalName(base);
                  if (it3.getWidth() > 64 && it3.getWidth() <= 128) {
                    // __uint128_t SCALAR storage
                    std::string e5 = "((uint64_t)(((__uint128_t)s->" +
                                     leaf + ") >> " + std::to_string(off) +
                                     "))";
                    if (w < 64)
                      e5 = "(" + e5 + " & ((1ULL << " + std::to_string(w) +
                           ") - 1))";
                    return "(" + e5 + ")";
                  }
                  if (it3.getWidth() > 128) {
                    return "qpw_wide_extract(s->" + leaf + ", " +
                           std::to_string((it3.getWidth() + 63) / 64) +
                           ", " + std::to_string(off) + ", " +
                           std::to_string(w) + ")";
                  }
                  std::string e2 = "s->" + leaf;
                  if (off) e2 = "(" + e2 + " >> " + std::to_string(off) + ")";
                  if (w < 64)
                    e2 = "(" + e2 + " & ((1ULL << " + std::to_string(w) +
                         ") - 1))";
                  return "(" + e2 + ")";
                }
                return std::nullopt;
              };
              std::function<std::optional<std::string>(Value, unsigned,
                                                       unsigned)>
                  wordOf = [&](Value v, unsigned off,
                               unsigned w) -> std::optional<std::string> {
                if (auto vb = v.getDefiningOp<hw::BitcastOp>()) {
                  auto r3 = wordOf(vb.getInput(), off, w);
                  if (!r3 && getenv("QP_DEBUG_DYN")) {
                    llvm::errs() << "    [wordOf bitcast-inner fail] op=";
                    if (Operation *d3 = vb.getInput().getDefiningOp())
                      llvm::errs() << d3->getName();
                    else
                      llvm::errs() << "blockarg";
                    llvm::errs() << "\n";
                  }
                  return r3;
                }
                if (auto vm = v.getDefiningOp<comb::MuxOp>()) {
                  auto c = comb_translator::translateValue(vm.getCond(), 24);
                  if (!c.success) return std::nullopt;
                  auto a = wordOf(vm.getTrueValue(), off, w);
                  auto b = wordOf(vm.getFalseValue(), off, w);
                  if (!a || !b) return std::nullopt;
                  return "((" + c.expr + ") ? " + *a + " : " + *b + ")";
                }
                if (auto vx = v.getDefiningOp<comb::XorOp>()) {
                  std::string r2;
                  for (Value o : vx.getOperands()) {
                    auto oe = wordOf(o, off, w);
                    if (!oe) return std::nullopt;
                    r2 += (r2.empty() ? "" : " ^ ") + *oe;
                  }
                  return "(" + r2 + ")";
                }
                if (auto vr = v.getDefiningOp<comb::ReplicateOp>()) {
                  unsigned rw =
                      vr.getInput().getType().getIntOrFloatBitWidth();
                  unsigned lo = off % rw;
                  auto ie = wordOf(vr.getInput(), 0, std::min(rw, 64u));
                  if (!ie) {
                    auto te = comb_translator::translateValue(vr.getInput(), 24);
                    if (!te.success) return std::nullopt;
                    ie = "(" + te.expr + ")";
                  }
                  std::string unit = "((uint64_t)" + *ie + ")";
                  if (lo + w <= rw) {
                    std::string e2 = unit;
                    if (lo) e2 = "(" + e2 + " >> " + std::to_string(lo) + ")";
                    if (w < 64)
                      e2 = "(" + e2 + " & ((1ULL << " + std::to_string(w) +
                           ") - 1))";
                    return "(" + e2 + ")";
                  }
                  // window spans several unit copies (aligned)
                  if (lo == 0 && w % rw == 0 && rw < 64) {
                    std::string e2;
                    for (unsigned k = 0; k * rw < w; ++k)
                      e2 += (k ? " | " : "") + ("(" + unit + " << " +
                                                std::to_string(k * rw) + ")");
                    return "(" + e2 + ")";
                  }
                  return std::nullopt;
                }
                if (auto vac = v.getDefiningOp<hw::ArrayCreateOp>()) {
                  // operand 0 = HIGHEST index element (MSBs)
                  int64_t eb = hw::getBitWidth(
                      cast<hw::ArrayType>(vac.getType()).getElementType());
                  if (eb <= 0) return std::nullopt;
                  unsigned n = vac.getNumOperands();
                  unsigned idx = off / (unsigned)eb;
                  if (idx >= n || (off % eb) + w > (unsigned)eb)
                    return std::nullopt;
                  return wordOf(vac.getOperand(n - 1 - idx), off % eb, w);
                }
                if (auto vs = v.getDefiningOp<mlir::arith::SelectOp>()) {
                  auto c = comb_translator::translateValue(
                      vs.getCondition(), 24);
                  if (!c.success) return std::nullopt;
                  auto a = wordOf(vs.getTrueValue(), off, w);
                  auto b = wordOf(vs.getFalseValue(), off, w);
                  if (!a || !b) return std::nullopt;
                  return "((" + c.expr + ") ? " + *a + " : " + *b + ")";
                }
                if (auto vagg = v.getDefiningOp<hw::AggregateConstantOp>()) {
                  // all-zero aggregate (the disable arm wipes key_state):
                  bool allZero = true;
                  std::function<void(Attribute)> chk = [&](Attribute a) {
                    if (auto arr = dyn_cast<ArrayAttr>(a)) {
                      for (Attribute e2 : arr) chk(e2);
                    } else if (auto ia = dyn_cast<IntegerAttr>(a)) {
                      if (!ia.getValue().isZero()) allZero = false;
                    } else
                      allZero = false;
                  };
                  chk(vagg.getFields());
                  if (allZero) return std::string("0ULL");
                  // uniform all-ones (the disable arm writes ~0 words):
                  bool allOnes = true;
                  std::function<void(Attribute)> chk1 = [&](Attribute a) {
                    if (auto arr = dyn_cast<ArrayAttr>(a)) {
                      for (Attribute e2 : arr) chk1(e2);
                    } else if (auto ia = dyn_cast<IntegerAttr>(a)) {
                      if (!ia.getValue().isAllOnes()) allOnes = false;
                    } else
                      allOnes = false;
                  };
                  chk1(vagg.getFields());
                  if (allOnes)
                    return w >= 64 ? std::string("0xFFFFFFFFFFFFFFFFULL")
                                   : "((1ULL << " + std::to_string(w) +
                                         ") - 1)";
                  return std::nullopt;
                }
                if (auto vg = v.getDefiningOp<hw::ArrayGetOp>()) {
                  if (auto kc =
                          vg.getIndex().getDefiningOp<hw::ConstantOp>()) {
                    int64_t eb = hw::getBitWidth(vg.getType());
                    if (eb > 0)
                      return wordOf(vg.getInput(),
                                    off + (unsigned)(kc.getValue()
                                                         .getZExtValue() *
                                                     eb),
                                    w);
                  }
                  // dynamic element select: N-way ternary chain on idx
                  auto arT = dyn_cast<hw::ArrayType>(
                      vg.getInput().getType());
                  if (arT && arT.getNumElements() >= 2 &&
                      arT.getNumElements() <= 8) {
                    auto ie = comb_translator::translateValue(vg.getIndex(), 24);
                    int64_t eb = hw::getBitWidth(vg.getType());
                    if (ie.success && eb > 0) {
                      unsigned nEl = arT.getNumElements();
                      SmallVector<std::string> arms;
                      bool okA = true;
                      for (unsigned k = 0; k < nEl && okA; ++k) {
                        auto a = wordOf(vg.getInput(),
                                        off + k * (unsigned)eb, w);
                        if (!a) okA = false;
                        else arms.push_back(*a);
                      }
                      if (okA) {
                        std::string e5 = arms[nEl - 1];
                        for (int k = (int)nEl - 2; k >= 0; --k)
                          e5 = "((((unsigned)(" + ie.expr + ")) == " +
                               std::to_string(k) + "u) ? " + arms[k] +
                               " : " + e5 + ")";
                        return e5;
                      }
                    }
                  }
                  return std::nullopt;
                }
                if (auto vp = v.getDefiningOp<llhd::ProbeOp>()) {
                  // Peel a sig.array_get chain on the probed REF (the
                  // init arm probes the very sub-array it drives):
                  // constant layers accumulate a bit offset; a dynamic
                  // 2-element layer projects both and muxes.
                  Value sref = vp.getSignal();
                  unsigned chainOff = 0;
                  std::optional<std::pair<std::string, unsigned>> dynSel;
                  while (auto sag = sref.getDefiningOp<llhd::SigArrayGetOp>()) {
                    Type et = cast<llhd::RefType>(sag.getType())
                                  .getNestedType();
                    int64_t eb = hw::getBitWidth(et);
                    if (eb <= 0) return std::nullopt;
                    if (auto kc3 = sag.getIndex()
                                       .getDefiningOp<hw::ConstantOp>()) {
                      chainOff +=
                          (unsigned)(kc3.getValue().getZExtValue() * eb);
                    } else {
                      auto arT2 = dyn_cast<hw::ArrayType>(
                          cast<llhd::RefType>(sag.getInput().getType())
                              .getNestedType());
                      if (!arT2 || arT2.getNumElements() != 2 || dynSel)
                        return std::nullopt;
                      auto ie3 = comb_translator::translateValue(
                          sag.getIndex(), 24);
                      if (!ie3.success) return std::nullopt;
                      dynSel = {ie3.expr, (unsigned)eb};
                    }
                    sref = sag.getInput();
                  }
                  std::string base = getSignalNameFromValue(sref);
                  if (base.empty() || base == "unnamed")
                    return std::nullopt;
                  Type st2 =
                      cast<llhd::RefType>(sref.getType()).getNestedType();
                  if (dynSel) {
                    auto a = leafAt(base, st2, off + chainOff, w);
                    auto b =
                        leafAt(base, st2, off + chainOff + dynSel->second, w);
                    if (!a || !b) return std::nullopt;
                    return "((" + dynSel->first + ") ? " + *b + " : " + *a +
                           ")";
                  }
                  return leafAt(base, st2, off + chainOff, w);
                }
                if (auto kc2 = v.getDefiningOp<hw::ConstantOp>()) {
                  uint64_t wv =
                      kc2.getValue().extractBitsAsZExtValue(
                          std::min(64u, w), off);
                  return std::to_string(wv) + "ULL";
                }
                return std::nullopt;
              };
              SmallVector<std::string> idxExpr(idxChain.size());
              SmallVector<int64_t> constIdx(idxChain.size(), -1);
              bool ok2 = true;
              for (size_t L = 0; ok2 && L < idxChain.size(); ++L) {
                if (auto k = idxChain[L].getDefiningOp<hw::ConstantOp>())
                  constIdx[L] = (int64_t)k.getValue().getZExtValue();
                else {
                  auto ie = comb_translator::translateValue(idxChain[L], 24);
                  if (!ie.success) ok2 = false;
                  else idxExpr[L] = ie.expr;
                }
              }
              SmallVector<std::string> wordExprs(innerElems);
              for (unsigned wI = 0; ok2 && wI < innerElems; ++wI) {
                auto we = wordOf(drv.getValue(), wI * innerW, innerW);
                if (!we) {
                  if (getenv("QP_DEBUG_DYN")) {
                    llvm::errs() << "  [DYN-ARR wordOf fail] off="
                                 << (wI * innerW) << " w=" << innerW
                                 << " v0=";
                    if (Operation *vd = drv.getValue().getDefiningOp())
                      llvm::errs() << vd->getName();
                    llvm::errs() << "\n";
                  }
                  ok2 = false;
                } else
                  wordExprs[wI] = *we;
              }
              if (ok2) {
                std::string gate0;
                gate0 = resolveDriveGate(drv->getBlock(), "DYN-ELEM-ARR");
                // THIS SITE NEVER ASKED FOR THE ENABLE.  Of the emitter's
                // drive-lowering sites this was the only one that did not
                // consult drv.getEnable(), so a conditionally-enabled dynamic
                // element write was emitted as an always-enabled one.
                if (Value enA = drv.getEnable()) {
                  auto eA = comb_translator::translateValue(enA, 12);
                  if (eA.success)
                    gate0 = gate0.empty()
                                ? "(" + eA.expr + ")"
                                : "(" + gate0 + ") && (" + eA.expr + ")";
                  else {
                    llvm::errs() << "  [PATH-COND FAIL] DYN-ELEM-ARR: enable is "
                                    "untranslatable (" << eA.errorMsg << ")\n";
                    g_pathCondRefused = true;
                    gate0 = "0";
                  }
                }
                std::function<void(size_t, std::string, std::string)> go2 =
                    [&](size_t L, std::string path, std::string gate) {
                      if (L == idxChain.size() && midIntElem) {
                        // 65..128-bit element: __uint128_t SCALAR storage —
                        // ONE stitched assignment, no [] indexing.
                        std::string tgtRaw = dynBase + structPath + path;
                        std::string tgt =
                            comb_translator::sanitizeSignalName(tgtRaw);
                        std::string comb2 =
                            "(((__uint128_t)(" + wordExprs[1] +
                            ") << 64) | (__uint128_t)(" + wordExprs[0] + "))";
                        std::string expr =
                            gate.empty()
                                ? comb2
                                : "((" + gate + ") ? (" + comb2 +
                                      ") : s->" + tgt + ")";
                        SmallVector<NamedAttribute> fields;
                        fields.push_back(NamedAttribute(
                            StringAttr::get(ctx, "target"),
                            StringAttr::get(ctx, tgt)));
                        fields.push_back(NamedAttribute(
                            StringAttr::get(ctx, "expression"),
                            StringAttr::get(ctx, expr)));
                        fields.push_back(NamedAttribute(
                            StringAttr::get(ctx, "bitWidth"),
                            IntegerAttr::get(IntegerType::get(ctx, 32),
                                             elemInt.getWidth())));
                        if (isSeq)
                          seqAttrs.push_back(DictionaryAttr::get(ctx, fields));
                        else
                          combAttrs.push_back(DictionaryAttr::get(ctx, fields));
                        if (!isSeq) {
                          CombinationalAssignment ca;
                          ca.targetSignal = tgtRaw;
                          ca.expression = expr;
                          ca.bitWidth = elemInt.getWidth();
                          moduleComb.assignments.push_back(std::move(ca));
                        }
                        return;
                      }
                      if (L == idxChain.size()) {
                        for (unsigned wI = 0; wI < innerElems; ++wI) {
std::string sub;
                          if (!wideIntElem) {
                            unsigned rem = wI;
                            SmallVector<unsigned> idxs2(innerDims.size());
                            for (int d = (int)innerDims.size() - 1; d >= 0;
                                 --d) {
                              idxs2[d] = rem % innerDims[d];
                              rem /= innerDims[d];
                            }
                            for (unsigned d = 0; d < innerDims.size(); ++d)
                              sub += "[" + std::to_string(idxs2[d]) + "]";
                          }
                          std::string tgtRaw =
                              dynBase + structPath + path + sub;
                          std::string tgt =
                              comb_translator::sanitizeSignalName(tgtRaw);
                          std::string selfRef =
                              wideIntElem
                                  ? ("s->" + tgt + "[" +
                                     std::to_string(wI) + "]")
                                  : ("s->" + tgt);
                          std::string expr =
                              gate.empty()
                                  ? wordExprs[wI]
                                  : "((" + gate + ") ? (" + wordExprs[wI] +
                                        ") : " + selfRef + ")";
                          SmallVector<NamedAttribute> fields;
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "target"),
                              StringAttr::get(ctx, tgt)));
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "expression"),
                              StringAttr::get(ctx, expr)));
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "bitWidth"),
                              IntegerAttr::get(IntegerType::get(ctx, 32),
                                               wideIntElem
                                                   ? elemInt.getWidth()
                                                   : innerW)));
                          if (wideIntElem)
                            fields.push_back(NamedAttribute(
                                StringAttr::get(ctx, "wordIndex"),
                                IntegerAttr::get(IntegerType::get(ctx, 32),
                                                 (int)wI)));
                          if (isSeq)
                            seqAttrs.push_back(
                                DictionaryAttr::get(ctx, fields));
                          else
                            combAttrs.push_back(
                                DictionaryAttr::get(ctx, fields));
                          if (!isSeq) {
                            CombinationalAssignment ca;
                            ca.targetSignal = tgtRaw;
                            ca.expression = expr;
                            ca.bitWidth = wideIntElem ? elemInt.getWidth()
                                                      : innerW;
                            if (wideIntElem) ca.wordIndex = (int)wI;
                            moduleComb.assignments.push_back(std::move(ca));
                          }
                        }
                        return;
                      }
                      if (constIdx[L] >= 0) {
                        go2(L + 1,
                            path + "[" + std::to_string(constIdx[L]) + "]",
                            gate);
                        return;
                      }
                      for (unsigned k = 0; k < sizes[L]; ++k) {
                        std::string g2 = "((" + idxExpr[L] + ") == " +
                                         std::to_string(k) + ")";
                        go2(L + 1, path + "[" + std::to_string(k) + "]",
                            gate.empty() ? g2 : gate + " && " + g2);
                      }
                    };
                go2(0, "", gate0);
                llvm::errs() << "  [DYN-ELEM-ARR] " << dynBase << " (" << combos
                             << "x" << innerElems << " words)\n";
                return;
              } else if (getenv("QP_DEBUG_DYN")) {
                llvm::errs() << "  [DYN-ARR bail] " << dynBase << "\n";
              }
            }
            if (shapeOk && elemInt && combos <= 64) {
              auto val = comb_translator::translateValue(drv.getValue(), 24);
              SmallVector<std::string> idxExpr(idxChain.size());
              SmallVector<int64_t> constIdx(idxChain.size(), -1);
              bool ok = val.success;
              for (size_t L = 0; ok && L < idxChain.size(); ++L) {
                if (auto k = idxChain[L].getDefiningOp<hw::ConstantOp>()) {
                  constIdx[L] = (int64_t)k.getValue().getZExtValue();
                } else {
                  auto ie = comb_translator::translateValue(idxChain[L], 24);
                  if (!ie.success) ok = false;
                  else idxExpr[L] = ie.expr;
                }
              }
              if (ok) {
                std::string gate0 = resolveDriveGate(drv->getBlock(),
                                                     "DYN-ELEM");
                if (Value en = drv.getEnable()) {
                  auto ee = comb_translator::translateValue(en, 24);
                  if (!ee.success) ok = false;
                  else
                    gate0 = gate0.empty()
                                ? "(" + ee.expr + ")"
                                : "(" + gate0 + ") && (" + ee.expr + ")";
                }
                if (ok) {
                  unsigned elemW = elemInt.getWidth();
                  std::function<void(size_t, std::string, std::string)> go =
                      [&](size_t L, std::string path, std::string gate) {
                        if (L == idxChain.size()) {
                          std::string tgtRaw = sigOp.getName()->str() + path;
                          std::string tgt =
                              comb_translator::sanitizeSignalName(tgtRaw);
                          std::string expr =
                              gate.empty()
                                  ? val.expr
                                  : "((" + gate + ") ? (" + val.expr +
                                        ") : s->" + tgt + ")";
                          SmallVector<NamedAttribute> fields;
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "target"),
                              StringAttr::get(ctx, tgt)));
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "expression"),
                              StringAttr::get(ctx, expr)));
                          fields.push_back(NamedAttribute(
                              StringAttr::get(ctx, "bitWidth"),
                              IntegerAttr::get(IntegerType::get(ctx, 32),
                                               elemW)));
                          if (isSeq)
                            seqAttrs.push_back(
                                DictionaryAttr::get(ctx, fields));
                          else
                            combAttrs.push_back(
                                DictionaryAttr::get(ctx, fields));
                          if (!isSeq) {
                            CombinationalAssignment ca;
                            ca.targetSignal = tgtRaw;
                            ca.expression = expr;
                            ca.bitWidth = elemW;
                            moduleComb.assignments.push_back(std::move(ca));
                          }
                          return;
                        }
                        if (constIdx[L] >= 0) {
                          go(L + 1,
                             path + "[" + std::to_string(constIdx[L]) + "]",
                             gate);
                          return;
                        }
                        for (unsigned k = 0; k < sizes[L]; ++k) {
                          std::string g2 = "((" + idxExpr[L] + ") == " +
                                           std::to_string(k) + ")";
                          go(L + 1, path + "[" + std::to_string(k) + "]",
                             gate.empty() ? g2 : gate + " && " + g2);
                        }
                      };
                  go(0, "", gate0);
                  llvm::errs() << "  [DYN-ELEM] " << dynBase
                               << " expanded (" << combos
                               << " combos x elem " << elemW << "b)\n";
                  return;
                }
              }
            }
          }
        }

        std::string sigName = getSignalNameFromValue(signal);
        SliceInfo slice = getSliceInfo(signal);

        // No dedup: LLHD process semantics is "last drv wins" within a
        // process, and outside a process multiple drvs of the same sig
        // are unusual but if present, the latter still overwrites.  We
        // emit every drv in IR order; tick() / update_state run them
        // sequentially, so a subsequent `s->X = ...` overrides any
        // earlier one targeting the same field.  This matters for
        // things like `racl_addr_hit_write`:
        //   1.  llhd.drv %racl_addr_hit_write, %c0_i13       (default 0)
        //   2.  llhd.drv %racl_addr_hit_write, %computed     (override)
        // Pre-fix dedup-by-sigName kept only #1 → all per-register WEs
        // gated on this sig stayed off → no register ever updated.
        // (slice info is still computed and threaded into the bit-update
        // wrapper below; for full-sig drvs, slice.sliced is false and
        // we just emit `s->X = expr;` as before.)
        (void)processedCombSignals;
        (void)processedSeqSignals;

        // Previously: skipped drvs whose target sig name matched a module
        // port name, expecting the caller's instance bridge to wire them.
        // That assumption breaks for the common SV pattern in prim_subreg
        // and friends where an output port (`q`) and an internal sig
        // (`logic q`) share a name — Phase 2.a's per-instance prefixing
        // makes both the inner sig and the caller's instance-result field
        // resolve to the same flat state-struct name (e.g.
        // `u_reg_u_ctrl_tx_q`), so the output bridge ends up emitting a
        // `s->X = s->X` self-loop that does nothing, AND the seq drv that
        // actually mutates the storage gets skipped — register state never
        // updates.  Letting the drv through gives us the real write; the
        // caller's redundant self-loop bridge is harmless.
        (void)modulePortNames;

        // Generate action
        EventAction action = tryGenerateAction(drv);

        // Path-condition gate: any drv inside a non-entry block of its
        // containing process must be gated by the predecessor cf.cond_br
        // chain.  Otherwise an unconditional drv (e.g. the default
        // `reg_rdata_next = -1` in the OT no-hit fallthrough block)
        // would unconditionally overwrite the conditional bit-update
        // drvs from the matched register-hit blocks.
        //
        // resolveBlockArgViaCFG (called from tryGenerateAction's
        // ASSIGN_SIGNAL fast path) already sets gatedCondition from the
        // BlockArg's containing block.  We only overwrite when it's
        // empty AND the drv's block isn't the entry — which catches the
        // const-default case.
        {
          Block *drvBlock = drv->getBlock();
          if (drvBlock && !isEntryBlock(drvBlock)) {
            if (auto cond = getBlockPathCondition(drvBlock)) {
              // A gate set by resolveBlockArgViaCFG covers the VALUE's
              // routing conditions but NOT necessarily the drv block's own
              // guards: lc_ctrl's token write sits under `if (qe)` inside
              // the claim arm, and the blockarg resolve contributed only
              // the claim mux — the qe hop lives on the drv block's path.
              // AND both; a repeated literal is boolean-idempotent.
              if (*cond != "1") {
                action.gatedCondition =
                    action.gatedCondition.empty()
                        ? *cond
                        : "(" + action.gatedCondition + ") && (" + *cond +
                              ")";
              }
            } else if (action.gatedCondition.empty()) {
              llvm::errs() << "  [PATH-COND FAIL] " << sigName
                           << ": drv in a non-entry block without a computable "
                              "path condition -> emitted UNGATED\n";
            }
          }
        }

        // llhd.drv `enable` operand (`drv %sig, %v after %t if %en`): the
        // sig-ref lowering (ExplodeStructSigs S1/S3) emits guarded drvs —
        // `drv A, v if c` / `drv B, v if !c` for a lowered inout select, and
        // `drv elem_i, v if idx==i` for a runtime-indexed array write.  It was
        // silently ignored before (every such drive became unconditional).
        if (Value en = drv.getEnable()) {
          auto enRes = comb_translator::translateValue(en, 12);
          if (!enRes.success) {
            llvm::errs() << "  [DRV-ENABLE] cannot translate enable for " << sigName
                         << ": " << enRes.errorMsg << " -> drv skipped\n";
            return;
          }
          action.gatedCondition = action.gatedCondition.empty()
              ? "(" + enRes.expr + ")"
              : "(" + action.gatedCondition + ") && (" + enRes.expr + ")";
        }

        // qemu.pump_gate (AccumulateRingDetect, module-local ring): this
        // register only advances on the pump clock — AND its update condition
        // with the pump pulse so settle clocks hold it entirely (including
        // its wrap-to-0 arm), while the pump clock applies the real next state.
        if (drv->hasAttr("qemu.pump_gate")) {
          action.gatedCondition = action.gatedCondition.empty()
              ? std::string("s->_qp_pump")
              : "(" + action.gatedCondition + ") && (s->_qp_pump)";
        }

        // WIDE (>128-bit) comb drv whose value is a comb.concat: no single
        // scalar expression can carry it (the translator's concat cap), but
        // each 64-bit WORD of the destination is expressible — decompose
        // into per-word actions (kmac_core's 560-bit encoded_key
        // `{zeros, key_data, encode_keylen}` fed the key slicer all-zero).
        if (isComplexAction(action) && !isSeq) {
          unsigned dstW = drv.getValue().getType().isIntOrFloat()
                              ? drv.getValue().getType().getIntOrFloatBitWidth()
                              : 0;
          auto ccOp = drv.getValue().getDefiningOp<circt::comb::ConcatOp>();
          if (dstW > 128 && ccOp) {
            // segments LSB-up: operand list is MSB-first
            struct Seg { unsigned off, w; std::string ex; unsigned exW; };
            llvm::SmallVector<Seg, 8> segs;
            bool ok = true;
            unsigned msb = dstW;
            for (Value o : ccOp.getOperands()) {
              unsigned w = o.getType().getIntOrFloatBitWidth();
              msb -= w;
              if (w <= 64) {
                auto e = comb_translator::translateValue(o, 12);
                if (!e.success) { ok = false; break; }
                segs.push_back({msb, w, "((uint64_t)(" + e.expr + "))", w});
              } else {
                // wide operand: a named wide signal, optionally through a
                // constant-offset comb.extract (kmac_core's per-key-length
                // arms slice key_data_i[0 +: 128/192/256/384])
                Value src = o;
                unsigned srcOff = 0;
                // zero-padding constant segments contribute nothing
                if (auto k0 = src.getDefiningOp<circt::hw::ConstantOp>()) {
                  if (k0.getValue().isZero())
                    continue;
                  ok = false;   // non-zero wide literal: no carrier
                  break;
                }
                if (auto exOp = src.getDefiningOp<circt::comb::ExtractOp>()) {
                  srcOff = exOp.getLowBit();
                  src = exOp.getInput();
                }
                auto e = comb_translator::translateValue(src, 12);
                std::string base;
                if (!e.success ||
                    !comb_translator::isPlainSignalRef(e.expr, &base)) {
                  llvm::errs() << "  [SPLIT bail] wide seg w=" << w << " op=";
                  if (Operation *d3 = src.getDefiningOp())
                    llvm::errs() << d3->getName();
                  else
                    llvm::errs() << "block-arg";
                  llvm::errs() << " expr=" << (e.success ? e.expr : e.errorMsg)
                               << "\n";
                  ok = false;
                  break;
                }
                unsigned srcTotW = src.getType().getIntOrFloatBitWidth();
                segs.push_back({msb, w,
                                "qpw_wide_extract(s->" + base + ", " +
                                    std::to_string((srcTotW + 63) / 64) +
                                    ", " + std::to_string(srcOff) + "u + ",
                                0});  // exW==0 marks the qpw form
              }
            }
            if (ok) {
              unsigned nWords = (dstW + 63) / 64;
              std::string sanT =
                  comb_translator::sanitizeSignalName(sigName);
              std::string blk = "    { /* wide concat split: " + sanT +
                                " */\n";
              for (unsigned wd = 0; wd < nWords; ++wd) {
                unsigned lo = wd * 64,
                         hi = std::min(dstW, lo + 64);
                std::string ex;
                for (const auto &sg : segs) {
                  unsigned sLo = std::max(lo, sg.off),
                           sHi = std::min(hi, sg.off + sg.w);
                  if (sLo >= sHi) continue;
                  unsigned take = sHi - sLo;
                  std::string piece;
                  if (sg.exW == 0) {
                    piece = sg.ex + std::to_string(sLo - sg.off) + ", " +
                            std::to_string(take) + ")";
                  } else {
                    piece = "((" + sg.ex + " >> " +
                            std::to_string(sLo - sg.off) + ") & " +
                            (take >= 64
                                 ? std::string("0xFFFFFFFFFFFFFFFFULL")
                                 : ("((1ULL << " + std::to_string(take) +
                                    ") - 1)")) +
                            ")";
                  }
                  std::string shifted =
                      (sLo - lo) ? ("(" + piece + " << " +
                                    std::to_string(sLo - lo) + ")")
                                 : piece;
                  ex = ex.empty() ? shifted : ex + " | " + shifted;
                }
                if (ex.empty()) ex = "0";
                if (!action.gatedCondition.empty())
                  ex = "(" + action.gatedCondition + ") ? (uint64_t)(" + ex +
                       ") : s->" + comb_translator::sanitizeSignalName(sigName) +
                       "[" + std::to_string(wd) + "]";
                blk += "    s->" + sanT + "[" + std::to_string(wd) +
                       "] = (uint64_t)(" + ex + ");\n";
              }
              blk += "    }";
              SmallVector<NamedAttribute> f2;
              f2.push_back(NamedAttribute(StringAttr::get(ctx, "target"),
                                          StringAttr::get(ctx, "__RAW__")));
              f2.push_back(NamedAttribute(StringAttr::get(ctx, "expression"),
                                          StringAttr::get(ctx, blk)));
              f2.push_back(NamedAttribute(
                  StringAttr::get(ctx, "bitWidth"),
                  IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
              combAttrs.push_back(DictionaryAttr::get(ctx, f2));
              llvm::errs() << "  [WIDE-CONCAT SPLIT] " << sigName << " -> "
                           << nWords << " words\n";
              return;
            }
          }
        }
        // WIDE (>128-bit) drv whose value is a DYNAMIC SHIFT-LEFT of a
        // narrow value: `{'0, wdata} << (depth * InW)` — prim_packer_fifo's
        // accumulation lane.  Semantically "clear + insert at runtime
        // offset"; the old COMPLEX drop left csrng's 384-bit adata packer
        // empty (the DRBG seed never arrived).
        if (isComplexAction(action)) {
          unsigned dstW2 = drv.getValue().getType().isIntOrFloat()
                               ? drv.getValue().getType().getIntOrFloatBitWidth()
                               : 0;
          auto shl = drv.getValue().getDefiningOp<circt::comb::ShlOp>();
          if (dstW2 > 128 && shl) {
            Value narrow;
            unsigned nw = 0;
            if (auto cc2 = shl.getLhs().getDefiningOp<circt::comb::ConcatOp>()) {
              bool zerosOk = cc2.getNumOperands() >= 2;
              for (unsigned i2 = 0; zerosOk && i2 + 1 < cc2.getNumOperands();
                   ++i2) {
                auto k2 = cc2.getOperand(i2)
                              .getDefiningOp<circt::hw::ConstantOp>();
                if (!k2 || !k2.getValue().isZero()) zerosOk = false;
              }
              if (zerosOk) {
                narrow = cc2.getOperand(cc2.getNumOperands() - 1);
                if (auto nT = dyn_cast<IntegerType>(narrow.getType()))
                  nw = nT.getWidth();
              }
            }
            // Shift amount: often itself a WIDE zero-padded concat
            // (`{'0, depth_q, 5'b0}` = depth*32) — compose the effective
            // scalar from the non-constant fields at their LSB offsets.
            auto effScalar = [&](Value v) -> std::optional<std::string> {
              auto tr0 = comb_translator::translateValue(v, 12);
              if (tr0.success) return tr0.expr;
              auto ccv = v.getDefiningOp<circt::comb::ConcatOp>();
              if (!ccv) return std::nullopt;
              unsigned hi3 = v.getType().getIntOrFloatBitWidth();
              std::string acc3;
              for (Value o3 : ccv.getOperands()) {
                unsigned w3 = o3.getType().getIntOrFloatBitWidth();
                hi3 -= w3;
                if (auto k3 = o3.getDefiningOp<circt::hw::ConstantOp>()) {
                  if (k3.getValue().isZero()) continue;
                  return std::nullopt;
                }
                if (hi3 >= 64) return std::nullopt;
                auto t3 = comb_translator::translateValue(o3, 12);
                if (!t3.success) return std::nullopt;
                std::string piece3 = "((uint64_t)(" + t3.expr + ")" +
                                     (hi3 ? (" << " + std::to_string(hi3)) : "") +
                                     ")";
                acc3 = acc3.empty() ? piece3 : "(" + acc3 + " | " + piece3 + ")";
              }
              if (acc3.empty()) acc3 = "0";
              return acc3;
            };
            if (narrow && nw > 0 && nw <= 64) {
              auto valN = comb_translator::translateValue(narrow, 12);
              auto shEO = effScalar(shl.getRhs());
              struct { bool success; std::string expr; } shE{
                  shEO.has_value(), shEO.value_or("")};
              if (valN.success &&
                  valN.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos)
                valN.success = false;  // ghost name — keep pre-fix drop
              if (shE.success &&
                  shE.expr.find(comb_translator::kUnresolvedArgSentinel) != std::string::npos)
                shE.success = false;
              if (valN.success && shE.success) {
                unsigned nWords2 = (dstW2 + 63) / 64;
                std::string sanT2 =
                    comb_translator::sanitizeSignalName(sigName);
                std::string blk2 = "    { /* wide dyn-shl: " + sanT2 + " */\n";
                if (!action.gatedCondition.empty())
                  blk2 += "    if (" + action.gatedCondition + ") {\n";
                blk2 += "    unsigned _qpo = (unsigned)(" + shE.expr + ");\n";
                blk2 += "    memset(s->" + sanT2 + ", 0, sizeof(s->" + sanT2 +
                        "));\n";
                blk2 += "    qpw_wide_insert(s->" + sanT2 + ", " +
                        std::to_string(nWords2) + ", _qpo, " +
                        std::to_string(nw) + ", (uint64_t)(" + valN.expr +
                        "));\n";
                if (!action.gatedCondition.empty()) blk2 += "    }\n";
                blk2 += "    }";
                SmallVector<NamedAttribute> f3;
                f3.push_back(NamedAttribute(StringAttr::get(ctx, "target"),
                                            StringAttr::get(ctx, "__RAW__")));
                f3.push_back(NamedAttribute(StringAttr::get(ctx, "expression"),
                                            StringAttr::get(ctx, blk2)));
                f3.push_back(NamedAttribute(
                    StringAttr::get(ctx, "bitWidth"),
                    IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
                if (isSeq) seqAttrs.push_back(DictionaryAttr::get(ctx, f3));
                else combAttrs.push_back(DictionaryAttr::get(ctx, f3));
                llvm::errs() << "  [" << (isSeq ? "SEQ" : "COMB")
                             << " DYN-SHL] " << sigName << " = zext("
                             << comb_translator::brief(valN.expr) << ") << "
                             << comb_translator::brief(shE.expr, 60) << "\n";
                return;
              }
            }
          }
        }
        // GENERAL WIDE-DRIVE CHANNEL — last resort before the drop.
        //
        // The bespoke splitter far above serves exactly one shape: a
        // comb.concat whose >64-bit segments are PLAIN SIGNAL REFS.  Every
        // other wide value printed "[SPLIT bail]" and was then DELETED: hmac's
        // HMAC key padding (the segment is `key ^ ipad`, a comb.xor), keymgr's
        // 1152-bit ADVANCE message vector, csrng's 448-bit state-readout mux,
        // kmac's 192-bit packed halves.  That splitter is a weaker hand-rolled
        // copy of the bit-range router, which already knows how to serve ONE
        // 64-bit window of an arbitrary expression.  So stop demanding a
        // carrier for the whole value and ask the router once per destination
        // word — the storage is `uint64_t name[nWords]` regardless.
        //
        // Placed HERE, after every specialised channel has had its refusal, so
        // it can only ever convert a drop into code: anything already handled
        // returns before reaching this point and keeps its exact spelling.
        // `!slice.sliced` keeps it off partial-signal drives, whose word
        // indexing belongs to the Bug-G path, not here.
        // `!isSeq`: the seq tier stages ordinary registers into _qp_next_NAME
        // during the edge and commits afterwards, so writing s->NAME[wd]
        // directly from here would bypass that staging.  No sequential wide
        // drive reaches this channel today (all 17 recovered sites are
        // combinational), and the pre-existing wide-concat splitter above
        // carries the same restriction — keep them aligned rather than leave
        // a trap for the first seq case that shows up.
        if (isComplexAction(action) && !isSeq && !slice.sliced) {
          unsigned dstW = drv.getValue().getType().isIntOrFloat()
                              ? drv.getValue().getType().getIntOrFloatBitWidth()
                              : 0;
          if (dstW > 128) {
            unsigned nWords = (dstW + 63) / 64;
            std::string sanT = comb_translator::sanitizeSignalName(sigName);
            // Stage every word in a temporary, then store.  A wide value
            // may legitimately read its OWN target at a different word index
            // (`x = {x[..], new}`); storing word by word would make word 1's
            // expression see word 0's NEW value — a read-after-write hazard
            // inside a single assignment.  Nothing in the fleet does this
            // today; the two-phase form costs nothing and removes the class.
            std::string blk = "    { /* wide word channel: " + sanT + " */\n";
            std::string stores;
            bool ok = true;
            for (unsigned wd = 0; wd < nWords; ++wd) {
              unsigned take = std::min(64u, dstW - wd * 64);
              auto e = comb_translator::sliceValue(drv.getValue(),
                                                   (uint64_t)wd * 64, take, 12);
              if (!e.success) {
                // Name the word that beat us: a whole-drive drop reported
                // only by its final op is what made this family opaque for
                // so long.
                llvm::errs() << "  [WIDE-WORD bail] " << sigName << " word "
                             << wd << "/" << nWords << ": " << e.errorMsg
                             << "\n";
                ok = false;
                break;
              }
              std::string ex = e.expr;
              if (!action.gatedCondition.empty())
                ex = "(" + action.gatedCondition + ") ? (uint64_t)(" + ex +
                     ") : s->" + sanT + "[" + std::to_string(wd) + "]";
              std::string tmp = "_qpw" + std::to_string(wd);
              blk += "    uint64_t " + tmp + " = (uint64_t)(" + ex + ");\n";
              stores += "    s->" + sanT + "[" + std::to_string(wd) + "] = " +
                        tmp + ";\n";
            }
            if (ok) {
              blk += stores;
              blk += "    }";
              SmallVector<NamedAttribute> fw;
              fw.push_back(NamedAttribute(StringAttr::get(ctx, "target"),
                                          StringAttr::get(ctx, "__RAW__")));
              fw.push_back(NamedAttribute(StringAttr::get(ctx, "expression"),
                                          StringAttr::get(ctx, blk)));
              fw.push_back(NamedAttribute(
                  StringAttr::get(ctx, "bitWidth"),
                  IntegerAttr::get(IntegerType::get(ctx, 32), 0)));
              combAttrs.push_back(DictionaryAttr::get(ctx, fw));
              llvm::errs() << "  [COMB WIDE-WORD] " << sigName << " -> "
                           << nWords << " words\n";
              return;
            }
          }
        }

        // Skip if complex
        if (isComplexAction(action)) {
          llvm::errs() << "  [COMPLEX " << (isSeq ? "SEQ" : "COMB") << "] " << sigName << " (op: ";
          if (Operation *dbgOp = drv.getValue().getDefiningOp())
            llvm::errs() << dbgOp->getName();
          else
            llvm::errs() << "block-arg";
          llvm::errs() << ", w=" << (drv.getValue().getType().isIntOrFloat()
                            ? drv.getValue().getType().getIntOrFloatBitWidth() : 0) << ")\n";
          llvm::errs() << "    -> " << action.expression << "\n";
          return;
        }

        // Generate expression
        std::string expr;
        switch (action.type) {
          case ActionType::ASSIGN_CONST:
            expr = std::to_string(action.constValue);
            break;
          case ActionType::ASSIGN_SIGNAL:
            expr = "s->" + comb_translator::sanitizeSignalName(action.sourceSignal);
            break;
          case ActionType::COMPUTE:
            // Extract expression part from "target = expr"
            if (action.expression.find(" = ") != std::string::npos) {
              expr = action.expression.substr(action.expression.find(" = ") + 3);
            } else {
              expr = action.expression;
            }
            break;
          case ActionType::ACCUMULATE:
            // For accumulate, generate s->sig + step
            if (action.constValue >= 0) {
              expr = "s->" + comb_translator::sanitizeSignalName(sigName) +
                     " + " + std::to_string(action.constValue);
            } else {
              expr = "s->" + comb_translator::sanitizeSignalName(sigName) +
                     " - " + std::to_string(-action.constValue);
            }
            break;
          default:
            return;
        }

        if (!expr.empty()) {
          // If this drv targets a slice of a multi-bit sig, wrap the
          // expression as a read-modify-write of the base field so
          // multiple per-bit drvs to the same sig accumulate properly:
          //   target = sigName  (base, unchanged)
          //   expr   = (s->X & ~MASK) | (((value) & VALMASK) << OFFSET)
          // emit-c then runs each entry as `s->X = <expr>;`, and 13
          // such statements together rebuild the full vector.
          unsigned drvWidth = getSignalBitWidth(signal);
          std::string sanBase = comb_translator::sanitizeSignalName(sigName);
          // Bug G: wide-array sliced drv — track which 64-bit word the
          // assignment writes (and the corresponding self-ref string used
          // for the gating ternary's else-branch).
          int wideWriteWordIndex = -1;
          std::string wideWriteSelfRef;
          if (slice.sliced && slice.baseWidth > slice.width &&
              slice.baseWidth > 0 && slice.baseWidth <= 64) {
            // Hex masks built as 64-bit literals (the C compiler
            // narrows on assignment to the actual field type).
            uint64_t valMask =
                (slice.width >= 64) ? ~uint64_t(0)
                                    : ((uint64_t(1) << slice.width) - 1);
            uint64_t fieldMask = valMask << slice.offset;
            std::string hexFieldMask = llvm::utohexstr(fieldMask);
            std::string hexValMask = llvm::utohexstr(valMask);
            expr = "(s->" + sanBase + " & ~0x" + hexFieldMask + "ULL) | "
                   "(((" + expr + ") & 0x" + hexValMask + "ULL) << " +
                   std::to_string(slice.offset) + ")";
            // Emit width is the BASE width — we're rewriting the full sig.
            drvWidth = slice.baseWidth;
          } else if (slice.sliced && slice.baseWidth > slice.width &&
                     slice.baseWidth > 64 && slice.baseWidth <= 128) {
            // Wide-base sliced drv: use __uint128_t literals so the
            // bit-update mask shifts up to 128 bits without UB.
            // Required for spi_device's 73-bit addr_hit one-hot
            // decoder — without this, every per-bit drv overwrites
            // the entire signal and only the last assignment sticks
            // (the upstream pattern in the IR is `sig.extract i, drv
            // 1-bit value`, which under the legacy <=64-bit gate
            // collapsed to `addr_hit = (reg_addr == LAST)`).
            // C macro for the literal:
            //   ((__uint128_t)hi << 64) | (__uint128_t)lo
            // Build as two halves so we can spell each part as ULL.
            __uint128_t valMask = (slice.width >= 128)
                ? ~__uint128_t(0)
                : ((__uint128_t(1) << slice.width) - 1);
            __uint128_t fieldMask = valMask << slice.offset;
            auto wide = [](__uint128_t m) {
              uint64_t hi = (uint64_t)(m >> 64);
              uint64_t lo = (uint64_t)m;
              return "(((__uint128_t)0x" + llvm::utohexstr(hi) +
                     "ULL << 64) | (__uint128_t)0x" + llvm::utohexstr(lo) +
                     "ULL)";
            };
            expr = "(s->" + sanBase + " & ~" + wide(fieldMask) + ") | "
                   "(((__uint128_t)(" + expr + ") & " + wide(valMask) +
                   ") << " + std::to_string(slice.offset) + ")";
            drvWidth = slice.baseWidth;
          } else if (slice.sliced && slice.baseWidth > slice.width &&
                     slice.baseWidth > 128) {
            // Bug G: signals wider than 128 bits live as `uint64_t arr[N]`.
            // A sliced drv writes one 64-bit word at `slice.offset / 64`.
            // Slice must fit in a single word; cross-word slices are not
            // supported (but the OT register decoder pattern is per-bit
            // sliced drv, so width is typically 1 — always single-word).
            unsigned wordIdx   = slice.offset / 64;
            unsigned localOff  = slice.offset % 64;
            // For now require slice.width <= 64 - localOff (single word).
            if (slice.width > (64 - localOff)) {
              llvm::errs() << "  [WARN] sliced drv crosses 64-bit word "
                              "boundary (offset=" << slice.offset
                           << " width=" << slice.width
                           << "): emit may be incorrect\n";
            }
            uint64_t valMask = (slice.width >= 64)
                ? ~uint64_t(0)
                : ((uint64_t(1) << slice.width) - 1);
            uint64_t fieldMask = valMask << localOff;
            std::string hexFieldMask = llvm::utohexstr(fieldMask);
            std::string hexValMask = llvm::utohexstr(valMask);
            expr = "(s->" + sanBase + "[" + std::to_string(wordIdx) +
                   "] & ~0x" + hexFieldMask + "ULL) | "
                   "(((uint64_t)(" + expr + ") & 0x" + hexValMask + "ULL) << " +
                   std::to_string(localOff) + ")";
            // Wide-array writes target a single 64-bit word; pass that
            // wordIndex via the comb_logic attr so renderLogicAttr can emit
            // `s->X[wordIdx] = expr` rather than `s->X = expr`.
            wideWriteWordIndex = static_cast<int>(wordIdx);
            wideWriteSelfRef = "s->" + sanBase + "[" +
                                std::to_string(wordIdx) + "]";
            drvWidth = slice.baseWidth;
          }
          // Path-condition gating: the drv only fires if its enclosing
          // block's predecessor cf.cond_br took the true / false edge
          // that reaches it.  Wrap as `(cond ? new : old)` so multiple
          // drvs to the same sig from different conditional blocks
          // compose correctly — only the one whose condition is true
          // changes the field; others pass through unchanged.
          // sanBase is what we read for the "old" pass-through; for
          // sliced drvs the wrapper above already reads s->sanBase, so
          // wrapping again preserves the same field.
          if (!action.gatedCondition.empty()) {
            // Bug G: wide-array sliced drv self-ref is `s->X[wordIdx]`,
            // not `s->X`.  Use whichever was set by the slice branch.
            std::string selfRef = wideWriteSelfRef.empty()
                                      ? ("s->" + sanBase)
                                      : wideWriteSelfRef;
            expr = "((" + action.gatedCondition + ") ? (" + expr +
                   ") : " + selfRef + ")";
          }

          // Per-classification target list (only comb goes into the JSON
          // / ModuleCombLogic so existing log/json output is byte-stable).
          int seqDom = -1;
          if (!isSeq) {
            if (auto ownProc = drv->getParentOfType<llhd::ProcessOp>()) {
              auto ins = combProcDomain.try_emplace(
                  ownProc.getOperation(), (int)combProcDomain.size());
              seqDom = ins.first->second;
            }
            CombinationalAssignment combAssign;
            combAssign.targetSignal = sigName;
            combAssign.expression = expr;
            combAssign.bitWidth = drvWidth;
            combAssign.wordIndex = wideWriteWordIndex;
            combAssign.seqDomain = seqDom;
            moduleComb.assignments.push_back(combAssign);
          }

          // Build attribute entry for this drv
          std::string sanitizedTarget = comb_translator::sanitizeSignalName(sigName);
          SmallVector<NamedAttribute> fields;
          fields.push_back(NamedAttribute(
              StringAttr::get(ctx, "target"),
              StringAttr::get(ctx, sanitizedTarget)));
          fields.push_back(NamedAttribute(
              StringAttr::get(ctx, "expression"),
              StringAttr::get(ctx, expr)));
          fields.push_back(NamedAttribute(
              StringAttr::get(ctx, "bitWidth"),
              IntegerAttr::get(IntegerType::get(ctx, 32), drvWidth)));
          // Bug G: wide-array sliced drv selects a 64-bit word index.
          if (wideWriteWordIndex >= 0) {
            fields.push_back(NamedAttribute(
                StringAttr::get(ctx, "wordIndex"),
                IntegerAttr::get(IntegerType::get(ctx, 32),
                                 wideWriteWordIndex)));
          }
          if (seqDom >= 0) {
            fields.push_back(NamedAttribute(
                StringAttr::get(ctx, "seqDomain"),
                IntegerAttr::get(IntegerType::get(ctx, 32), seqDom)));
          }

          // Phase 1: propagate drv_class onto seq entries so emit-c (Phase
          // 2.c) can route ACCUMULATE → ptimer (already wired) and
          // UNCHANGED/COMPLEX → tick().  Only seq carries this — comb
          // doesn't need routing so we keep its schema unchanged.
          if (isSeq) {
            if (auto cls = drv->getAttrOfType<StringAttr>("qemu.drv_class")) {
              fields.push_back(NamedAttribute(
                  StringAttr::get(ctx, "drv_class"), cls));
            }
          }

          if (isSeq)
            seqAttrs.push_back(DictionaryAttr::get(ctx, fields));
          else
            combAttrs.push_back(DictionaryAttr::get(ctx, fields));

          llvm::errs() << "  [" << (isSeq ? "SEQ" : "COMB") << "] " << sigName
                       << " = " << comb_translator::brief(expr) << "\n";
        }
      };

      // EXECUTION-order collection, precise form.  Plain RPO was a blunt
      // instrument: in an if/else diamond whose taken-arm jumps straight
      // back to the wait loop (a back edge), DFS finishes that arm first
      // and RPO pushes it LAST — the reset arm of digest_mode_flag_q ended
      // up overwriting the normal arm and the whole SHA core ran in None
      // mode.  What last-write-wins ACTUALLY requires is only this: if
      // block A can reach block B in the SAME activation (back edges cut,
      // since an activation stops at llhd.wait), A's drvs must be emitted
      // before B's.  Mutually-unreachable blocks (exclusive branches) keep
      // their textual order — the order every existing device was
      // validated under.  Constraint = acyclic reachability; tie-break =
      // textual order; i.e. a stable Kahn sort.
      auto collectRegionDrvsExecOrder = [](Region &region,
                                           SmallVectorImpl<llhd::DriveOp> &outv) {
        if (region.empty())
          return;
        SmallVector<Block *> blocks;
        llvm::DenseMap<Block *, unsigned> idx;
        for (Block &b : region) {
          idx[&b] = blocks.size();
          blocks.push_back(&b);
        }
        const unsigned n = blocks.size();
        // DFS from entry marking back edges (target on current stack).
        enum : uint8_t { White, Grey, Black };
        SmallVector<uint8_t> color(n, White);
        SmallVector<SmallVector<unsigned, 4>> dagSucc(n);
        SmallVector<std::pair<unsigned, unsigned>, 16> stk;  // (node, succIdx)
        color[0] = Grey;
        stk.push_back({0, 0});
        while (!stk.empty()) {
          auto &top = stk.back();
          Block *b = blocks[top.first];
          unsigned nsucc = std::distance(b->succ_begin(), b->succ_end());
          if (top.second < nsucc) {
            Block *s = *std::next(b->succ_begin(), top.second++);
            unsigned si = idx[s];
            if (color[si] == Grey)
              continue;  // back edge: cut (next activation, not this one)
            dagSucc[top.first].push_back(si);
            if (color[si] == White) {
              color[si] = Grey;
              stk.push_back({si, 0});
            }
          } else {
            color[top.first] = Black;
            stk.pop_back();
          }
        }
        // Reachability closure over the DAG (blocks are few; bitset DP in
        // reverse finish order would be finer, simple O(V*E) BFS is fine).
        SmallVector<llvm::SmallPtrSet<Block *, 8>> reach(n);
        for (unsigned i = 0; i < n; ++i) {
          SmallVector<unsigned, 8> bfs{i};
          llvm::SmallPtrSet<Block *, 8> &ri = reach[i];
          while (!bfs.empty()) {
            unsigned b = bfs.pop_back_val();
            for (unsigned s : dagSucc[b])
              if (ri.insert(blocks[s]).second)
                bfs.push_back(s);
          }
        }

        // TEXTUAL order is the baseline — it is what every shipped device
        // was validated under, and reordering unrelated targets broke the
        // byte-identical gate.  Only a SAME-SIGNAL drv pair where the
        // textually-later block executes FIRST (its block reaches the
        // earlier one) is re-ordered, within the group's own slots.
        SmallVector<llhd::DriveOp> textual;
        for (Block &b : region)
          for (Operation &op : b)
            if (auto d = dyn_cast<llhd::DriveOp>(&op))
              textual.push_back(d);
        llvm::MapVector<Value, SmallVector<unsigned, 4>> groups;
        for (unsigned i = 0; i < textual.size(); ++i)
          groups[textual[i].getSignal()].push_back(i);
        SmallVector<llhd::DriveOp> result(textual.begin(), textual.end());
        for (auto &g : groups) {
          auto &slots = g.second;
          if (slots.size() < 2)
            continue;
          SmallVector<unsigned, 4> ord(slots.begin(), slots.end());
          std::stable_sort(ord.begin(), ord.end(),
                           [&](unsigned a, unsigned b2) {
            Block *ba = textual[a]->getBlock();
            Block *bb2 = textual[b2]->getBlock();
            if (ba == bb2)
              return a < b2;
            bool aReachesB = reach[idx[ba]].count(bb2);
            bool bReachesA = reach[idx[bb2]].count(ba);
            if (aReachesB && !bReachesA)
              return true;   // a executes first
            if (bReachesA && !aReachesB)
              return false;  // b executes first
            return a < b2;   // exclusive branches: textual order
          });
          for (unsigned k = 0; k < slots.size(); ++k)
            result[slots[k]] = textual[ord[k]];
        }
        for (llhd::DriveOp d : result)
          outv.push_back(d);
      };

      SmallVector<llhd::DriveOp> orderedDrvs;
      for (Operation &op : hwMod.getBodyBlock()->getOperations()) {
        if (auto procOp = dyn_cast<llhd::ProcessOp>(&op))
          collectRegionDrvsExecOrder(procOp.getBody(), orderedDrvs);
        else if (auto d0 = dyn_cast<llhd::DriveOp>(&op))
          orderedDrvs.push_back(d0);
        else
          op.walk([&](llhd::DriveOp d1) { orderedDrvs.push_back(d1); });
      }
      for (llhd::DriveOp drv : orderedDrvs)
        processDrv(drv);

      // Set attribute on this hw.module (not on ModuleOp!)
      if (!combAttrs.empty()) {
        hwMod->setAttr("qemu.comb_logic", ArrayAttr::get(ctx, combAttrs));
        llvm::errs() << "  -> Added qemu.comb_logic with " << combAttrs.size() << " entries\n";
      }
      // Phase 1: also publish sequential drvs.  emit-c will (in a later
      // commit) consume this attribute to generate a tick() function.
      // For now this is purely additive — no .c output changes yet.
      if (!seqAttrs.empty()) {
        hwMod->setAttr("qemu.seq_logic", ArrayAttr::get(ctx, seqAttrs));
        llvm::errs() << "  -> Added qemu.seq_logic with " << seqAttrs.size() << " entries\n";
      }

      // Collect for JSON output
      if (!moduleComb.assignments.empty()) {
        totalAssignments += moduleComb.assignments.size();
        allModules.push_back(std::move(moduleComb));
      }
    });

    // Summary
    llvm::errs() << "\n";
    llvm::errs() << "----------------------------------------\n";
    llvm::errs() << "Summary:\n";
    llvm::errs() << "  Modules with comb logic: " << allModules.size() << "\n";
    llvm::errs() << "  Total assignments: " << totalAssignments << "\n";
    llvm::errs() << "----------------------------------------\n";

    qemu_passes::writePassReport(
        "comb_logic_extract",
        [&](llvm::raw_ostream &os) {
          os << "Combinational Logic Extraction — summary\n";
          os << "========================================\n";
          os << "Modules with comb logic: " << allModules.size() << "\n";
          os << "Total assignments:       " << totalAssignments << "\n\n";
          os << "-- Per-module breakdown --\n";
          for (const auto &m : allModules)
            os << "  " << m.moduleName << ": "
               << m.assignments.size() << " assignment(s)\n";
        });

    // Output: Save as JSON to results folder (per-module grouped format).
    // Gated by --no-reports via PassReports::g_reportsEnabled so users can
    // opt out of all `results/common/default/generation/` artefacts with one flag.
    if (!allModules.empty() && qemu_passes::g_reportsEnabled) {
      // Ensure results directory exists
      llvm::sys::fs::create_directories("results/common/default/generation");

      std::string resultsPath = "results/common/default/generation/comb_logic_extract.json";
      std::error_code EC;
      llvm::raw_fd_ostream outFile(resultsPath, EC);

      if (!EC) {
        outFile << "{\n";
        outFile << "  \"modules\": [\n";

        for (size_t m = 0; m < allModules.size(); ++m) {
          const auto &modComb = allModules[m];
          outFile << "    {\n";
          outFile << "      \"module\": \"" << escapeJsonString(modComb.moduleName) << "\",\n";
          outFile << "      \"combinational_logic\": [\n";

          for (size_t i = 0; i < modComb.assignments.size(); ++i) {
            const auto &assign = modComb.assignments[i];
            std::string sanitizedTarget = comb_translator::sanitizeSignalName(assign.targetSignal);
            outFile << "        {\n";
            outFile << "          \"target\": \"" << escapeJsonString(sanitizedTarget) << "\",\n";
            outFile << "          \"expression\": \"" << escapeJsonString(assign.expression) << "\",\n";
            outFile << "          \"bitWidth\": " << assign.bitWidth << ",\n";
            outFile << "          \"c_code\": \"s->" << escapeJsonString(sanitizedTarget)
                    << " = " << escapeJsonString(assign.expression) << ";\"\n";
            outFile << "        }";
            if (i < modComb.assignments.size() - 1) {
              outFile << ",";
            }
            outFile << "\n";
          }

          outFile << "      ]\n";
          outFile << "    }";
          if (m < allModules.size() - 1) {
            outFile << ",";
          }
          outFile << "\n";
        }

        outFile << "  ]\n";
        outFile << "}\n";
        llvm::errs() << "\nJSON output written to: " << resultsPath << "\n";
      } else {
        llvm::errs() << "\nWarning: Could not write JSON to " << resultsPath
                     << ": " << EC.message() << "\n";
      }
    }

    // NOTE: We do NOT set any attribute on the top-level ModuleOp
    // Each hw.module now has its own qemu.comb_logic attribute

    // AN UNGATED GUARDED WRITE IS A WRONG ANSWER, SO STOP.
    if (g_pathCondRefused) {
      mod.emitError("comb-logic-extract: a drive's path condition could not "
                    "be resolved; emitting the write ungated would make a "
                    "guarded RAM write unconditional.  See the "
                    "[PATH-COND FAIL] line above.");
      signalPassFailure();
      return;
    }
  }
};

} // anonymous namespace
