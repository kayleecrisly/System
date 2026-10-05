#!/usr/bin/env python3
"""Exercise the real catalog loader and emitter; optional pre-change comparison."""
import argparse
import copy
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
PARSER = argparse.ArgumentParser()
PARSER.add_argument("--qemu-passes", required=True, type=Path)
PARSER.add_argument("--baseline", type=Path)
ARGS, UNITTEST_ARGS = PARSER.parse_known_args()
BINARY = ARGS.qemu_passes.resolve()
BASELINE = ARGS.baseline.resolve() if ARGS.baseline else None


def fixture(module="demo", irq=None, chardev=False):
    attrs = '''qemu.functional_txns = [
      {kind = "READ", addr_signal = "addr", addr_width = 32 : i64,
       rdata_signal = "rdata", rdata_width = 32 : i64, enable_signal = "wr",
       is_bus_write = false, confidence = 1.0 : f64},
      {kind = "WRITE", addr_signal = "addr", addr_width = 32 : i64,
       wdata_signal = "wdata", wdata_width = 32 : i64, enable_signal = "wr",
       is_bus_write = true, confidence = 1.0 : f64}
    ]'''
    if irq is not None:
        attrs += f''', qemu.irq_blueprint = {{irq_count = {irq} : i64,
          intr_state_offset = 0 : i64, intr_enable_offset = 4 : i64}}'''
    if chardev:
        attrs += ', qemu.chardev_blueprint = {tx = {trigger_offset = 28 : i64}}'
    return f'''module {{
      hw.module @{module}(in %addr : i32, in %wdata : i32, in %wr : i1,
                          out rdata : i32) attributes {{{attrs}}} {{
        hw.output %wdata : i32
      }}
    }}
    '''


def catalog():
    return {
        "$schema_version": 1,
        "project": "testchip",
        "backend": "opentitan",
        "fallback": "error",
        "naming": {"qom_prefix": "testchip", "state_prefix": "TestChip",
                   "macro_prefix": "TESTCHIP"},
        "devices": [{"module": "demo"}],
    }


class DeviceCatalogTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="qp-catalog-test-")
        self.addCleanup(self.tmp.cleanup)
        self.work = Path(self.tmp.name)
        self.serial = 0

    def emit(self, config=None, module="demo", irq=None, chardev=False,
             binary=BINARY, ir=None):
        self.serial += 1
        run = self.work / str(self.serial)
        run.mkdir()
        src = run / "input.mlir"
        src.write_text(ir if ir is not None else fixture(module, irq, chardev))
        out = run / "generated"
        cmd = [str(binary), str(src), "--qemu-emit-c", "--no-reports",
               f"--qemu-output-dir={out}", "-o", str(run / "output.mlir")]
        if config is not None:
            if isinstance(config, Path):
                path = config
            else:
                path = run / "catalog.json"
                path.write_text(json.dumps(config))
            cmd.append(f"--device-catalog={path}")
            try:
                legacy = json.loads(path.read_text()).get('backend') == 'opentitan'
            except (OSError, ValueError):
                legacy = False
            if binary == BINARY and legacy:
                cmd.append('--rtl-adapter=opentitan')
        p = subprocess.run(cmd, cwd=run, capture_output=True, text=True, timeout=60)
        files = {x.name: x.read_text() for x in out.rglob("*") if x.is_file()}
        return p, files

    def success(self, config=None, **kwargs):
        p, files = self.emit(config, **kwargs)
        self.assertEqual(p.returncode, 0, p.stderr + p.stdout)
        self.assertEqual(len(files), 4, p.stderr)
        return files

    def failure(self, config, message, **kwargs):
        p, files = self.emit(config, **kwargs)
        self.assertNotEqual(p.returncode, 0)
        self.assertIn(message, p.stderr)
        self.assertEqual(files, {}, "invalid configuration wrote partial C output")

    def test_default_catalog_is_neutral(self):
        implicit = self.success(module="uart")
        explicit = self.success(ROOT / "defaults/generic.json", module="uart")
        self.assertEqual(implicit, explicit)
        self.assertIn('"qp-uart-qp"', implicit["uart_qp_shim.h"])
        self.assertNotIn("hw/opentitan/", implicit["uart_qp_shim.c"])
        legacy = self.success(ROOT.parent / "projects/opentitan/catalogs/opentitan.json", module="uart")
        self.assertIn('"ot-uart-qp"', legacy["uart_qp_shim.h"])

    def test_custom_catalog_drives_names_properties_irq_and_mmio(self):
        c = catalog()
        c["devices"][0].update({
            "qom_type": "my-timer", "state_type": "MyTimerState",
            "type_macro": "MY_TIMER", "irq_count": 2, "mmio_size": "0x2000",
            "properties": [
                {"kind": "uint32", "name": "clock-hz", "field": "clock_hz", "default": 1000000},
                {"kind": "uint8", "name": "version", "field": "version", "default": 255},
                {"kind": "bool", "name": "enabled", "field": "enabled", "default": True},
                {"kind": "string", "name": "label", "field": "label"},
                {"kind": "link", "name": "clock-src", "field": "clock_src", "target_type_macro": "TYPE_DEVICE"},
            ],
        })
        files = self.success(c, irq=1)
        shim = files["demo_qp_shim.c"]
        self.assertIn('#define TYPE_MY_TIMER "my-timer"', files["demo_qp_shim.h"])
        self.assertIn("struct MyTimerState", shim)
        self.assertIn("MY_TIMER_IRQ_NUM 2u", shim)  # declaration beats inference
        self.assertIn('DEFINE_PROP_UINT32("clock-hz", MyTimerState, clock_hz, 1000000u)', shim)
        self.assertIn('DEFINE_PROP_BOOL("enabled", MyTimerState, enabled, true)', shim)
        self.assertIn('DEFINE_PROP_UINT8("version", MyTimerState, version, 255)', shim)
        self.assertIn("ibex_irq_set(&s->irqs[i]", shim)
        self.assertIn("TYPE_MY_TIMER, 0x2000", shim)
        self.assertIn('"demo", 0x2000', files["demo.c"])

    def test_blueprint_count_used_when_count_omitted(self):
        files = self.success(catalog(), irq=3)
        self.assertIn("TESTCHIP_DEMO_QP_IRQ_NUM 3u", files["demo_qp_shim.c"])
        files = self.success(catalog())
        self.assertIn("TESTCHIP_DEMO_QP_IRQ_NUM 0u", files["demo_qp_shim.c"])

    def test_generic_and_strict_fallback_and_project_isolation(self):
        c = catalog()
        self.failure(c, "fallback=error", module="uart")
        c["fallback"] = "generic"
        files = self.success(c, module="uart", irq=2)
        self.assertIn('"testchip-uart-qp"', files["uart_qp_shim.h"])
        self.assertIn("TESTCHIP_UART_QP_IRQ_NUM 2u", files["uart_qp_shim.c"])
        self.assertNotIn("OT_COMMON_DEV_ID", files["uart_qp_shim.c"])

    def test_properties_inherit_or_replace_and_chardev_autoproperty(self):
        c = catalog()
        c["generic_properties"] = [{"kind": "string", "name": "label", "field": "label"}]
        files = self.success(c)
        self.assertIn('DEFINE_PROP_STRING("label",', files["demo_qp_shim.c"])
        c["devices"][0]["properties"] = []
        files = self.success(c, chardev=True)
        self.assertNotIn('DEFINE_PROP_STRING("label",', files["demo_qp_shim.c"])
        self.assertIn('DEFINE_PROP_CHR("chardev",', files["demo_qp_shim.c"])
        self.assertIn("CharFrontend chr;", files["demo_qp_shim.c"])

    def test_invalid_catalogs_fail_before_emission(self):
        edits = [
            (lambda c: c.update({"$schema_version": 2}), "$schema_version"),
            (lambda c: c.update({"irq_cout": 2}), "unknown field"),
            (lambda c: c.update({"fallback": "silent"}), "fallback must"),
            (lambda c: c.update({"devices": {}}), "devices must be an array"),
            (lambda c: c["devices"][0].update({"irq_count": -1}), "irq_count"),
            (lambda c: c["devices"][0].update({"irq_count": 33}), "irq_count"),
            (lambda c: c["devices"][0].update({"irq_count": "2"}), "irq_count"),
            (lambda c: c["devices"][0].update({"irq_count": None}), "irq_count"),
            (lambda c: c["devices"][0].update({"irq_count": True}), "irq_count"),
            (lambda c: c["devices"][0].update({"mmio_size": 0}), "mmio_size"),
            (lambda c: c["devices"][0].update({"mmio_size": -1}), "mmio_size"),
            (lambda c: c["devices"][0].update({"mmio_size": "oops"}), "mmio_size"),
            (lambda c: c["devices"][0].update({"state_type": "X; bad"}), "state_type"),
            (lambda c: c["devices"][0].update({"key_sink": "true"}), "key_sink"),
            (lambda c: c["devices"].append(copy.deepcopy(c["devices"][0])), "duplicate"),
            (lambda c: c["devices"].append({"module": "other", "qom_type": "testchip-demo-qp"}), "duplicate"),
            (lambda c: c["devices"][0].update({"sources": [{}]}), "document"),
        ]
        for edit, diagnostic in edits:
            with self.subTest(diagnostic=diagnostic, edit=edit):
                c = catalog()
                edit(c)
                self.failure(c, diagnostic)

    def test_invalid_properties(self):
        props = [
            ({"kind": "code", "field": "f", "name": "f"}, "unknown property kind"),
            ({"kind": "bool", "field": "f", "name": "f", "default": 1}, "boolean default"),
            ({"kind": "uint8", "field": "f", "name": "f", "default": 256}, "in-range"),
            ({"kind": "string", "field": "core", "name": "f"}, "reserved"),
            ({"kind": "string", "field": "switch", "name": "f"}, "C identifier"),
            ({"kind": "string", "field": "f", "name": "chardev"}, "reserved for chardev"),
            ({"kind": "string", "field": "f", "name": "f", "name_macro": "F"}, "exactly one"),
            ({"kind": "chardev", "field": "other", "name": "chardev"}, "must be 'chr'"),
            ({"kind": "string", "field": "chr", "name": "chardev"}, "reserved for chardev"),
            ({"kind": "string", "field": "f", "name": "f", "default": "x"}, "default is only"),
            ({"kind": "link", "field": "f", "name": "f", "target_type_macro": "TYPE_DEVICE, bad"}, "C identifier"),
        ]
        for prop, diagnostic in props:
            with self.subTest(prop=prop):
                c = catalog()
                c["devices"][0]["properties"] = [prop]
                self.failure(c, diagnostic)
        c = catalog()
        c["devices"][0]["properties"] = [
            {"kind": "string", "field": "f", "name": "a"},
            {"kind": "string", "field": "f", "name": "b"},
        ]
        self.failure(c, "duplicate property field")

    def test_template_is_incomplete_and_generic_port_irqs_are_loadable(self):
        self.failure(ROOT.parent / "projects/common/catalogs/project.template.json", "irq_count")
        ir = fixture()
        ir = ir.replace("out rdata : i32", "out rdata : i32, out intr : i2")
        ir = ir.replace("qemu.functional_txns =", 'qemu.irq_outputs = [{port = "intr", bit = 0 : i32}, {port = "intr", bit = 1 : i32}], qemu.functional_txns =')
        ir = ir.replace("hw.output %wdata : i32", "%zero = hw.constant 0 : i2\n        hw.output %wdata, %zero : i32, i2")
        config = catalog()
        config['backend'] = 'generic-sysbus'
        config['devices'][0]['irq_count'] = 2
        files = self.success(config, ir=ir)
        self.assertIn("qemu_set_irq(s->irqs[1]", files["demo_qp_shim.c"])
        self.assertNotIn("IbexIRQ", files["demo_qp_shim.c"])

    def test_missing_and_malformed_file(self):
        self.failure(self.work / "missing.json", "missing.json")
        bad = self.work / "bad.json"
        bad.write_text('{"devices":')
        self.failure(bad, "bad.json")

    def test_catalog_without_bus_contract_fails(self):
        self.failure(catalog(), "requires usable bus transactions",
                     ir="module { hw.module @demo() { hw.output } }")

    @unittest.skipUnless(BASELINE, "--baseline not supplied")
    def test_all_original_devices_and_generic_output_unchanged(self):
        config = json.loads((ROOT.parent / "projects/opentitan/catalogs/opentitan.json").read_text())
        modules = [d["module"] for d in config["devices"]] + ["unlisted_top"]
        for module in modules:
            with self.subTest(module=module):
                before = self.success(ROOT.parent / "projects/opentitan/catalogs/opentitan.json", module=module, binary=BASELINE)
                after = self.success(ROOT.parent / "projects/opentitan/catalogs/opentitan.json", module=module)
                for name in before:
                    # Only the regeneration instructions in the banner change.
                    original = before[name].replace(
                        "after changing the kKnownDevices catalog in lib/QEMUEmitCPass.cpp.",
                        "after changing the JSON selected by --device-catalog.")
                    self.assertEqual(original, after[name], name)


if __name__ == "__main__":
    unittest.main(argv=[__file__] + UNITTEST_ARGS)
