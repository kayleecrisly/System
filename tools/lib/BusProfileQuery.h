//===- BusProfileQuery.h - Read-side helper for qemu.bus_profile -*-C++-*-===//
//
// Wraps the qemu.bus_profile DictionaryAttr that BusProfileLoadPass attaches
// to the top ModuleOp. Downstream passes call:
//
//   auto profile = BusProfileQuery::fromModule(getOperation());
//   if (!profile) { /* no bus profile attached */ }
//   else if (auto addr = profile->getSignalName("addr"))
//     targetSignal = addr->str();
//
// instead of grepping the IR for "paddr" / "a_address" / etc.
//
// v1 supports kind=signal and kind=struct_field bindings only. Returns
// signal NAMES (strings); does not resolve to mlir::Value. Downstream
// passes consume the strings the same way they consume CLI-supplied
// signal names.
//
//===----------------------------------------------------------------------===//

#ifndef QEMU_PASSES_BUS_PROFILE_QUERY_H
#define QEMU_PASSES_BUS_PROFILE_QUERY_H

#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"

#include <optional>
#include <string>

namespace qemu_passes {

class BusProfileQuery {
public:
  // Construct from a ModuleOp that carries qemu.bus_profile.
  // Returns nullopt if no profile is attached, or if the declared
  // top_module is not present in the IR.
  static std::optional<BusProfileQuery> fromModule(mlir::ModuleOp mod);

  // Return the signal name for a role, or nullopt if the role is unbound.
  //   kind=signal       -> the .name field      (e.g. "pwrite", "paddr")
  //   kind=struct_field -> the .field field     (e.g. "a_opcode", "a_address")
  std::optional<llvm::StringRef> getSignalName(llvm::StringRef role) const;

  // The bit width declared in the binding (not re-validated against IR).
  std::optional<unsigned> getWidth(llvm::StringRef role) const;

  // True iff the role's binding is non-null.
  bool hasRole(llvm::StringRef role) const;

  // Comma-joined names of the listed roles (skipping unbound roles).
  // Empty string if all listed roles are unbound. Convenience for passes
  // that consume comma-separated string lists (e.g. ForwardConstrain's
  // busSignals option).
  std::string joinSignalNames(llvm::ArrayRef<llvm::StringRef> roles) const;

  // Returns the names listed in the top-level noise_signals array of the
  // bus profile, in declaration order. Each entry is a signal/field name
  // (string) that downstream passes should fold to a constant. The constant
  // value is NOT carried here — it's auto-derived from analysis (see
  // ForwardConstrainPass::determineReplacementValue).
  llvm::SmallVector<llvm::StringRef, 8> getNoiseSignals() const;

  // Same as getNoiseSignals but returned as a comma-joined string, for
  // passes that consume the comma-separated form (ForwardConstrain).
  std::string getNoiseSignalsJoined() const;

  llvm::StringRef getTopModuleName() const { return topModuleName_; }
  circt::hw::HWModuleOp getTopModule() const { return topMod_; }

private:
  BusProfileQuery(mlir::DictionaryAttr profile,
                  circt::hw::HWModuleOp topMod,
                  llvm::StringRef topName);

  // Returns the per-role binding DictionaryAttr, or nullptr if the role's
  // binding is null/absent.
  mlir::DictionaryAttr getBindingDict(llvm::StringRef role) const;

  mlir::DictionaryAttr profile_;
  circt::hw::HWModuleOp topMod_;
  std::string topModuleName_;
};

} // namespace qemu_passes

#endif // QEMU_PASSES_BUS_PROFILE_QUERY_H
