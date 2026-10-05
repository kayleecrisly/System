#!/usr/bin/env python3
"""Generate a portable QEMU RISC-V rehosting machine from a BoardSpec.

The BoardSpec is the single source of truth.  This tool deliberately knows no
OpenTitan device names: generated peripherals are ordinary QOM/SysBus devices,
and platform-specific facts enter only through JSON data.

Usage:
  python3 tools/board/rehost_gen.py validate projects/common/boards/mini_riscv.board.json
  python3 tools/board/rehost_gen.py generate projects/common/boards/mini_riscv.board.json -o OUT
  python3 tools/board/rehost_gen.py check projects/common/boards/mini_riscv.board.json -o OUT
"""

import argparse
import hashlib
import json
import os
import re
import sys
from pathlib import Path


class SpecError(ValueError):
    pass


def load_spec(path):
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def number(value, where):
    if isinstance(value, bool):
        raise SpecError(f"{where}: boolean is not an address")
    if isinstance(value, int):
        if value < 0:
            raise SpecError(f"{where}: value must be non-negative")
        return value
    if isinstance(value, str) and re.fullmatch(r"0x[0-9a-fA-F]+", value):
        return int(value, 16)
    raise SpecError(f"{where}: expected non-negative integer or 0x... string")


def uint32(value, where, *, positive=False):
    value = number(value, where)
    if value > 0xffffffff:
        raise SpecError(f"{where}: value exceeds 32 bits")
    if positive and value == 0:
        raise SpecError(f"{where}: value must be greater than zero")
    return value


def require_bool(value, where):
    if not isinstance(value, bool):
        raise SpecError(f"{where}: expected true/false")
    return value


def is_power_of_two(value):
    return value > 0 and value & (value - 1) == 0


def c_u64(value):
    return f"0x{value:x}ULL"


def c_ident(value):
    return re.sub(r"[^A-Za-z0-9_]", "_", value)


def require_id(value, where):
    if not isinstance(value, str) or not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", value):
        raise SpecError(f"{where}: expected a C-style identifier")
    return value


def require_keys(obj, keys, where):
    if not isinstance(obj, dict):
        raise SpecError(f"{where}: expected object")
    missing = [k for k in keys if k not in obj]
    if missing:
        raise SpecError(f"{where}: missing required field(s): {', '.join(missing)}")


def reject_unknown(obj, allowed, where):
    unknown = sorted(set(obj) - set(allowed))
    if unknown:
        raise SpecError(f"{where}: unknown field(s): {', '.join(unknown)}")


def validate_properties(props, where):
    for i, prop in enumerate(props or []):
        pwhere = f"{where}[{i}]"
        require_keys(prop, ("name", "kind", "value"), pwhere)
        reject_unknown(prop, ("name", "kind", "value"), pwhere)
        if prop["kind"] not in ("string", "uint", "int", "bool", "enum"):
            raise SpecError(f"{pwhere}.kind: unsupported property kind {prop['kind']!r}")
        if prop["kind"] == "bool" and not isinstance(prop["value"], bool):
            raise SpecError(f"{pwhere}.value: bool property requires true/false")
        if prop["kind"] in ("uint", "int", "enum") and (
            isinstance(prop["value"], bool) or not isinstance(prop["value"], int)
        ):
            raise SpecError(f"{pwhere}.value: integer property requires a JSON integer")
        if prop["kind"] == "string" and not isinstance(prop["value"], str):
            raise SpecError(f"{pwhere}.value: string property requires a JSON string")


def add_range(ranges, name, base, size):
    if size <= 0:
        raise SpecError(f"{name}: size must be greater than zero")
    end = base + size
    if end > (1 << 64):
        raise SpecError(f"{name}: address range exceeds 64 bits")
    for other_name, other_base, other_end in ranges:
        if base < other_end and other_base < end:
            raise SpecError(
                f"address overlap: {name} [{base:#x},{end:#x}) overlaps "
                f"{other_name} [{other_base:#x},{other_end:#x})"
            )
    ranges.append((name, base, end))


def validate_riscv_interrupts(config, ranges, all_objects, controllers_by_name,
                              num_harts, hartid_base):
    """Validate official QEMU SiFive PLIC and RISC-V ACLINT adapters."""
    require_keys(config, (), "riscv_interrupts")
    reject_unknown(config, ("plic", "aclint"), "riscv_interrupts")
    if not config:
        raise SpecError("riscv_interrupts: expected plic and/or aclint")

    plic = config.get("plic")
    if plic is not None:
        where = "riscv_interrupts.plic"
        required = (
            "name", "kind", "base", "size", "hart_config", "num_sources",
            "num_priorities", "priority_base", "pending_base", "enable_base",
            "enable_stride", "context_base", "context_stride",
        )
        require_keys(plic, required, where)
        reject_unknown(plic, required + ("edge_triggered",), where)
        if plic["kind"] != "sifive-plic":
            raise SpecError(f"{where}.kind: supported adapter is 'sifive-plic'")
        name = require_id(plic["name"], f"{where}.name")
        if name in all_objects:
            raise SpecError(f"{where}.name: duplicate object name {name!r}")
        all_objects.add(name)
        controllers_by_name[name] = {
            "adapter": "sifive-plic",
            "input_count": uint32(plic["num_sources"], f"{where}.num_sources", positive=True),
        }
        base = number(plic["base"], f"{where}.base")
        size = uint32(plic["size"], f"{where}.size", positive=True)
        add_range(ranges, f"{name}.mmio", base, size)
        hart_config = plic["hart_config"]
        if not isinstance(hart_config, str) or not hart_config:
            raise SpecError(f"{where}.hart_config: expected a non-empty string")
        hart_modes = hart_config.split(",")
        if len(hart_modes) != num_harts:
            raise SpecError(
                f"{where}.hart_config: describes {len(hart_modes)} hart(s), "
                f"but cpu.num_harts is {num_harts}"
            )
        for i, modes in enumerate(hart_modes):
            if not modes or any(mode not in "USM" for mode in modes) or len(set(modes)) != len(modes):
                raise SpecError(f"{where}.hart_config[{i}]: expected unique U/S/M mode letters")
        # sifive_plic_create() indexes CPUs using hart IDs in QEMU 10.2.
        if hartid_base != 0:
            raise SpecError(f"{where}: current adapter requires cpu.hartid_base = 0")
        num_sources = controllers_by_name[name]["input_count"]
        num_priorities = uint32(plic["num_priorities"], f"{where}.num_priorities", positive=True)
        offsets = {}
        for field in ("priority_base", "pending_base", "enable_base", "enable_stride",
                      "context_base", "context_stride"):
            offsets[field] = uint32(plic[field], f"{where}.{field}")
        for field in ("enable_stride", "context_stride"):
            if not is_power_of_two(offsets[field]):
                raise SpecError(f"{where}.{field}: expected a power of two")
        contexts = sum(len(modes) for modes in hart_modes)
        last_priority = offsets["priority_base"] + 4 * num_sources
        last_pending = offsets["pending_base"] + 4 * ((num_sources + 31) // 32)
        last_enable = offsets["enable_base"] + offsets["enable_stride"] * contexts
        last_context = offsets["context_base"] + offsets["context_stride"] * contexts
        if max(last_priority, last_pending, last_enable, last_context) > size:
            raise SpecError(f"{where}: register layout exceeds PLIC aperture size {size:#x}")
        if "edge_triggered" in plic:
            require_bool(plic["edge_triggered"], f"{where}.edge_triggered")
    aclint = config.get("aclint")
    if aclint is not None:
        where = "riscv_interrupts.aclint"
        require_keys(aclint, ("kind",), where)
        reject_unknown(aclint, ("kind", "mswi", "mtimer"), where)
        if aclint["kind"] != "riscv-aclint":
            raise SpecError(f"{where}.kind: supported adapter is 'riscv-aclint'")
        if "mswi" not in aclint and "mtimer" not in aclint:
            raise SpecError(f"{where}: expected mswi and/or mtimer")
        if num_harts > 4095:
            raise SpecError("cpu.num_harts: ACLINT supports at most 4095 harts")

        mswi = aclint.get("mswi")
        if mswi is not None:
            mwhere = f"{where}.mswi"
            require_keys(mswi, ("base",), mwhere)
            reject_unknown(mswi, ("base", "supervisor"), mwhere)
            base = number(mswi["base"], f"{mwhere}.base")
            add_range(ranges, "aclint.mswi", base, 0x4000)
            if base & 0x3:
                raise SpecError(f"{mwhere}.base: expected 4-byte alignment")
            if "supervisor" in mswi:
                require_bool(mswi["supervisor"], f"{mwhere}.supervisor")

        mtimer = aclint.get("mtimer")
        if mtimer is not None:
            mwhere = f"{where}.mtimer"
            required = ("base", "size", "timecmp_base", "time_base", "timebase_frequency")
            require_keys(mtimer, required, mwhere)
            reject_unknown(mtimer, required + ("provide_rdtime",), mwhere)
            base = number(mtimer["base"], f"{mwhere}.base")
            size = uint32(mtimer["size"], f"{mwhere}.size", positive=True)
            timecmp = uint32(mtimer["timecmp_base"], f"{mwhere}.timecmp_base")
            time_base = uint32(mtimer["time_base"], f"{mwhere}.time_base")
            uint32(mtimer["timebase_frequency"], f"{mwhere}.timebase_frequency", positive=True)
            add_range(ranges, "aclint.mtimer", base, size)
            if base & 0x7 or timecmp & 0x7 or time_base & 0x7:
                raise SpecError(f"{mwhere}: base, timecmp_base and time_base require 8-byte alignment")
            if timecmp + 8 * num_harts > size or time_base + 8 > size:
                raise SpecError(f"{mwhere}: timer registers exceed aperture size {size:#x}")
            if "provide_rdtime" in mtimer:
                require_bool(mtimer["provide_rdtime"], f"{mwhere}.provide_rdtime")


def validate(spec):
    require_keys(spec, ("$schema_version", "machine", "cpu", "memory", "models", "devices", "boot"), "board")
    reject_unknown(spec, ("$schema_version", "machine", "platform", "cpu", "memory", "models",
                          "riscv_interrupts", "interrupt_controllers", "devices",
                          "gpio_connections", "boot"), "board")
    if spec["$schema_version"] != 1:
        raise SpecError("board.$schema_version: only schema version 1 is supported")

    machine = spec["machine"]
    require_keys(machine, ("name", "arch"), "machine")
    reject_unknown(machine, ("name", "arch", "description", "kconfig", "kconfig_selects"), "machine")
    if not isinstance(machine["name"], str) or not re.fullmatch(r"[a-z][a-z0-9-]*", machine["name"]):
        raise SpecError("machine.name: expected lower-case QEMU machine name")
    if machine["arch"] != "riscv":
        raise SpecError("machine.arch: this generator currently supports only riscv")
    kconfig_selects = machine.get("kconfig_selects", [])
    if not isinstance(kconfig_selects, list):
        raise SpecError("machine.kconfig_selects: expected a list")
    if len(kconfig_selects) != len(set(kconfig_selects)):
        raise SpecError("machine.kconfig_selects: duplicate dependency")
    for i, item in enumerate(kconfig_selects):
        if not isinstance(item, str) or not re.fullmatch(r"[A-Z][A-Z0-9_]*", item):
            raise SpecError(f"machine.kconfig_selects[{i}]: invalid Kconfig symbol")

    if "platform" in spec:
        platform = spec["platform"]
        required = ("reference_machine", "integration_level", "source_files", "unsupported")
        require_keys(platform, required, "platform")
        reject_unknown(platform, required, "platform")
        if platform["integration_level"] not in ("peripheral-test", "full-system"):
            raise SpecError("platform.integration_level: expected peripheral-test or full-system")
        for field in ("reference_machine",):
            if not isinstance(platform[field], str) or not platform[field]:
                raise SpecError(f"platform.{field}: expected non-empty string")
        for field in ("source_files", "unsupported"):
            values = platform[field]
            if not isinstance(values, list) or any(not isinstance(v, str) or not v for v in values):
                raise SpecError(f"platform.{field}: expected a list of non-empty strings")
            if len(values) != len(set(values)):
                raise SpecError(f"platform.{field}: duplicate entry")

    cpu = spec["cpu"]
    require_keys(cpu, ("qom_type", "reset_vector"), "cpu")
    reject_unknown(cpu, ("qom_type", "reset_vector", "num_harts", "hartid_base",
                         "properties"), "cpu")
    if not isinstance(cpu["qom_type"], str) or not cpu["qom_type"]:
        raise SpecError("cpu.qom_type: expected non-empty QOM type string")
    reset_vector = number(cpu["reset_vector"], "cpu.reset_vector")
    num_harts = uint32(cpu.get("num_harts", 1), "cpu.num_harts", positive=True)
    hartid_base = uint32(cpu.get("hartid_base", 0), "cpu.hartid_base")
    if hartid_base + num_harts > 0x100000000:
        raise SpecError("cpu: hart ID range exceeds 32 bits")
    validate_properties(cpu.get("properties", []), "cpu.properties")

    ranges = []
    memories = spec["memory"]
    if not isinstance(memories, list) or not memories:
        raise SpecError("memory: expected at least one region")
    memory_ids = set()
    reset_mapped = False
    for i, mem in enumerate(memories):
        where = f"memory[{i}]"
        require_keys(mem, ("name", "base", "size", "kind"), where)
        reject_unknown(mem, ("name", "base", "size", "kind"), where)
        name = require_id(mem["name"], f"{where}.name")
        if name in memory_ids:
            raise SpecError(f"{where}.name: duplicate memory name {name!r}")
        memory_ids.add(name)
        if mem["kind"] not in ("ram", "rom"):
            raise SpecError(f"{where}.kind: expected ram or rom")
        base, size = number(mem["base"], f"{where}.base"), number(mem["size"], f"{where}.size")
        add_range(ranges, f"memory.{name}", base, size)
        reset_mapped |= base <= reset_vector < base + size
    if not reset_mapped:
        raise SpecError(f"cpu.reset_vector {reset_vector:#x} is not inside a memory region")

    models = spec["models"]
    if not isinstance(models, dict):
        raise SpecError("models: expected object")
    for name, model in models.items():
        require_id(name, f"models.{name}")
        require_keys(model, ("qom_type", "mmio_regions", "irq_outputs"), f"models.{name}")
        reject_unknown(model, ("qom_type", "header", "sources", "mmio_regions",
                               "irq_outputs", "gpio_inputs"), f"models.{name}")
        if not isinstance(model["mmio_regions"], int) or model["mmio_regions"] < 1:
            raise SpecError(f"models.{name}.mmio_regions: expected positive integer")
        if not isinstance(model["irq_outputs"], int) or model["irq_outputs"] < 0:
            raise SpecError(f"models.{name}.irq_outputs: expected non-negative integer")
        if "gpio_inputs" in model and (
            not isinstance(model["gpio_inputs"], int) or model["gpio_inputs"] < 0
        ):
            raise SpecError(f"models.{name}.gpio_inputs: expected non-negative integer")

    controllers = spec.get("interrupt_controllers", [])
    all_objects = {"cpu"}
    controllers_by_name = {}
    if "riscv_interrupts" in spec:
        validate_riscv_interrupts(spec["riscv_interrupts"], ranges, all_objects,
                                  controllers_by_name, num_harts, hartid_base)
    for i, ctl in enumerate(controllers):
        where = f"interrupt_controllers[{i}]"
        require_keys(ctl, ("name", "qom_type", "mmio"), where)
        reject_unknown(ctl, ("name", "model", "qom_type", "mmio", "properties", "cpu_irqs",
                             "input_count", "output_kind"), where)
        name = require_id(ctl["name"], f"{where}.name")
        if name in all_objects:
            raise SpecError(f"{where}.name: duplicate object name {name!r}")
        all_objects.add(name)
        controllers_by_name[name] = ctl
        if not isinstance(ctl["qom_type"], str) or not ctl["qom_type"]:
            raise SpecError(f"{where}.qom_type: expected non-empty QOM type string")
        controller_model = None
        if "model" in ctl:
            controller_model = models.get(ctl["model"])
            if controller_model is None:
                raise SpecError(f"{where}.model: unknown model {ctl['model']!r}")
            if ctl["qom_type"] != controller_model["qom_type"]:
                raise SpecError(f"{where}.qom_type: does not match model {controller_model['qom_type']!r}")
            if "gpio_inputs" in controller_model and ctl.get("input_count") != controller_model["gpio_inputs"]:
                raise SpecError(f"{where}.input_count: does not match model GPIO input count")
        if ctl.get("output_kind", "sysbus") not in ("sysbus", "gpio"):
            raise SpecError(f"{where}.output_kind: expected sysbus or gpio")
        validate_properties(ctl.get("properties", []), f"{where}.properties")
        seen_regions = set()
        for j, mmio in enumerate(ctl["mmio"]):
            mwhere = f"{where}.mmio[{j}]"
            require_keys(mmio, ("region", "base", "size"), mwhere)
            reject_unknown(mmio, ("region", "base", "size"), mwhere)
            region = mmio["region"]
            if not isinstance(region, int) or region < 0:
                raise SpecError(f"{mwhere}.region: expected non-negative integer")
            if controller_model is not None and region >= controller_model["mmio_regions"]:
                raise SpecError(f"{mwhere}.region: outside model MMIO region count")
            if region in seen_regions:
                raise SpecError(f"{mwhere}.region: region {region} mapped twice")
            seen_regions.add(region)
            base, size = number(mmio["base"], f"{mwhere}.base"), number(mmio["size"], f"{mwhere}.size")
            add_range(ranges, f"{name}.mmio[{mmio['region']}]", base, size)
        for j, irq in enumerate(ctl.get("cpu_irqs", [])):
            iwhere = f"{where}.cpu_irqs[{j}]"
            require_keys(irq, ("output", "cpu_input"), iwhere)
            reject_unknown(irq, ("output", "cpu_input"), iwhere)
            if not isinstance(irq["output"], int) or irq["output"] < 0:
                raise SpecError(f"{iwhere}.output: expected non-negative integer")
            if controller_model is not None and irq["output"] >= controller_model["irq_outputs"]:
                raise SpecError(f"{iwhere}.output: outside model IRQ output count")
            if not isinstance(irq["cpu_input"], int) or irq["cpu_input"] < 0:
                raise SpecError(f"{iwhere}.cpu_input: expected non-negative integer")

    for i, dev in enumerate(spec["devices"]):
        where = f"devices[{i}]"
        require_keys(dev, ("name", "model", "qom_type", "mmio"), where)
        reject_unknown(dev, ("name", "model", "qom_type", "mmio", "properties",
                             "irqs", "links", "chardev"), where)
        name = require_id(dev["name"], f"{where}.name")
        if name in all_objects:
            raise SpecError(f"{where}.name: duplicate object name {name!r}")
        all_objects.add(name)
        model_name = dev["model"]
        if model_name not in models:
            raise SpecError(f"{where}.model: unknown model {model_name!r}")
        model = models[model_name]
        if dev["qom_type"] != model["qom_type"]:
            raise SpecError(f"{where}.qom_type: {dev['qom_type']!r} does not match model {model['qom_type']!r}")
        validate_properties(dev.get("properties", []), f"{where}.properties")
        seen_regions = set()
        for j, mmio in enumerate(dev["mmio"]):
            mwhere = f"{where}.mmio[{j}]"
            require_keys(mmio, ("region", "base", "size"), mwhere)
            reject_unknown(mmio, ("region", "base", "size"), mwhere)
            region = mmio["region"]
            if not isinstance(region, int) or not 0 <= region < model["mmio_regions"]:
                raise SpecError(f"{mwhere}.region: outside model MMIO region count {model['mmio_regions']}")
            if region in seen_regions:
                raise SpecError(f"{mwhere}.region: region {region} mapped twice")
            seen_regions.add(region)
            base, size = number(mmio["base"], f"{mwhere}.base"), number(mmio["size"], f"{mwhere}.size")
            add_range(ranges, f"{name}.mmio[{region}]", base, size)
        for j, irq in enumerate(dev.get("irqs", [])):
            iwhere = f"{where}.irqs[{j}]"
            require_keys(irq, ("output", "controller", "input"), iwhere)
            reject_unknown(irq, ("output", "controller", "input"), iwhere)
            if not isinstance(irq["output"], int) or not 0 <= irq["output"] < model["irq_outputs"]:
                raise SpecError(f"{iwhere}.output: outside model IRQ output count {model['irq_outputs']}")
            ctl = controllers_by_name.get(irq["controller"])
            if ctl is None:
                raise SpecError(f"{iwhere}.controller: unknown interrupt controller {irq['controller']!r}")
            if not isinstance(irq["input"], int) or irq["input"] < 0:
                raise SpecError(f"{iwhere}.input: expected non-negative integer")
            if "input_count" in ctl and irq["input"] >= ctl["input_count"]:
                raise SpecError(f"{iwhere}.input: outside controller input count {ctl['input_count']}")
        if dev.get("chardev") is not None:
            ch = dev["chardev"]
            require_keys(ch, ("property", "serial_index"), f"{where}.chardev")
            reject_unknown(ch, ("property", "serial_index"), f"{where}.chardev")
            if not isinstance(ch["property"], str) or not ch["property"]:
                raise SpecError(f"{where}.chardev.property: expected non-empty string")
            if not isinstance(ch["serial_index"], int) or ch["serial_index"] < 0:
                raise SpecError(f"{where}.chardev.serial_index: expected non-negative integer")

    for i, dev in enumerate(spec["devices"]):
        for j, link in enumerate(dev.get("links", [])):
            where = f"devices[{i}].links[{j}]"
            require_keys(link, ("property", "target"), where)
            reject_unknown(link, ("property", "target"), where)
            if link["target"] not in all_objects:
                raise SpecError(f"{where}.target: unknown object {link['target']!r}")

    for i, conn in enumerate(spec.get("gpio_connections", [])):
        where = f"gpio_connections[{i}]"
        require_keys(conn, ("from", "to"), where)
        reject_unknown(conn, ("from", "to"), where)
        for side in ("from", "to"):
            ep = conn[side]
            require_keys(ep, ("device", "name", "index"), f"{where}.{side}")
            reject_unknown(ep, ("device", "name", "index"), f"{where}.{side}")
            if ep["device"] not in all_objects:
                raise SpecError(f"{where}.{side}.device: unknown object {ep['device']!r}")
            if not isinstance(ep["index"], int) or ep["index"] < 0:
                raise SpecError(f"{where}.{side}.index: expected non-negative integer")

    boot = spec["boot"]
    require_keys(boot, ("kind",), "boot")
    reject_unknown(boot, ("kind", "use_elf_entry"), "boot")
    if boot["kind"] not in ("direct-elf", "none"):
        raise SpecError(f"boot.kind: unsupported boot adapter {boot['kind']!r}")
    if "use_elf_entry" in boot and not isinstance(boot["use_elf_entry"], bool):
        raise SpecError("boot.use_elf_entry: expected true/false")
    return spec


def emit_property(dev_expr, prop):
    name = json.dumps(prop["name"])
    kind, value = prop["kind"], prop["value"]
    if kind == "string":
        return f"    qdev_prop_set_string({dev_expr}, {name}, {json.dumps(value)});"
    if kind == "bool":
        return f"    qdev_prop_set_bit({dev_expr}, {name}, {'true' if value else 'false'});"
    if kind == "int":
        return f"    qdev_prop_set_int32({dev_expr}, {name}, {value});"
    if kind == "enum":
        return f"    qdev_prop_set_enum({dev_expr}, {name}, {value});"
    return f"    qdev_prop_set_uint64({dev_expr}, {name}, {c_u64(value)});"


def emit_machine(spec):
    machine = spec["machine"]
    stem = c_ident(machine["name"])
    state_type = "QpRehost" + "".join(p.title() for p in stem.split("_")) + "State"
    headers = sorted({m.get("header") for m in spec["models"].values() if m.get("header")})
    riscv_interrupts = spec.get("riscv_interrupts", {})
    if "plic" in riscv_interrupts:
        headers.append("hw/intc/sifive_plic.h")
    if "aclint" in riscv_interrupts:
        headers.append("hw/intc/riscv_aclint.h")
    headers = sorted(set(headers))
    resetvec = number(spec["cpu"]["reset_vector"], "cpu.reset_vector")
    num_harts = spec["cpu"].get("num_harts", 1)
    hartid_base = spec["cpu"].get("hartid_base", 0)
    lines = [
        "/* Generated by tools/board/rehost_gen.py.  Do not hand-edit. */",
        '#include "qemu/osdep.h"',
        '#include "qapi/error.h"',
        '#include "qemu/error-report.h"',
        '#include "hw/boards.h"',
        '#include "hw/core/cpu.h"',
        '#include "hw/loader.h"',
        '#include "hw/qdev-properties.h"',
        '#include "hw/sysbus.h"',
        '#include "system/address-spaces.h"',
        '#include "system/system.h"',
        '#include "target/riscv/cpu.h"',
        '#include <elf.h>',
    ]
    lines += [f'#include "{h}"' for h in headers]
    lines += [
        "",
        f"typedef struct {state_type} {{",
        "    MachineState parent_obj;",
    ]
    for mem in spec["memory"]:
        lines.append(f"    MemoryRegion mem_{c_ident(mem['name'])};")
    lines += [
        f"}} {state_type};",
        "",
        f"#define TYPE_{stem.upper()}_MACHINE MACHINE_TYPE_NAME(\"{machine['name']}\")",
        f"OBJECT_DECLARE_SIMPLE_TYPE({state_type}, {stem.upper()}_MACHINE)",
        "",
        f"static void {stem}_init(MachineState *machine)",
        "{",
        f"    {state_type} *s = {stem.upper()}_MACHINE(machine);",
        "    MemoryRegion *sysmem = get_system_memory();",
        f"    RISCVCPU *cpus[{num_harts}];",
        "",
        f"    for (uint32_t i = 0; i < {num_harts}; i++) {{",
        "        cpus[i] = RISCV_CPU(object_new(machine->cpu_type));",
    ]
    for prop in spec["cpu"].get("properties", []):
        lines.append("    " + emit_property("DEVICE(cpus[i])", prop))
    lines += [
        f"        cpus[i]->env.mhartid = {hartid_base} + i;",
        f"        cpus[i]->env.resetvec = {c_u64(resetvec)};",
        "        qdev_realize(DEVICE(cpus[i]), NULL, &error_fatal);",
        "    }",
        "",
    ]
    for mem in spec["memory"]:
        ident = c_ident(mem["name"])
        base, size = number(mem["base"], "memory.base"), number(mem["size"], "memory.size")
        init = "memory_region_init_ram" if mem["kind"] == "ram" else "memory_region_init_rom"
        lines += [
            f"    {init}(&s->mem_{ident}, NULL,",
            f"        \"{machine['name']}.{mem['name']}\", {c_u64(size)}, &error_fatal);",
            f"    memory_region_add_subregion(sysmem, {c_u64(base)}, &s->mem_{ident});",
        ]
    lines.append("")

    object_names = {"cpu": "DEVICE(cpus[0])"}
    plic = riscv_interrupts.get("plic")
    if plic is not None:
        ident = c_ident(plic["name"])
        object_names[plic["name"]] = f"dev_{ident}"
        lines += [
            f"    DeviceState *dev_{ident} = sifive_plic_create(",
            f"        {c_u64(number(plic['base'], 'riscv_interrupts.plic.base'))},",
            f"        (char *){json.dumps(plic['hart_config'])}, {num_harts}, {hartid_base},",
            f"        {uint32(plic['num_sources'], 'riscv_interrupts.plic.num_sources')},",
            f"        {uint32(plic['num_priorities'], 'riscv_interrupts.plic.num_priorities')},",
            f"        {c_u64(number(plic['priority_base'], 'riscv_interrupts.plic.priority_base'))},",
            f"        {c_u64(number(plic['pending_base'], 'riscv_interrupts.plic.pending_base'))},",
            f"        {c_u64(number(plic['enable_base'], 'riscv_interrupts.plic.enable_base'))},",
            f"        {c_u64(number(plic['enable_stride'], 'riscv_interrupts.plic.enable_stride'))},",
            f"        {c_u64(number(plic['context_base'], 'riscv_interrupts.plic.context_base'))},",
            f"        {c_u64(number(plic['context_stride'], 'riscv_interrupts.plic.context_stride'))},",
            f"        {c_u64(number(plic['size'], 'riscv_interrupts.plic.size'))},",
            f"        {'true' if plic.get('edge_triggered', False) else 'false'});",
            "",
        ]

    aclint = riscv_interrupts.get("aclint")
    if aclint is not None:
        mswi = aclint.get("mswi")
        if mswi is not None:
            lines += [
                "    riscv_aclint_swi_create(",
                f"        {c_u64(number(mswi['base'], 'riscv_interrupts.aclint.mswi.base'))},",
                f"        {hartid_base}, {num_harts},",
                f"        {'true' if mswi.get('supervisor', False) else 'false'});",
            ]
        mtimer = aclint.get("mtimer")
        if mtimer is not None:
            lines += [
                "    riscv_aclint_mtimer_create(",
                f"        {c_u64(number(mtimer['base'], 'riscv_interrupts.aclint.mtimer.base'))},",
                f"        {c_u64(number(mtimer['size'], 'riscv_interrupts.aclint.mtimer.size'))},",
                f"        {hartid_base}, {num_harts},",
                f"        {c_u64(number(mtimer['timecmp_base'], 'riscv_interrupts.aclint.mtimer.timecmp_base'))},",
                f"        {c_u64(number(mtimer['time_base'], 'riscv_interrupts.aclint.mtimer.time_base'))},",
                f"        {uint32(mtimer['timebase_frequency'], 'riscv_interrupts.aclint.mtimer.timebase_frequency')},",
                f"        {'true' if mtimer.get('provide_rdtime', False) else 'false'});",
            ]
        lines.append("")

    for ctl in spec.get("interrupt_controllers", []):
        ident = c_ident(ctl["name"])
        object_names[ctl["name"]] = f"dev_{ident}"
        lines.append(f"    DeviceState *dev_{ident} = qdev_new({json.dumps(ctl['qom_type'])});")
        for prop in ctl.get("properties", []):
            lines.append(emit_property(f"dev_{ident}", prop))
        lines.append(f"    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev_{ident}), &error_fatal);")
        for mmio in ctl["mmio"]:
            lines.append(f"    sysbus_mmio_map(SYS_BUS_DEVICE(dev_{ident}), {mmio['region']}, {c_u64(number(mmio['base'], 'mmio.base'))});")
        for irq in ctl.get("cpu_irqs", []):
            if ctl.get("output_kind", "sysbus") == "gpio":
                lines.append(f"    qdev_connect_gpio_out(dev_{ident}, {irq['output']}, qdev_get_gpio_in(DEVICE(cpus[0]), {irq['cpu_input']}));")
            else:
                lines.append(f"    sysbus_connect_irq(SYS_BUS_DEVICE(dev_{ident}), {irq['output']}, qdev_get_gpio_in(DEVICE(cpus[0]), {irq['cpu_input']}));")
        lines.append("")

    for dev in spec["devices"]:
        ident = c_ident(dev["name"])
        object_names[dev["name"]] = f"dev_{ident}"
        lines.append(f"    DeviceState *dev_{ident} = qdev_new({json.dumps(dev['qom_type'])});")
        for prop in dev.get("properties", []):
            lines.append(emit_property(f"dev_{ident}", prop))
        if dev.get("chardev"):
            ch = dev["chardev"]
            lines.append(f"    qdev_prop_set_chr(dev_{ident}, {json.dumps(ch['property'])}, serial_hd({ch['serial_index']}));")
        # Links are emitted after every object has been declared below.
        lines.append("")

    for dev in spec["devices"]:
        ident = c_ident(dev["name"])
        for link in dev.get("links", []):
            target = object_names[link["target"]]
            lines.append(f"    object_property_set_link(OBJECT(dev_{ident}), {json.dumps(link['property'])}, OBJECT({target}), &error_fatal);")
        lines.append(f"    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev_{ident}), &error_fatal);")
        for mmio in dev["mmio"]:
            lines.append(f"    sysbus_mmio_map(SYS_BUS_DEVICE(dev_{ident}), {mmio['region']}, {c_u64(number(mmio['base'], 'mmio.base'))});")
        for irq in dev.get("irqs", []):
            ctl = c_ident(irq["controller"])
            lines.append(f"    sysbus_connect_irq(SYS_BUS_DEVICE(dev_{ident}), {irq['output']}, qdev_get_gpio_in(dev_{ctl}, {irq['input']}));")
        lines.append("")

    for conn in spec.get("gpio_connections", []):
        src, dst = conn["from"], conn["to"]
        src_expr, dst_expr = object_names[src["device"]], object_names[dst["device"]]
        lines.append(
            f"    qdev_connect_gpio_out_named({src_expr}, {json.dumps(src['name'])}, {src['index']}, "
            f"qdev_get_gpio_in_named({dst_expr}, {json.dumps(dst['name'])}, {dst['index']}));"
        )

    if spec["boot"]["kind"] == "direct-elf":
        use_entry = spec["boot"].get("use_elf_entry", True)
        lines += [
            "",
            "    if (machine->kernel_filename) {",
            f"        uint64_t entry = {c_u64(resetvec)};",
            "        ssize_t size = load_elf(machine->kernel_filename, NULL, NULL, NULL,",
            "            &entry, NULL, NULL, NULL, ELFDATA2LSB, EM_RISCV, 0, 0);",
            "        if (size < 0) {",
            "            error_report(\"cannot load RISC-V ELF '%s': %s\",",
            "                machine->kernel_filename, load_elf_strerror(size));",
            "            exit(EXIT_FAILURE);",
            "        }",
        ]
        if use_entry:
            lines += [
                f"        for (uint32_t i = 0; i < {num_harts}; i++) {{",
                "            cpus[i]->env.resetvec = entry;",
                "        }",
            ]
        lines += [
            f"        for (uint32_t i = 0; i < {num_harts}; i++) {{",
            "            cpu_reset(CPU(cpus[i]));",
            "        }",
            "    }",
        ]

    lines += [
        "}",
        "",
        f"static void {stem}_machine_class_init(ObjectClass *oc, const void *data)",
        "{",
        "    MachineClass *mc = MACHINE_CLASS(oc);",
        "    (void)data;",
        f"    mc->desc = {json.dumps(machine.get('description', machine['name']))};",
        f"    mc->init = {stem}_init;",
        f"    mc->min_cpus = {num_harts};",
        f"    mc->default_cpus = {num_harts};",
        f"    mc->max_cpus = {num_harts};",
        f"    mc->default_cpu_type = {json.dumps(spec['cpu']['qom_type'])};",
        "    mc->default_ram_size = 0;",
        f"    mc->default_ram_id = {json.dumps(machine['name'] + '.ram')};",
        "    mc->no_floppy = true;",
        "    mc->no_cdrom = true;",
        "}",
        "",
        f"static const TypeInfo {stem}_machine_typeinfo = {{",
        f"    .name = TYPE_{stem.upper()}_MACHINE,",
        "    .parent = TYPE_MACHINE,",
        f"    .instance_size = sizeof({state_type}),",
        f"    .class_init = {stem}_machine_class_init,",
        "};",
        "",
        f"static void {stem}_machine_register_types(void)",
        "{",
        f"    type_register_static(&{stem}_machine_typeinfo);",
        "}",
        "",
        f"type_init({stem}_machine_register_types)",
        "",
    ]
    return "\n".join(lines)


def emit_meson(spec, c_name):
    cfg = spec["machine"].get("kconfig", c_ident(spec["machine"]["name"]).upper())
    sources = []
    for model in spec["models"].values():
        sources.extend(model.get("sources", []))
    quoted = ",\n        ".join(json.dumps(s) for s in [c_name] + sorted(set(sources)))
    return (
        "# Generated by tools/board/rehost_gen.py.  Enter through subdir() from hw/riscv/meson.build.\n"
        f"riscv_ss.add(when: 'CONFIG_{cfg}', if_true: files(\n"
        f"        {quoted},\n"
        "))\n"
    )


def emit_kconfig(spec):
    cfg = spec["machine"].get("kconfig", c_ident(spec["machine"]["name"]).upper())
    selects = set(spec["machine"].get("kconfig_selects", []))
    riscv_interrupts = spec.get("riscv_interrupts", {})
    if "plic" in riscv_interrupts:
        selects.add("SIFIVE_PLIC")
    if "aclint" in riscv_interrupts:
        selects.add("RISCV_ACLINT")
    lines = [
        "# Generated by tools/board/rehost_gen.py.  Source from the architecture Kconfig.\n"
        f"config {cfg}\n"
        "    bool\n"
        "    default y\n"
        "    depends on RISCV\n"
    ]
    lines.extend(f"    select {symbol}\n" for symbol in sorted(selects))
    return "".join(lines)


def canonical_spec(spec):
    return json.dumps(spec, sort_keys=True, separators=(",", ":")).encode()


def artifacts(spec):
    stem = c_ident(spec["machine"]["name"])
    c_name = stem + ".c"
    digest = hashlib.sha256(canonical_spec(spec)).hexdigest()
    lock = {
        "schema_version": 1,
        "machine": spec["machine"]["name"],
        "board_sha256": digest,
        "generator": "tools/board/rehost_gen.py",
    }
    return {
        c_name: emit_machine(spec),
        "meson.build": emit_meson(spec, c_name),
        "Kconfig": emit_kconfig(spec),
        "manifest.lock.json": json.dumps(lock, indent=2, sort_keys=True) + "\n",
    }


def write_artifacts(spec, outdir):
    out = Path(outdir)
    out.mkdir(parents=True, exist_ok=True)
    for name, content in artifacts(spec).items():
        (out / name).write_text(content, encoding="utf-8")


def check_artifacts(spec, outdir):
    expected = artifacts(spec)
    out = Path(outdir)
    errors = []
    for name, content in expected.items():
        path = out / name
        if not path.exists():
            errors.append(f"missing {path}")
        elif path.read_text(encoding="utf-8") != content:
            errors.append(f"stale {path}")
    extra = sorted(p.name for p in out.iterdir() if p.is_file() and p.name not in expected) if out.exists() else []
    errors.extend(f"unexpected {out / name}" for name in extra)
    return errors


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="command", required=True)
    for command in ("validate", "generate", "check"):
        p = sub.add_parser(command)
        p.add_argument("board")
        if command != "validate":
            p.add_argument("-o", "--out", required=True)
    args = ap.parse_args()
    try:
        spec = validate(load_spec(args.board))
        if args.command == "validate":
            print(f"VALID: {args.board} ({len(spec['devices'])} device(s))")
        elif args.command == "generate":
            write_artifacts(spec, args.out)
            print(f"GENERATED: {args.out} ({len(artifacts(spec))} artifact(s))")
        else:
            errors = check_artifacts(spec, args.out)
            if errors:
                for error in errors:
                    print(f"STALE: {error}", file=sys.stderr)
                return 1
            print(f"CURRENT: {args.out}")
    except (OSError, json.JSONDecodeError, SpecError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
