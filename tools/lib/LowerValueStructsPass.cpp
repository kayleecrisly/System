//===- LowerValueStructsPass.cpp - Lower SSA hw.struct ops to comb bits -===//
//
// Greedy pattern rewrite that eliminates all SSA value-level hw.struct
// operations by replacing them with comb-dialect bit operations:
//
//   hw.struct_create(a, b, c)  ->  comb.concat a, b, c      (MSB first)
//   hw.struct_extract %i["f"]  ->  comb.extract from N      (LSB-indexed)
//   hw.struct_explode %s       ->  one comb.extract per field
//   hw.aggregate_constant <struct>  ->  hw.constant <packed int>
//   hw.bitcast <int> -> <struct>    ->  fold through (RAUW)
//
// Struct-typed llhd.sig signals are NOT rewritten here; ExplodeStructSigs
// handles that.  Pipeline expects:
//     [lower-value-structs]  ->  [explode-struct-sigs]  ->  [lower-value-structs]
// so the struct_create / struct_extract pairs that ExplodeStructSigs emits
// get consumed on the second run.
//
// Bit layout convention: first declared field -> MSBs, last -> LSBs.  This
// matches comb.concat's operand ordering, so struct_create operands pass
// through in the same order.
//===----------------------------------------------------------------------===//

#include "PassReports.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/HW/HWTypes.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_LOWERVALUESTRUCTS
#define GEN_PASS_DEF_LOWERVALUESTRUCTS
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Helpers
//===----------------------------------------------------------------------===//

/// Sum of bit widths of all leaf (non-struct) fields, recursing through
/// nested structs.  Returns -1 if any leaf is not an IntegerType.
static int64_t computeFlatBitWidth(Type ty) {
  if (auto intTy = dyn_cast<IntegerType>(ty))
    return intTy.getWidth();
  if (auto structTy = dyn_cast<hw::StructType>(ty)) {
    int64_t total = 0;
    for (const auto &el : structTy.getElements()) {
      int64_t w = computeFlatBitWidth(el.type);
      if (w < 0)
        return -1;
      total += w;
    }
    return total;
  }
  return -1;
}

/// LSB-indexed bit offset of `fieldName` within `structTy`.  Returns
/// {offset, width}; width == 0 when the field is not found or any leaf is
/// non-integer (caller bails).
static std::pair<unsigned, unsigned>
fieldOffsetAndWidth(hw::StructType structTy, StringRef fieldName) {
  unsigned offset = 0;
  auto elements = structTy.getElements();
  for (auto it = elements.rbegin(); it != elements.rend(); ++it) {
    int64_t w = computeFlatBitWidth(it->type);
    if (w < 0)
      return {0, 0};
    if (it->name == fieldName)
      return {offset, static_cast<unsigned>(w)};
    offset += static_cast<unsigned>(w);
  }
  return {0, 0};
}

//===----------------------------------------------------------------------===//
// Patterns
//===----------------------------------------------------------------------===//

/// Returns true if any transitive user of `v` forces `v` to keep its struct
/// type.  Three kinds of such users exist:
///   1. Signature boundaries: hw.output, func.return, hw.instance — these
///      see module / function signatures that hw-flatten-io rewrites later.
///   2. Enclosing struct_create / struct_inject: if our result is a field
///      of a bigger struct that itself must stay struct-typed, we must too.
///   3. llhd.drv / llhd.wait whose signal/operand type is struct.
///
/// The check is shallow (1 hop through struct_create/inject), because the
/// greedy driver will revisit our op when the outer struct_create's guard
/// relaxes (never, if it's truly on a signature boundary).
static bool mustKeepStructType(Value v) {
  for (Operation *u : v.getUsers()) {
    // Signature-boundary ops: module output, function return/call, instance.
    if (isa<hw::OutputOp, func::ReturnOp, func::CallOp, hw::InstanceOp>(u))
      return true;
    // Enclosing struct operations propagate the guard: if the bigger struct
    // must stay struct-typed, our value (a field of it) must too.
    if (auto create = dyn_cast<hw::StructCreateOp>(u)) {
      if (mustKeepStructType(create.getResult()))
        return true;
    }
    if (auto inject = dyn_cast<hw::StructInjectOp>(u)) {
      if (mustKeepStructType(inject.getResult()))
        return true;
    }
    // LLHD timing-aware ops with struct-typed operands: Pass 2 handles
    // struct-typed llhd.sig, but if something still expects a struct
    // driven value or watches a struct signal, we defer.
    if (auto drv = dyn_cast<llhd::DriveOp>(u)) {
      if (isa<hw::StructType>(drv.getValue().getType()))
        return true;
    }
    if (auto wait = dyn_cast<llhd::WaitOp>(u)) {
      for (Value obs : wait.getObserved()) {
        if (obs == v && isa<hw::StructType>(obs.getType()))
          return true;
      }
    }
  }
  return false;
}

/// hw.struct_create(a, b, c) -> comb.concat a, b, c
///
/// Only fires when all operands are IntegerType (i.e. nested structs have
/// been lowered already) and the struct_create's result is NOT consumed by
/// a signature-boundary op.  Greedy driver will revisit as nested patterns
/// rewrite deeper levels.
struct StructCreateToConcat : OpRewritePattern<hw::StructCreateOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(hw::StructCreateOp op,
                                PatternRewriter &rw) const override {
    // Defer if the struct value crosses a signature boundary this pass
    // can't rewrite; hw-flatten-io will handle it later and a subsequent
    // --lower-value-structs run will fold any residue.
    if (mustKeepStructType(op.getResult()))
      return failure();

    // Ordering safety: let the field-level patterns consume struct_extract /
    // struct_explode users FIRST.  If we rewrite the create while such a
    // user still exists, that user is left holding an integer-typed operand
    // — and the greedy driver runs StructExtractOp's builtin folder before
    // any pattern, which cast<>s the operand to StructType and asserts.
    // (The old code relied on the driver's empirical visit order; hmac's
    // IR shape broke it.)  Each user rewrite re-enqueues this op, so we
    // always get another chance once they're gone.
    for (Operation *user : op->getUsers())
      if (isa<hw::StructExtractOp, hw::StructExplodeOp>(user))
        return failure();

    SmallVector<Value, 8> operands;
    int64_t totalW = 0;
    for (Value v : op.getInput()) {
      if (auto intTy = dyn_cast<IntegerType>(v.getType())) {
        totalW += intTy.getWidth();
        operands.push_back(v);
        continue;
      }

      // Packed arrays can be fields of a struct (keymgr_dpe's key slots are
      // the motivating case).  Flatten them at the same boundary instead of
      // waiting for an impossible all-integer intermediate struct_create.
      int64_t width = computeFlatBitWidth(v.getType());
      if (width <= 0)
        return failure();
      auto fieldIntTy = rw.getIntegerType(static_cast<unsigned>(width));
      operands.push_back(
          rw.create<hw::BitcastOp>(op.getLoc(), fieldIntTy, v).getResult());
      totalW += width;
    }
    auto intTy = rw.getIntegerType(static_cast<unsigned>(totalW));
    rw.replaceOpWithNewOp<comb::ConcatOp>(op, intTy, operands);
    return success();
  }
};

/// hw.struct_extract %wide["f"] -> comb.extract %wide from offset
///
/// Folds through a reachable hw.struct_create directly.  This is the only
/// path that fires in practice: hw.struct_extract requires struct-typed
/// input per its op definition, and the greedy driver's default visit
/// order consumes struct_extract ops via this pattern BEFORE
/// StructCreateToConcat rewrites the producing struct_create (verified
/// empirically on UART, gpio0, and the golden tests — zero firings of a
/// hypothetical "integer input" branch).  If the input is not struct-typed
/// or its producing op is not a struct_create (e.g. comes from llhd.prb on
/// a block argument or an opaque source), we return failure() and let
/// Pass 2 / later rewrites handle it.
struct StructExtractToBitExtract : OpRewritePattern<hw::StructExtractOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(hw::StructExtractOp op,
                                PatternRewriter &rw) const override {
    // Raw operand access: the ODS getter getInput() cast<>s to StructType
    // and ASSERTS on a transiently-lowered producer (hmac reaches one) —
    // the guard below must run before any typed accessor.
    Value input = op->getOperand(0);
    auto structTy = dyn_cast<hw::StructType>(input.getType());
    if (!structTy)
      return failure();
    auto create = input.getDefiningOp<hw::StructCreateOp>();
    if (!create)
      return failure();  // opaque struct source; wait for Pass 2 / later rewrites
    StringRef fieldName = op.getFieldNameAttr().getValue();
    for (auto [idx, el] : llvm::enumerate(structTy.getElements())) {
      if (el.name == fieldName) {
        rw.replaceOp(op, create.getInput()[idx]);
        return success();
      }
    }
    return failure();
  }
};

/// hw.struct_explode %s -> one comb.extract per field
///
/// Like StructExtractToBitExtract: supports both struct-typed input (fold
/// through struct_create) and integer input (after concat lowering).
struct StructExplodeLowering : OpRewritePattern<hw::StructExplodeOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(hw::StructExplodeOp op,
                                PatternRewriter &rw) const override {
    Value input = op->getOperand(0);   // raw: see StructExtractToBitExtract

    // Struct-typed input: fold through direct struct_create.
    if (auto structTy = dyn_cast<hw::StructType>(input.getType())) {
      auto create = input.getDefiningOp<hw::StructCreateOp>();
      if (!create)
        return failure();
      SmallVector<Value, 8> results(create.getInput());
      rw.replaceOp(op, results);
      return success();
    }

    // Integer input from a previously-lowered concat.
    if (auto concat = input.getDefiningOp<comb::ConcatOp>()) {
      SmallVector<Value, 8> results(concat.getInputs());
      if (results.size() != op.getNumResults())
        return failure();
      rw.replaceOp(op, results);
      return success();
    }

    return failure();
  }
};

/// hw.aggregate_constant <struct> -> hw.constant <packed integer>
///
/// Flattens a constant struct to a single integer constant with the same
/// bit pattern.  Only handles structs whose leaves are all IntegerType (or
/// nested structs of IntegerType, recursively).
struct AggregateConstantLowering
    : OpRewritePattern<hw::AggregateConstantOp> {
  using OpRewritePattern::OpRewritePattern;

  /// Recursively collapse an ArrayAttr-of-integer-ish attrs into a single
  /// APInt by concatenating (MSB-first per declaration order) per field.
  static std::optional<llvm::APInt> packAttr(Type ty, Attribute attr) {
    if (auto intTy = dyn_cast<IntegerType>(ty)) {
      if (auto intAttr = dyn_cast<IntegerAttr>(attr)) {
        // Normalize APInt width to the declared field width.
        auto v = intAttr.getValue();
        return v.zextOrTrunc(intTy.getWidth());
      }
      return std::nullopt;
    }
    if (auto structTy = dyn_cast<hw::StructType>(ty)) {
      auto arrAttr = dyn_cast<ArrayAttr>(attr);
      if (!arrAttr)
        return std::nullopt;
      auto elements = structTy.getElements();
      if (arrAttr.size() != elements.size())
        return std::nullopt;
      int64_t totalW = computeFlatBitWidth(structTy);
      if (totalW < 0)
        return std::nullopt;
      llvm::APInt result(static_cast<unsigned>(totalW), 0);
      unsigned shift = static_cast<unsigned>(totalW);
      for (auto [el, fieldAttr] : llvm::zip(elements, arrAttr)) {
        auto fieldVal = packAttr(el.type, fieldAttr);
        if (!fieldVal)
          return std::nullopt;
        unsigned w = fieldVal->getBitWidth();
        shift -= w;
        result |= fieldVal->zext(static_cast<unsigned>(totalW)) << shift;
      }
      return result;
    }
    return std::nullopt;
  }

  LogicalResult matchAndRewrite(hw::AggregateConstantOp op,
                                PatternRewriter &rw) const override {
    auto structTy = dyn_cast<hw::StructType>(op.getType());
    if (!structTy)
      return failure();  // only handle struct-typed aggregates
    if (mustKeepStructType(op.getResult()))
      return failure();  // hw-flatten-io has to fix the signature first
    int64_t totalW = computeFlatBitWidth(structTy);
    if (totalW < 0)
      return failure();  // non-integer leaf

    auto packed = packAttr(structTy, op.getFields());
    if (!packed)
      return failure();

    rw.replaceOpWithNewOp<hw::ConstantOp>(op, *packed);
    return success();
  }
};

/// hw.bitcast int -> struct  ==>  rewrite each struct_extract user to
/// comb.extract on the original integer input; erase the bitcast once
/// all its uses are gone.
///
/// Two-phase: scan ALL users first to confirm they are struct_extract ops
/// with resolvable fields, then commit the rewrites.  This avoids the
/// PatternRewriter's inability to roll back partial rewrites if a later
/// user turns out to be unhandled (e.g. the bitcast's result is also fed
/// to hw.output or another op we don't touch).
struct BitcastIntToStructLowering : OpRewritePattern<hw::BitcastOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(hw::BitcastOp op,
                                PatternRewriter &rw) const override {
    if (!isa<hw::StructType>(op.getResult().getType()))
      return failure();
    auto intTy = dyn_cast<IntegerType>(op.getInput().getType());
    if (!intTy)
      return failure();
    auto structTy = cast<hw::StructType>(op.getResult().getType());
    int64_t structW = computeFlatBitWidth(structTy);
    if (structW < 0 || static_cast<unsigned>(structW) != intTy.getWidth())
      return failure();

    // Phase 1: validate every user is a struct_extract with a known field
    // offset.  No IR is mutated in this pass — if any user fails, we bail
    // with the bitcast untouched.  The cached {extract, offset, width}
    // triples are reused in Phase 2 to avoid recomputing.
    struct PendingRewrite {
      hw::StructExtractOp extract;
      unsigned offset;
      unsigned width;
    };
    SmallVector<PendingRewrite, 4> pending;
    for (Operation *user : op.getResult().getUsers()) {
      auto extract = dyn_cast<hw::StructExtractOp>(user);
      if (!extract)
        return failure();  // non-extract user (e.g. hw.output); bail cleanly
      auto [offset, width] =
          fieldOffsetAndWidth(structTy,
                              extract.getFieldNameAttr().getValue());
      if (width == 0)
        return failure();
      pending.push_back({extract, offset, width});
    }

    // Phase 2: commit rewrites in a single pass.  By this point every
    // user has been proven rewritable, so no partial state can leak.
    for (auto &pr : pending) {
      auto newExt = rw.create<comb::ExtractOp>(
          pr.extract.getLoc(),
          rw.getIntegerType(pr.width),
          op.getInput(),
          pr.offset);
      Value repl = newExt.getResult();
      // NESTED aggregate field (struct-in-struct — hmac's IR reaches one):
      // the extract's users still expect the aggregate type.  Bitcast the
      // integer slice back; the resulting bitcast(int -> struct) is exactly
      // this pattern's own match shape, so the inner layer is consumed on a
      // later iteration.  Replacing with the bare integer instead leaves
      // the inner struct_extracts type-torn (operand i23, cast<> assert).
      if (repl.getType() != pr.extract.getType())
        repl = rw.create<hw::BitcastOp>(pr.extract.getLoc(),
                                        pr.extract.getType(), repl)
                   .getResult();
      rw.replaceOp(pr.extract, repl);
    }
    if (op.getResult().use_empty())
      rw.eraseOp(op);
    return success();
  }
};

//===----------------------------------------------------------------------===//
// MuxOnAggregateToInt - Lower comb.mux on struct/array result types
//
// `comb.mux %sel, %trueVal, %falseVal : !hw.struct<...>` is verifier-legal
// in source IR but breaks once StructCreateToConcat / StructExtractToBitExtract
// rewrite the operands to integer types: the mux result still claims to be
// struct/array while operands become integer → "all of {trueValue,
// falseValue, result} have same type" verifier failure.
//
// Surfaced by spi_host's `tlul_socket_1n` body, which has 3 struct-typed
// muxes (TL-UL request blanking).  UART/GPIO/rv_timer/i2c have zero such
// muxes.
//
// Rewrite: bitcast both operands to a flat integer of the same total bit
// width, do an integer mux, then bitcast back.  BitcastIntToStructLowering
// will fold the trailing bitcast against any downstream struct_extract.
//===----------------------------------------------------------------------===//

struct MuxOnAggregateToInt : OpRewritePattern<comb::MuxOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(comb::MuxOp op,
                                PatternRewriter &rw) const override {
    Type ty = op.getType();
    if (!isa<hw::StructType, hw::ArrayType>(ty))
      return failure();

    int64_t bw = computeFlatBitWidth(ty);
    if (bw <= 0)
      return failure();

    auto intTy = rw.getIntegerType(static_cast<unsigned>(bw));
    Location loc = op.getLoc();

    auto toInt = [&](Value v) -> Value {
      if (v.getType() == intTy)
        return v;
      return rw.create<hw::BitcastOp>(loc, intTy, v).getResult();
    };
    Value tInt = toInt(op.getTrueValue());
    Value fInt = toInt(op.getFalseValue());

    auto newMux = rw.create<comb::MuxOp>(loc, op.getCond(), tInt, fInt);
    auto castBack = rw.create<hw::BitcastOp>(loc, ty, newMux.getResult());
    rw.replaceOp(op, castBack.getResult());
    return success();
  }
};

//===----------------------------------------------------------------------===//
// arith.select on aggregate VALUES (struct / array) — same treatment as
// comb.mux: select between flat integers, bitcast back.  Produced by
// ExplodeStructSigs' sig-ref lowering (value-level select over struct
// element probes of a runtime-indexed struct array).
//===----------------------------------------------------------------------===//

struct SelectOnAggregateToInt : OpRewritePattern<arith::SelectOp> {
  using OpRewritePattern::OpRewritePattern;
  LogicalResult matchAndRewrite(arith::SelectOp op,
                                PatternRewriter &rw) const override {
    Type ty = op.getType();
    if (!isa<hw::StructType, hw::ArrayType>(ty))
      return failure();
    int64_t bw = computeFlatBitWidth(ty);
    if (bw <= 0)
      return failure();
    auto intTy = rw.getIntegerType(static_cast<unsigned>(bw));
    Location loc = op.getLoc();
    auto toInt = [&](Value v) -> Value {
      if (v.getType() == intTy) return v;
      return rw.create<hw::BitcastOp>(loc, intTy, v).getResult();
    };
    Value tInt = toInt(op.getTrueValue());
    Value fInt = toInt(op.getFalseValue());
    auto newMux = rw.create<comb::MuxOp>(loc, op.getCondition(), tInt, fInt);
    auto castBack = rw.create<hw::BitcastOp>(loc, ty, newMux.getResult());
    rw.replaceOp(op, castBack.getResult());
    return success();
  }
};

//===----------------------------------------------------------------------===//
// hw.array_create of aggregate elements — build the flat integer array by
// bitcasting each element to its flat width, then bitcast the whole array back
// to the declared array<N x struct> type (BitcastIntToStructLowering /
// the translators fold the casts against downstream extracts).
//===----------------------------------------------------------------------===//

struct ArrayCreateOfAggregateToInt : OpRewritePattern<hw::ArrayCreateOp> {
  using OpRewritePattern::OpRewritePattern;
  LogicalResult matchAndRewrite(hw::ArrayCreateOp op,
                                PatternRewriter &rw) const override {
    auto arrTy = dyn_cast<hw::ArrayType>(op.getType());
    if (!arrTy) return failure();
    Type elTy = arrTy.getElementType();
    if (!isa<hw::StructType, hw::ArrayType>(elTy)) return failure();
    int64_t bw = computeFlatBitWidth(elTy);
    if (bw <= 0) return failure();
    auto intTy = rw.getIntegerType(static_cast<unsigned>(bw));
    Location loc = op.getLoc();
    SmallVector<Value, 8> ints;
    for (Value v : op.getOperands())
      ints.push_back(v.getType() == intTy ? v : rw.create<hw::BitcastOp>(loc, intTy, v).getResult());
    auto intArrTy = hw::ArrayType::get(intTy, arrTy.getNumElements());
    Value flat = rw.create<hw::ArrayCreateOp>(loc, intArrTy, ints);
    auto castBack = rw.create<hw::BitcastOp>(loc, arrTy, flat);
    rw.replaceOp(op, castBack.getResult());
    return success();
  }
};

//===----------------------------------------------------------------------===//
// Pass driver
//===----------------------------------------------------------------------===//

struct LowerValueStructsPass
    : public ::impl::LowerValueStructsBase<LowerValueStructsPass> {
  using LowerValueStructsBase::LowerValueStructsBase;

  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    ModuleOp mod = getOperation();

    // Count residual struct ops before rewriting to produce a before/after
    // diff in the report.  Cheap walks — only called when reports are on.
    auto countStructOps = [](ModuleOp m) {
      unsigned c = 0;
      m.walk([&](Operation *op) {
        if (isa<hw::StructCreateOp, hw::StructExtractOp,
                hw::StructExplodeOp, hw::StructInjectOp,
                hw::AggregateConstantOp>(op))
          ++c;
      });
      return c;
    };
    unsigned structOpsBefore =
        qemu_passes::g_reportsEnabled ? countStructOps(mod) : 0;

    RewritePatternSet patterns(ctx);
    patterns.add<StructCreateToConcat, StructExtractToBitExtract,
                 StructExplodeLowering, AggregateConstantLowering,
                 BitcastIntToStructLowering,
                 MuxOnAggregateToInt, SelectOnAggregateToInt,
                 ArrayCreateOfAggregateToInt>(ctx);

    GreedyRewriteConfig config;
    // NOTE on folding: StructExtractOp::fold cast<>s its operand to
    // StructType and crashes on a transient producer-already-lowered state.
    // The StructCreateToConcat ordering guard (defer while struct_extract /
    // struct_explode users remain) prevents that state from ever existing,
    // so folding stays ON — turning it off changes the canonical IR shape
    // for EVERY device (rv_plic's ie/prio input bridges resolved into
    // truncated single-word sources and all irq tests failed).
    if (failed(applyPatternsGreedily(mod, std::move(patterns), config))) {
      llvm::errs() << "[lower-value-structs] greedy rewrite did not converge\n";
      signalPassFailure();
      return;
    }

    // Type-consistency diagnostic: a struct_extract whose operand is no
    // longer struct-typed means some rewrite tore the producer out from
    // under it — that IR cannot be emitted correctly.  Be LOUD and dump
    // the shape so the responsible pattern can be identified.
    mod.walk([&](hw::StructExtractOp ex) {
      if (!isa<hw::StructType>(ex->getOperand(0).getType())) {
        llvm::errs() << "[lower-value-structs] TYPE-TORN struct_extract: ";
        ex->print(llvm::errs());
        llvm::errs() << "\n  operand type: " << ex->getOperand(0).getType()
                     << "\n  producer: ";
        if (Operation *def = ex->getOperand(0).getDefiningOp())
          def->print(llvm::errs());
        else
          llvm::errs() << "<block argument>";
        llvm::errs() << "\n";
      }
    });

    unsigned structOpsAfter =
        qemu_passes::g_reportsEnabled ? countStructOps(mod) : 0;
    qemu_passes::writePassReport(
        "lower_value_structs",
        [&](llvm::raw_ostream &os) {
          os << "Lower Value Structs — summary\n";
          os << "=============================\n";
          os << "Struct ops before: " << structOpsBefore << "\n";
          os << "Struct ops after:  " << structOpsAfter << "\n";
          os << "Rewritten:         "
             << (structOpsBefore - structOpsAfter) << "\n";
          os << "Residual (guarded at signature boundaries): "
             << structOpsAfter << "\n";
        });
  }
};

}  // namespace
