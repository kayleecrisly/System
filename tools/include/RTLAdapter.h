#ifndef QEMU_PASSES_RTL_ADAPTER_H
#define QEMU_PASSES_RTL_ADAPTER_H
#include "mlir/IR/BuiltinOps.h"
namespace qemu_passes {
// Explicit project policy, independent of QOM/backend selection.
inline bool usesOpenTitanRTLAdapter(mlir::Operation *op) {
  while (op) {
    if (auto module = mlir::dyn_cast<mlir::ModuleOp>(op)) {
      auto adapter = module->getAttrOfType<mlir::StringAttr>("qemu.rtl_adapter");
      return adapter && adapter.getValue() == "opentitan";
    }
    op = op->getParentOp();
  }
  return false;
}
} // namespace qemu_passes
#endif
