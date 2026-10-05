#ifndef QEMU_PASSES_GENERIC_SYSBUS_EMITTER_H
#define QEMU_PASSES_GENERIC_SYSBUS_EMITTER_H
#include "DeviceCatalog.h"
#include "llvm/Support/Error.h"
#include <utility>

namespace qemu_passes {
struct PortIRQ {
  std::string field;
  unsigned bit;
};
struct GenericSysBusConfig {
  std::vector<PortIRQ> irqs;
  std::string pinInput, pinOutput, pinEnable;
  unsigned pinInputWidth = 0, pinOutputWidth = 0, pinEnableWidth = 0;
  uint64_t mmioSize = 4096;
  uint64_t pumpHz = 0;
  std::string resetPort;
  unsigned resetActive = 0;
  using Inputs = std::vector<std::pair<std::string, uint64_t>>;
  Inputs readInputs, writeInputs, idleInputs, ties;
};
llvm::Error emitGenericSysBus(llvm::StringRef name, const DeviceShim &device,
                              const GenericSysBusConfig &config,
                              llvm::StringRef outputDir);
} // namespace qemu_passes
#endif
