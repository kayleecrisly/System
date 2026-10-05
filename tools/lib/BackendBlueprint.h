//===----------------------------------------------------------------------===//
// BackendBlueprint.h - Shared backend "blueprint" attribute builders.
//
// The qemu.chardev_blueprint / qemu.irq_blueprint module attributes are the
// contract between the DETECTION layer (which recognizes device roles) and the
// EMISSION layer (generateQpShim, which reads ONLY these attrs).  Two passes
// produce them:
//   - BackendCharDevDetectPass : OT-convention auto-detection (the fast path)
//   - BackendBindingLoadPass   : a declarative binding JSON (the generic path,
//                                fillable by an AI + validated against the IR)
// To guarantee the two CANNOT drift in the attr shape they emit, both call the
// builders here.  This is the single source of truth for blueprint attr layout.
//===----------------------------------------------------------------------===//

#ifndef QEMU_PASSES_BACKEND_BLUEPRINT_H
#define QEMU_PASSES_BACKEND_BLUEPRINT_H

#include "circt/Dialect/HW/HWOps.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/MLIRContext.h"
#include "llvm/ADT/StringRef.h"
#include <cstdint>
#include <optional>
#include <string>

namespace qemu_passes {

/// One TX or RX chardev FIFO's roles (discovered by the detector OR declared
/// in a binding JSON).
struct FifoInfo {
  std::string fifoInstance;   // e.g. "u_uart_txfifo" (exact RTL instance name)
  std::string parentModule;   // e.g. "uart_core"
  std::string wvalidSource;   // e.g. "reg2hw.wdata.qe" (diagnostic)
  std::string nameHint;       // optional sv.namehint (diagnostic)
  std::string strobeRegName;  // e.g. "wdata" / "rdata" (diagnostic)
  unsigned    strobeBitIdx = 0;
  uint64_t    strobeOffset = 0;   // MMIO trigger (TX) / pop (RX) offset
  bool        strobeMatched = false;
};

/// A character device's chardev blueprint (TX/RX FIFOs + drain/source ports).
struct DeviceBlueprint {
  circt::hw::HWModuleOp topMod;
  std::optional<FifoInfo> tx;
  std::optional<FifoInfo> rx;
  std::string drainTopPort;   // cio_tx_o
  std::string sourceTopPort;  // cio_rx_i
  // OPTIONAL: flattened model state-struct field that, when nonzero, gates
  // internal TX->RX routing (system loopback).  When present, the shim mirrors
  // a TX byte into the RX buffer instead of the external chardev, matching the
  // model's own `rx_in = <this> ? tx_out : ...` mux.  Empty = no loopback role
  // (shim emits the unconditional external-write path, byte-identical to before).
  std::string loopbackField;  // e.g. "uart_core_sys_loopback"
};

/// A device's data-pin I/O roles (discovered by the detector OR declared in a
/// binding JSON).  ROLE-based, never device-specific: any device exposing a
/// data-output bus / output-enable / data-input bus gets the same generic
/// qdev_init_gpio_in/out wiring in the emitter.  Empty port name = role absent.
struct PinIoInfo {
  std::string dataOutPort;    // top-level output data bus (e.g. "cio_gpio_o")
  unsigned    dataOutWidth = 0;
  std::string oePort;         // matching output-enable bus (e.g. "cio_gpio_en_o")
  unsigned    oeWidth = 0;
  std::string dataInPort;     // top-level input data bus (e.g. "cio_gpio_i")
  unsigned    dataInWidth = 0;
};

/// Build the qemu.chardev_blueprint DictionaryAttr from a DeviceBlueprint.
mlir::DictionaryAttr buildChardevBlueprintAttr(mlir::MLIRContext *ctx,
                                               const DeviceBlueprint &bp);

/// Build the qemu.pin_io_blueprint DictionaryAttr.  Emits keys
/// {data_out_port,data_out_width,output_enable_port,output_enable_width,
///  data_in_port,data_in_width} only for roles whose port is present.
mlir::DictionaryAttr buildPinIoBlueprintAttr(mlir::MLIRContext *ctx,
                                             const PinIoInfo &pin);

/// Build the qemu.irq_blueprint DictionaryAttr.  `intrEnableOff < 0` and
/// `alertTestOff < 0` omit their respective keys (intr_enable is absent on IPs
/// like aon_timer; the shim then drives irqs[i] = INTR_STATE[i]).  Caller is
/// responsible for the validity gate (irqCount > 0 && intrStateOff >= 0).
mlir::DictionaryAttr buildIrqBlueprintAttr(mlir::MLIRContext *ctx,
                                           int64_t intrStateOff,
                                           int64_t intrEnableOff,
                                           int64_t alertTestOff,
                                           unsigned irqCount);

/// Emit a JSON "IR digest" to `path` — the AI's input for producing a binding:
/// the top module's ports (interrupts flagged), every prim_fifo_sync instance
/// (+ its traced wvalid source), and the reg_top addr-decode (regname -> MMIO
/// offset).  Exposes the structural hooks a producer needs WITHOUT OT layout
/// priors.  Defined in BackendCharDevDetectPass.cpp to reuse its IR helpers.
void dumpIrDigest(mlir::ModuleOp mod, llvm::StringRef path);


/// Largest register offset in the top device's address decode (see
/// BackendCharDevDetectPass.cpp).  0 when no reg_top can be identified.
uint64_t maxAddrDecodeOffset(mlir::ModuleOp mod);

} // namespace qemu_passes

#endif // QEMU_PASSES_BACKEND_BLUEPRINT_H
