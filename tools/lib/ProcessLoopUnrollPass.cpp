//===- ProcessLoopUnrollPass.cpp - Unroll counted loops in llhd.process ===//
//
// Detects bounded `for (i = init; i < bound; i += step)` loops realised as
// cf.br/cf.cond_br inside an llhd.process body and unrolls them into
// straight-line CFG so downstream CombTranslator can see constant indices.
//
// Required because OT prim_tlul_socket_1n's response port mux is written as
// a counted loop with a conditional drv inside; without unrolling the
// bb-arg loop variable poisons array_get's index and the entire response
// path collapses to the err_resp default.
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"

#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"

#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_PROCESSLOOPUNROLL
#define GEN_PASS_DEF_PROCESSLOOPUNROLL
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

/// Information captured about a candidate counted loop, after the detector
/// has confirmed all required predecessors and terminator shapes.  All
/// values are normalised to `uint64_t`; the op-volume budget (see
/// kUnrollCloneOpCeiling) bounds the pass's own memory by iterations x
/// REGION ops — the quantity actually cloned.
struct CountedLoop {
  Block *header;
  Block *body;
  Block *exit;
  Block *initPred;   // first predecessor that supplies the init value
  SmallVector<Block *, 2> initPreds;  // ALL init predecessors (an always_comb
                                      // re-enters its loop after every wait,
                                      // so a header often has init edges from
                                      // both the entry and the post-wait block)
  Block *latchPred;  // predecessor that supplies arg + step
  uint64_t init;
  uint64_t step;
  uint64_t bound;
  uint64_t iterCount;  // (bound - init) / step
  unsigned argWidth;
  // Operands the header's exit edge passes to `exit` (chained loops: the
  // first loop's exit feeds the next loop's header init, e.g. pinmux
  // `^bb10(%c0_i32)`).  Forwarded by the last iteration's branch.
  SmallVector<Value, 2> exitOperands;
};

/// Return the constant value driven into the header's block argument by the
/// edge from `pred` (which is a cf.br whose successor is `header`).  Init
/// edges look like `cf.br header(%c0_i32 : i32)`; latch edges are handled
/// separately because they pass `comb.add %arg, %step` rather than a
/// constant.
static std::optional<uint64_t>
getInitFromBranch(Block *pred, Block *header) {
  Operation *term = pred->getTerminator();
  if (auto br = dyn_cast<cf::BranchOp>(term)) {
    if (br.getDest() != header) return std::nullopt;
    if (br.getOperands().size() != 1) return std::nullopt;
    if (auto c = br.getOperand(0).getDefiningOp<hw::ConstantOp>())
      return c.getValue().getZExtValue();
    return std::nullopt;
  }
  // `if (guard) for (...)` — the init edge is one side of a cf.cond_br
  // (the other side skips the loop entirely).
  if (auto cbr = dyn_cast<cf::CondBranchOp>(term)) {
    bool t = cbr.getTrueDest() == header, f = cbr.getFalseDest() == header;
    if (t == f) return std::nullopt;   // neither, or both (degenerate)
    OperandRange ops = t ? cbr.getTrueDestOperands() : cbr.getFalseDestOperands();
    if (ops.size() != 1) return std::nullopt;
    if (auto c = ops[0].getDefiningOp<hw::ConstantOp>())
      return c.getValue().getZExtValue();
  }
  return std::nullopt;
}

/// If the latch edge passes `comb.add %header_arg, <const>`, return the
/// constant step.  Otherwise nullopt.
static std::optional<uint64_t>
getStepFromBranch(Block *pred, Block *header, BlockArgument headerArg) {
  auto br = dyn_cast<cf::BranchOp>(pred->getTerminator());
  if (!br || br.getDest() != header) return std::nullopt;
  if (br.getOperands().size() != 1) return std::nullopt;
  Value v = br.getOperand(0);
  auto add = v.getDefiningOp<comb::AddOp>();
  if (!add || add.getNumOperands() != 2) return std::nullopt;
  Value lhs = add.getOperand(0), rhs = add.getOperand(1);
  // Accept either operand order.
  Value otherOp;
  if (lhs == headerArg) otherOp = rhs;
  else if (rhs == headerArg) otherOp = lhs;
  else return std::nullopt;
  if (auto c = otherOp.getDefiningOp<hw::ConstantOp>())
    return c.getValue().getZExtValue();
  return std::nullopt;
}

/// Match the header terminator `cf.cond_br <icmp ult|slt|ugt|sgt arg bound>,
/// body, exit`.  `slt` is accepted when the bound constant is non-negative
/// (the SV `for (int i = 0; i < N; i++)` idiom lowers to a signed i32 compare;
/// with init >= 0 it is equivalent to ult).  `ugt`/`sgt` are the DESCENDING
/// twins: `for (int i = N-1; i >= 0; i--)` lowers to `icmp sgt %i, -1`, and
/// rejecting them left every descending loop in the fleet un-unrolled — which
/// is not merely slower, it is WRONG (the induction variable degrades to 0, so
/// every iteration computes iteration 0).  prim_fifo_async's @gray2dec is
/// exactly this shape; its four drives were being dropped for it.  Those four
/// happen to cost nothing today — @prim_fifo_async* is replaced wholesale by a
/// FIFO organ, so its module body is never emitted — but the un-unrolled
/// descending loop is a general defect, not an spi_device one.
/// Returns (body, exit, bound, exit-edge operands, descending, signed,
/// predicate).
///
/// `eq` AND `ne` ARE NOT EXOTIC — THEY ARE WHAT A SINGLE-ITERATION LOOP
/// BECOMES.  CIRCT's own canonicalizer rewrites `x <u min+1` to `x == min`
/// (CombFolds.cpp), so `for (k = 0; k < 1; k++)` NECESSARILY arrives here as
/// `icmp eq`.  Refusing the predicate therefore refused a shape the compiler
/// upstream is guaranteed to produce, and the refusal was silent: the loop
/// stayed rolled and its induction variable became `s->_unknown_argN`, read
/// as 0.  keymgr is the fleet's one instance, and what it costs is in
/// `u_checks.rom_digest_vld_o` — the ROM digest validity feeding
/// CreatorRootKey.
static std::optional<std::tuple<Block *, Block *, uint64_t,
                                SmallVector<Value, 2>, bool, bool,
                                comb::ICmpPredicate>>
matchHeaderCondBr(Block *header, BlockArgument headerArg) {
  auto cbr = dyn_cast<cf::CondBranchOp>(header->getTerminator());
  if (!cbr) return std::nullopt;
  auto cmp = cbr.getCondition().getDefiningOp<comb::ICmpOp>();
  if (!cmp) return std::nullopt;
  bool isUlt = cmp.getPredicate() == comb::ICmpPredicate::ult;
  bool isSlt = cmp.getPredicate() == comb::ICmpPredicate::slt;
  bool isUgt = cmp.getPredicate() == comb::ICmpPredicate::ugt;
  bool isSgt = cmp.getPredicate() == comb::ICmpPredicate::sgt;
  bool isEq = cmp.getPredicate() == comb::ICmpPredicate::eq;
  bool isNe = cmp.getPredicate() == comb::ICmpPredicate::ne;
  if (!isUlt && !isSlt && !isUgt && !isSgt && !isEq && !isNe)
    return std::nullopt;
  bool descending = isUgt || isSgt;
  bool isSigned = isSlt || isSgt;
  Value lhs = cmp.getOperand(0), rhs = cmp.getOperand(1);
  if (lhs != headerArg) return std::nullopt;
  auto bound = rhs.getDefiningOp<hw::ConstantOp>();
  if (!bound) return std::nullopt;
  // Ascending signed with a negative bound is an empty loop, not a pattern we
  // model.  Descending signed with a negative bound is the NORMAL case
  // (`i > -1`), so the guard must not apply there.
  if (isSlt && bound.getValue().isNegative()) return std::nullopt;
  Block *body = cbr.getTrueDest();
  Block *exit = cbr.getFalseDest();
  if (body == header || exit == header) return std::nullopt;
  // The body edge must not carry operands (we clone the body per iteration
  // and re-enter it with a plain branch).
  if (!cbr.getTrueDestOperands().empty()) return std::nullopt;
  SmallVector<Value, 2> exitOps(cbr.getFalseDestOperands().begin(),
                                cbr.getFalseDestOperands().end());
  // Exit operands must be loop-invariant: constants or values not defined
  // in the header (body-defined values are rejected in unrollLoop once the
  // body set is known).
  for (Value v : exitOps) {
    if (v == headerArg) return std::nullopt;
    if (auto arg = dyn_cast<BlockArgument>(v))
      if (arg.getOwner() == header) return std::nullopt;
    if (Operation *def = v.getDefiningOp())
      if (def->getBlock() == header) return std::nullopt;
  }
  return std::make_tuple(body, exit, bound.getValue().getZExtValue(), exitOps,
                         descending, isSigned, cmp.getPredicate());
}

/// Try to recognise `header` as a counted-loop entry.  Returns nullopt if
/// any required structural condition is unmet — caller leaves IR alone.
static constexpr uint64_t kUnrollBlockCap = 128;
static constexpr uint64_t kUnrollCloneOpCeiling = 16000000;

/// Blocks of a loop's body region.  Shared by both recognisers so the
/// volume they are judged on is the same quantity.
static llvm::SetVector<Block *>
collectBodyRegion(Block *body, Block *header, Block *exit) {
  llvm::SetVector<Block *> result;
  SmallVector<Block *, 8> worklist;
  worklist.push_back(body);
  while (!worklist.empty()) {
    Block *bb = worklist.pop_back_val();
    if (bb == header || bb == exit) continue;
    if (!result.insert(bb)) continue;
    Operation *term = bb->getTerminator();
    for (Block *succ : term->getSuccessors())
      worklist.push_back(succ);
    if (result.size() > kUnrollBlockCap) {
      result.clear();
      return result;
    }
  }
  return result;
}

/// Set when a loop is refused.  Refusing is a WRONG ANSWER, not a slower
/// path, so the pass must fail rather than emit a model.
static bool g_unrollRefused = false;

/// One volume decision for both recognisers.
///
/// Returns the region op count, or nullopt when the loop must be refused
/// (and prints why).  Two things had to change together here and neither
/// works alone:
///
///   THE QUANTITY.  This counted ops in the loop's FIRST BLOCK while the
///   unroller clones the whole body region — an understatement measured at
///   up to 1041x on this tree (pinmux: 94 first-block ops vs 2082 region
///   ops).  The old 400,000 ceiling only survived because of that error;
///   applied to the true quantity it would refuse pinmux's two large loops
///   and push the fleet straight into the gcc failure described below.
///
///   THE CEILING.  It used to be the current maximum plus headroom, which
///   is a treadmill: 16 -> 47 -> 64 -> 65 -> 200,000 -> 400,000, bumped
///   each time one more real design landed above it.  It is now derived
///   from a measured resource: the marginal cost of a cloned op is 207.9 B
///   (pinmux pass RSS 379,560 KB at a ceiling that refuses its 47-iteration
///   loop vs 891,964 KB at one that admits it, over 2,523,712 region ops).
///   A 4 GiB marginal budget per pass — the container cap is 15 GB and
///   regen runs 8-way — divided by 208 B/op is 20.6M; take 2^24.  When the
///   machine changes, re-measure those two numbers; do not bump this one.
///
/// REFUSING DOES NOT SAVE RESOURCES, IT MOVES THEM AND MULTIPLIES THEM.
/// Measured on pinmux: refusing its 126,289 loop grew the emitted C from
/// 28.1 MB to 57.6 MB, put 70 `_unknown_arg` references in it, and gcc with
/// the real QEMU flags was OOM-killed after 384 s at 14.5 GB.  Admitting it
/// costs 86 s and 1.2 GB.  There is no cliff on the high side to defend:
/// ceilings of 400,000 and 8,000,000 produce byte-identical output because
/// nothing in the fleet lives between them.
static std::optional<uint64_t>
checkUnrollVolume(uint64_t iters, Block *body, Block *header, Block *exit,
                  const char *site) {
  auto blocks = collectBodyRegion(body, header, exit);
  if (blocks.empty()) {
    llvm::errs() << "[process-loop-unroll] SKIP: " << site
                 << " loop body region exceeds " << kUnrollBlockCap
                 << " blocks (body will be emitted with an unresolved "
                    "induction variable)\n";
    g_unrollRefused = true;
    return std::nullopt;
  }
  uint64_t regionOps = 0;
  for (Block *bb : blocks)
    for (Operation &op : *bb) { (void)op; ++regionOps; }
  // Every counted loop's size, not only the ones that trip.  A threshold
  // whose distribution nobody has looked at is a guess — and this census
  // used to exist at ONE of the two sites, so 23 of the fleet's 215 loops
  // were missing from the distribution the ceiling was argued from.
  llvm::errs() << "[unroll-size] " << site << " " << iters << " iters x "
               << regionOps << " region ops (" << blocks.size()
               << " blocks) = " << (iters * regionOps) << "\n";
  if (iters * regionOps > kUnrollCloneOpCeiling) {
    llvm::errs() << "[process-loop-unroll] SKIP: " << site << " counted loop "
                 << iters << " iters x " << regionOps << " region ops = "
                 << (iters * regionOps) << " exceeds clone-op ceiling "
                 << kUnrollCloneOpCeiling
                 << " (refusing means every iteration is computed as "
                    "iteration 0 — this is a wrong answer, so the pass "
                    "fails rather than emit a model)\n";
    g_unrollRefused = true;
    return std::nullopt;
  }
  return regionOps;
}

static std::optional<CountedLoop>
detectCountedLoop(Block *header) {
  if (header->getNumArguments() != 1) return std::nullopt;
  auto headerArg = header->getArgument(0);
  auto intTy = dyn_cast<IntegerType>(headerArg.getType());
  if (!intTy) return std::nullopt;

  // Predecessors: exactly ONE latch (arg + const) and one or more init
  // edges, every one of which passes the SAME constant.  (An always_comb
  // process re-enters its counted loop after each llhd.wait, so the header
  // typically has an entry init edge and a post-wait init edge.)
  SmallVector<Block *, 4> preds;
  for (Block *p : header->getPredecessors()) preds.push_back(p);
  if (preds.size() < 2) return std::nullopt;

  Block *latchPred = nullptr;
  SmallVector<Block *, 2> initPreds;
  uint64_t init = 0, step = 0;
  bool haveInit = false;
  for (Block *p : preds) {
    if (auto st = getStepFromBranch(p, header, headerArg)) {
      if (latchPred) return std::nullopt;   // two latches: not a simple loop
      latchPred = p; step = *st;
      continue;
    }
    if (auto in = getInitFromBranch(p, header)) {
      if (haveInit && *in != init) return std::nullopt;  // inconsistent inits
      init = *in; haveInit = true;
      initPreds.push_back(p);
      continue;
    }
    return std::nullopt;   // some other kind of edge
  }
  if (!latchPred || initPreds.empty()) return std::nullopt;
  Block *initPred = initPreds.front();

  if (step == 0) return std::nullopt;

  auto m = matchHeaderCondBr(header, headerArg);
  if (!m) return std::nullopt;
  auto [body, exit, bound, exitOps, descending, isSigned, pred] = *m;

  unsigned aw = intTy.getWidth();
  auto sExt = [&](uint64_t v) -> int64_t {
    if (aw >= 64) return (int64_t)v;
    uint64_t sign = 1ull << (aw - 1);
    return (int64_t)((v ^ sign) - sign);
  };
  uint64_t iters;
  if (pred == comb::ICmpPredicate::eq) {
    // `while (k == bound)`.  The step is nonzero, so the body can run at most
    // once: exactly when the loop is entered with k already equal to bound.
    iters = (init == bound) ? 1 : 0;
  } else if (pred == comb::ICmpPredicate::ne) {
    // `while (k != bound)`.  Terminates only if bound is reachable from init
    // by whole steps in the step's own direction; otherwise it is not a
    // counted loop at all and must be refused OUT LOUD rather than silently.
    if (aw == 0 || aw > 64) return std::nullopt;
    int64_t sStep = sExt(step);
    int64_t sInit = isSigned ? sExt(init) : (int64_t)init;
    int64_t sBound = isSigned ? sExt(bound) : (int64_t)bound;
    int64_t delta = sBound - sInit;
    if (sStep == 0 || delta % sStep != 0 || delta / sStep < 0) {
      llvm::errs() << "[process-loop-unroll] SKIP: `!=` counted loop whose "
                      "bound is not reachable from init by whole steps (init="
                   << sInit << " bound=" << sBound << " step=" << sStep
                   << ") — leaving it rolled would compute every iteration as "
                      "iteration 0\n";
      g_unrollRefused = true;
      return std::nullopt;
    }
    iters = (uint64_t)(delta / sStep);
  } else if (!descending) {
    if (bound <= init) return std::nullopt;
    iters = (bound - init + step - 1) / step;
  } else {
    // `step` is the ZERO-EXTENDED wrap of a negative increment (i32 -1 arrives
    // as 0xFFFFFFFF), so recover its magnitude modulo the induction width.
    // The per-iteration constant at the unroll site is already materialised
    // as APInt(argWidth, init + i*step), and that wraps to init - i*|step| on
    // its own — only the TRIP COUNT needed the signed reading.
    if (aw == 0 || aw > 64) return std::nullopt;
    // Read the step SIGNED in the induction width: a descending loop's step
    // must actually be negative there.  A non-negative step under a `>`
    // predicate never terminates in hardware, so it is not a counted loop —
    // refuse rather than compute a trip count for a shape that cannot exist.
    int64_t sStep = sExt(step);
    if (sStep >= 0) return std::nullopt;
    uint64_t mag = (uint64_t)(-sStep);
    int64_t sInit = isSigned ? sExt(init) : (int64_t)init;
    int64_t sBound = isSigned ? sExt(bound) : (int64_t)bound;
    if (sInit <= sBound) return std::nullopt;
    iters = ((uint64_t)(sInit - sBound) + mag - 1) / mag;
  }
  // Iteration cap.  16 was too small for real IPs: pinmux's per-pad
  // retention-register loop has 47 iterations (NMioPads), spi_device's
  // socket/tpm loops 24/28.  A loop left un-unrolled is not "just slower":
  // the induction variable becomes `_unknown_arg0` (=0) in the emitted C
  // (every pad computed as pad 0 — WRONG) and the CFG-join resolver expands
  // the per-iteration path conditions into an O(N²) expression (pinmux:
  // two 30 MB single lines, ~30 min gcc).  Never reject silently.
  // The real constraint is EMITTED-CODE VOLUME, not the trip count: a
  // 65-iteration loop over a 20-op body is small, a 16-iteration loop
  // over a 10k-op body is not.  Budget = iterations x body ops.  (A
  // fixed trip cap kept needing to be bumped: 16 -> 47 for pinmux's
  // pads, 64 -> 65 for alert_handler's per-alert masks loop.)
  if (iters == 0) {
    // A zero-trip loop is a legitimate shape, and leaving it rolled is still
    // the iteration-0 wrong answer for anything the body feeds.  Rewriting the
    // header to branch straight to `exit` is the right handling; until that
    // exists, say so — the emitted `_unknown_arg` is caught by the fleet
    // audit rather than being invisible.
    llvm::errs() << "[process-loop-unroll] SKIP: counted loop with ZERO trips "
                    "(init=" << init << " bound=" << bound
                 << ", predicate not satisfiable at entry); the body stays "
                    "rolled with an unresolved induction variable\n";
    return std::nullopt;
  }
  if (!checkUnrollVolume(iters, body, header, exit, "block-arg"))
    return std::nullopt;

  CountedLoop loop;
  loop.header = header;
  loop.body = body;
  loop.exit = exit;
  loop.initPred = initPred;
  loop.initPreds = initPreds;
  loop.latchPred = latchPred;
  loop.init = init;
  loop.step = step;
  loop.bound = bound;
  loop.iterCount = iters;
  loop.argWidth = intTy.getWidth();
  loop.exitOperands = exitOps;
  return loop;
}

/// Collect every block reachable from `start` whose every successor stays
/// within the set (excluding the latch edge back to `header`).  This is
/// the "loop body region" we need to clone N times.  Bounded by depth +
/// size to avoid runaway on degenerate IR.
static llvm::SetVector<Block *>
collectLoopBodyBlocks(const CountedLoop &loop) {
  return collectBodyRegion(loop.body, loop.header, loop.exit);
}

/// Unroll the loop in place.  The original header / latchPred / body
/// blocks are removed; in their place we emit `iterCount` copies of the
/// body wired sequentially.  initPred is rewritten to branch into the
/// first iteration's entry; the last iteration's latch goes to `exit`.
static LogicalResult unrollLoop(const CountedLoop &loop) {
  // Figure out the parent region's block list so we know where to insert
  // cloned blocks.
  Region *region = loop.header->getParent();
  if (!region) return failure();

  // Snapshot the loop body region (everything reachable from `body`,
  // excluding `header`/`exit`).  We need every block here so the IRMapping
  // can re-target intra-body branches.
  llvm::SetVector<Block *> bodyBlocks = collectLoopBodyBlocks(loop);
  if (bodyBlocks.empty()) return failure();

  // Track the entry block of each iteration's clone (where the previous
  // iteration's latch should branch).
  SmallVector<Block *, 4> iterEntries;
  SmallVector<Block *, 4> iterLatches; // latch block (= cloned latchPred)

  // The latch block is just one of the bodyBlocks (the one whose terminator
  // branches back to `header`).  Identify it.
  Block *latchInBody = nullptr;
  for (Block *bb : bodyBlocks) {
    auto br = dyn_cast<cf::BranchOp>(bb->getTerminator());
    if (br && br.getDest() == loop.header) {
      if (latchInBody) return failure(); // multiple latches: bail
      latchInBody = bb;
    }
  }
  if (!latchInBody) return failure();

  // Exit-edge operands must not be defined inside the loop body.
  for (Value v : loop.exitOperands) {
    Block *defBlock = nullptr;
    if (auto arg = dyn_cast<BlockArgument>(v)) defBlock = arg.getOwner();
    else if (Operation *def = v.getDefiningOp()) defBlock = def->getBlock();
    if (defBlock && bodyBlocks.contains(defBlock)) return failure();
  }

  Operation *parentOp = region->getParentOp();
  (void)parentOp;

  for (uint64_t i = 0; i < loop.iterCount; ++i) {
    uint64_t iterValue = loop.init + i * loop.step;

    IRMapping mapping;

    // Emit a constant for this iteration's loop variable, in the IP just
    // before `loop.header`'s init predecessor's terminator.  We'll use
    // this constant to map the header block argument inside cloned ops.
    // Place the per-iteration constant at the top of the region's entry
    // block so it dominates the clones no matter which init edge enters.
    OpBuilder b(&region->front(), region->front().begin());
    auto constOp = b.create<hw::ConstantOp>(
        loop.header->getArgument(0).getLoc(),
        b.getIntegerType(loop.argWidth),
        static_cast<int64_t>(iterValue));
    mapping.map(loop.header->getArgument(0), constOp.getResult());

    // Clone every body block.  Insert clones immediately before the
    // header (keeps verifier happy and keeps post-pipeline dump readable).
    DenseMap<Block *, Block *> blockMap;
    for (Block *bb : bodyBlocks) {
      Block *clone = new Block();
      // Block args of body blocks (not header) — re-create them and map.
      for (BlockArgument arg : bb->getArguments()) {
        BlockArgument newArg = clone->addArgument(arg.getType(), arg.getLoc());
        mapping.map(arg, newArg);
      }
      region->getBlocks().insert(Region::iterator(loop.header), clone);
      blockMap[bb] = clone;
    }

    // THE HEADER MAY DEFINE VALUES THE BODY USES.
    //
    // Only the induction variable was mapped, so any other header-defined
    // value referenced from the body stayed pointing at the ORIGINAL header —
    // and erasing the header nulls that operand.  It is not hypothetical and
    // not exotic: CSE merges the header's `k == bound` with an identical
    // comparison in the body, so keymgr's single-iteration loop had its
    // body's `comb.mux` condition defined in the header.  The module then
    // failed verification with `null operand found` and a source location,
    // naming neither the loop nor the value.
    //
    // The header's non-terminator ops are pure functions of the induction
    // variable and of values from outside the loop, so cloning them into each
    // iteration ahead of the body — with the induction variable already bound
    // to this iteration's constant — is exact.
    {
      Block *entryClone = blockMap[loop.body];
      OpBuilder hb(entryClone, entryClone->begin());
      for (Operation &op : *loop.header) {
        if (op.hasTrait<mlir::OpTrait::IsTerminator>())
          continue;
        hb.clone(op, mapping);
      }
    }

    // Clone ops into their respective blocks; mapping handles SSA value
    // re-targeting for inter-block use-def edges.  APPEND (end(), not
    // begin()) so the header clones above stay ahead of the body.
    for (Block *bb : bodyBlocks) {
      Block *clone = blockMap[bb];
      OpBuilder cb(clone, clone->end());
      for (Operation &op : *bb) {
        cb.clone(op, mapping);
      }
    }

    // Re-target intra-clone branch successors — `Operation::clone` with
    // the IRMapping copies the *original* successor pointer, so we need
    // a second pass to fix it up against `blockMap`.
    for (Block *bb : bodyBlocks) {
      Block *clone = blockMap[bb];
      Operation *term = clone->getTerminator();
      for (unsigned s = 0; s < term->getNumSuccessors(); ++s) {
        Block *origSucc = term->getSuccessor(s);
        auto it = blockMap.find(origSucc);
        if (it != blockMap.end())
          term->setSuccessor(it->second, s);
      }
    }

    iterEntries.push_back(blockMap[loop.body]);
    iterLatches.push_back(blockMap[latchInBody]);
  }

  // Wire the iteration chain:
  //   initPred → iter[0].entry
  //   iter[i].latch → iter[i+1].entry  (just rewrite latch's br)
  //   iter[N-1].latch → exit
  for (Block *ip : loop.initPreds) {
    Operation *term = ip->getTerminator();
    OpBuilder b(term);
    if (auto br = dyn_cast<cf::BranchOp>(term)) {
      b.create<cf::BranchOp>(br.getLoc(), iterEntries[0], ValueRange{});
    } else {
      auto cbr = cast<cf::CondBranchOp>(term);
      bool t = cbr.getTrueDest() == loop.header;
      llvm::SmallVector<Value, 4> tOps(cbr.getTrueDestOperands());
      llvm::SmallVector<Value, 4> fOps(cbr.getFalseDestOperands());
      if (t) { tOps.clear(); } else { fOps.clear(); }
      b.create<cf::CondBranchOp>(cbr.getLoc(), cbr.getCondition(),
                                 t ? iterEntries[0] : cbr.getTrueDest(), tOps,
                                 t ? cbr.getFalseDest() : iterEntries[0], fOps);
    }
    term->erase();
  }
  for (uint64_t i = 0; i < loop.iterCount; ++i) {
    Block *latch = iterLatches[i];
    bool last = (i + 1 >= loop.iterCount);
    Block *next = last ? loop.exit : iterEntries[i + 1];
    auto term = latch->getTerminator();
    OpBuilder b(term);
    // The last iteration leaves the loop the way the header's exit edge
    // did — including its operands (chained-loop init values).
    b.create<cf::BranchOp>(term->getLoc(), next,
                           last ? ValueRange(loop.exitOperands) : ValueRange{});
    term->erase();
  }

  // Remove the original loop infrastructure.  Order matters: erase the
  // body blocks first (they reference header_arg via the mapping), then
  // the header itself.
  for (Block *bb : bodyBlocks) {
    bb->dropAllDefinedValueUses();
    bb->erase();
  }
  loop.header->dropAllDefinedValueUses();
  loop.header->erase();

  // Post-condition: no null operands.  Verification runs only at the end of
  // the pass, which gives a source location and nothing about WHICH unroll
  // produced it.
  for (Block &pbb : *region)
    for (Operation &pop : pbb)
      for (unsigned pi = 0; pi < pop.getNumOperands(); ++pi)
        if (!pop.getOperand(pi)) {
          llvm::errs() << "[process-loop-unroll] NULL OPERAND after unrolling "
                       << loop.iterCount << " iters: " << pop.getName()
                       << " operand #" << pi << "\n";
          return failure();
        }

  return success();
}

//===----------------------------------------------------------------------===//
// Signal-induction counted loops
//
// `for (int i = 0; i < N; i++)` inside an always block where `i` is a local
// variable lowers to a SIGNAL, not a block argument:
//   ^init:  %i = llhd.sig %c0 ; llhd.drv %i, %c0 ; cf.br ^hdr
//   ^hdr:   %v = llhd.prb %i ; %c = comb.icmp slt %v, %cN ; cf.cond_br %c, ^body, ^exit
//   ^body…: (uses llhd.prb %i) … ^latch: llhd.drv %i, add(prb %i, %c1) ; cf.br ^hdr
// (tlul_adapter_sram's byte-lane loops; the emitter otherwise sees a state
// field literally called `i`).  Unroll like the block-arg form: clone the body
// per iteration, replace every cloned `prb %i` with the iteration constant,
// drop the drvs to %i, and finally erase %i.
//===----------------------------------------------------------------------===//

struct SigCountedLoop {
  Block *header, *body, *exit, *initPred, *latchPred;
  Value sig;                 // the induction signal
  llhd::DriveOp initDrv, latchDrv;
  uint64_t init, step, bound, iterCount;
  unsigned width;
  SmallVector<Value, 2> exitOperands;
};

static std::optional<SigCountedLoop> detectSigCountedLoop(Block *header) {
  if (header->getNumArguments() != 0) return std::nullopt;
  auto cbr = dyn_cast<cf::CondBranchOp>(header->getTerminator());
  if (!cbr) return std::nullopt;
  auto cmp = cbr.getCondition().getDefiningOp<comb::ICmpOp>();
  if (!cmp) return std::nullopt;
  bool isUlt = cmp.getPredicate() == comb::ICmpPredicate::ult;
  bool isSlt = cmp.getPredicate() == comb::ICmpPredicate::slt;
  if (!isUlt && !isSlt) return std::nullopt;
  auto prb = cmp.getLhs().getDefiningOp<llhd::ProbeOp>();
  if (!prb || prb->getBlock() != header) return std::nullopt;
  Value sig = prb.getSignal();
  auto sigOp = sig.getDefiningOp<llhd::SignalOp>();
  if (!sigOp) return std::nullopt;
  auto inout = dyn_cast<llhd::RefType>(sig.getType());
  if (!inout) return std::nullopt;
  auto intTy = dyn_cast<IntegerType>(inout.getNestedType());
  if (!intTy || intTy.getWidth() > 64) return std::nullopt;
  auto boundC = cmp.getRhs().getDefiningOp<hw::ConstantOp>();
  if (!boundC) return std::nullopt;
  if (isSlt && boundC.getValue().isNegative()) return std::nullopt;
  // header must contain only: prb(s) of sig, the icmp, the terminator
  for (Operation &op : *header) {
    if (&op == cbr.getOperation() || &op == cmp.getOperation()) continue;
    if (auto p2 = dyn_cast<llhd::ProbeOp>(op)) { if (p2.getSignal() == sig) continue; }
    return std::nullopt;
  }
  Block *body = cbr.getTrueDest(), *exit = cbr.getFalseDest();
  if (body == header || exit == header) return std::nullopt;
  if (!cbr.getTrueDestOperands().empty()) return std::nullopt;

  SmallVector<Block *, 2> preds;
  for (Block *p : header->getPredecessors()) preds.push_back(p);
  if (preds.size() != 2) return std::nullopt;

  auto lastDrvTo = [&](Block *b) -> llhd::DriveOp {
    llhd::DriveOp last;
    for (Operation &op : *b)
      if (auto d = dyn_cast<llhd::DriveOp>(op))
        if (d.getSignal() == sig) last = d;
    return last;
  };
  auto asInit = [&](Block *b, uint64_t &v) -> llhd::DriveOp {
    if (!isa<cf::BranchOp>(b->getTerminator())) return nullptr;
    auto d = lastDrvTo(b);
    if (!d) return nullptr;
    auto c = d.getValue().getDefiningOp<hw::ConstantOp>();
    if (!c) return nullptr;
    v = c.getValue().getZExtValue();
    return d;
  };
  auto asLatch = [&](Block *b, uint64_t &st) -> llhd::DriveOp {
    if (!isa<cf::BranchOp>(b->getTerminator())) return nullptr;
    auto d = lastDrvTo(b);
    if (!d) return nullptr;
    auto add = d.getValue().getDefiningOp<comb::AddOp>();
    if (!add || add.getNumOperands() != 2) return nullptr;
    Value other;
    for (Value o : add.getOperands()) {
      if (auto p2 = o.getDefiningOp<llhd::ProbeOp>()) { if (p2.getSignal() == sig) continue; }
      other = o;
    }
    auto c = other ? other.getDefiningOp<hw::ConstantOp>() : nullptr;
    if (!c) return nullptr;
    st = c.getValue().getZExtValue();
    return d;
  };
  SigCountedLoop L;
  uint64_t v0 = 0, st = 0;
  if ((L.initDrv = asInit(preds[0], v0)) && (L.latchDrv = asLatch(preds[1], st))) {
    L.initPred = preds[0]; L.latchPred = preds[1];
  } else if ((L.initDrv = asInit(preds[1], v0)) && (L.latchDrv = asLatch(preds[0], st))) {
    L.initPred = preds[1]; L.latchPred = preds[0];
  } else return std::nullopt;
  if (st == 0) return std::nullopt;
  uint64_t bound = boundC.getValue().getZExtValue();
  if (bound <= v0) return std::nullopt;
  uint64_t iters = (bound - v0 + st - 1) / st;
  if (iters == 0) return std::nullopt;
  if (!checkUnrollVolume(iters, body, header, exit, "signal-IV"))
    return std::nullopt;
  L.header = header; L.body = body; L.exit = exit; L.sig = sig;
  L.init = v0; L.step = st; L.bound = bound; L.iterCount = iters; L.width = intTy.getWidth();
  L.exitOperands.assign(cbr.getFalseDestOperands().begin(), cbr.getFalseDestOperands().end());
  for (Value v : L.exitOperands) {
    if (Operation *def = v.getDefiningOp())
      if (def->getBlock() == header) return std::nullopt;
  }
  return L;
}

static LogicalResult unrollSigLoop(SigCountedLoop loop) {
  auto fail = [&](llvm::StringRef reason) -> LogicalResult {
    llvm::StringRef sigName = "<unnamed>";
    if (auto sigOp = loop.sig.getDefiningOp<llhd::SignalOp>())
      if (auto name = sigOp.getName())
        sigName = *name;
    llvm::errs() << "[process-loop-unroll] signal-IV unroll rejected for '"
                 << sigName << "': " << reason << "\n";
    return failure();
  };
  Region *region = loop.header->getParent();
  if (!region) return fail("header has no parent region");
  // Body region — the SHARED collector, with the shared cap.
  //
  // This path used to re-implement the walk with its own bare limit of 64
  // while the recogniser had already admitted the loop under
  // kUnrollBlockCap = 128.  A region of 65..128 blocks was therefore accepted
  // and then refused here, and the refusal was the quietest kind in the pass:
  // `return failure()` with no message, after which the driver merely printed
  // "leaving loop intact".  Worse than the block-arg path's version of the
  // same mistake, because a signal induction variable degrades WITHOUT
  // producing `_unknown_argN` — the IV is an llhd.sig mapped to a real state
  // field, so nothing in the emitted C looks wrong and no instrument sees it.
  llvm::SetVector<Block *> bodyBlocks =
      collectBodyRegion(loop.body, loop.header, loop.exit);
  if (bodyBlocks.empty()) {
    llvm::errs() << "[process-loop-unroll] SKIP: signal-IV loop body region "
                    "exceeds " << kUnrollBlockCap << " blocks\n";
    g_unrollRefused = true;
    return fail("body region is empty or exceeds block cap");
  }
  if (!bodyBlocks.contains(loop.latchPred))
    return fail("latch block is outside collected body region");
  // The induction sig must be private to the loop: drvs = {init, latch};
  // prbs in header/body only.  CIRCT also emits a module-level probe solely
  // to place the local induction signal in the enclosing process's llhd.wait
  // sensitivity list.  That is not a data use: after unrolling the signal is
  // static, so retaining the inert sensitivity entry is semantics-preserving.
  for (Operation *u : loop.sig.getUsers()) {
    if (u == loop.initDrv.getOperation() || u == loop.latchDrv.getOperation()) continue;
    if (auto probe = dyn_cast<llhd::ProbeOp>(u)) {
      if (u->getBlock() == loop.header || bodyBlocks.contains(u->getBlock()))
        continue;
      bool waitSensitivityOnly = true;
      for (Operation *probeUser : probe.getResult().getUsers())
        if (!isa<llhd::WaitOp>(probeUser)) {
          waitSensitivityOnly = false;
          break;
        }
      if (waitSensitivityOnly)
        continue;
    }
    llvm::errs() << "[process-loop-unroll] external induction-signal user: ";
    u->print(llvm::errs(), OpPrintingFlags().skipRegions());
    llvm::errs() << "\n";
    return fail("induction signal has a user outside the loop");
  }
  for (Value v : loop.exitOperands) {
    Block *defBlock = nullptr;
    if (auto arg = dyn_cast<BlockArgument>(v)) defBlock = arg.getOwner();
    else if (Operation *def = v.getDefiningOp()) defBlock = def->getBlock();
    if (defBlock && bodyBlocks.contains(defBlock))
      return fail("loop exit operand is defined inside the loop body");
  }

  SmallVector<Block *, 4> iterEntries, iterLatches;
  Location loc = loop.header->getTerminator()->getLoc();
  for (uint64_t i = 0; i < loop.iterCount; ++i) {
    uint64_t iterValue = loop.init + i * loop.step;
    IRMapping mapping;
    DenseMap<Block *, Block *> blockMap;
    for (Block *bb : bodyBlocks) {
      Block *clone = new Block();
      for (BlockArgument arg : bb->getArguments())
        mapping.map(arg, clone->addArgument(arg.getType(), arg.getLoc()));
      region->getBlocks().insert(Region::iterator(loop.header), clone);
      blockMap[bb] = clone;
    }
    for (Block *bb : bodyBlocks) {
      Block *clone = blockMap[bb];
      OpBuilder cb(clone, clone->begin());
      for (Operation &op : *bb) cb.clone(op, mapping);
    }
    for (Block *bb : bodyBlocks) {
      Operation *term = blockMap[bb]->getTerminator();
      for (unsigned si = 0; si < term->getNumSuccessors(); ++si) {
        auto it = blockMap.find(term->getSuccessor(si));
        if (it != blockMap.end()) term->setSuccessor(it->second, si);
      }
    }
    // Replace cloned probes of the induction sig with the iteration constant;
    // drop cloned drvs to it.
    for (Block *bb : bodyBlocks) {
      Block *clone = blockMap[bb];
      for (Operation &op : llvm::make_early_inc_range(*clone)) {
        if (auto p = dyn_cast<llhd::ProbeOp>(op)) {
          if (p.getSignal() != loop.sig) continue;
          OpBuilder b(p);
          Value c = b.create<hw::ConstantOp>(loc, b.getIntegerType(loop.width), (int64_t)iterValue);
          p.getResult().replaceAllUsesWith(c);
          p.erase();
        } else if (auto d = dyn_cast<llhd::DriveOp>(op)) {
          if (d.getSignal() == loop.sig) d.erase();
        }
      }
    }
    iterEntries.push_back(blockMap[loop.body]);
    iterLatches.push_back(blockMap[loop.latchPred]);
  }
  // Wire: init → iter0 ; iter[i] latch → iter[i+1] ; last → exit(+operands)
  {
    auto br = cast<cf::BranchOp>(loop.initPred->getTerminator());
    OpBuilder b(br);
    b.create<cf::BranchOp>(br.getLoc(), iterEntries[0], ValueRange{});
    br.erase();
    loop.initDrv.erase();
  }
  for (uint64_t i = 0; i < loop.iterCount; ++i) {
    Block *latch = iterLatches[i];
    bool last = (i + 1 >= loop.iterCount);
    Operation *term = latch->getTerminator();
    OpBuilder b(term);
    b.create<cf::BranchOp>(term->getLoc(), last ? loop.exit : iterEntries[i + 1],
                           last ? ValueRange(loop.exitOperands) : ValueRange{});
    term->erase();
  }
  for (Block *bb : bodyBlocks) { bb->dropAllDefinedValueUses(); bb->erase(); }
  loop.header->dropAllDefinedValueUses();
  loop.header->erase();
  if (loop.sig.use_empty())
    if (Operation *so = loop.sig.getDefiningOp()) so->erase();
  return success();
}

struct ProcessLoopUnrollPass
    : public ::impl::ProcessLoopUnrollBase<ProcessLoopUnrollPass> {
  void runOnOperation() override {
    // RESET THE REFUSAL FLAG.  It is a file static and the pass runs more than
    // once per generation, so without this a refusal in an earlier invocation
    // would fail a later, innocent one — and, worse, the flag surviving would
    // make the failure look like it belonged to whatever ran last.
    g_unrollRefused = false;
    ModuleOp mod = getOperation();

    unsigned unrolledCount = 0;
    // Counted loops live in llhd.process bodies AND in package functions
    // (`func.func` — e.g. spi_device_pkg::sram_strb2mask's byte-lane loop);
    // the translator inlines a func only once it is straight-line, so unroll
    // both.  Blocks left chained by plain branches are merged by the
    // canonicalizer that follows this pass.
    auto unrollRegion = [&](Region &region) {
      while (true) {
        std::optional<CountedLoop> found;
        std::optional<SigCountedLoop> foundSig;
        for (Block &bb : region.getBlocks()) {
          if (auto loop = detectCountedLoop(&bb)) { found = loop; break; }
          if (auto loop = detectSigCountedLoop(&bb)) { foundSig = loop; break; }
        }
        if (!found && !foundSig) break;
        LogicalResult r = found ? unrollLoop(*found) : unrollSigLoop(*foundSig);
        if (failed(r)) {
          // "Leaving the loop intact" is the iteration-0 wrong answer, and
          // the message did not even carry the SKIP token the census reads.
          // It also broke out of the rescan, abandoning every REMAINING loop
          // in this region — which no longer matters only because the pass
          // now fails.
          llvm::errs() << "[process-loop-unroll] SKIP: unroll failed after "
                          "the loop was accepted; leaving it rolled would "
                          "compute every iteration as iteration 0\n";
          g_unrollRefused = true;
          break;
        }
        ++unrolledCount;
      }
    };
    mod.walk([&](mlir::func::FuncOp fn) { if (!fn.getBody().empty()) unrollRegion(fn.getBody()); });
    // ONE WALKER.  This was a verbatim copy of unrollRegion, and the two
    // drifted: the block cap was 128 in one and 64 in the other for the same
    // concept, which is how the same bug came to exist twice.
    mod.walk([&](llhd::ProcessOp proc) { unrollRegion(proc.getBody()); });

    // REFUSING A LOOP IS A WRONG ANSWER, SO STOP.
    //
    // A refused loop keeps its induction variable as `_unknown_argN` (= 0),
    // so every iteration is computed as iteration 0 and the model builds and
    // runs anyway.  spi_device's 256-entry passthrough command filter died
    // exactly that way.  ExplodeStructSigsPass already sets the precedent:
    // when its iteration cap is hit it emits an error and fails the pass
    // rather than emitting a degraded model.  The SKIP line is printed
    // first, so audit_drops.py still counts the channel.
    if (g_unrollRefused) {
      mod.emitError("process-loop-unroll: refused to unroll a counted loop; "
                    "the emitted model would compute every iteration as "
                    "iteration 0.  See the preceding "
                    "[process-loop-unroll] diagnostic for the exact cause.");
      signalPassFailure();
      return;
    }

    if (unrolledCount > 0)
      llvm::errs() << "[process-loop-unroll] unrolled " << unrolledCount
                   << " counted loop(s)\n";
  }
};

} // namespace
