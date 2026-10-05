//===- BusProfileLoadPass.cpp - Load per-peripheral bus binding ----*-C++-*-===//
//
// Reads a <peripheral>.bus.json file (path passed via --binding-path),
// validates each role binding against the IR (signal existence + width),
// and attaches a flattened `qemu.bus_profile` DictionaryAttr on the top
// ModuleOp. Downstream passes consume this attribute instead of hardcoding
// bus signal names like 'pwrite' / 'a_valid'.
//
// Schema reference: see qemu-passes/gpio0_simplified.bus.json for the canonical
// shape. Roles and validation rules are documented in that file's _doc_* keys.
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/Pass/Pass.h"

#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/HW/HWTypes.h"
#include "circt/Dialect/LLHD/LLHDOps.h"

#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_BUSPROFILELOAD
#define GEN_PASS_DEF_BUSPROFILELOAD
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Canonical role vocabulary (must match keys under "bindings" in *.bus.json)
//===----------------------------------------------------------------------===//

// Closed role vocabulary. v1: 4 semantic roles. Other "control plane"
// signals (psel/penable/a_valid/a_ready/...) are listed in the top-level
// noise_signals array, NOT as roles.
static constexpr llvm::StringLiteral kRoles[] = {
    "addr",      // address bus
    "wdata",     // write data bus
    "rdata",     // read data bus
    "wr_enable"  // R/W direction signal (APB pwrite / AHB hwrite / TL-UL a_opcode)
};

// Comment / metadata keys that the loader silently ignores.
static bool isCommentKey(llvm::StringRef k) {
  return k.starts_with("_") || k == "$schema_version";
}

//===----------------------------------------------------------------------===//
// JSON value -> MLIR Attribute conversion for a single role binding.
// Returns UnitAttr on JSON null (= role unbound), DictionaryAttr otherwise.
//===----------------------------------------------------------------------===//

static Attribute roleBindingToAttr(MLIRContext *ctx,
                                   const llvm::json::Value &v,
                                   llvm::StringRef role,
                                   std::string &errOut) {
  if (v.kind() == llvm::json::Value::Null)
    return UnitAttr::get(ctx);

  const auto *obj = v.getAsObject();
  if (!obj) {
    errOut = ("role '" + role + "': expected object or null").str();
    return nullptr;
  }

  llvm::SmallVector<NamedAttribute, 6> entries;
  for (const auto &kv : *obj) {
    llvm::StringRef k = kv.first;
    if (isCommentKey(k))
      continue;
    if (auto sv = kv.second.getAsString()) {
      entries.emplace_back(StringAttr::get(ctx, k),
                           StringAttr::get(ctx, *sv));
    } else if (auto iv = kv.second.getAsInteger()) {
      entries.emplace_back(StringAttr::get(ctx, k),
                           IntegerAttr::get(IntegerType::get(ctx, 64), *iv));
    } else {
      errOut =
          (llvm::Twine("role '") + role + "': unsupported value type for key '" +
           k + "' (only string/integer accepted in v1)").str();
      return nullptr;
    }
  }
  return DictionaryAttr::get(ctx, entries);
}

/// Return the C-side flattened signal name represented by a binding.  Scalar
/// Wujian100 APB/AHB ports use kind=signal.  struct_field is kept usable for
/// already-flattened CIRCT input by following the same carrier_field spelling
/// convention as FunctionalBusTxnInferPass.
static std::string getBoundSignalName(DictionaryAttr bindings,
                                      llvm::StringRef role) {
  auto binding = bindings.getAs<DictionaryAttr>(role);
  if (!binding)
    return {};
  if (auto resolved = binding.getAs<StringAttr>("resolved_name"))
    return resolved.getValue().str();
  auto kind = binding.getAs<StringAttr>("kind");
  if (!kind)
    return {};
  if (kind.getValue() == "signal") {
    if (auto name = binding.getAs<StringAttr>("name"))
      return name.getValue().str();
  } else if (kind.getValue() == "struct_field") {
    auto carrier = binding.getAs<StringAttr>("carrier");
    auto field = binding.getAs<StringAttr>("field");
    if (carrier && field)
      return (carrier.getValue() + "_" + field.getValue()).str();
  }
  return {};
}

static unsigned getBoundWidth(DictionaryAttr bindings, llvm::StringRef role) {
  if (auto binding = bindings.getAs<DictionaryAttr>(role))
    if (auto width = binding.getAs<IntegerAttr>("width"))
      return static_cast<unsigned>(width.getInt());
  return 0;
}

//===----------------------------------------------------------------------===//
// Pass
//===----------------------------------------------------------------------===//

struct BusProfileLoadPass
    : public ::impl::BusProfileLoadBase<BusProfileLoadPass> {
  using ::impl::BusProfileLoadBase<BusProfileLoadPass>::BusProfileLoadBase;

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();

    if (bindingPath.empty()) {
      mod.emitError(
          "bus-profile-load: --binding-path=<path-to-*.bus.json> is required");
      return signalPassFailure();
    }

    // ---- 1. Read file ----
    auto bufOrErr = llvm::MemoryBuffer::getFile(bindingPath);
    if (!bufOrErr) {
      mod.emitError() << "bus-profile-load: cannot open " << bindingPath
                      << ": " << bufOrErr.getError().message();
      return signalPassFailure();
    }

    // ---- 2. Parse JSON ----
    auto parsed = llvm::json::parse((*bufOrErr)->getBuffer());
    if (!parsed) {
      mod.emitError() << "bus-profile-load: JSON parse error in " << bindingPath
                      << ": " << llvm::toString(parsed.takeError());
      return signalPassFailure();
    }
    const auto *root = parsed->getAsObject();
    if (!root) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": top-level JSON value must be an object";
      return signalPassFailure();
    }

    // ---- 3. Schema version ----
    auto ver = root->getInteger("$schema_version");
    if (!ver || *ver != 1) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": unsupported or missing $schema_version (expected 1)";
      return signalPassFailure();
    }

    // ---- 4. design.{top_module, bus_adapter_modules} ----
    const auto *design = root->getObject("design");
    if (!design) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": missing 'design' object";
      return signalPassFailure();
    }
    auto topModuleOpt = design->getString("top_module");
    if (!topModuleOpt) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": design.top_module missing or not a string";
      return signalPassFailure();
    }
    StringRef topModule = *topModuleOpt;

    hw::HWModuleOp topHwModule = nullptr;
    mod.walk([&](hw::HWModuleOp hwMod) -> WalkResult {
      if (hwMod.getName() == topModule) {
        topHwModule = hwMod;
        return WalkResult::interrupt();
      }
      return WalkResult::advance();
    });
    if (!topHwModule) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": design.top_module @" << topModule
                      << " not found in IR";
      return signalPassFailure();
    }

    llvm::SmallVector<Attribute, 4> adapterAttrs;
    if (const auto *arr = design->getArray("bus_adapter_modules")) {
      for (const auto &v : *arr) {
        auto s = v.getAsString();
        if (!s)
          continue;
        adapterAttrs.push_back(StringAttr::get(ctx, *s));
        bool exists = false;
        mod.walk([&](hw::HWModuleOp m) -> WalkResult {
          if (m.getName() == *s) {
            exists = true;
            return WalkResult::interrupt();
          }
          return WalkResult::advance();
        });
        if (!exists)
          mod.emitWarning()
              << "bus-profile-load: bus_adapter_module @" << *s
              << " declared in " << bindingPath << " but not found in IR";
      }
    }

    // ---- 5. bindings: validate each role, build per-role attrs ----
    const auto *bindings = root->getObject("bindings");
    if (!bindings) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": missing 'bindings' object";
      return signalPassFailure();
    }

    llvm::SmallVector<NamedAttribute, 16> bindingEntries;
    llvm::DenseSet<StringRef> boundRoles;

    for (auto roleLit : kRoles) {
      StringRef role(roleLit);
      const auto *v = bindings->get(role);
      if (!v) {
        mod.emitError()
            << "bus-profile-load: " << bindingPath
            << ": bindings missing key '" << role
            << "' (use null if not applicable; do not omit)";
        return signalPassFailure();
      }

      std::string err;
      Attribute attr = roleBindingToAttr(ctx, *v, role, err);
      if (!attr) {
        mod.emitError() << "bus-profile-load: " << bindingPath << ": " << err;
        return signalPassFailure();
      }

      // Validate non-null bindings against IR.
      if (auto dict = dyn_cast<DictionaryAttr>(attr)) {
        auto kindAttr = dict.getAs<StringAttr>("kind");
        if (!kindAttr) {
          mod.emitError() << "bus-profile-load: " << bindingPath
                          << ": role '" << role
                          << "' missing required 'kind'";
          return signalPassFailure();
        }

        auto scope = dict.getAs<StringAttr>("module");
        if (scope && scope.getValue() != topModule) {
          mod.emitError("bus-profile-load: v1 bus roles must bind top-module ports; internal module bindings are unsupported");
          return signalPassFailure();
        }
        auto name = dict.getAs<StringAttr>(kindAttr.getValue() == "struct_field" ? "carrier" : "name");
        if (!name || (kindAttr.getValue() != "signal" && kindAttr.getValue() != "struct_field")) {
          mod.emitError("bus-profile-load: expected signal name or struct_field carrier");
          return signalPassFailure();
        }
        Type resolvedType;
        bool output = role == "rdata";
        for (auto port : topHwModule.getPortList())
          if (port.getName() == name.getValue() &&
              port.dir == (output ? hw::ModulePort::Direction::Output : hw::ModulePort::Direction::Input))
            resolvedType = port.type;
        std::string resolvedName = name.getValue().str();
        if (kindAttr.getValue() == "struct_field") {
          auto field = dict.getAs<StringAttr>("field");
          if (!field) {
            mod.emitError("bus-profile-load: struct_field requires field");
            return signalPassFailure();
          }
          SmallVector<StringRef> parts;
          field.getValue().split(parts, '.');
          for (auto part : parts) {
            auto st = dyn_cast_or_null<hw::StructType>(resolvedType);
            Type next;
            if (st)
              for (auto elem : st.getElements())
                if (elem.name.getValue() == part) next = elem.type;
            resolvedType = next;
            resolvedName += "_" + part.str();
          }
        }
        auto intType = dyn_cast_or_null<IntegerType>(resolvedType);
        auto width = dict.getAs<IntegerAttr>("width");
        if (!intType || !width || width.getInt() < 1 || width.getInt() > 64 ||
            width.getInt() != intType.getWidth()) {
          mod.emitError() << "bus-profile-load: role '" << role
                          << "' requires an existing top port/field with correct direction and exact integer width (1..64)";
          return signalPassFailure();
        }
        if (role == "wr_enable" && intType.getWidth() != 1) {
          mod.emitError("bus-profile-load: v1 functional MMIO requires a 1-bit write direction; encoded protocols require an adapter");
          return signalPassFailure();
        }
        if (auto polarity = dict.getAs<StringAttr>("polarity"))
          if (polarity.getValue() != "active_high") {
            mod.emitError("bus-profile-load: unsupported write polarity; v1 requires active_high");
            return signalPassFailure();
          }
        NamedAttrList resolved(dict);
        resolved.set("resolved_name", StringAttr::get(ctx, resolvedName));
        attr = resolved.getDictionary(ctx);
        boundRoles.insert(role);
      }

      bindingEntries.emplace_back(StringAttr::get(ctx, role), attr);
    }

    // ---- 6. noise_signals: top-level array of strings ----
    // Each entry is a signal/field name that ForwardConstrain (and similar
    // analysis passes) should fold to a constant in Phase 3 elimination.
    // The constant value is auto-derived from collected constraints; the
    // schema only carries the name. Empty array / missing key = no folding.
    llvm::SmallVector<Attribute, 8> noiseAttrs;
    if (const auto *noiseArr = root->getArray("noise_signals")) {
      for (const auto &v : *noiseArr) {
        if (auto s = v.getAsString())
          noiseAttrs.push_back(StringAttr::get(ctx, *s));
      }
    }

    // ---- 6b. transactions: top-level array of {kind, guard:[{role,op,value}]} ----
    // BusProfileResolve consumes this to walk the IR and materialise the
    // read_drive / write_drive sequences.  Each guard clause must reference
    // a role that is non-null in bindings; we validate that here.
    llvm::SmallVector<Attribute, 4> txnAttrs;
    if (const auto *txnArr = root->getArray("transactions")) {
      for (const auto &tv : *txnArr) {
        const auto *txnObj = tv.getAsObject();
        if (!txnObj) {
          mod.emitError() << "bus-profile-load: " << bindingPath
                          << ": transactions[] entries must be objects";
          return signalPassFailure();
        }
        auto kindOpt = txnObj->getString("kind");
        if (!kindOpt) {
          mod.emitError() << "bus-profile-load: " << bindingPath
                          << ": transaction missing 'kind'";
          return signalPassFailure();
        }
        StringRef kind = *kindOpt;
        if (kind != "READ" && kind != "WRITE") {
          mod.emitError() << "bus-profile-load: " << bindingPath
                          << ": transaction kind must be READ or WRITE, got '"
                          << kind << "'";
          return signalPassFailure();
        }

        llvm::SmallVector<Attribute, 4> guardClauses;
        if (const auto *guardArr = txnObj->getArray("guard")) {
          for (const auto &gv : *guardArr) {
            const auto *gObj = gv.getAsObject();
            if (!gObj) {
              mod.emitError() << "bus-profile-load: " << bindingPath
                              << ": guard entry must be an object";
              return signalPassFailure();
            }
            auto roleOpt  = gObj->getString("role");
            auto opOpt    = gObj->getString("op");
            auto valueOpt = gObj->getInteger("value");
            if (!roleOpt || !opOpt || !valueOpt) {
              mod.emitError() << "bus-profile-load: " << bindingPath
                              << ": guard requires {role, op, value}";
              return signalPassFailure();
            }
            if (*roleOpt != "wr_enable" || *opOpt != "eq" ||
                *valueOpt != (kind == "WRITE" ? 1 : 0)) {
              mod.emitError("bus-profile-load: unsupported transaction guard; v1 requires wr_enable == 0 for READ and == 1 for WRITE");
              return signalPassFailure();
            }
            if (!boundRoles.contains(*roleOpt)) {
              mod.emitError()
                  << "bus-profile-load: " << bindingPath
                  << ": transaction guard references unbound role '"
                  << *roleOpt << "'";
              return signalPassFailure();
            }
            llvm::SmallVector<NamedAttribute, 3> clause;
            clause.emplace_back(StringAttr::get(ctx, "role"),
                                StringAttr::get(ctx, *roleOpt));
            clause.emplace_back(StringAttr::get(ctx, "op"),
                                StringAttr::get(ctx, *opOpt));
            clause.emplace_back(
                StringAttr::get(ctx, "value"),
                IntegerAttr::get(IntegerType::get(ctx, 64), *valueOpt));
            guardClauses.push_back(DictionaryAttr::get(ctx, clause));
          }
        }

        llvm::SmallVector<NamedAttribute, 2> entry;
        entry.emplace_back(StringAttr::get(ctx, "kind"),
                           StringAttr::get(ctx, kind));
        entry.emplace_back(StringAttr::get(ctx, "guard"),
                           ArrayAttr::get(ctx, guardClauses));
        txnAttrs.push_back(DictionaryAttr::get(ctx, entry));
      }
    }

    auto bindingsAttr = DictionaryAttr::get(ctx, bindingEntries);

    // ---- 7. Materialise the declarative profile for the existing generic
    // QEMU emitter.  qemu.functional_txns is the protocol-independent data
    // contract consumed by QEMUEmitCPass; until now BusProfileLoad only wrote
    // qemu.bus_profile, so a valid JSON profile had no effect on C emission.
    llvm::SmallVector<Attribute, 4> functionalTxnAttrs;
    for (Attribute txnAttr : txnAttrs) {
      auto txn = dyn_cast<DictionaryAttr>(txnAttr);
      auto kindAttr = txn ? txn.getAs<StringAttr>("kind") : StringAttr();
      if (!kindAttr)
        continue;

      StringRef kind = kindAttr.getValue();
      std::string addr = getBoundSignalName(bindingsAttr, "addr");
      std::string wdata = getBoundSignalName(bindingsAttr, "wdata");
      std::string rdata = getBoundSignalName(bindingsAttr, "rdata");
      std::string wrEnable = getBoundSignalName(bindingsAttr, "wr_enable");

      if (addr.empty() || (kind == "WRITE" && wdata.empty()) ||
          (kind == "READ" && rdata.empty())) {
        mod.emitError() << "bus-profile-load: " << bindingPath
                        << ": transaction " << kind
                        << " lacks its required addr/data binding";
        return signalPassFailure();
      }

      llvm::SmallVector<NamedAttribute, 12> fields;
      auto addString = [&](StringRef key, const std::string &value) {
        if (!value.empty())
          fields.emplace_back(StringAttr::get(ctx, key),
                              StringAttr::get(ctx, value));
      };
      auto addWidth = [&](StringRef key, unsigned value) {
        if (value)
          fields.emplace_back(
              StringAttr::get(ctx, key),
              IntegerAttr::get(IntegerType::get(ctx, 64), value));
      };
      fields.emplace_back(StringAttr::get(ctx, "kind"), kindAttr);
      fields.emplace_back(StringAttr::get(ctx, "confidence"),
                          FloatAttr::get(Float64Type::get(ctx), 1.0));
      fields.emplace_back(StringAttr::get(ctx, "weak"),
                          BoolAttr::get(ctx, false));
      fields.emplace_back(StringAttr::get(ctx, "is_bus_write"),
                          BoolAttr::get(ctx, kind == "WRITE"));
      addString("addr_signal", addr);
      addWidth("addr_width", getBoundWidth(bindingsAttr, "addr"));
      if (kind == "WRITE") {
        addString("wdata_signal", wdata);
        addWidth("wdata_width", getBoundWidth(bindingsAttr, "wdata"));
      } else {
        addString("rdata_signal", rdata);
        addWidth("rdata_width", getBoundWidth(bindingsAttr, "rdata"));
      }
      addString("enable_signal", wrEnable);
      functionalTxnAttrs.push_back(DictionaryAttr::get(ctx, fields));
    }
    if (functionalTxnAttrs.empty()) {
      mod.emitError() << "bus-profile-load: " << bindingPath
                      << ": no READ/WRITE transactions were declared";
      return signalPassFailure();
    }
    topHwModule->setAttr("qemu.functional_txns",
                         ArrayAttr::get(ctx, functionalTxnAttrs));
    topHwModule->setAttr("qemu.bus_profile_declared", UnitAttr::get(ctx));
    topHwModule->setAttr("qemu.protocol_constraints",
                         ArrayAttr::get(ctx, noiseAttrs));

    // ---- 8. Attach qemu.bus_profile on ModuleOp ----
    llvm::SmallVector<NamedAttribute, 5> profile;
    profile.emplace_back(StringAttr::get(ctx, "top_module"),
                         StringAttr::get(ctx, topModule));
    profile.emplace_back(StringAttr::get(ctx, "bus_adapter_modules"),
                         ArrayAttr::get(ctx, adapterAttrs));
    profile.emplace_back(StringAttr::get(ctx, "bindings"),
                         bindingsAttr);
    profile.emplace_back(StringAttr::get(ctx, "noise_signals"),
                         ArrayAttr::get(ctx, noiseAttrs));
    profile.emplace_back(StringAttr::get(ctx, "transactions"),
                         ArrayAttr::get(ctx, txnAttrs));

    mod->setAttr("qemu.bus_profile", DictionaryAttr::get(ctx, profile));

    llvm::outs() << "[bus-profile-load] " << bindingPath << ": top=@"
                 << topModule << ", bound_roles=" << boundRoles.size()
                 << ", noise_signals=" << noiseAttrs.size()
                 << ", transactions=" << txnAttrs.size() << "\n";
  }
};

} // namespace
