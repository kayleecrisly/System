// External, per-project QOM shim descriptions. No hardware behavior lives here.
#ifndef QEMU_PASSES_DEVICE_CATALOG_H
#define QEMU_PASSES_DEVICE_CATALOG_H

#include "llvm/ADT/StringRef.h"
#include "llvm/Support/Error.h"
#include <cstdint>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace qemu_passes {

struct ShimProp {
  std::string nameStr;
  std::string macro;
  std::string fieldType;
  std::string fieldName;
  std::string extraArgs;
};

struct DeviceShim {
  std::string typeNameMacro;
  std::string structName;
  std::string typeMacroBase;
  unsigned irqCount = 0;
  std::vector<ShimProp> properties;
  bool keySinkIf = false;
  bool irqCountDeclared = false;
  std::optional<uint64_t> mmioSize;
  std::string backend = "generic-sysbus";
};

class DeviceCatalog {
public:
  static llvm::Expected<DeviceCatalog> load(llvm::StringRef path);
  // Look up by the IR top module, even when the emitted device name is overridden.
  llvm::Expected<DeviceShim> resolve(llvm::StringRef module,
                                     llvm::StringRef emittedName,
                                     unsigned inferredIrqCount) const;

private:
  DeviceShim makeGeneric(llvm::StringRef name) const;
  bool allowGeneric = false;
  std::string qomPrefix, statePrefix, macroPrefix;
  std::vector<ShimProp> genericProperties;
  std::string backend = "generic-sysbus";
  std::map<std::string, DeviceShim> devices;
};

} // namespace qemu_passes
#endif
