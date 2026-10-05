//===- ExplodeStructSigsPass.cpp - Explode aggregate llhd.sig -----------===//
//
// For every `llhd.sig` whose element type is an aggregate (`!hw.struct<...>`
// or `!hw.array<N×T>`), creates one independent scalar `llhd.sig` per leaf
// (struct field or array index) and rewrites drv/prb users accordingly.
// Naming uses "." as the path joiner: struct fields become `parent.field`,
// array indices become `parent.[i]` — both flatten to a unique state-struct
// field after sanitizeName in QEMUEmitC.
//
// Nested aggregates are handled by an internal fixed-point loop (up to 16
// iterations): an `array<1×struct<q:i1>>` field becomes a struct sig in
// iter 1, then an integer leaf in iter 2.
//===----------------------------------------------------------------------===//

#include "PassReports.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/HW/HWTypes.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Interfaces/ControlFlowInterfaces.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/IR/Verifier.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_EXPLODESTRUCTSIGS
#define GEN_PASS_DEF_EXPLODESTRUCTSIGS
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Helper: collect aggregate-typed (struct or array) llhd.sig signals that
// are safely explodable.
//
// Struct sigs: always explodable.  Array sigs: only when every
// `llhd.sig.array_get` user has a constant index — runtime-indexed arrays
// (e.g. UART's `array<32×i8>` FIFO storage with `storage[wptr]`) are
// memories, not structural unrolls, and must be left as-is for downstream
// passes to handle separately.
//===----------------------------------------------------------------------===//

// Arrays up to this many elements are exploded even when some
// llhd.sig.array_get carries a RUNTIME index (FIFO storage `storage[wptr]`):
// the dynamic read becomes a mux tree over the element sigs, the dynamic
// write a per-element guarded drv (`drv elem_i when idx==i`).  Larger arrays
// (SRAM macros) stay whole — they need real C array fields in the emitter.
static constexpr unsigned kMaxDynamicArrayElems = 64;

static bool arraySigHasOnlyStaticIndices(llhd::SignalOp sigOp) {
  for (Operation *user : sigOp->getUsers()) {
    if (auto get = dyn_cast<llhd::SigArrayGetOp>(user)) {
      Value idx = get.getIndex();
      if (!idx.getDefiningOp<hw::ConstantOp>())
        return false;
    }
  }
  return true;
}

static SmallVector<llhd::SignalOp> collectAggregateSigs(ModuleOp module) {
  SmallVector<llhd::SignalOp> result;
  module.walk([&](llhd::SignalOp sigOp) {
    auto inoutTy = dyn_cast<llhd::RefType>(sigOp.getType());
    if (!inoutTy)
      return;
    Type elemTy = inoutTy.getNestedType();
    if (isa<hw::StructType>(elemTy)) {
      result.push_back(sigOp);
      return;
    }
    if (isa<hw::ArrayType>(elemTy) &&
        (arraySigHasOnlyStaticIndices(sigOp) ||
         (!getenv("QP_NO_S3") && cast<hw::ArrayType>(elemTy).getNumElements() <= kMaxDynamicArrayElems &&
          (isa<IntegerType>(cast<hw::ArrayType>(elemTy).getElementType()) ||
           isa<hw::StructType>(cast<hw::ArrayType>(elemTy).getElementType()) ||
           isa<hw::ArrayType>(cast<hw::ArrayType>(elemTy).getElementType())))))
      result.push_back(sigOp);
  });
  return result;
}

//===----------------------------------------------------------------------===//
// Helper: build a zero-valued aggregate constant for a given type.
// For IntegerType -> hw.constant 0.
// For StructType  -> hw.aggregate_constant with a nested ArrayAttr whose
//                    elements are zero-valued per-field attributes.
//===----------------------------------------------------------------------===//

/// Build a per-field zero attribute (returns IntegerAttr for int leaves or
/// ArrayAttr for nested structs/arrays).  Returns null on unsupported type.
static Attribute buildZeroFieldAttr(MLIRContext *ctx, Type ty) {
  if (auto intTy = dyn_cast<IntegerType>(ty))
    return IntegerAttr::get(intTy, 0);
  if (auto structTy = dyn_cast<hw::StructType>(ty)) {
    SmallVector<Attribute, 4> perField;
    for (const auto &el : structTy.getElements()) {
      Attribute a = buildZeroFieldAttr(ctx, el.type);
      if (!a)
        return Attribute{};
      perField.push_back(a);
    }
    return ArrayAttr::get(ctx, perField);
  }
  if (auto arrTy = dyn_cast<hw::ArrayType>(ty)) {
    Attribute elemAttr = buildZeroFieldAttr(ctx, arrTy.getElementType());
    if (!elemAttr)
      return Attribute{};
    SmallVector<Attribute, 4> elements(arrTy.getNumElements(), elemAttr);
    return ArrayAttr::get(ctx, elements);
  }
  return Attribute{};
}

static Value buildZeroAggregate(OpBuilder &builder, Location loc, Type ty) {
  if (auto intTy = dyn_cast<IntegerType>(ty)) {
    return builder.create<hw::ConstantOp>(loc, intTy, 0).getResult();
  }
  if (isa<hw::StructType>(ty) || isa<hw::ArrayType>(ty)) {
    Attribute a = buildZeroFieldAttr(builder.getContext(), ty);
    if (!a)
      return Value{};
    auto arr = cast<ArrayAttr>(a);
    return builder.create<hw::AggregateConstantOp>(loc, ty, arr).getResult();
  }
  return Value{};
}

/// Copy every `qemu.*` attribute from `src` onto `dst`.  Called when
/// splitting a struct-level drv/prb into per-field equivalents so downstream
/// passes (e.g. QEMUEmitC's ACCUMULATE counter scanner) see the same
/// classification metadata as the parent operation.
///
/// Note: `qemu.drv_class` and `qemu.step` get meaningful values only when
/// DrvClassification re-runs after struct elimination, because the
/// per-field drvs have different value expressions (bit arithmetic) than
/// the struct-level parent (struct_create).  The copy here is defensive
/// preservation for pipelines that omit the re-run.
static void copyQemuAttrs(Operation *src, Operation *dst) {
  for (NamedAttribute attr : src->getAttrs()) {
    StringRef name = attr.getName().getValue();
    if (name.starts_with("qemu."))
      dst->setAttr(attr.getName(), attr.getValue());
  }
}

//===----------------------------------------------------------------------===//
// Explode a single struct-typed sig: create per-field sigs, rewrite users.
// Returns failure() on unsupported user patterns; caller should signalFailure.
//===----------------------------------------------------------------------===//

static LogicalResult explodeStructOne(llhd::SignalOp sigOp) {
  auto inoutTy = cast<llhd::RefType>(sigOp.getType());
  auto structTy = cast<hw::StructType>(inoutTy.getNestedType());

  StringRef baseName =
      sigOp.getName().has_value() ? sigOp.getName().value() : "anon_struct_sig";

  OpBuilder builder(sigOp);

  // Build one per-field sig.  Map field name -> new sig Value.
  llvm::DenseMap<StringAttr, Value> fieldSigs;
  for (const auto &el : structTy.getElements()) {
    // Fix 2 (P0): use "." as the field-joiner.  The downstream
    // sanitizeName() in QEMUEmitCPass converts "." to "_", so a sig named
    // "tl_i.a_address" lands as state field `tl_i_a_address` — which
    // matches the form CombTranslator naturally produces when tracing
    // hw.struct_extract chains (it also uses "."), letting both
    // registration paths converge on a single state-struct field instead
    // of producing the historical `tl_i__a_address` vs `tl_i_a_address`
    // collision.
    std::string newName = (baseName + "." + el.name.strref()).str();
    Value init = buildZeroAggregate(builder, sigOp.getLoc(), el.type);
    if (!init)
      return sigOp.emitError(
          "unsupported field type for struct sig explosion: ")
             << el.type;

    auto nameAttr = builder.getStringAttr(newName);
    auto newSig =
        builder.create<llhd::SignalOp>(sigOp.getLoc(), nameAttr, init);
    fieldSigs[el.name] = newSig.getResult();
  }

  // Rewrite users.  Use early-inc range because we erase as we go.
  for (Operation *user : llvm::make_early_inc_range(sigOp->getUsers())) {
    if (auto drv = dyn_cast<llhd::DriveOp>(user)) {
      OpBuilder b(drv);
      Value structVal = drv.getValue();
      for (const auto &el : structTy.getElements()) {
        // Extract the field value from the driven struct.  Pass 1 (re-run)
        // will eliminate this struct_extract.
        Value fieldVal =
            b.create<hw::StructExtractOp>(drv.getLoc(), structVal, el.name)
                .getResult();
        // Emit per-field drv (preserve time and optional enable).
        auto newDrv =
            b.create<llhd::DriveOp>(drv.getLoc(), fieldSigs[el.name], fieldVal,
                                  drv.getTime(), drv.getEnable());
        // Propagate qemu.* metadata so downstream passes (QEMUEmitC's
        // ACCUMULATE counter scanner, etc.) see the parent's classification.
        // DrvClassification is expected to re-run after struct elimination
        // to refine these labels per field.
        copyQemuAttrs(drv, newDrv);
      }
      drv.erase();
    } else if (auto prb = dyn_cast<llhd::ProbeOp>(user)) {
      OpBuilder b(prb);
      SmallVector<Value, 8> fieldVals;
      for (const auto &el : structTy.getElements()) {
        auto newPrb =
            b.create<llhd::ProbeOp>(prb.getLoc(), fieldSigs[el.name]);
        // Propagate qemu.* metadata for consistency with the drv branch;
        // current pipelines don't mark prb ops, but future ones might.
        copyQemuAttrs(prb, newPrb);
        fieldVals.push_back(newPrb.getResult());
      }
      // Rebuild the struct for downstream consumers; Pass 1 re-run will
      // consume the struct_create / struct_extract pair.
      Value rebuilt = b.create<hw::StructCreateOp>(prb.getLoc(), structTy,
                                                    fieldVals)
                         .getResult();
      prb.getResult().replaceAllUsesWith(rebuilt);
      prb.erase();
    } else if (auto sigStructExtract =
                   dyn_cast<llhd::SigStructExtractOp>(user)) {
      // llhd.sig.struct_extract %sig[field] returns a sub-signal aliasing
      // the field.  After explosion, that aliasing is already expressed by
      // the per-field independent sig we just created; just replace the
      // result with the field sig.
      StringRef fieldName = sigStructExtract.getField();
      auto nameAttr = StringAttr::get(sigStructExtract.getContext(), fieldName);
      auto it = fieldSigs.find(nameAttr);
      if (it == fieldSigs.end())
        return sigStructExtract.emitError(
                   "llhd.sig.struct_extract field '")
               << fieldName << "' not found in exploded struct sig";
      sigStructExtract.getResult().replaceAllUsesWith(it->second);
      sigStructExtract.erase();
    } else if (isa<llhd::SigExtractOp>(user)) {
      return user->emitError(
          "llhd.sig.extract (bit slicing) on struct sig not supported; "
          "this pass only handles llhd.sig.struct_extract (field "
          "projection).  If struct-to-int bit slicing is needed, lower "
          "with hw-aggregate-to-comb first.");
    } else {
      return user->emitError(
                 "unsupported user of struct-typed llhd.sig: ")
             << user->getName();
    }
  }

  sigOp.erase();
  return success();
}

//===----------------------------------------------------------------------===//
// Explode a single array-typed sig: create per-index sigs, rewrite users.
// Mirrors explodeStructOne but for `!hw.array<N×T>`.  Per-index sigs are
// named "<base>.[<i>]" — the dotted-bracket form matches walkLeaves on the
// QEMUEmitC side, which already canonicalises array indexing.
//===----------------------------------------------------------------------===//

static LogicalResult explodeArrayOne(llhd::SignalOp sigOp) {
  auto inoutTy = cast<llhd::RefType>(sigOp.getType());
  auto arrTy = cast<hw::ArrayType>(inoutTy.getNestedType());
  unsigned numElements = arrTy.getNumElements();
  Type elemTy = arrTy.getElementType();

  StringRef baseName =
      sigOp.getName().has_value() ? sigOp.getName().value() : "anon_array_sig";

  OpBuilder builder(sigOp);

  // Build one per-index sig of the array's element type.  Naming
  // convention `parent[i]` (no "." before `[`) matches walkLeaves +
  // resolveValueExpr in QEMUEmitCPass.cpp, so all paths sanitize to
  // the same flat field name (e.g. `parent_0__field` rather than two
  // diverging forms `parent_0_field` and `parent__0__field`).
  SmallVector<Value, 4> elemSigs(numElements);
  for (unsigned i = 0; i < numElements; ++i) {
    std::string newName = (baseName + "[" + std::to_string(i) + "]").str();
    Value init = buildZeroAggregate(builder, sigOp.getLoc(), elemTy);
    if (!init)
      return sigOp.emitError(
          "unsupported element type for array sig explosion: ")
             << elemTy;

    auto nameAttr = builder.getStringAttr(newName);
    auto newSig =
        builder.create<llhd::SignalOp>(sigOp.getLoc(), nameAttr, init);
    elemSigs[i] = newSig.getResult();
  }

  // Helper: resolve a sig-extract index Value to a constant unsigned.
  // The IR shape we see in OT is always `hw.constant <i> : iN`, but we
  // tolerate any constant-foldable form by checking ConstantOp first.
  auto extractConstIndex =
      [](Value idx) -> std::optional<unsigned> {
    if (auto c = idx.getDefiningOp<hw::ConstantOp>())
      return static_cast<unsigned>(c.getValue().getZExtValue());
    return std::nullopt;
  };

  // Rewrite users.
  for (Operation *user : llvm::make_early_inc_range(sigOp->getUsers())) {
    if (auto drv = dyn_cast<llhd::DriveOp>(user)) {
      OpBuilder b(drv);
      Value arrVal = drv.getValue();
      // Per-index extraction from the driven array value.  Pass 1 (re-run)
      // will eliminate hw.array_get against a known hw.array_create.
      // hw.array_get takes index as iN where N = clog2(numElements).
      unsigned idxBits =
          numElements <= 1 ? 1u : llvm::Log2_64_Ceil(numElements);
      auto idxTy = b.getIntegerType(idxBits);
      for (unsigned i = 0; i < numElements; ++i) {
        Value idxVal =
            b.create<hw::ConstantOp>(drv.getLoc(), idxTy,
                                     static_cast<int64_t>(i))
                .getResult();
        Value elemVal =
            b.create<hw::ArrayGetOp>(drv.getLoc(), arrVal, idxVal).getResult();
        auto newDrv =
            b.create<llhd::DriveOp>(drv.getLoc(), elemSigs[i], elemVal,
                                  drv.getTime(), drv.getEnable());
        copyQemuAttrs(drv, newDrv);
      }
      drv.erase();
    } else if (auto prb = dyn_cast<llhd::ProbeOp>(user)) {
      OpBuilder b(prb);
      // Preferred: rewrite each `hw.array_get %whole[idx]` user directly —
      // constant idx → prb of that element sig, runtime idx → value-level
      // select chain over the element probes.  No hw.array_create is built,
      // so struct-element arrays survive LowerValueStructs (which would
      // otherwise retype the operands and leave the array_create ill-typed).
      {
        bool allGets = true;
        for (Operation *u : prb.getResult().getUsers())
          if (!isa<hw::ArrayGetOp>(u)) { allGets = false; break; }
        if (allGets && !prb.getResult().use_empty()) {
          for (Operation *u : llvm::make_early_inc_range(prb.getResult().getUsers())) {
            auto ag = cast<hw::ArrayGetOp>(u);
            OpBuilder gb(ag);
            Location gl = ag.getLoc();
            if (auto ic = ag.getIndex().getDefiningOp<hw::ConstantOp>()) {
              unsigned i = ic.getValue().getZExtValue();
              if (i >= numElements) return ag.emitError("array_get index out of range");
              Value v = gb.create<llhd::ProbeOp>(gl, elemSigs[i]);
              ag.getResult().replaceAllUsesWith(v);
              ag.erase();
              continue;
            }
            Value idx = ag.getIndex();
            auto idxTy = cast<IntegerType>(idx.getType());
            Value acc = gb.create<llhd::ProbeOp>(gl, elemSigs[numElements - 1]);
            bool intElem = isa<IntegerType>(elemTy);
            for (int i = (int)numElements - 2; i >= 0; --i) {
              Value ci = gb.create<hw::ConstantOp>(gl, idxTy, (int64_t)i);
              Value eq = gb.create<comb::ICmpOp>(gl, comb::ICmpPredicate::eq, idx, ci);
              Value pi = gb.create<llhd::ProbeOp>(gl, elemSigs[i]);
              acc = intElem ? gb.create<comb::MuxOp>(gl, eq, pi, acc).getResult()
                            : gb.create<arith::SelectOp>(gl, eq, pi, acc).getResult();
            }
            ag.getResult().replaceAllUsesWith(acc);
            ag.erase();
          }
          prb.erase();
          continue;
        }
      }
      SmallVector<Value, 4> elemVals;
      for (unsigned i = 0; i < numElements; ++i) {
        auto newPrb = b.create<llhd::ProbeOp>(prb.getLoc(), elemSigs[i]);
        copyQemuAttrs(prb, newPrb);
        elemVals.push_back(newPrb.getResult());
      }
      // hw.array_create operand order: first operand = LAST element (MSB-
      // first per CIRCT convention).  Reverse our 0..N-1 vector.
      SmallVector<Value, 4> reversed(elemVals.rbegin(), elemVals.rend());
      for (Value ev : reversed)
        if (ev.getType() != elemTy) {
          llvm::errs() << "[explode-struct-sigs] DEBUG elem type mismatch for "
                       << baseName << ": elem " << ev.getType()
                       << " vs array elem " << elemTy << "\n";
          break;
        }
      Value rebuilt =
          b.create<hw::ArrayCreateOp>(prb.getLoc(), reversed).getResult();
      prb.getResult().replaceAllUsesWith(rebuilt);
      prb.erase();
    } else if (auto sigArrayGet = dyn_cast<llhd::SigArrayGetOp>(user)) {
      // Constant-fold the index, then alias to the per-index sig.
      auto idxOpt = extractConstIndex(sigArrayGet.getIndex());
      if (!idxOpt) {
        // RUNTIME index (S3): read → mux tree over element sigs, write →
        // per-element guarded drv, other sig-ref users → inout select chain
        // (lowered by lowerInOutSelects afterwards).
        Value idx = sigArrayGet.getIndex();
        auto idxTy = cast<IntegerType>(idx.getType());
        auto mkEq = [&](OpBuilder &b, Location loc, unsigned i) -> Value {
          Value ci = b.create<hw::ConstantOp>(loc, idxTy, (int64_t)i);
          return b.create<comb::ICmpOp>(loc, comb::ICmpPredicate::eq, idx, ci);
        };
        for (Operation *u : llvm::make_early_inc_range(sigArrayGet.getResult().getUsers())) {
          OpBuilder b(u); Location loc = u->getLoc();
          if (auto prb = dyn_cast<llhd::ProbeOp>(u)) {
            Value acc = b.create<llhd::ProbeOp>(loc, elemSigs[numElements - 1]);
            bool intElem = isa<IntegerType>(elemTy);
            for (int i = (int)numElements - 2; i >= 0; --i) {
              Value pi = b.create<llhd::ProbeOp>(loc, elemSigs[i]);
              // comb.mux for integers; arith.select for struct VALUES (any type)
              acc = intElem ? b.create<comb::MuxOp>(loc, mkEq(b, loc, i), pi, acc).getResult()
                            : b.create<arith::SelectOp>(loc, mkEq(b, loc, i), pi, acc).getResult();
            }
            prb.getResult().replaceAllUsesWith(acc); prb.erase();
          } else if (auto drv = dyn_cast<llhd::DriveOp>(u)) {
            for (unsigned i = 0; i < numElements; ++i) {
              Value en = mkEq(b, loc, i);
              if (drv.getEnable()) en = b.create<comb::AndOp>(loc, drv.getEnable(), en);
              auto nd = b.create<llhd::DriveOp>(loc, elemSigs[i], drv.getValue(), drv.getTime(), en);
              copyQemuAttrs(drv, nd);
            }
            drv.erase();
          } else {
            // sig.extract / struct_extract / nested get / branch operand:
            // hand over an inout select chain; the sig-ref lowering pushes
            // probes/drives through it.
            //
            // DOMINANCE: the chain is built at THIS user's position, but
            // replaceAllUsesWith rewires EVERY user of the sig.array_get —
            // including ones in blocks this user does not dominate.  Build
            // the chain at the sig.array_get itself (whose def dominates all
            // its users by SSA), not at the first user encountered.
            OpBuilder bg(sigArrayGet);
            Location gloc = sigArrayGet.getLoc();
            Value acc = elemSigs[numElements - 1];
            for (int i = (int)numElements - 2; i >= 0; --i)
              acc = bg.create<arith::SelectOp>(gloc, mkEq(bg, gloc, i), elemSigs[i], acc);
            sigArrayGet.getResult().replaceAllUsesWith(acc);
            break;
          }
        }
        if (!sigArrayGet.getResult().use_empty())
          return sigArrayGet.emitError("dynamic sig.array_get: leftover users");
        sigArrayGet.erase();
        continue;
      }
      unsigned i = *idxOpt;
      if (i >= numElements)
        return sigArrayGet.emitError(
                   "llhd.sig.array_get index ")
               << i << " out of range for array<" << numElements << ">";
      sigArrayGet.getResult().replaceAllUsesWith(elemSigs[i]);
      sigArrayGet.erase();
    } else if (isa<llhd::SigExtractOp>(user)) {
      return user->emitError(
          "llhd.sig.extract (bit slicing) on array sig not supported; "
          "this pass only handles llhd.sig.array_get (index projection).");
    } else {
      return user->emitError(
                 "unsupported user of array-typed llhd.sig: ")
             << user->getName();
    }
  }

  sigOp.erase();
  return success();
}

//===----------------------------------------------------------------------===//
// Top-level dispatcher: pick struct vs array explosion based on element type.
//===----------------------------------------------------------------------===//

static LogicalResult explodeOne(llhd::SignalOp sigOp) {
  auto inoutTy = cast<llhd::RefType>(sigOp.getType());
  Type elemTy = inoutTy.getNestedType();
  if (isa<hw::StructType>(elemTy))
    return explodeStructOne(sigOp);
  if (isa<hw::ArrayType>(elemTy))
    return explodeArrayOne(sigOp);
  return sigOp.emitError(
             "internal: explodeOne called on non-aggregate llhd.sig (")
         << elemTy << ")";
}

//===----------------------------------------------------------------------===//
// Signal-reference lowering (S1 / S2)
//
// Moore/LLHD sometimes selects between SIGNAL REFERENCES rather than values:
//   %r = arith.select %c, %A, %B : !hw.inout<T>      (S1)
//   ^bb(%r : !hw.inout<T>)  with preds passing sigs   (S2)
// followed by `llhd.prb %r` / `llhd.drv %r, v`.  Downstream (CombLogicExtract,
// QEMUEmitC) only understands probes/drives of NAMED sigs; anything else fell
// back to the shared bogus field "unnamed" (every such reference in a module
// aliased onto ONE C field — spi_device's sd output enable read a stranger).
// Normalise here so the rest of the pipeline never sees these shapes:
//   S1: prb(select) → select(prb A, prb B); drv(select) → guarded drvs;
//       sig.extract/struct_extract/array_get(select) → select of the parts.
//   S2: an inout block argument becomes an INTEGER selector argument over the
//       candidate sigs that can flow in; prb/drv/... users are rewritten via an
//       inout select chain (then S1), predecessors pass the candidate id.
//===----------------------------------------------------------------------===//

static bool isInOutTy(Type t) { return isa<llhd::RefType>(t); }

/// S1.  Returns number of selects lowered.
static LogicalResult lowerInOutSelects(ModuleOp module, unsigned &lowered) {
  // Worklist: every inout arith.select found by one walk, plus any created
  // while lowering (pushed-down extracts produce new inout selects).  A select
  // is retried when its remaining users are other selects (they get lowered
  // first and re-probe it).
  SmallVector<arith::SelectOp, 32> work;
  module.walk([&](arith::SelectOp op) { if (isInOutTy(op.getType())) work.push_back(op); });
  llvm::DenseSet<Operation *> inWork(work.begin(), work.end());
  auto push = [&](arith::SelectOp op) { if (inWork.insert(op.getOperation()).second) work.push_back(op); };
  unsigned guard = 0;
  while (!work.empty()) {
    if (++guard > 5000000) return module.emitError("lower-inout-selects: runaway");
    arith::SelectOp sel = work.pop_back_val();
    inWork.erase(sel.getOperation());
    if (!sel->getBlock()) continue;   // erased
    Value c = sel.getCondition(), A = sel.getTrueValue(), B = sel.getFalseValue();
    bool pendingSelectUser = false;
    for (Operation *user : llvm::make_early_inc_range(sel.getResult().getUsers())) {
      OpBuilder b(user);
      Location loc = user->getLoc();
      if (auto prb = dyn_cast<llhd::ProbeOp>(user)) {
        Value pa = b.create<llhd::ProbeOp>(loc, A);
        Value pb = b.create<llhd::ProbeOp>(loc, B);
        Value v = b.create<comb::MuxOp>(loc, c, pa, pb);
        prb.getResult().replaceAllUsesWith(v);
        prb.erase();
      } else if (auto drv = dyn_cast<llhd::DriveOp>(user)) {
        Value t = b.create<hw::ConstantOp>(loc, b.getI1Type(), 1);
        Value nc = b.create<comb::XorOp>(loc, c, t);
        Value enA = drv.getEnable() ? b.create<comb::AndOp>(loc, drv.getEnable(), c).getResult() : c;
        Value enB = drv.getEnable() ? b.create<comb::AndOp>(loc, drv.getEnable(), nc).getResult() : nc;
        auto d1 = b.create<llhd::DriveOp>(loc, A, drv.getValue(), drv.getTime(), enA);
        auto d2 = b.create<llhd::DriveOp>(loc, B, drv.getValue(), drv.getTime(), enB);
        copyQemuAttrs(drv, d1); copyQemuAttrs(drv, d2);
        drv.erase();
      } else if (auto ex = dyn_cast<llhd::SigExtractOp>(user)) {
        Value ea = b.create<llhd::SigExtractOp>(loc, ex.getType(), A, ex.getLowBit());
        Value eb = b.create<llhd::SigExtractOp>(loc, ex.getType(), B, ex.getLowBit());
        auto ns = b.create<arith::SelectOp>(loc, c, ea, eb);
        ex.getResult().replaceAllUsesWith(ns.getResult()); ex.erase();
        push(ns);
      } else if (auto sx = dyn_cast<llhd::SigStructExtractOp>(user)) {
        Value ea = b.create<llhd::SigStructExtractOp>(loc, sx.getType(), A, sx.getFieldAttr());
        Value eb = b.create<llhd::SigStructExtractOp>(loc, sx.getType(), B, sx.getFieldAttr());
        auto ns = b.create<arith::SelectOp>(loc, c, ea, eb);
        sx.getResult().replaceAllUsesWith(ns.getResult()); sx.erase();
        push(ns);
      } else if (auto ag = dyn_cast<llhd::SigArrayGetOp>(user)) {
        Value ea = b.create<llhd::SigArrayGetOp>(loc, ag.getType(), A, ag.getIndex());
        Value eb = b.create<llhd::SigArrayGetOp>(loc, ag.getType(), B, ag.getIndex());
        auto ns = b.create<arith::SelectOp>(loc, c, ea, eb);
        ag.getResult().replaceAllUsesWith(ns.getResult()); ag.erase();
        push(ns);
      } else if (auto os = dyn_cast<arith::SelectOp>(user)) {
        // nested: the outer select must be lowered first (its prb users then
        // re-probe this one) — make sure it is queued and revisit this later.
        push(os);
        pendingSelectUser = true;
      }
      // branch operands: handled by S2
    }
    if (sel.getResult().use_empty()) { sel.erase(); ++lowered; continue; }
    if (pendingSelectUser) push(sel);
  }
  return success();
}

/// S2 helpers ------------------------------------------------------------
namespace {
struct Cand { Value sig; Value cond; bool isValue = false; };   // cond may be null (= always)
}

static Value andCond(OpBuilder &b, Location loc, Value a, Value c) {
  if (!a) return c;
  if (!c) return a;
  return b.create<comb::AndOp>(loc, a, c);
}
static Value notCond(OpBuilder &b, Location loc, Value c) {
  Value t = b.create<hw::ConstantOp>(loc, b.getI1Type(), 1);
  return b.create<comb::XorOp>(loc, c, t);
}

/// Expand an incoming sig-reference value into leaf candidates.  Returns
/// false if it hits an inout block argument that is not yet converted (caller
/// retries later).  `argTables` holds the leaf table of already-converted args
/// (now integer selectors): value == j  →  leaf j.
static bool expandCands(OpBuilder &b, Location loc, Value v, Value cond,
                        SmallVectorImpl<Cand> &out,
                        const DenseMap<Value, SmallVector<Value, 4>> &argTables,
                        const DenseSet<Value> &valueArgs,
                        unsigned depth = 0) {
  if (depth > 32) return false;
  if (auto sel = v.getDefiningOp<arith::SelectOp>()) {
    if (!expandCands(b, loc, sel.getTrueValue(), andCond(b, loc, cond, sel.getCondition()), out, argTables, valueArgs, depth + 1)) return false;
    return expandCands(b, loc, sel.getFalseValue(), andCond(b, loc, cond, notCond(b, loc, sel.getCondition())), out, argTables, valueArgs, depth + 1);
  }
  if (auto arg = dyn_cast<BlockArgument>(v)) {
    if (valueArgs.count(v)) { out.push_back({v, cond, /*isValue=*/true}); return true; }
    auto it = argTables.find(v);
    if (it == argTables.end()) return false;   // unconverted inout arg
    // converted: integer selector over its leaf table
    auto ity = cast<IntegerType>(v.getType());
    for (unsigned j = 0; j < it->second.size(); ++j) {
      Value cj = b.create<hw::ConstantOp>(loc, ity, (int64_t)j);
      Value eq = b.create<comb::ICmpOp>(loc, comb::ICmpPredicate::eq, v, cj);
      out.push_back({it->second[j], andCond(b, loc, cond, eq)});
    }
    return true;
  }
  out.push_back({v, cond});   // llhd.sig / sig.extract / struct_extract / array_get
  return true;
}

/// S2.  Converts every inout block argument in every process.
static LogicalResult lowerInOutBlockArgs(ModuleOp module, unsigned &converted) {
  DenseMap<Value, SmallVector<Value, 4>> argTables;   // selector-converted arg → leaf sigs
  DenseSet<Value> valueArgs;                          // value-converted args (probe-only users)
  for (int round = 0; round < 64; ++round) {
    SmallVector<BlockArgument, 16> todo;
    module.walk([&](llhd::ProcessOp proc) {
      for (Block &bb : proc.getBody())
        for (BlockArgument a : bb.getArguments())
          if (isInOutTy(a.getType())) todo.push_back(a);
    });
    if (todo.empty()) return success();
    bool progress = false;
    for (BlockArgument arg : todo) {
      Block *bb = arg.getOwner();
      unsigned k = arg.getArgNumber();
      OpBuilder b(bb, bb->begin());
      Location loc = arg.getLoc();
      // Gather incoming (terminator, successor index, value)
      struct Inc { Operation *term; unsigned succ; Value v; };
      SmallVector<Inc, 4> incs;
      bool ready = true;
      for (Block *pred : bb->getPredecessors()) {
        Operation *term = pred->getTerminator();
        for (unsigned si = 0; si < term->getNumSuccessors(); ++si) {
          if (term->getSuccessor(si) != bb) continue;
          auto br = dyn_cast<BranchOpInterface>(term);
          if (!br) { ready = false; break; }
          Value v = br.getSuccessorOperands(si)[k];
          incs.push_back({term, si, v});
        }
      }
      if (!ready) continue;
      // Candidate leaves (dedupe by Value); self-reference (arg passed to
      // itself around a loop) contributes nothing new.
      SmallVector<Value, 4> leaves;
      SmallVector<SmallVector<Cand, 4>, 4> incCands(incs.size());
      bool ok = true, anyValueCand = false;
      for (unsigned i = 0; i < incs.size() && ok; ++i) {
        if (incs[i].v == arg) continue;
        OpBuilder tb(incs[i].term);
        if (!expandCands(tb, loc, incs[i].v, Value(), incCands[i], argTables, valueArgs)) { ok = false; break; }
        for (auto &c : incCands[i]) {
          if (c.isValue) { anyValueCand = true; continue; }
          if (!llvm::is_contained(leaves, c.sig)) leaves.push_back(c.sig);
        }
      }
      if (!ok) continue;   // retry later

      // ---- Value path: every non-terminator user is a probe (directly or
      // through sig.extract).  Convert the arg to a VALUE of the element type;
      // predecessors probe their own leaf.  This is exactly the shape the
      // CFG resolver's one-hot read-mux collapse understands (O(N)); a
      // selector would be re-referenced N times in the mux chain (O(N²)).
      bool probeOnly = true;
      for (OpOperand &use : arg.getUses()) {
        Operation *u = use.getOwner();
        if (u->hasTrait<OpTrait::IsTerminator>()) {
          // Forwarding to ANOTHER block's arg keeps a sig-ref alive there
          // (its users may drive) — only a self-loop pass is harmless.
          bool selfPass = false;
          if (auto br = dyn_cast<BranchOpInterface>(u))
            for (unsigned si = 0; si < u->getNumSuccessors(); ++si)
              if (u->getSuccessor(si) == bb) selfPass = true;
          if (selfPass) continue;
          probeOnly = false; break;
        }
        if (isa<llhd::ProbeOp>(u)) continue;
        if (auto ex = dyn_cast<llhd::SigExtractOp>(u)) {
          bool allPrb = true;
          for (Operation *u2 : ex.getResult().getUsers()) if (!isa<llhd::ProbeOp>(u2)) allPrb = false;
          if (allPrb && ex.getLowBit().getDefiningOp<hw::ConstantOp>()) continue;
        }
        probeOnly = false; break;
      }
      if (probeOnly) {
        Type elemTy = cast<llhd::RefType>(arg.getType()).getNestedType();
        arg.setType(elemTy);
        for (Operation *u : llvm::make_early_inc_range(arg.getUsers())) {
          if (u->hasTrait<OpTrait::IsTerminator>()) continue;
          if (auto prb = dyn_cast<llhd::ProbeOp>(u)) {
            prb.getResult().replaceAllUsesWith(arg); prb.erase();
          } else if (auto ex = dyn_cast<llhd::SigExtractOp>(u)) {
            OpBuilder eb(ex);
            unsigned lo = ex.getLowBit().getDefiningOp<hw::ConstantOp>().getValue().getZExtValue();
            unsigned w = cast<IntegerType>(cast<llhd::RefType>(ex.getType()).getNestedType()).getWidth();
            Value slice = eb.create<comb::ExtractOp>(ex.getLoc(), arg, lo, w);
            for (Operation *u2 : llvm::make_early_inc_range(ex.getResult().getUsers())) {
              auto p2 = cast<llhd::ProbeOp>(u2);
              p2.getResult().replaceAllUsesWith(slice); p2.erase();
            }
            ex.erase();
          }
        }
        for (unsigned i = 0; i < incs.size(); ++i) {
          OpBuilder tb(incs[i].term);
          Location tl = incs[i].term->getLoc();
          Value val;
          if (incs[i].v == arg) {
            val = arg;
          } else {
            auto &cs = incCands[i];
            auto leafVal = [&](const Cand &c) -> Value {
              return c.isValue ? c.sig : tb.create<llhd::ProbeOp>(tl, c.sig).getResult();
            };
            val = leafVal(cs.back());
            for (int j = (int)cs.size() - 2; j >= 0; --j)
              val = cs[j].cond ? tb.create<comb::MuxOp>(tl, cs[j].cond, leafVal(cs[j]), val).getResult() : leafVal(cs[j]);
          }
          auto br = cast<BranchOpInterface>(incs[i].term);
          auto so = br.getSuccessorOperands(incs[i].succ);
          so.getMutableForwardedOperands()[k - so.getProducedOperandCount()].set(val);
        }
        valueArgs.insert(arg);
        ++converted;
        progress = true;
        continue;
      }
      if (anyValueCand) {
        module.emitError("lower-inout-block-args: a value-converted arg flows into an arg with drv users");
        return failure();
      }
      if (leaves.empty()) continue;   // degenerate
      unsigned n = leaves.size();
      unsigned width = std::max(1u, (unsigned)llvm::Log2_32_Ceil(std::max(n, 2u)));
      auto ity = IntegerType::get(module.getContext(), width);

      // Rewrite non-terminator users of arg through an inout select chain
      // (S1 lowers it): sel(id==0, leaf0, sel(id==1, leaf1, ... leaf_{n-1}))
      // Build the chain lazily at the block start (after arg is retyped).
      arg.setType(ity);
      Value chain = leaves[n - 1];
      for (int i = (int)n - 2; i >= 0; --i) {
        Value ci = b.create<hw::ConstantOp>(loc, ity, (int64_t)i);
        Value eq = b.create<comb::ICmpOp>(loc, comb::ICmpPredicate::eq, arg, ci);
        chain = b.create<arith::SelectOp>(loc, eq, leaves[i], chain);
      }
      for (OpOperand &use : llvm::make_early_inc_range(arg.getUses())) {
        Operation *owner = use.getOwner();
        if (owner->hasTrait<OpTrait::IsTerminator>()) continue;   // forwarding: id passes through
        if (owner == chain.getDefiningOp()) continue;
        // ops inside the chain reference arg legitimately (icmp)
        if (isa<comb::ICmpOp>(owner) && owner->getBlock() == bb &&
            owner->getOperand(0) == arg) {
          bool inChain = false;
          for (Operation *cu : owner->getResult(0).getUsers())
            if (isa<arith::SelectOp>(cu) && isInOutTy(cu->getResult(0).getType())) inChain = true;
          if (inChain) continue;
        }
        use.set(chain);
      }
      // Predecessors: pass the candidate id (constant / select over ids /
      // remapped selector).
      for (unsigned i = 0; i < incs.size(); ++i) {
        OpBuilder tb(incs[i].term);
        Location tl = incs[i].term->getLoc();
        Value idv;
        if (incs[i].v == arg) {
          idv = arg;   // self loop: keep the selector
        } else {
          // build: cond_j ? id_j : ... over incCands (last one unconditional)
          auto &cs = incCands[i];
          auto idxOf = [&](Value s) { return (int64_t)(std::find(leaves.begin(), leaves.end(), s) - leaves.begin()); };
          idv = tb.create<hw::ConstantOp>(tl, ity, idxOf(cs.back().sig));
          for (int j = (int)cs.size() - 2; j >= 0; --j) {
            Value cj = tb.create<hw::ConstantOp>(tl, ity, idxOf(cs[j].sig));
            idv = cs[j].cond ? tb.create<comb::MuxOp>(tl, cs[j].cond, cj, idv).getResult() : cj;
          }
        }
        auto br = cast<BranchOpInterface>(incs[i].term);
        auto so = br.getSuccessorOperands(incs[i].succ);
        so.getMutableForwardedOperands()[k - so.getProducedOperandCount()].set(idv);
      }
      argTables[arg] = leaves;
      ++converted;
      progress = true;
    }
    if (!progress) {
      module.emitError("lower-inout-block-args: stuck (unsupported predecessor shape)");
      return failure();
    }
  }
  return module.emitError("lower-inout-block-args: no fixpoint after 64 rounds");
}

//===----------------------------------------------------------------------===//
// Pass driver
//===----------------------------------------------------------------------===//

struct ExplodeStructSigsPass
    : public ::impl::ExplodeStructSigsBase<ExplodeStructSigsPass> {
  using ExplodeStructSigsBase::ExplodeStructSigsBase;

  void runOnOperation() override {
    ModuleOp module = getOperation();

    // Normalize constant-index llhd.sig.array_slice into per-element
    // llhd.sig.array_get references.  alert_handler's per-LPG mubi
    // synchronizers write elements through length-1 slices (48 sites);
    // aes_key_expand's word-shift assignments (regular[5:2] = key[3:0])
    // produce length-N slices.  Both are semantically a run of element
    // references: driving users become one drv per element (value
    // unwrapped with hw.array_get), probing users re-assemble the run
    // with hw.array_create.  Leaves dynamic-index slices untouched (the
    // explode walk will then reject them loudly as before).
    {
      SmallVector<llhd::SigArraySliceOp> slices;
      module.walk([&](llhd::SigArraySliceOp s) { slices.push_back(s); });
      for (auto s : slices) {
        auto resTy = dyn_cast<llhd::RefType>(s.getResult().getType());
        auto arrTy =
            resTy ? dyn_cast<hw::ArrayType>(resTy.getNestedType()) : nullptr;
        if (!arrTy)
          continue;
        auto idxC = s.getLowIndex().getDefiningOp<hw::ConstantOp>();
        if (!idxC)
          continue;
        unsigned numElems = arrTy.getNumElements();
        APInt base = idxC.getValue();
        // hw.array_get on the drv'd value (an array<numElems x T>) wants a
        // ceil(log2(numElems))-bit index, minimum 1 bit.
        unsigned valIdxWidth =
            std::max(1u, llvm::Log2_64_Ceil(std::max(numElems, 2u)));
        OpBuilder b(s);
        SmallVector<Value> elemRefs;
        for (unsigned k = 0; k < numElems; ++k) {
          auto idxK = b.create<hw::ConstantOp>(
              s.getLoc(), base + APInt(base.getBitWidth(), k));
          elemRefs.push_back(
              b.create<llhd::SigArrayGetOp>(s.getLoc(), s.getInput(), idxK)
                  .getResult());
        }
        bool allHandled = true;
        for (Operation *user :
             llvm::make_early_inc_range(s.getResult().getUsers())) {
          if (auto drv = dyn_cast<llhd::DriveOp>(user)) {
            OpBuilder db(drv);
            for (unsigned k = 0; k < numElems; ++k) {
              auto valIdx = db.create<hw::ConstantOp>(
                  drv.getLoc(), db.getIntegerType(valIdxWidth), k);
              auto unwrapped = db.create<hw::ArrayGetOp>(
                  drv.getLoc(), drv.getValue(), valIdx);
              db.create<llhd::DriveOp>(drv.getLoc(), elemRefs[k],
                                     unwrapped.getResult(), drv.getTime(),
                                     drv.getEnable());
            }
            drv.erase();
            continue;
          }
          if (auto prb = dyn_cast<llhd::ProbeOp>(user)) {
            OpBuilder pb(prb);
            // hw.array_create takes operands most-significant first
            // (operand 0 becomes element numElems-1).
            SmallVector<Value> elemVals;
            for (unsigned k = numElems; k-- > 0;)
              elemVals.push_back(
                  pb.create<llhd::ProbeOp>(prb.getLoc(), elemRefs[k])
                      .getResult());
            auto wrapped =
                pb.create<hw::ArrayCreateOp>(prb.getLoc(), elemVals);
            prb.getResult().replaceAllUsesWith(wrapped.getResult());
            prb.erase();
            continue;
          }
          allHandled = false;
        }
        if (allHandled && s.getResult().use_empty())
          s.erase();
      }
    }

    unsigned selsLowered = 0, argsConverted = 0;
    const bool noS1 = getenv("QP_NO_S1"), noS2 = getenv("QP_NO_S2");
    if ((!noS1 && failed(lowerInOutSelects(module, selsLowered))) ||
        (!noS2 && failed(lowerInOutBlockArgs(module, argsConverted))) ||
        (!noS1 && failed(lowerInOutSelects(module, selsLowered)))) {
      signalPassFailure();
      return;
    }

    constexpr int kMaxIterations = 16;
    int iter = 0;
    int totalExploded = 0;
    for (; iter < kMaxIterations; ++iter) {
      // The dynamic-index (S3) rewrite of an aggregate array leaves inout
      // `arith.select` chains over its ELEMENT sigs; lower them before the
      // elements themselves are exploded (explodeStructOne has no select case).
      if (!noS1 && failed(lowerInOutSelects(module, selsLowered))) {
        signalPassFailure();
        return;
      }
      auto aggSigs = collectAggregateSigs(module);
      if (aggSigs.empty())
        break;
      for (llhd::SignalOp sigOp : aggSigs) {
        std::string nm = sigOp.getName().has_value() ? sigOp.getName()->str() : "?";
        if (failed(explodeOne(sigOp))) {
          signalPassFailure();
          return;
        }
        ++totalExploded;
        if (getenv("QP_EXPLODE_VERIFY") && failed(mlir::verify(module))) {
          llvm::errs() << "[explode-struct-sigs] module INVALID after exploding " << nm << "\n";
          signalPassFailure();
          return;
        }
      }
    }

    if (iter >= kMaxIterations && !collectAggregateSigs(module).empty()) {
      module.emitError(
          "explode-struct-sigs: aggregate nesting exceeded iteration limit ")
          << kMaxIterations;
      signalPassFailure();
      return;
    }

    // Dynamic-index explosion may leave inout select chains behind.
    if (!noS1 && failed(lowerInOutSelects(module, selsLowered))) {
      signalPassFailure();
      return;
    }
    llvm::errs() << "[explode-struct-sigs] exploded " << totalExploded
                 << " aggregate sig(s) in " << iter << " iteration(s); "
                 << "sig-ref lowering: " << selsLowered << " inout select(s), "
                 << argsConverted << " inout block arg(s)\n";

    qemu_passes::writePassReport(
        "explode_struct_sigs",
        [&](llvm::raw_ostream &os) {
          os << "Explode Aggregate Sigs — summary\n";
          os << "================================\n";
          os << "Aggregate sigs exploded: " << totalExploded << "\n";
          os << "Fixed-point iterations:  " << iter << "\n";
          os << "Iteration cap:           " << kMaxIterations << "\n";
        });
  }
};

}  // namespace
