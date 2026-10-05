//===- BusProfileQuery.cpp - Implementation -------------------------------===//

#include "BusProfileQuery.h"

#include "mlir/IR/Operation.h"
#include "llvm/ADT/SmallVector.h"

using namespace mlir;
using namespace circt;

namespace qemu_passes {

// ----- Construction --------------------------------------------------------

std::optional<BusProfileQuery>
BusProfileQuery::fromModule(ModuleOp mod) {
  auto profile = mod->getAttrOfType<DictionaryAttr>("qemu.bus_profile");
  if (!profile)
    return std::nullopt;

  auto topNameAttr = profile.getAs<StringAttr>("top_module");
  if (!topNameAttr)
    return std::nullopt;
  StringRef topName = topNameAttr.getValue();

  hw::HWModuleOp topMod;
  mod.walk([&](hw::HWModuleOp m) -> WalkResult {
    if (m.getName() == topName) {
      topMod = m;
      return WalkResult::interrupt();
    }
    return WalkResult::advance();
  });
  if (!topMod)
    return std::nullopt;

  return BusProfileQuery(profile, topMod, topName);
}

BusProfileQuery::BusProfileQuery(DictionaryAttr profile,
                                 hw::HWModuleOp topMod,
                                 StringRef topName)
    : profile_(profile), topMod_(topMod), topModuleName_(topName.str()) {}

// ----- Per-role binding lookup --------------------------------------------

DictionaryAttr BusProfileQuery::getBindingDict(StringRef role) const {
  auto bindings = profile_.getAs<DictionaryAttr>("bindings");
  if (!bindings)
    return {};

  // Each binding is either:
  //   - DictionaryAttr (non-null binding with kind/name/...)
  //   - UnitAttr (= JSON null, role unbound)
  // .getAs<DictionaryAttr> returns null in the UnitAttr case, which is
  // the correct "unbound" answer.
  return bindings.getAs<DictionaryAttr>(role);
}

bool BusProfileQuery::hasRole(StringRef role) const {
  return (bool)getBindingDict(role);
}

// ----- Signal name resolution ---------------------------------------------

std::optional<StringRef>
BusProfileQuery::getSignalName(StringRef role) const {
  DictionaryAttr binding = getBindingDict(role);
  if (!binding)
    return std::nullopt;

  if (auto resolved = binding.getAs<StringAttr>("resolved_name"))
    return resolved.getValue();

  auto kindAttr = binding.getAs<StringAttr>("kind");
  if (!kindAttr)
    return std::nullopt;

  if (kindAttr.getValue() == "signal") {
    if (auto nameAttr = binding.getAs<StringAttr>("name"))
      return nameAttr.getValue();
  } else if (kindAttr.getValue() == "struct_field") {
    if (auto fieldAttr = binding.getAs<StringAttr>("field"))
      return fieldAttr.getValue();
  }
  return std::nullopt;
}

std::optional<unsigned>
BusProfileQuery::getWidth(StringRef role) const {
  DictionaryAttr binding = getBindingDict(role);
  if (!binding)
    return std::nullopt;
  if (auto wAttr = binding.getAs<IntegerAttr>("width"))
    return (unsigned)wAttr.getInt();
  return std::nullopt;
}

// ----- Convenience: join signal names of a role list ---------------------

std::string
BusProfileQuery::joinSignalNames(ArrayRef<StringRef> roles) const {
  llvm::SmallVector<std::string, 8> names;
  for (StringRef role : roles) {
    if (auto n = getSignalName(role))
      names.push_back(n->str());
  }
  std::string out;
  for (size_t i = 0; i < names.size(); ++i) {
    if (i)
      out += ',';
    out += names[i];
  }
  return out;
}

// ----- noise_signals accessors --------------------------------------------

llvm::SmallVector<StringRef, 8> BusProfileQuery::getNoiseSignals() const {
  llvm::SmallVector<StringRef, 8> out;
  auto arr = profile_.getAs<ArrayAttr>("noise_signals");
  if (!arr)
    return out;
  for (Attribute a : arr) {
    if (auto s = dyn_cast<StringAttr>(a))
      out.push_back(s.getValue());
  }
  return out;
}

std::string BusProfileQuery::getNoiseSignalsJoined() const {
  std::string out;
  bool first = true;
  for (StringRef n : getNoiseSignals()) {
    if (!first) out += ',';
    out += n.str();
    first = false;
  }
  return out;
}

} // namespace qemu_passes
