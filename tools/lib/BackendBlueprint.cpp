//===----------------------------------------------------------------------===//
// BackendBlueprint.cpp - Shared blueprint attribute builders (see header).
//===----------------------------------------------------------------------===//

#include "BackendBlueprint.h"
#include "mlir/IR/BuiltinTypes.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"

using namespace mlir;
using namespace circt;

namespace qemu_passes {

DictionaryAttr buildChardevBlueprintAttr(MLIRContext *ctx,
                                         const DeviceBlueprint &bp) {
  auto str = [&](StringRef s) { return StringAttr::get(ctx, s); };
  auto u64 = [&](uint64_t v) {
    return IntegerAttr::get(IntegerType::get(ctx, 64), v);
  };

  SmallVector<NamedAttribute> top;
  if (bp.tx.has_value()) {
    const auto &tx = *bp.tx;
    SmallVector<NamedAttribute> txDict;
    txDict.push_back({str("fifo_instance"), str(tx.fifoInstance)});
    txDict.push_back({str("parent_module"), str(tx.parentModule)});
    txDict.push_back({str("wvalid_source"), str(tx.wvalidSource)});
    if (!tx.nameHint.empty())
      txDict.push_back({str("namehint"), str(tx.nameHint)});
    if (tx.strobeMatched) {
      txDict.push_back({str("strobe_reg_name"), str(tx.strobeRegName)});
      txDict.push_back({str("trigger_offset"), u64(tx.strobeOffset)});
    }
    if (!bp.drainTopPort.empty())
      txDict.push_back({str("drain_top_port"), str(bp.drainTopPort)});
    top.push_back({str("tx"), DictionaryAttr::get(ctx, txDict)});
  }
  if (bp.rx.has_value()) {
    const auto &rx = *bp.rx;
    SmallVector<NamedAttribute> rxDict;
    rxDict.push_back({str("fifo_instance"), str(rx.fifoInstance)});
    rxDict.push_back({str("parent_module"), str(rx.parentModule)});
    rxDict.push_back({str("wvalid_source"), str(rx.wvalidSource)});
    if (!rx.nameHint.empty())
      rxDict.push_back({str("namehint"), str(rx.nameHint)});
    if (rx.strobeMatched) {
      rxDict.push_back({str("strobe_reg_name"), str(rx.strobeRegName)});
      rxDict.push_back({str("pop_offset"), u64(rx.strobeOffset)});
    }
    if (!bp.sourceTopPort.empty())
      rxDict.push_back({str("source_top_port"), str(bp.sourceTopPort)});
    top.push_back({str("rx"), DictionaryAttr::get(ctx, rxDict)});
  }
  // OPTIONAL system-loopback role: a model state-struct field that gates
  // internal TX->RX routing.  Top-level key (sibling of tx/rx); omitted when
  // empty so non-loopback devices keep the exact prior attr shape.
  if (!bp.loopbackField.empty())
    top.push_back({str("loopback_field"), str(bp.loopbackField)});
  return DictionaryAttr::get(ctx, top);
}

DictionaryAttr buildIrqBlueprintAttr(MLIRContext *ctx, int64_t intrStateOff,
                                     int64_t intrEnableOff, int64_t alertTestOff,
                                     unsigned irqCount) {
  auto str = [&](StringRef s) { return StringAttr::get(ctx, s); };
  auto u64 = [&](uint64_t v) {
    return IntegerAttr::get(IntegerType::get(ctx, 64), v);
  };
  SmallVector<NamedAttribute> irqDict;
  irqDict.push_back({str("intr_state_offset"), u64((uint64_t)intrStateOff)});
  // intr_enable is OPTIONAL (e.g. aon_timer has no INTR_ENABLE register).
  if (intrEnableOff >= 0)
    irqDict.push_back({str("intr_enable_offset"), u64((uint64_t)intrEnableOff)});
  if (alertTestOff >= 0)
    irqDict.push_back({str("alert_test_offset"), u64((uint64_t)alertTestOff)});
  irqDict.push_back({str("irq_count"), u64(irqCount)});
  return DictionaryAttr::get(ctx, irqDict);
}

DictionaryAttr buildPinIoBlueprintAttr(MLIRContext *ctx, const PinIoInfo &pin) {
  auto str = [&](StringRef s) { return StringAttr::get(ctx, s); };
  auto u64 = [&](uint64_t v) {
    return IntegerAttr::get(IntegerType::get(ctx, 64), v);
  };
  // Emit a role only when its port is present — a device may have just data
  // inputs, just outputs, or the full out/oe/in triple.  Keys are ROLE names,
  // never device names (genericity: the emitter consumes roles, not "gpio").
  SmallVector<NamedAttribute> d;
  if (!pin.dataOutPort.empty()) {
    d.push_back({str("data_out_port"), str(pin.dataOutPort)});
    d.push_back({str("data_out_width"), u64(pin.dataOutWidth)});
  }
  if (!pin.oePort.empty()) {
    d.push_back({str("output_enable_port"), str(pin.oePort)});
    d.push_back({str("output_enable_width"), u64(pin.oeWidth)});
  }
  if (!pin.dataInPort.empty()) {
    d.push_back({str("data_in_port"), str(pin.dataInPort)});
    d.push_back({str("data_in_width"), u64(pin.dataInWidth)});
  }
  return DictionaryAttr::get(ctx, d);
}

} // namespace qemu_passes
