//===- tool_main.cpp - QEMU Passes Driver ---------------------------------===//
//
// Driver for QEMU conversion passes:
// 1. clock-signal-detection - Detect and mark clock signals (two-level)
// 2. drv-classification - Classify drv operations
// 3. CSE (MLIR builtin) - Common subexpression elimination for deduplication
// 4. clock-drv-removal - Remove filterable clock topology
// 5. hw-flatten-io (CIRCT builtin, recursive) - Flatten struct module ports
// 6. lower-value-structs + explode-struct-sigs + lower-value-structs - Eliminate
//                       all hw.struct operations and struct-typed llhd.sig
// 7. tlul-control-inference / functional-bus-txn-infer - Bus transaction analysis
// 8. comb-logic-extract - Extract combinational logic for QEMU update_state()
// 9. qemu-emit-c - Emit QEMU device C code from annotated IR
//
// forward-constrain is NOT part of --all-passes (explicit two-stage tool).
//
// Usage:
//   qemu-passes input.mlir --clock-signal-detection
//   qemu-passes input.mlir --drv-classification
//   qemu-passes input.mlir --clock-drv-removal
//   qemu-passes input.mlir --forward-constrain --fc-target-signal=pwrite
//   qemu-passes input.mlir --forward-constrain --fc-target-signal=pwrite \
//                          --fc-apply-constraints --fc-bus-signals=psel,penable
//   qemu-passes input.mlir --comb-logic-extract
//   qemu-passes input.mlir --qemu-emit-c
//   qemu-passes input.mlir --all-passes -o output.mlir
//
// Note: forward-constrain is NOT part of --all-passes. It is a two-stage
// analysis+elimination pass; invoke it explicitly with the signal names you
// want to analyze and/or eliminate.
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"  // For func dialect
#include "mlir/Transforms/Passes.h"  // For CSE pass

#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/WithColor.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/raw_ostream.h"

#include "PassReports.h"
#include "BackendBlueprint.h"
#include "RTLAdapter.h"

#include <chrono>

// CIRCT Dialects
#include "circt/Dialect/HW/HWDialect.h"
#include "circt/Dialect/HW/HWPasses.h"    // createFlattenIO(FlattenIOOptions)
#include "circt/Dialect/SV/SVDialect.h"
#include "circt/Dialect/Comb/CombDialect.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/Seq/SeqDialect.h"
#include "circt/Dialect/LLHD/LLHDDialect.h"
#include "circt/Dialect/LLHD/LLHDOps.h"

// TableGen 生成的 Pass 声明
#define GEN_PASS_DECL_CLOCKSIGNALDETECTION
#define GEN_PASS_DECL_DRVCLASSIFICATION
#define GEN_PASS_DECL_CLOCKDRVREMOVAL
#define GEN_PASS_DECL_FORWARDCONSTRAIN
#define GEN_PASS_DECL_TLULCONTROLINFERENCE
#define GEN_PASS_DECL_FUNCTIONALBUSTXNINFER
#define GEN_PASS_DECL_COMBLOGICEXTRACT
#define GEN_PASS_DECL_LOWERVALUESTRUCTS
#define GEN_PASS_DECL_EXPLODESTRUCTSIGS
#define GEN_PASS_DECL_PROCESSLOOPUNROLL
#define GEN_PASS_DECL_QEMUEMITC
#define GEN_PASS_DECL_BACKENDCHARDEVDETECT
#define GEN_PASS_DECL_BACKENDBINDINGLOAD
#define GEN_PASS_DECL_BUSPROFILELOAD
#define GEN_PASS_DECL_BUSPROFILERESOLVE
#define GEN_PASS_DECL_ACCUMULATERINGDETECT
#include "Passes.h.inc"

// Forward declarations for pass creation functions

using namespace mlir;

//===----------------------------------------------------------------------===//
// Importer cast-residue folding
//===----------------------------------------------------------------------===//

// circt-verilog occasionally leaves a pair of unrealized_conversion_casts that
// round-trip a value through an unlowered frontend (moore) type — e.g.
// i16 -> !moore.array<2 x l8> -> !hw.array<2xi8> — where it failed to insert
// an implicit SystemVerilog conversion.  When source and destination carry the
// same bit count the pair is a pure reinterpretation: fold it to hw.bitcast
// (or nothing when the types already match).  Any residue that does NOT fold
// this way is rejected loudly — it would otherwise reach a pass as an opaque
// value and fail in a far less debuggable place.

// See the comment at the use site in foldImporterCastResidue: rewrite
// get(bitcast(src))[k] into bitcast(extract(src, k*W, W)).  Exposed as a
// standalone helper because the shape is BORN at two different times — the
// importer emits some directly, and ExplodeStructSigs manufactures many more
// when it splits whole-array drvs into per-element ones — so it must run
// again mid-pipeline after the explosion.
static void foldGetOfBitcast(ModuleOp module) {
  SmallVector<circt::hw::ArrayGetOp> gets;
  module.walk([&](circt::hw::ArrayGetOp g) { gets.push_back(g); });
  for (circt::hw::ArrayGetOp g : gets) {
    auto idxC = g.getIndex().getDefiningOp<circt::hw::ConstantOp>();
    auto bc = g.getInput().getDefiningOp<circt::hw::BitcastOp>();
    if (!idxC || !bc)
      continue;
    int64_t elemW = circt::hw::getBitWidth(g.getType());
    int64_t srcW = circt::hw::getBitWidth(bc.getInput().getType());
    if (elemW <= 0 || srcW <= 0)
      continue;
    uint64_t off = idxC.getValue().getZExtValue() * (uint64_t)elemW;
    if (off + elemW > (uint64_t)srcW)
      continue;
    OpBuilder builder(g);
    Value srcInt = bc.getInput();
    if (!isa<IntegerType>(srcInt.getType()))
      srcInt = builder.create<circt::hw::BitcastOp>(
          g.getLoc(), builder.getIntegerType(srcW), srcInt);
    Value slice = builder.create<circt::comb::ExtractOp>(
        g.getLoc(), builder.getIntegerType(elemW), srcInt, (int32_t)off);
    Value repl = slice;
    if (g.getType() != slice.getType())
      repl = builder.create<circt::hw::BitcastOp>(g.getLoc(), g.getType(),
                                                  slice);
    g.getResult().replaceAllUsesWith(repl);
    g.erase();
  }
}

// Lift PURE value-producing scf.if into comb.mux: when both arms are a
// single block of side-effect-free ops ending in scf.yield of one value,
// hoist the arm bodies above the if (unconditional evaluation of pure
// combinational logic is semantics-preserving) and replace the if with a
// mux.  The importer lowers SV unique-case inside functions/always_comb to
// scf.if trees, which every downstream translator treats as an opaque root
// (aes_shift_rows' byte-rotate came out as a dead self-assign).  Innermost
// ifs lift first across fixed-point rounds, so nested trees collapse fully.
static void liftPureScfIf(ModuleOp module) {
  bool changed = true;
  unsigned lifted = 0;
  while (changed) {
    changed = false;
    SmallVector<mlir::scf::IfOp> ifs;
    module.walk([&](mlir::scf::IfOp o) { ifs.push_back(o); });
    for (mlir::scf::IfOp ifOp : ifs) {
      if (ifOp.getNumResults() != 1 ||
          !isa<IntegerType>(ifOp.getResult(0).getType()))
        continue;
      auto pure = [](Region &r) {
        if (!r.hasOneBlock())
          return false;
        for (Operation &op : r.front().without_terminator()) {
          if (op.getNumRegions())
            return false;
          if (isa<circt::llhd::DriveOp>(op))
            return false;
        }
        return isa<mlir::scf::YieldOp>(r.front().getTerminator());
      };
      if (ifOp.getElseRegion().empty() || !pure(ifOp.getThenRegion()) ||
          !pure(ifOp.getElseRegion()))
        continue;
      Block &tb = ifOp.getThenRegion().front();
      Block &eb = ifOp.getElseRegion().front();
      Value tv = cast<mlir::scf::YieldOp>(tb.getTerminator()).getOperand(0);
      Value ev = cast<mlir::scf::YieldOp>(eb.getTerminator()).getOperand(0);
      Block *host = ifOp->getBlock();
      host->getOperations().splice(Block::iterator(ifOp),
                                   tb.getOperations(), tb.begin(),
                                   std::prev(tb.end()));
      host->getOperations().splice(Block::iterator(ifOp),
                                   eb.getOperations(), eb.begin(),
                                   std::prev(eb.end()));
      OpBuilder builder(ifOp);
      Value mux = builder.create<circt::comb::MuxOp>(
          ifOp.getLoc(), ifOp.getCondition(), tv, ev);
      ifOp.getResult(0).replaceAllUsesWith(mux);
      ifOp.erase();
      ++lifted;
      changed = true;
    }
  }
  if (lifted)
    llvm::errs() << "[scf-lift] lifted " << lifted
                 << " pure scf.if into comb.mux\n";
}

struct FoldGetOfBitcastPass
    : public PassWrapper<FoldGetOfBitcastPass, OperationPass<ModuleOp>> {
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(FoldGetOfBitcastPass)
  void runOnOperation() override { foldGetOfBitcast(getOperation()); }
  StringRef getArgument() const final { return "qp-fold-get-of-bitcast"; }
  StringRef getDescription() const final {
    return "Rewrite constant array_get over bitcast into comb.extract";
  }
};

static LogicalResult foldImporterCastResidue(ModuleOp module) {
  SmallVector<UnrealizedConversionCastOp> foldable;
  module.walk([&](UnrealizedConversionCastOp outer) {
    if (outer.getNumOperands() != 1 || outer.getNumResults() != 1)
      return;
    auto inner =
        outer.getOperand(0).getDefiningOp<UnrealizedConversionCastOp>();
    if (!inner || inner.getNumOperands() != 1 || inner.getNumResults() != 1)
      return;
    if (!isa<OpaqueType>(inner.getResult(0).getType()))
      return;
    Type srcTy = inner.getOperand(0).getType();
    Type dstTy = outer.getResult(0).getType();
    int64_t srcW = circt::hw::getBitWidth(srcTy);
    int64_t dstW = circt::hw::getBitWidth(dstTy);
    auto srcArr = dyn_cast<circt::hw::ArrayType>(srcTy);
    bool sameWidth = srcW > 0 && srcW == dstW;
    bool stripDim = srcArr && srcArr.getElementType() == dstTy;
    if (!sameWidth && !stripDim)
      return;
    foldable.push_back(outer);
  });
  for (UnrealizedConversionCastOp outer : foldable) {
    auto inner =
        outer.getOperand(0).getDefiningOp<UnrealizedConversionCastOp>();
    Value src = inner.getOperand(0);
    Type dstTy = outer.getResult(0).getType();
    Value repl = src;
    if (src.getType() != dstTy) {
      OpBuilder builder(outer);
      auto srcArr = dyn_cast<circt::hw::ArrayType>(src.getType());
      if (srcArr && srcArr.getElementType() == dstTy) {
        // Outer dimension stripped: the importer's encoding of an
        // outer-index-0 element get (non-zero indices select the row first).
        unsigned idxW = std::max(
            1u, llvm::Log2_64_Ceil(std::max<uint64_t>(
                    srcArr.getNumElements(), 2)));
        auto zero = builder.create<circt::hw::ConstantOp>(
            outer.getLoc(), builder.getIntegerType(idxW), 0);
        repl = builder.create<circt::hw::ArrayGetOp>(outer.getLoc(), src,
                                                     zero);
      } else {
        repl =
            builder.create<circt::hw::BitcastOp>(outer.getLoc(), dstTy, src);
      }
    }
    outer.getResult(0).replaceAllUsesWith(repl);
    outer.erase();
    if (inner.use_empty())
      inner.erase();
  }

  // Single casts between registered hw types — two importer shapes:
  //   a) same bit count: a pure reinterpretation → hw.bitcast (pinmux's
  //      i224 -> array<16xpad_attr>, the control-fsm wrappers' i16 ->
  //      array<2xi8>).
  //   b) array<N x E> -> E, i.e. the outer dimension stripped: the
  //      importer's encoding of an outer-index-0 element get on a
  //      multi-dimensional packed array (the non-zero-index form selects
  //      the row first, so index 0 is the only one encoded this way) →
  //      hw.array_get [0].
  {
    SmallVector<UnrealizedConversionCastOp> singles;
    module.walk([&](UnrealizedConversionCastOp c) {
      if (c.getNumOperands() == 1 && c.getNumResults() == 1 &&
          !isa<OpaqueType>(c.getOperand(0).getType()) &&
          !isa<OpaqueType>(c.getResult(0).getType()))
        singles.push_back(c);
    });
    for (UnrealizedConversionCastOp c : singles) {
      Value src = c.getOperand(0);
      Type srcTy = src.getType(), dstTy = c.getResult(0).getType();
      OpBuilder builder(c);
      Value repl;
      int64_t srcW = circt::hw::getBitWidth(srcTy);
      int64_t dstW = circt::hw::getBitWidth(dstTy);
      auto srcArr = dyn_cast<circt::hw::ArrayType>(srcTy);
      if (srcTy == dstTy) {
        repl = src;
      } else if (srcW > 0 && srcW == dstW) {
        repl = builder.create<circt::hw::BitcastOp>(c.getLoc(), dstTy, src);
      } else if (srcArr && srcArr.getElementType() == dstTy) {
        unsigned idxW = std::max(
            1u, llvm::Log2_64_Ceil(std::max<uint64_t>(
                    srcArr.getNumElements(), 2)));
        auto zero = builder.create<circt::hw::ConstantOp>(
            c.getLoc(), builder.getIntegerType(idxW), 0);
        repl = builder.create<circt::hw::ArrayGetOp>(c.getLoc(), src, zero);
      } else {
        continue;   // unknown shape — leave it; downstream stays loud
      }
      c.getResult(0).replaceAllUsesWith(repl);
      c.erase();
    }
  }
  // Fold hw.array_get (constant index) over hw.array_concat.  The importer's
  // out-of-bounds guard pads an array with zero segments before indexing
  // (MooreToCore pushes the data segment first — operand 0 holds the LOWEST
  // indices — and the zero padding after).  A constant get lands in exactly
  // one segment; chase nested concats locally in one pass (a whole-module
  // fixed-point rescan here was quadratic and stalled pinmux/spi_device
  // regen for 10+ minutes).
  {
    SmallVector<circt::hw::ArrayGetOp> gets;
    module.walk([&](circt::hw::ArrayGetOp g) { gets.push_back(g); });
    for (circt::hw::ArrayGetOp g : gets) {
      auto idxC = g.getIndex().getDefiningOp<circt::hw::ConstantOp>();
      if (!idxC || !g.getInput().getDefiningOp<circt::hw::ArrayConcatOp>())
        continue;
      uint64_t idx = idxC.getValue().getZExtValue();
      Value cur = g.getInput();
      // Descend through nested concats until the index lands in a
      // non-concat segment.
      while (auto cat = cur.getDefiningOp<circt::hw::ArrayConcatOp>()) {
        uint64_t off = 0;
        Value seg;
        for (Value o : cat.getOperands()) {
          uint64_t segLen =
              cast<circt::hw::ArrayType>(o.getType()).getNumElements();
          if (idx < off + segLen) {
            seg = o;
            idx -= off;
            break;
          }
          off += segLen;
        }
        if (!seg)
          break;
        cur = seg;
      }
      if (cur == g.getInput())
        continue;
      OpBuilder builder(g);
      Value repl;
      uint64_t curLen =
          cast<circt::hw::ArrayType>(cur.getType()).getNumElements();
      if (curLen == 1 &&
          isa_and_nonnull<circt::hw::ArrayCreateOp>(cur.getDefiningOp())) {
        repl =
            cast<circt::hw::ArrayCreateOp>(cur.getDefiningOp()).getOperand(0);
      } else {
        unsigned idxW = std::max(
            1u, llvm::Log2_64_Ceil(std::max<uint64_t>(curLen, 2)));
        auto nIdx = builder.create<circt::hw::ConstantOp>(
            g.getLoc(), builder.getIntegerType(idxW), idx);
        repl = builder.create<circt::hw::ArrayGetOp>(g.getLoc(), cur, nIdx);
      }
      g.getResult().replaceAllUsesWith(repl);
      g.erase();
    }
  }

  // Rewrite get(bitcast) chains born at import time (see helper above).
  foldGetOfBitcast(module);

  auto walked = module.walk([&](Operation *op) -> WalkResult {
    for (Type t : op->getResultTypes())
      if (isa<OpaqueType>(t)) {
        op->emitError("unlowered frontend type survived import and does not "
                      "fold to a same-width bitcast: ")
            << t;
        return WalkResult::interrupt();
      }
    return WalkResult::advance();
  });
  return failure(walked.wasInterrupted());
}

//===----------------------------------------------------------------------===//
// Straight-line func.call inlining
//===----------------------------------------------------------------------===//

// The importer emits SystemVerilog package functions (aes_pkg::aes_transpose,
// prim_mubi_pkg::mubi4_*, tlul_pkg::extract_*) as func.func + func.call.  The
// bridge and comb translators see a call as an opaque root and SKIP the whole
// expression.  The generic MLIR inliner cannot help: llhd regions implement no
// DialectInlinerInterface, so it refuses every one of these call sites.  All
// such functions are single-block straight-line dataflow, so inline them
// directly: clone the body at the call site with arguments mapped, replace the
// call results with the mapped return operands.  Calls whose callee has
// control flow or nested regions are left alone (downstream stays as loud as
// before).  Runs to a fixed point so functions calling functions collapse too.
static void inlineStraightLineCalls(ModuleOp module) {
  SymbolTableCollection symbolTables;
  unsigned inlined = 0;
  bool changed = true;
  while (changed) {
    changed = false;
    SmallVector<func::CallOp> calls;
    module.walk([&](func::CallOp c) { calls.push_back(c); });
    for (func::CallOp call : calls) {
      auto callee = dyn_cast_or_null<func::FuncOp>(
          symbolTables.lookupNearestSymbolFrom(call, call.getCalleeAttr()));
      if (!callee || callee.getBody().empty() ||
          !callee.getBody().hasOneBlock())
        continue;
      Block &body = callee.getBody().front();
      auto ret = dyn_cast<func::ReturnOp>(body.getTerminator());
      if (!ret)
        continue;
      bool hasRegions = false;
      for (Operation &op : body.without_terminator())
        if (op.getNumRegions()) {
          hasRegions = true;
          break;
        }
      if (hasRegions)
        continue;
      OpBuilder builder(call);
      IRMapping map;
      for (auto [arg, operand] :
           llvm::zip(body.getArguments(), call.getOperands()))
        map.map(arg, operand);
      for (Operation &op : body.without_terminator()) {
        Operation *cloned = builder.clone(op, map);
        // Function-local llhd.sig names are only unique within their
        // function; two different callees both naming a local "out[k]"
        // collide after inlining into one module and the flattened state
        // fields overwrite each other (aes_ctr's ctr_we_o got clobbered by
        // rev-ordered data bytes).  Qualify each clone with the inline id.
        if (auto sg = dyn_cast<circt::llhd::SignalOp>(cloned))
          if (auto nm = sg.getName())
            sg.setNameAttr(StringAttr::get(
                module.getContext(),
                ("qpinl" + llvm::Twine(inlined) + "_" + *nm).str()));
      }
      for (auto [res, retVal] :
           llvm::zip(call.getResults(), ret.getOperands()))
        res.replaceAllUsesWith(map.lookupOrDefault(retVal));
      call.erase();
      ++inlined;
      changed = true;
    }
  }
  // Drop private functions that no longer have any uses.
  SmallVector<func::FuncOp> dead;
  module.walk([&](func::FuncOp f) {
    if (f.isPrivate() &&
        SymbolTable::symbolKnownUseEmpty(f.getSymNameAttr(), module))
      dead.push_back(f);
  });
  for (func::FuncOp f : dead)
    f.erase();
  if (inlined)
    llvm::errs() << "[func-inline] inlined " << inlined
                 << " straight-line calls, erased " << dead.size()
                 << " dead functions\n";
}

// Pass wrapper so the inliner can ALSO run mid-pipeline: functions whose
// bodies still contain loops at parse time (aes_rev_order_sp2v & co.) only
// become straight-line after ProcessLoopUnroll — the parse-time inline pass
// necessarily skips them, and an un-inlined call is an opaque root that
// kills the whole output bridge (aes_ctr's ctr_we_o fed the sparse-encoding
// checkers zeros and latched a fatal alert at reset).
struct InlineStraightCallsPass
    : public PassWrapper<InlineStraightCallsPass, OperationPass<ModuleOp>> {
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(InlineStraightCallsPass)
  void runOnOperation() override { inlineStraightLineCalls(getOperation()); }
  StringRef getArgument() const final { return "qp-inline-straight-calls"; }
  StringRef getDescription() const final {
    return "Inline single-block straight-line func.calls";
  }
};

//===----------------------------------------------------------------------===//
// Command line options
//===----------------------------------------------------------------------===//

static llvm::cl::opt<std::string> inputFilename(
    llvm::cl::Positional,
    llvm::cl::desc("<input .mlir>"),
    llvm::cl::Required);

static llvm::cl::opt<std::string> outputFilename(
    "o",
    llvm::cl::desc("Output file.  If unset, --all-passes writes to "
                   "results/common/default/generation/pipeline.mlir; other invocations print to stdout."),
    llvm::cl::value_desc("filename"),
    llvm::cl::init(""));

static llvm::cl::opt<bool> noReports(
    "no-reports",
    llvm::cl::desc("Disable per-pass results/common/default/generation/<name>.log report files"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> noForwardConstrain(
    "no-forward-constrain",
    llvm::cl::desc("Skip the auto-ForwardConstrain step inside --all-passes "
                   "(useful for debugging or when its constant folding "
                   "produces undesired results)"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runBusProfileLoad(
    "bus-profile-load",
    llvm::cl::desc("Load <peripheral>.bus.json and attach qemu.bus_profile "
                   "(requires --binding-path)"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runBusProfileResolve(
    "bus-profile-resolve",
    llvm::cl::desc("Resolve qemu.bus_profile transactions to drive sequences "
                   "(requires prior --bus-profile-load)"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> bindingPath(
    "binding-path",
    llvm::cl::desc("Path to <peripheral>.bus.json. When set, BusProfileLoad "
                   "is added before any other configured pass."),
    llvm::cl::value_desc("path"),
    llvm::cl::init(""));

static llvm::cl::opt<std::string> backendBindingPath(
    "backend-binding",
    llvm::cl::desc("Path to <peripheral>.binding.json (declarative backend "
                   "role binding). When set inside --all-passes, replaces the "
                   "OT auto-detector (BackendCharDevDetect) with the "
                   "BackendBindingLoad pass — they emit the same blueprints."),
    llvm::cl::value_desc("path"),
    llvm::cl::init(""));

static llvm::cl::opt<std::string> dumpIrDigestPath(
    "dump-ir-digest",
    llvm::cl::desc("Run the early preprocessing (clock removal + TLUL, structs "
                   "intact) then write a JSON IR digest (ports, prim_fifo_sync "
                   "instances, addr-decode offsets) to this path and exit. The "
                   "input for an AI/human to author a --backend-binding JSON."),
    llvm::cl::value_desc("path"),
    llvm::cl::init(""));

static llvm::cl::opt<bool> runClockDetection(
    "clock-signal-detection",
    llvm::cl::desc("Run clock signal detection pass"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runDrvClassification(
    "drv-classification",
    llvm::cl::desc("Run drv classification pass"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runClockDrvRemoval(
    "clock-drv-removal",
    llvm::cl::desc("Run clock drv removal pass"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runForwardConstrain(
    "forward-constrain",
    llvm::cl::desc("Run forward-constraint signal tracing pass"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> fcTargetSignal(
    "fc-target-signal",
    llvm::cl::desc("Target signal to trace forward (required by "
                   "--forward-constrain)"),
    llvm::cl::value_desc("name"),
    llvm::cl::init(""));

static llvm::cl::opt<bool> fcApplyConstraints(
    "fc-apply-constraints",
    llvm::cl::desc("After analysis, substitute --fc-bus-signals with "
                   "constants and canonicalize"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> fcBusSignals(
    "fc-bus-signals",
    llvm::cl::desc("Comma-separated signal names to constant-fold (requires "
                   "--fc-apply-constraints)"),
    llvm::cl::value_desc("name,name,..."),
    llvm::cl::init(""));

static llvm::cl::opt<bool> runTLULControlInference(
    "tlul-control-inference",
    llvm::cl::desc("Run TL-UL transaction inference pass (OpenTitan)"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runFunctionalBusTxnInfer(
    "functional-bus-txn-infer",
    llvm::cl::desc("Run functional bus transaction inference (field-name agnostic)"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> functionalTxnDumpPath(
    "dump-functional-txn",
    llvm::cl::desc("Path to dump functional transaction candidates (JSON)"),
    llvm::cl::value_desc("path"),
    llvm::cl::init(""));

static llvm::cl::opt<bool> runHWFlattenIO(
    "hw-flatten-io",
    llvm::cl::desc("Run CIRCT hw-flatten-io (flatten struct module ports)"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runLowerValueStructs(
    "lower-value-structs",
    llvm::cl::desc("Lower value-level hw.struct ops to comb.concat/extract"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runExplodeStructSigs(
    "explode-struct-sigs",
    llvm::cl::desc("Explode struct-typed llhd.sig into per-field scalar sigs"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runCombLogicExtract(
    "comb-logic-extract",
    llvm::cl::desc("Run combinational logic extraction pass"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> runQEMUEmitC(
    "qemu-emit-c",
    llvm::cl::desc("Run QEMU C code emission pass"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> qemuOutputDir(
    "qemu-output-dir",
    llvm::cl::desc("Output directory for generated QEMU C files"),
    llvm::cl::value_desc("dir"),
    llvm::cl::init("outputs/common/default/models"));

static llvm::cl::opt<bool> noLiveTargetPrune(
    "no-live-target-prune",
    llvm::cl::desc("Disable QEMUEmitC's comb_logic live-target reachability "
                   "filter; emit all comb_logic entries unfiltered "
                   "(legacy behaviour, useful for debugging)"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> deviceCatalogPath(
    "device-catalog",
    llvm::cl::desc("Project device catalog JSON; replaces the neutral generic catalog"),
    llvm::cl::value_desc("path"), llvm::cl::init(""));

static llvm::cl::opt<std::string> rtlAdapter(
    "rtl-adapter",
    llvm::cl::desc("Explicit RTL abstraction adapter: none or opentitan"),
    llvm::cl::init("none"));

static llvm::cl::opt<bool> runAllPasses(
    "all-passes",
    llvm::cl::desc("Run all six passes in order (includes CSE)"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> emitOutput(
    "emit-output",
    llvm::cl::desc("Emit the transformed MLIR output"),
    llvm::cl::init(false));

//===----------------------------------------------------------------------===//
// Main
//===----------------------------------------------------------------------===//

int main(int argc, char **argv) {
  llvm::InitLLVM y(argc, argv);

  llvm::cl::ParseCommandLineOptions(argc, argv,
      "QEMU Conversion Passes for LLHD IR\n\n"
      "Usage:\n"
      "  qemu-passes <input.mlir> --clock-signal-detection\n"
      "  qemu-passes <input.mlir> --drv-classification\n"
      "  qemu-passes <input.mlir> --clock-drv-removal\n"
      "  qemu-passes <input.mlir> --forward-constrain --fc-target-signal=<name>\n"
      "  qemu-passes <input.mlir> --comb-logic-extract\n"
      "  qemu-passes <input.mlir> --all-passes -o output.mlir\n"
  );

  // Create MLIR context and register dialects
  MLIRContext context;
  DialectRegistry registry;
  registry.insert<
    circt::hw::HWDialect,
    circt::sv::SVDialect,
    circt::comb::CombDialect,
    circt::seq::SeqDialect,
    circt::llhd::LLHDDialect,
    mlir::cf::ControlFlowDialect,
    mlir::func::FuncDialect
  ,
      mlir::scf::SCFDialect>();
  context.appendDialectRegistry(registry);
  context.loadAllAvailableDialects();
  // Accept unregistered (moore) types at parse time so importer cast residue
  // can be folded below instead of failing the parse outright.
  context.allowUnregisteredDialects(true);

  // Parse input file
  auto stamp = [start = std::chrono::steady_clock::now()](const char *what) {
    llvm::errs() << "[t] " << what << " +"
                 << std::chrono::duration_cast<std::chrono::seconds>(
                        std::chrono::steady_clock::now() - start)
                        .count()
                 << "s\n";
  };
  OwningOpRef<ModuleOp> module = parseSourceFile<ModuleOp>(inputFilename, &context);
  if (!module) {
    llvm::WithColor::error() << "Failed to parse input MLIR: " << inputFilename << "\n";
    return 1;
  }
  stamp("parsed");
  if (rtlAdapter != "none" && rtlAdapter != "opentitan") {
    llvm::WithColor::error() << "--rtl-adapter must be none or opentitan\n";
    return 1;
  }
  (*module)->setAttr("qemu.rtl_adapter", StringAttr::get(&context, rtlAdapter));
  llvm::errs() << "[rtl-adapter] " << rtlAdapter << "\n";

  // Fold same-width importer cast residue to hw.bitcast; reject anything else.
  if (failed(foldImporterCastResidue(*module)))
    return 1;
  stamp("cast-residue folded");

  // Inline straight-line package-function calls so downstream translators see
  // plain expressions instead of opaque func.call roots.
  inlineStraightLineCalls(*module);

  // Collapse the importer's scf.if value trees into comb.mux so translators
  // see plain dataflow (must run before inlining can happen a second time
  // mid-pipeline — a function body whose only region ops were pure scf.ifs
  // becomes inlinable straight-line code after this).
  liftPureScfIf(*module);
  inlineStraightLineCalls(*module);
  stamp("calls inlined");

  // --dump-ir-digest: run the early preprocessing (so structs are intact for
  // the wvalid tracer + the addr-decode is resolvable) then emit the JSON IR
  // digest and exit.  Standalone tool — the front half of the AI binding loop.
  if (!dumpIrDigestPath.empty()) {
    PassManager dpm(&context);
    dpm.addPass(createClockSignalDetection(
        [] { ClockSignalDetectionOptions o; o.bindingPath = backendBindingPath; return o; }()));
    dpm.addPass(createDrvClassification());
    dpm.addPass(createCSEPass());
    dpm.addPass(createClockDrvRemoval());
    dpm.addPass(createTLULControlInference());
    if (failed(dpm.run(*module))) {
      llvm::WithColor::error() << "dump-ir-digest: preprocessing failed\n";
      return 1;
    }
    qemu_passes::dumpIrDigest(*module, dumpIrDigestPath);
    return 0;
  }

  // If no pass flag was given, auto-select --all-passes as the default
  // (preserves the original behaviour where bare `qemu-passes input.mlir`
  // runs the full preprocessing pipeline).
  bool anyFlag = runBusProfileLoad || runBusProfileResolve ||
                 runClockDetection || runDrvClassification ||
                 runClockDrvRemoval || runHWFlattenIO ||
                 runLowerValueStructs || runExplodeStructSigs ||
                 runForwardConstrain || runTLULControlInference ||
                 runFunctionalBusTxnInfer || runCombLogicExtract ||
                 runQEMUEmitC || runAllPasses;
  if (!anyFlag) {
    llvm::outs() << "No pass specified. Running --all-passes by default.\n"
                 << "Pass the explicit flag (e.g. --all-passes) or --help for "
                    "options.\n\n";
    runAllPasses = true;
  }

  // Create PassManager
  PassManager pm(&context);
  pm.enableVerifier(true);

  // A declarative bus profile is an input to inference/folding/emission, not
  // a post-processing annotation.  Load it before the canonical all-passes
  // pipeline so every downstream pass sees the explicit mapping.
  const bool loadProfileBeforeAll =
      runAllPasses && (runBusProfileLoad || !bindingPath.empty());
  if (loadProfileBeforeAll) {
    BusProfileLoadOptions bplOpts;
    bplOpts.bindingPath = bindingPath;
    pm.addPass(createBusProfileLoad(bplOpts));
  }

  // --all-passes expands into the canonical preprocessing pipeline.  It is
  // no longer mutually exclusive with the individual pass flags: users can
  // combine e.g. `--all-passes --qemu-emit-c --qemu-output-dir=out` to run
  // preprocessing + C emission in a single invocation.  If both --all-passes
  // and an individual flag (like --drv-classification) are set, the
  // individual flag appends AFTER the --all-passes block.
  //
  // Note: forward-constrain is NOT part of --all-passes by design. It
  // requires a user-supplied target signal and is meant for explicit
  // two-stage invocation; it is only added when --forward-constrain is set.
  if (runAllPasses) {
    // func.call inlining happens right after parse (inlineStraightLineCalls
    // in main) — the generic MLIR inliner refuses to inline into llhd
    // regions (no DialectInlinerInterface), so we do it ourselves for the
    // straight-line package functions the importer produces.
    pm.addPass(createClockSignalDetection(
        [] { ClockSignalDetectionOptions o; o.bindingPath = backendBindingPath; return o; }()));
    pm.addPass(createDrvClassification());
    pm.addPass(createCSEPass());  // CSE before clock removal for deduplication
    pm.addPass(createClockDrvRemoval());
    // Fix 6 (P2): TLUL inference must run BEFORE struct elimination.
    // SignalNameTracer in TLULControlInferencePass walks hw.struct_extract
    // chains to reconstruct dotted signal names (e.g. "tl_i.a_valid").
    // After ExplodeStructSigs replaces those struct ops with per-field
    // llhd.sig + llhd.prb, the dotted name reconstruction breaks and TLUL
    // finds nothing.  TLUL is analysis-only (writes no IR attributes),
    // so reordering is safe.
    pm.addPass(createTLULControlInference());
    // Backend topology source: either the OT auto-detector OR a declarative
    // binding JSON (--backend-binding).  Both emit the SAME qemu.chardev_blueprint
    // / qemu.irq_blueprint attrs (via the shared builders), so downstream is
    // identical.  Must run BEFORE ExplodeStructSigs (the detector's
    // SignalNameTracer needs hw.struct_extract chains intact; same slot as TLUL).
    // Analysis-only.
    //
    // DECLARATION OVERRIDES DERIVATION; ABSENCE FALLS BACK TO IT.
    //
    // These two used to be mutually exclusive, so a binding that omitted a
    // block did not merely decline to declare it — it disabled the capability
    // outright, silently.  hmac, kmac, aes and keymgr have bindings with no
    // `irq` block, so no qemu.irq_blueprint was attached, so their shims
    // declared IbexIRQ pins, the board wired them to PLIC 166-168, and NOTHING
    // EVER DROVE THEM.  hmac's done interrupt could not arrive, and the three
    // hmac gate targets "passed" only because their verdict was `grep wfi`
    // over a log in which the firmware's own WAIT loop had printed one.
    //
    // Running the detector after the loader restores the intended
    // relationship: the binding says what it knows, the detector derives the
    // rest.  Every setAttr in the detector is guarded on the attribute being
    // absent, so a declaration always wins.
    if (!backendBindingPath.empty()) {
      BackendBindingLoadOptions bbOpts;
      bbOpts.bindingPath = backendBindingPath;
      pm.addPass(createBackendBindingLoad(bbOpts));
    }
    pm.addPass(createBackendCharDevDetect());
    // --- Struct-elimination stage ---
    // Order matters: hw-flatten-io cannot rewrite module bodies that contain
    // LLHD struct-typed operations.  So we first eliminate struct usage
    // *inside* module bodies (explode struct sigs + lower value struct ops),
    // which is enough for the comb-logic paths downstream passes actually
    // translate.  Module-signature-level struct (on hw.module ports,
    // hw.instance args, func.call / hw.output) is intentionally preserved;
    // LowerValueStructs defers rewriting those cases.
    pm.addPass(createExplodeStructSigs());
    // Unroll counted loops in llhd.process bodies before LowerValueStructs:
    // OT prim_tlul_socket_1n's response port mux is a `for (i in 0..N)
    // { if dso == i: drv tl_t_p, tl_u_i[N-1-i] }` loop whose `array_get`
    // index depends on the loop var, which CombTranslator can't translate
    // (non-constant index → COMPLEX → drv dropped).  Unrolling specialises
    // %i to literal constants so subsequent canonicalization folds the
    // chain into a clean dev_select_outstanding-keyed ternary.
    pm.addPass(createProcessLoopUnroll());
    // Fold array_get / struct_extract on the now-constant indices before
    // LowerValueStructs starts rewriting struct values to integer concats:
    // without this, CIRCT's array_get folder fires inside LowerValueStructs's
    // greedy driver after operand types have been partially lowered, hits
    // a type-mismatch assertion ("folder produced i66, expected struct").
    pm.addPass(mlir::createCanonicalizerPass());
    // Second inline round: function bodies that carried loops at parse time
    // are straight-line only after unrolling AND the canonicalizer's block
    // merging (unroll leaves a chain of cf.br-linked blocks, so the
    // single-block check fails right after unroll).
    pm.addPass(std::make_unique<InlineStraightCallsPass>());
    // Second struct/array-sig explosion: aggregate sigs indexed by a loop
    // induction variable (`llhd.sig.array_get %cmd_info[%i]` in an
    // always_comb `for`) could not be exploded before unrolling (dynamic
    // index).  Now that ProcessLoopUnroll turned the index into constants,
    // explode them too — otherwise the whole array<N x struct> sig is dropped
    // (spi_device's cmd_info never reached cmdparse/readcmd/upload).
    // Idempotent for sigs already exploded in the first pass.  NOTE: it must
    // run AFTER LowerValueStructs — before it, the rebuilt array_create of
    // struct_create operands trips LowerValueStructs' element-wise lowering
    // ("array_create requires all operands to have the same type").
    pm.addPass(createLowerValueStructs());
    pm.addPass(createCSEPass());
    // Canonicalize after struct elimination: folds the residual
    // `comb.extract(comb.concat(a, b, c), offset)` chains produced by
    // struct-to-bit lowering into direct operand references.  This gives
    // DrvClassification cleaner arithmetic patterns to match and shortens
    // the C expressions emitted by CombLogicExtract.
    pm.addPass(mlir::createCanonicalizerPass());
    pm.addPass(createExplodeStructSigs());
    pm.addPass(mlir::createCanonicalizerPass());
    // Re-classify drvs after struct elimination: per-field drvs created by
    // ExplodeStructSigs may match ACCUMULATE / LOOP_ITER patterns that the
    // struct-level parent never could.
    pm.addPass(createDrvClassification());
    // --- End struct-elimination stage ---
    // TLULControlInference moved up to before struct elimination — see Fix 6
    // comment above.  Only FunctionalBusTxnInfer (which doesn't depend on
    // struct field names) and CombLogicExtract remain here.
    pm.addPass(createFunctionalBusTxnInfer()); // Functional bus txn inference (fallback)
    // Route B — protocol-noise folding before comb logic gets translated to C.
    // ForwardConstrain auto-discovers its target signal from
    // qemu.functional_txns (written by FunctionalBusTxnInfer above) and its
    // bus-signal list from qemu.protocol_constraints (written by
    // TLULControlInference, when it identifies TL-UL traffic) or — when TLUL
    // stays silent and the OpenTitan adapter was explicitly selected — its noise default
    // below.  --no-forward-constrain skips this step.
    if (!noForwardConstrain) {
      ForwardConstrainOptions fcOpts;
      fcOpts.applyConstraints = true;
      // targetSignal and busSignals stay empty — ForwardConstrain's
      // auto-discover (route B) reads them from IR attributes
      // (qemu.functional_txns, qemu.protocol_constraints) and falls back to
      // the legacy TL-UL default only under the explicit OpenTitan adapter.
      pm.addPass(createForwardConstrain(fcOpts));
    }
    pm.addPass(createAccumulateRingDetect());
    pm.addPass(createCombLogicExtract());
  }

  // Individual pass flags always apply (on top of --all-passes if both set).
  // Bus-profile-load goes FIRST if scheduled, so qemu.bus_profile is in
  // place by the time any downstream pass (ForwardConstrain / BusProfileResolve)
  // looks for it.
  if (!loadProfileBeforeAll &&
      (runBusProfileLoad || (!bindingPath.empty() && !runAllPasses))) {
    BusProfileLoadOptions bplOpts;
    bplOpts.bindingPath = bindingPath;
    pm.addPass(createBusProfileLoad(bplOpts));
  }
  if (runClockDetection) {
    pm.addPass(createClockSignalDetection(
        [] { ClockSignalDetectionOptions o; o.bindingPath = backendBindingPath; return o; }()));
  }
  if (runDrvClassification) {
    pm.addPass(createDrvClassification());
  }
  if (runClockDrvRemoval) {
    pm.addPass(createClockDrvRemoval());
  }
  if (runHWFlattenIO) {
    circt::hw::FlattenIOOptions fopts;
    fopts.recursive = true;
    pm.addPass(circt::hw::createFlattenIO(fopts));
  }
  if (runLowerValueStructs) {
    pm.addPass(createLowerValueStructs());
  }
  if (runExplodeStructSigs) {
    pm.addPass(createExplodeStructSigs());
  }
  if (runForwardConstrain) {
    ForwardConstrainOptions opts;
    opts.targetSignal = fcTargetSignal;
    opts.applyConstraints = fcApplyConstraints;
    opts.busSignals = fcBusSignals;
    pm.addPass(createForwardConstrain(opts));
  }
  if (runTLULControlInference) {
    pm.addPass(createTLULControlInference());
  }
  if (runFunctionalBusTxnInfer) {
    pm.addPass(createFunctionalBusTxnInfer());
  }
  if (runCombLogicExtract) {
    pm.addPass(createAccumulateRingDetect());
    pm.addPass(createCombLogicExtract());
  }
  if (runQEMUEmitC) {
    QEMUEmitCOptions opts;
    opts.outputDir = qemuOutputDir;
    opts.deviceCatalog = deviceCatalogPath;
    opts.noLiveTargetPrune = noLiveTargetPrune;
    pm.addPass(createQEMUEmitC(opts));
  }
  if (runBusProfileResolve) {
    pm.addPass(createBusProfileResolve());
  }

  // Wire --no-reports to the shared PassReports toggle.  Passes check this
  // flag via qemu_passes::g_reportsEnabled before writing results/common/default/generation/*.log.
  qemu_passes::g_reportsEnabled = !noReports;

  // Run passes
  stamp("pipeline start");
  if (failed(pm.run(*module))) {
    llvm::WithColor::error() << "Pass execution failed\n";
    return 1;
  }
  stamp("pipeline done");

  // Decide where the transformed MLIR goes.
  // Priority:
  //   1. Explicit -o=<file>  -> that exact path.
  //   2. -o not set, --all-passes was run -> default to results/common/default/generation/pipeline.mlir
  //      so downstream --qemu-emit-c invocations can find it.
  //   3. -o not set, --all-passes NOT run -> print to stdout (classic).
  std::string resolvedOutput = outputFilename;
  bool writeToStdout = false;
  if (resolvedOutput.empty()) {
    if (runAllPasses) {
      (void)llvm::sys::fs::create_directories("results/common/default/generation");
      resolvedOutput = "results/common/default/generation/pipeline.mlir";
    } else {
      writeToStdout = true;
    }
  }

  if (writeToStdout) {
    llvm::outs() << "\n========================================\n";
    llvm::outs() << "Transformed LLHD IR:\n";
    llvm::outs() << "========================================\n\n";
    module->print(llvm::outs());
  } else {
    std::error_code ec;
    llvm::raw_fd_ostream os(resolvedOutput, ec, llvm::sys::fs::OF_Text);
    if (ec) {
      llvm::WithColor::error()
          << "Could not open output file " << resolvedOutput << ": "
          << ec.message() << "\n";
      return 1;
    }
    module->print(os);
    llvm::outs() << "\nOutput written to: " << resolvedOutput << "\n";
  }

  return 0;
}
