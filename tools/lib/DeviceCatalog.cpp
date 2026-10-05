#include "DeviceCatalog.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include <algorithm>

using namespace llvm;
using namespace qemu_passes;

namespace {
Error invalid(const Twine &where, const Twine &message) {
  return createStringError(inconvertibleErrorCode(),
                           (where + ": " + message).str());
}

bool identifier(StringRef s) {
  if (s.empty() || !(isAlpha(s.front()) || s.front() == '_'))
    return false;
  static const StringRef keywords[] = {
      "auto", "break", "case", "char", "const", "continue", "default",
      "do", "double", "else", "enum", "extern", "float", "for", "goto",
      "if", "inline", "int", "long", "register", "restrict", "return",
      "short", "signed", "sizeof", "static", "struct", "switch", "typedef",
      "union", "unsigned", "void", "volatile", "while", "_Alignas",
      "_Alignof", "_Atomic", "_Bool", "_Complex", "_Generic", "_Imaginary",
      "_Noreturn", "_Static_assert", "_Thread_local", "bool", "true", "false"};
  if (llvm::is_contained(keywords, s))
    return false;
  return llvm::all_of(s, [](char c) { return isAlnum(c) || c == '_'; });
}

bool externalName(StringRef s) {
  return !s.empty() && llvm::all_of(s, [](char c) {
    return isAlnum(c) || c == '_' || c == '-' || c == '.';
  });
}

Error keys(const json::Object &obj, std::initializer_list<StringRef> allowed,
           StringRef where) {
  for (const auto &kv : obj) {
    StringRef key = kv.first;
    if (key == "_comment") {
      if (!kv.second.getAsString())
        return invalid(where, "_comment must be a string");
    } else if (std::find(allowed.begin(), allowed.end(), key) == allowed.end()) {
      return invalid(where, "unknown field '" + key + "'");
    }
  }
  return Error::success();
}

Expected<std::string> requiredString(const json::Object &obj, StringRef key,
                                     StringRef where) {
  auto s = obj.getString(key);
  if (!s || s->empty())
    return invalid(where, "'" + key + "' must be a non-empty string");
  return s->str();
}

Error sources(const json::Object &obj, StringRef where) {
  if (!obj.get("sources"))
    return Error::success();
  auto *arr = obj.getArray("sources");
  if (!arr)
    return invalid(where, "sources must be an array");
  for (const auto &v : *arr) {
    auto *s = v.getAsObject();
    if (!s)
      return invalid(where, "each source must be an object");
    if (auto e = keys(*s, {"document", "location", "url"}, where))
      return e;
    for (StringRef name : {"document", "location"}) {
      auto value = requiredString(*s, name, where);
      if (!value)
        return value.takeError();
    }
    if (s->get("url") && !s->getString("url"))
      return invalid(where, "source url must be a string");
  }
  return Error::success();
}

Expected<std::vector<ShimProp>> properties(const json::Value &value,
                                          StringRef where) {
  auto *arr = value.getAsArray();
  if (!arr)
    return invalid(where, "properties must be an array");
  std::vector<ShimProp> result;
  StringSet<> names, fields;
  for (const auto &v : *arr) {
    auto *obj = v.getAsObject();
    if (!obj)
      return invalid(where, "each property must be an object");
    if (auto e = keys(*obj, {"kind", "name", "name_macro", "field", "default",
                             "target_type_macro"}, where))
      return std::move(e);
    auto kind = requiredString(*obj, "kind", where);
    if (!kind)
      return kind.takeError();
    auto field = requiredString(*obj, "field", where);
    if (!field)
      return field.takeError();
    if (!identifier(*field))
      return invalid(where, "property field must be a C identifier");
    // State members owned by the emitter, not configurable properties.
    StringRef f = *field;
    if (f == "parent_obj" || f == "core" || f == "mmio" || f == "irqs" ||
        f == "alert" || f == "out_lines" || f == "pin_out" ||
        f.starts_with("qp_") || f.starts_with("aux_") ||
        f.starts_with("mmio_") || f.starts_with("backing"))
      return invalid(where, "reserved property field '" + f + "'");
    if (!fields.insert(f).second)
      return invalid(where, "duplicate property field '" + f + "'");
    bool macroName = obj->get("name_macro") != nullptr;
    if (macroName == (obj->get("name") != nullptr))
      return invalid(where, "property requires exactly one of name/name_macro");
    auto name = requiredString(*obj, macroName ? "name_macro" : "name", where);
    if (!name)
      return name.takeError();
    if (!(macroName ? identifier(*name) : externalName(*name)))
      return invalid(where, "invalid property name or name_macro");
    if ((!macroName && *name == "chardev") || *field == "chr") {
      if (*kind != "chardev" || macroName || *name != "chardev")
        return invalid(where, "name 'chardev' and field 'chr' are reserved for chardev");
    }
    if (!names.insert(*name).second)
      return invalid(where, "duplicate property name '" + *name + "'");
    ShimProp p;
    p.fieldName = *field;
    p.nameStr = macroName ? *name : "\"" + *name + "\"";
    if (*kind == "string") {
      p.macro = "DEFINE_PROP_STRING";
      p.fieldType = "char *";
    } else if (*kind == "chardev") {
      if (*field != "chr")
        return invalid(where, "chardev property field must be 'chr'");
      p.macro = "DEFINE_PROP_CHR";
      p.fieldType = "CharFrontend";
    } else if (*kind == "bool") {
      auto def = obj->getBoolean("default");
      if (!def)
        return invalid(where, "bool property requires a boolean default");
      p.macro = "DEFINE_PROP_BOOL";
      p.fieldType = "bool";
      p.extraArgs = *def ? ", true" : ", false";
    } else if (*kind == "uint8" || *kind == "uint32") {
      auto def = obj->getInteger("default");
      uint64_t max = *kind == "uint8" ? 255 : UINT32_MAX;
      if (!def || *def < 0 || static_cast<uint64_t>(*def) > max)
        return invalid(where, "unsigned property requires an in-range integer default");
      p.macro = *kind == "uint8" ? "DEFINE_PROP_UINT8" : "DEFINE_PROP_UINT32";
      p.fieldType = *kind == "uint8" ? "uint8_t" : "uint32_t";
      p.extraArgs = ", " + std::to_string(*def) + (*kind == "uint32" ? "u" : "");
    } else if (*kind == "link") {
      auto target = requiredString(*obj, "target_type_macro", where);
      if (!target)
        return target.takeError();
      if (!identifier(*target))
        return invalid(where, "target_type_macro must be a C identifier");
      p.macro = "DEFINE_PROP_LINK";
      p.fieldType = "DeviceState *";
      p.extraArgs = ", " + *target + ",\n                     DeviceState *";
    } else {
      return invalid(where, "unknown property kind '" + *kind + "'");
    }
    if (obj->get("default") && *kind != "bool" && *kind != "uint8" && *kind != "uint32")
      return invalid(where, "default is only supported for bool/uint8/uint32");
    if (obj->get("target_type_macro") && *kind != "link")
      return invalid(where, "target_type_macro is only supported for link");
    if (*field == "chr" && *kind != "chardev")
      return invalid(where, "field 'chr' is reserved for chardev");
    result.push_back(std::move(p));
  }
  return result;
}
} // namespace

DeviceShim DeviceCatalog::makeGeneric(StringRef name) const {
  DeviceShim d;
  d.backend = backend;
  d.typeNameMacro = qomPrefix + "-";
  d.structName = statePrefix;
  d.typeMacroBase = macroPrefix + "_";
  bool capitalize = true;
  for (char ch : name) {
    if (ch == '_') {
      d.typeNameMacro += '-';
      d.typeMacroBase += '_';
      capitalize = true;
      continue;
    }
    d.typeNameMacro += ch;
    d.typeMacroBase += toUpper(ch);
    d.structName += capitalize ? toUpper(ch) : ch;
    capitalize = false;
  }
  d.typeNameMacro += "-qp";
  d.structName += "QpState";
  d.typeMacroBase += "_QP";
  d.properties = genericProperties;
  return d;
}

Expected<DeviceCatalog> DeviceCatalog::load(StringRef path) {
  auto buffer = MemoryBuffer::getFile(path);
  if (!buffer)
    return invalid(path, buffer.getError().message());
  auto parsed = json::parse((*buffer)->getBuffer());
  if (!parsed)
    return invalid(path, toString(parsed.takeError()));
  auto *root = parsed->getAsObject();
  if (!root)
    return invalid(path, "catalog must be an object");
  if (auto e = keys(*root, {"$schema_version", "project", "fallback", "naming",
                           "generic_properties", "devices", "sources", "backend"}, path))
    return std::move(e);
  if (root->getInteger("$schema_version") != 1)
    return invalid(path, "$schema_version must be 1");
  auto project = requiredString(*root, "project", path);
  if (!project)
    return project.takeError();
  if (auto e = sources(*root, path))
    return std::move(e);
  DeviceCatalog catalog;
  if (root->get("backend")) {
    auto b = root->getString("backend");
    if (!b || (*b != "opentitan" && *b != "generic-sysbus"))
      return invalid(path, "backend must be 'opentitan' or 'generic-sysbus'");
    catalog.backend = b->str();
  }
  auto fallback = root->getString("fallback");
  if (!fallback || (*fallback != "generic" && *fallback != "error"))
    return invalid(path, "fallback must be 'generic' or 'error'");
  catalog.allowGeneric = *fallback == "generic";
  auto *naming = root->getObject("naming");
  if (!naming)
    return invalid(path, "naming must be an object");
  if (auto e = keys(*naming, {"qom_prefix", "state_prefix", "macro_prefix"}, path))
    return std::move(e);
  for (auto entry : {std::make_pair("qom_prefix", &catalog.qomPrefix),
                     std::make_pair("state_prefix", &catalog.statePrefix),
                     std::make_pair("macro_prefix", &catalog.macroPrefix)}) {
    auto value = requiredString(*naming, entry.first, path);
    if (!value)
      return value.takeError();
    if (!(StringRef(entry.first) == "qom_prefix" ? externalName(*value)
                                                : identifier(*value)))
      return invalid(path, "invalid naming prefix '" + StringRef(entry.first) + "'");
    *entry.second = *value;
  }
  if (auto *props = root->get("generic_properties")) {
    auto ps = properties(*props, path);
    if (!ps)
      return ps.takeError();
    catalog.genericProperties = std::move(*ps);
  }
  auto *devices = root->getArray("devices");
  if (!devices)
    return invalid(path, "devices must be an array");
  StringSet<> qomTypes, stateTypes, typeMacros;
  for (const auto &v : *devices) {
    auto *obj = v.getAsObject();
    if (!obj)
      return invalid(path, "each device must be an object");
    if (auto e = keys(*obj, {"module", "qom_type", "state_type", "type_macro",
                            "irq_count", "mmio_size", "properties", "key_sink",
                            "sources", "backend"}, path))
      return std::move(e);
    auto module = requiredString(*obj, "module", path);
    if (!module)
      return module.takeError();
    std::string where = (path + ": device '" + *module + "'").str();
    if (!identifier(*module))
      return invalid(where, "module must be a C identifier");
    DeviceShim d = catalog.makeGeneric(*module);
    if (obj->get("backend")) {
      auto b = obj->getString("backend");
      if (!b || (*b != "opentitan" && *b != "generic-sysbus"))
        return invalid(where, "backend must be 'opentitan' or 'generic-sysbus'");
      d.backend = b->str();
    }
    for (auto entry : {std::make_pair("qom_type", &d.typeNameMacro),
                       std::make_pair("state_type", &d.structName),
                       std::make_pair("type_macro", &d.typeMacroBase)}) {
      if (!obj->get(entry.first)) continue;
      auto value = requiredString(*obj, entry.first, where);
      if (!value)
        return value.takeError();
      if (!(StringRef(entry.first) == "qom_type" ? externalName(*value)
                                                : identifier(*value)))
        return invalid(where, "invalid '" + StringRef(entry.first) + "'");
      *entry.second = *value;
    }
    if (!qomTypes.insert(d.typeNameMacro).second ||
        !stateTypes.insert(d.structName).second ||
        !typeMacros.insert(d.typeMacroBase).second)
      return invalid(where, "duplicate QOM type, state type or type macro");
    if (obj->get("irq_count")) {
      auto n = obj->getInteger("irq_count");
      if (!n || *n < 0 || *n > 32)
        return invalid(where, "irq_count must be an integer in [0, 32] (current IRQ backend width)");
      d.irqCount = static_cast<unsigned>(*n);
      d.irqCountDeclared = true;
    }
    if (auto *size = obj->get("mmio_size")) {
      uint64_t n = 0;
      if (auto str = size->getAsString()) {
        if (str->getAsInteger(0, n))
          return invalid(where, "mmio_size must be a positive integer or hex string");
      } else if (auto i = size->getAsInteger(); i && *i > 0) {
        n = static_cast<uint64_t>(*i);
      }
      if (!n || n > INT64_MAX)
        return invalid(where, "mmio_size must be in [1, INT64_MAX]");
      d.mmioSize = n;
    }
    if (obj->get("key_sink")) {
      auto b = obj->getBoolean("key_sink");
      if (!b)
        return invalid(where, "key_sink must be a boolean");
      d.keySinkIf = *b;
    }
    if (auto *props = obj->get("properties")) {
      auto ps = properties(*props, where);
      if (!ps)
        return ps.takeError();
      d.properties = std::move(*ps);
    }
    if (auto e = sources(*obj, where))
      return std::move(e);
    if (!catalog.devices.emplace(*module, std::move(d)).second)
      return invalid(where, "duplicate module");
  }
  return catalog;
}

Expected<DeviceShim> DeviceCatalog::resolve(StringRef module,
                                           StringRef emittedName,
                                           unsigned inferredIrqCount) const {
  if (!identifier(emittedName))
    return invalid("device-catalog", "emitted device name must be a C identifier");
  auto it = devices.find(module.str());
  if (it == devices.end() && !allowGeneric)
    return invalid("device-catalog", "module '" + module + "' is not in the catalog (fallback=error)");
  DeviceShim d = it == devices.end() ? makeGeneric(emittedName) : it->second;
  if (!d.irqCountDeclared)
    d.irqCount = inferredIrqCount;
  if (d.backend == "generic-sysbus" && d.keySinkIf)
    return invalid("device-catalog", "key_sink requires the opentitan backend");
  if (d.irqCount > 32)
    return invalid("device-catalog", "IRQ count exceeds current 32-bit IRQ backend");
  return d;
}
