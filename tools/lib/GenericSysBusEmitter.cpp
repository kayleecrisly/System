#include "GenericSysBusEmitter.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace qemu_passes;

Error qemu_passes::emitGenericSysBus(StringRef name, const DeviceShim &d,
                                    const GenericSysBusConfig &cfg,
                                    StringRef outputDir) {
  std::string stem = (outputDir + "/" + name + "_qp_shim").str();
  std::error_code ec;
  raw_fd_ostream h(stem + ".h", ec);
  if (ec) return createStringError(ec, "cannot write %s.h", stem.c_str());
  raw_fd_ostream c(stem + ".c", ec);
  if (ec) return createStringError(ec, "cannot write %s.c", stem.c_str());
  std::string fn = ("qp_" + name).str();
  h << "/* Generated generic SysBus wrapper. */\n#pragma once\n"
    << "#include \"hw/sysbus.h\"\n#include \"qom/object.h\"\n"
    << "#define TYPE_" << d.typeMacroBase << " \"" << d.typeNameMacro << "\"\n"
    << "OBJECT_DECLARE_SIMPLE_TYPE(" << d.structName << ", " << d.typeMacroBase << ")\n"
    << "void *" << fn << "_core(DeviceState *dev);\n"
    << "void " << fn << "_sync(DeviceState *dev);\n";
  c << "/* Generated generic SysBus wrapper. Configure JSON; do not edit. */\n"
    << "#include \"qemu/osdep.h\"\n#include \"qemu/module.h\"\n"
    << "#include \"qemu/timer.h\"\n#include \"hw/irq.h\"\n"
    << "#include \"hw/qdev-properties.h\"\n#include \"hw/qdev-properties-system.h\"\n"
    << "#include \"chardev/char-fe.h\"\n"
    << "#include \"" << name << ".h\"\n#include \"" << name << "_qp_shim.h\"\n\n"
    << "struct " << d.structName << " {\n    SysBusDevice parent_obj;\n"
    << "    MemoryRegion mmio;\n    " << name << "_state core;\n";
  if (!cfg.irqs.empty())
    c << "    qemu_irq irqs[" << cfg.irqs.size() << "];\n";
  if (cfg.pinInputWidth)
    c << "    uint64_t pin_input;\n";
  if (cfg.pinOutputWidth)
    c << "    qemu_irq pin_data[" << cfg.pinOutputWidth << "];\n"
      << "    uint64_t last_pin_data;\n    bool pins_valid;\n";
  if (cfg.pinEnableWidth)
    c << "    qemu_irq pin_enable[" << cfg.pinEnableWidth << "];\n"
      << "    uint64_t last_pin_enable;\n";
  if (cfg.pumpHz)
    c << "    QEMUTimer *pump;\n    int64_t deadline;\n    uint64_t phase;\n";
  for (auto &p : d.properties)
    c << "    " << p.fieldType << " " << p.fieldName << ";\n";
  c << "};\n\nOBJECT_DEFINE_SIMPLE_TYPE(" << d.structName << ", " << fn
    << ", " << d.typeMacroBase << ", SYS_BUS_DEVICE)\n\n"
    << "static void " << fn << "_update_outputs(" << d.structName << " *s)\n{\n";
  if (cfg.irqs.empty()) c << "    (void)s;\n";
  for (size_t i = 0; i < cfg.irqs.size(); ++i)
    c << "    qemu_set_irq(s->irqs[" << i << "], (s->core."
      << cfg.irqs[i].field << " >> " << cfg.irqs[i].bit << ") & 1u);\n";
  if (cfg.pinOutputWidth) {
    c << "    uint64_t data = s->core." << cfg.pinOutput << ";\n"
      << "    uint64_t changed = s->pins_valid ? (data ^ s->last_pin_data) : UINT64_MAX;\n"
      << "    s->last_pin_data = data;\n";
    if (cfg.pinEnableWidth)
      c << "    uint64_t enable = s->core." << cfg.pinEnable << ";\n"
        << "    uint64_t enable_changed = s->pins_valid ? (enable ^ s->last_pin_enable) : UINT64_MAX;\n"
        << "    s->last_pin_enable = enable;\n";
    c << "    s->pins_valid = true;\n";
    if (cfg.pinEnableWidth)
      c << "    for (unsigned i = 0; i < " << cfg.pinEnableWidth << "; ++i)\n"
        << "        if ((enable_changed >> i) & 1) qemu_set_irq(s->pin_enable[i], (enable >> i) & 1);\n";
    c << "    for (unsigned i = 0; i < " << cfg.pinOutputWidth << "; ++i)\n"
      << "        if ((changed >> i) & 1) qemu_set_irq(s->pin_data[i], (data >> i) & 1);\n";
  }
  c << "}\n\nvoid *" << fn << "_core(DeviceState *dev)\n{\n"
    << "    return &" << d.typeMacroBase << "(dev)->core;\n}\n"
    << "void " << fn << "_sync(DeviceState *dev)\n{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(dev);\n"
    << "    " << name << "_settle(&s->core);\n"
    << "    " << fn << "_update_outputs(s);\n}\n\n";
  if (cfg.pinInputWidth)
    c << "static void " << fn << "_pin_input(void *opaque, int n, int level)\n{\n"
      << "    " << d.structName << " *s = opaque;\n"
      << "    uint64_t mask = UINT64_C(1) << n;\n"
      << "    s->pin_input = (s->pin_input & ~mask) | (level ? mask : 0);\n"
      << "    s->core." << cfg.pinInput << " = s->pin_input;\n"
      << "    " << fn << "_sync(DEVICE(s));\n}\n";
  auto inputs = [&](const GenericSysBusConfig::Inputs &values) {
    for (auto &kv : values)
      c << "    s->core." << kv.first << " = UINT64_C(" << kv.second << ");\n";
  };
  c << "static uint64_t " << fn << "_read(void *opaque, hwaddr addr, unsigned size)\n{\n"
    << "    " << d.structName << " *s = opaque;\n";
  inputs(cfg.readInputs);
  c << "    uint64_t value = " << name << "_read(&s->core, addr, size);\n";
  inputs(cfg.idleInputs);
  c << "    " << fn << "_sync(DEVICE(s));\n    return value;\n}\n"
    << "static void " << fn << "_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)\n{\n"
    << "    " << d.structName << " *s = opaque;\n";
  inputs(cfg.writeInputs);
  c << "    " << name << "_write(&s->core, addr, value, size);\n";
  inputs(cfg.idleInputs);
  c << "    " << fn << "_sync(DEVICE(s));\n}\n"
    << "static const MemoryRegionOps " << fn << "_ops = {\n"
    << "    .read = " << fn << "_read, .write = " << fn << "_write,\n"
    << "    .endianness = DEVICE_LITTLE_ENDIAN,\n"
    << "    .valid.min_access_size = 4, .valid.max_access_size = 4,\n"
    << "    .impl.min_access_size = 4, .impl.max_access_size = 4,\n};\n";
  if (cfg.pumpHz) {
    c << "/* Rational deadlines retain fractional nanoseconds and do not drift.\n"
      << " * Virtual time continues while the guest is halted in WFI. */\n"
      << "static void " << fn << "_schedule(" << d.structName << " *s)\n{\n"
      << "    s->phase += UINT64_C(1000000000);\n"
      << "    s->deadline += s->phase / UINT64_C(" << cfg.pumpHz << ");\n"
      << "    s->phase %= UINT64_C(" << cfg.pumpHz << ");\n"
      << "    timer_mod(s->pump, s->deadline);\n}\n"
      << "static void " << fn << "_pump(void *opaque)\n{\n"
      << "    " << d.structName << " *s = opaque;\n"
      << "    " << name << "_advance_tick(&s->core);\n"
      << "    " << fn << "_update_outputs(s);\n"
      << "    " << fn << "_schedule(s);\n}\n";
  }
  c << "static void " << fn << "_reset(DeviceState *dev)\n{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(dev);\n";
  if (cfg.pumpHz) c << "    timer_del(s->pump);\n";
  c << "    memset(&s->core, 0, sizeof(s->core));\n";
  if (cfg.pinInputWidth)
    c << "    s->core." << cfg.pinInput << " = s->pin_input;\n";
  if (cfg.pinOutputWidth) c << "    s->pins_valid = false;\n";
  c << "    " << name << "_reset(&s->core);\n";
  c << "    " << fn << "_sync(dev);\n";
  if (cfg.pumpHz)
    c << "    s->deadline = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);\n"
      << "    s->phase = 0;\n    " << fn << "_schedule(s);\n";
  c << "}\n"
    << "static void " << fn << "_init(Object *obj)\n{\n"
    << "    " << d.structName << " *s = " << d.typeMacroBase << "(obj);\n"
    << "    memory_region_init_io(&s->mmio, obj, &" << fn << "_ops, s,\n"
    << "                          TYPE_" << d.typeMacroBase << ", " << cfg.mmioSize << ");\n"
    << "    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);\n";
  for (size_t i = 0; i < cfg.irqs.size(); ++i)
    c << "    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[" << i << "]);\n";
  if (cfg.pinInputWidth)
    c << "    qdev_init_gpio_in_named(DEVICE(obj), " << fn << "_pin_input, \"data-in\", "
      << cfg.pinInputWidth << ");\n";
  if (cfg.pinOutputWidth)
    c << "    qdev_init_gpio_out_named(DEVICE(obj), s->pin_data, \"data-out\", "
      << cfg.pinOutputWidth << ");\n";
  if (cfg.pinEnableWidth)
    c << "    qdev_init_gpio_out_named(DEVICE(obj), s->pin_enable, \"output-enable\", "
      << cfg.pinEnableWidth << ");\n";
  if (cfg.pumpHz)
    c << "    s->pump = timer_new_ns(QEMU_CLOCK_VIRTUAL, " << fn << "_pump, s);\n";
  c << "}\nstatic void " << fn << "_finalize(Object *obj)\n{\n";
  if (cfg.pumpHz)
    c << "    " << d.structName << " *s = " << d.typeMacroBase << "(obj);\n"
      << "    timer_free(s->pump);\n";
  else c << "    (void)obj;\n";
  c << "}\n";
  if (!d.properties.empty()) {
    c << "static const Property " << fn << "_properties[] = {\n";
    for (auto &p : d.properties)
      c << "    " << p.macro << "(" << p.nameStr << ", " << d.structName
        << ", " << p.fieldName << p.extraArgs << "),\n";
    c << "};\n";
  }
  c << "static void " << fn << "_class_init(ObjectClass *klass, const void *data)\n{\n"
    << "    DeviceClass *dc = DEVICE_CLASS(klass);\n    (void)data;\n"
    << "    device_class_set_legacy_reset(dc, " << fn << "_reset);\n";
  if (!d.properties.empty())
    c << "    device_class_set_props(dc, " << fn << "_properties);\n";
  c << "}\n";
  h.flush(); c.flush();
  if (h.has_error() || c.has_error())
    return createStringError(inconvertibleErrorCode(), "failed writing generic SysBus wrapper");
  return Error::success();
}
