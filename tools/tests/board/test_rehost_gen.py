#!/usr/bin/env python3

import copy
import importlib.util
import json
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SOC = ROOT / "board"
MODULE_SPEC = importlib.util.spec_from_file_location("rehost_gen", SOC / "rehost_gen.py")
rehost_gen = importlib.util.module_from_spec(MODULE_SPEC)
MODULE_SPEC.loader.exec_module(rehost_gen)


class RehostGeneratorTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.example = json.loads((ROOT.parent / "projects/common/boards/mini_riscv.board.json").read_text())
        cls.earlgrey = json.loads((ROOT.parent / "projects/opentitan/boards/earlgrey_rehost.board.json").read_text())

    def test_example_validates_and_emits_portable_qemu_api(self):
        spec = rehost_gen.validate(copy.deepcopy(self.example))
        output = rehost_gen.artifacts(spec)
        machine = output["qp_mini_riscv.c"]
        self.assertIn("type_init(qp_mini_riscv_machine_register_types)", machine)
        self.assertIn('qdev_new("ot-uart-qp")', machine)
        self.assertIn("sysbus_mmio_map(SYS_BUS_DEVICE(dev_uart0), 0, 0x10000000ULL)", machine)
        self.assertIn("sysbus_connect_irq(SYS_BUS_DEVICE(dev_uart0), 0", machine)
        self.assertIn("DeviceState *dev_plic0 = sifive_plic_create(", machine)
        self.assertIn("riscv_aclint_swi_create(", machine)
        self.assertIn("riscv_aclint_mtimer_create(", machine)
        self.assertIn("qdev_get_gpio_in(dev_plic0, 5)", machine)
        self.assertIn("load_elf(machine->kernel_filename", machine)
        self.assertNotIn("OT_EG_SOC_", machine)
        self.assertIn("    select SIFIVE_PLIC", output["Kconfig"])
        self.assertIn("    select RISCV_ACLINT", output["Kconfig"])
        self.assertNotIn("    select XILINX", output["Kconfig"])

    def test_generation_is_deterministic_and_checkable(self):
        spec = rehost_gen.validate(copy.deepcopy(self.example))
        with tempfile.TemporaryDirectory() as td:
            rehost_gen.write_artifacts(spec, td)
            self.assertEqual([], rehost_gen.check_artifacts(spec, td))
            lock = json.loads((Path(td) / "manifest.lock.json").read_text())
            self.assertEqual(64, len(lock["board_sha256"]))
            (Path(td) / "Kconfig").write_text("stale\n")
            self.assertTrue(any("stale" in e for e in rehost_gen.check_artifacts(spec, td)))

    def test_address_overlap_is_rejected(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["mmio"][0]["base"] = "0x80000010"
        with self.assertRaisesRegex(rehost_gen.SpecError, "address overlap"):
            rehost_gen.validate(spec)

    def test_model_contract_mismatch_is_rejected(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["qom_type"] = "wrong-uart"
        with self.assertRaisesRegex(rehost_gen.SpecError, "does not match model"):
            rehost_gen.validate(spec)

    def test_irq_endpoint_bounds_are_checked(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["irqs"][0]["output"] = 1
        with self.assertRaisesRegex(rehost_gen.SpecError, "outside model IRQ output"):
            rehost_gen.validate(spec)

    def test_plic_source_bounds_are_checked(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["irqs"][0]["input"] = 53
        with self.assertRaisesRegex(rehost_gen.SpecError, "outside controller input count"):
            rehost_gen.validate(spec)

    def test_plic_hart_configuration_must_match_cpu_count(self):
        spec = copy.deepcopy(self.example)
        spec["cpu"]["num_harts"] = 2
        with self.assertRaisesRegex(rehost_gen.SpecError, "describes 1 hart"):
            rehost_gen.validate(spec)

    def test_fixed_multi_hart_topology_is_emitted(self):
        spec = copy.deepcopy(self.example)
        spec["cpu"]["num_harts"] = 2
        spec["riscv_interrupts"]["plic"]["hart_config"] = "M,M"
        machine = rehost_gen.emit_machine(rehost_gen.validate(spec))
        self.assertIn("RISCVCPU *cpus[2]", machine)
        self.assertIn("for (uint32_t i = 0; i < 2; i++)", machine)
        self.assertIn("mc->default_cpus = 2", machine)

    def test_plic_register_layout_must_fit_aperture(self):
        spec = copy.deepcopy(self.example)
        spec["riscv_interrupts"]["plic"]["size"] = "0x1000"
        with self.assertRaisesRegex(rehost_gen.SpecError, "register layout exceeds"):
            rehost_gen.validate(spec)

    def test_aclint_timer_offsets_must_fit_aperture(self):
        spec = copy.deepcopy(self.example)
        spec["riscv_interrupts"]["aclint"]["mtimer"]["time_base"] = "0x8000"
        with self.assertRaisesRegex(rehost_gen.SpecError, "timer registers exceed"):
            rehost_gen.validate(spec)

    def test_unknown_link_target_is_rejected(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["links"] = [{"property": "clock-src", "target": "missing"}]
        with self.assertRaisesRegex(rehost_gen.SpecError, "unknown object"):
            rehost_gen.validate(spec)

    def test_unknown_field_is_rejected_instead_of_silently_ignored(self):
        spec = copy.deepcopy(self.example)
        spec["devices"][0]["mmio_base"] = "0x10000000"
        with self.assertRaisesRegex(rehost_gen.SpecError, "unknown field"):
            rehost_gen.validate(spec)

    def test_earlgrey_uses_qdev_gpio_plic_outputs(self):
        spec = rehost_gen.validate(copy.deepcopy(self.earlgrey))
        machine = rehost_gen.emit_machine(spec)
        self.assertEqual("peripheral-test", spec["platform"]["integration_level"])
        self.assertEqual(17, len(spec["devices"]))
        self.assertIn('qdev_new("ot-rv-plic-qp")', machine)
        self.assertIn("qdev_connect_gpio_out(dev_plic0, 0", machine)
        self.assertIn("qdev_connect_gpio_out(dev_plic0, 1", machine)
        self.assertNotIn("sysbus_connect_irq(SYS_BUS_DEVICE(dev_plic0)", machine)

    def test_earlgrey_devices_match_authoritative_digest_and_binding(self):
        board = rehost_gen.validate(copy.deepcopy(self.earlgrey))
        digest = json.loads((ROOT.parent / "projects/opentitan/boards/soc.digest.json").read_text())["devices"]
        binding = json.loads((ROOT.parent / "projects/opentitan/boards/earlgrey.soc.json").read_text())["devices"]
        by_model = {device["model"]: device for device in board["devices"]}

        for entry in binding:
            device = by_model[entry["name"]]
            facts = digest[entry["ot_instance"]]
            self.assertEqual(int(facts["base"], 16), rehost_gen.number(
                device["mmio"][0]["base"], f"{entry['name']}.base"))
            self.assertEqual(entry["irq_count"], len(device.get("irqs", [])))
            expected_inputs = list(range(
                facts.get("plic", {}).get("base_src", 0),
                facts.get("plic", {}).get("base_src", 0) + entry["irq_count"],
            ))
            self.assertEqual(expected_inputs, [irq["input"] for irq in device.get("irqs", [])])

    def test_earlgrey_all_declared_models_are_instantiated(self):
        board = rehost_gen.validate(copy.deepcopy(self.earlgrey))
        used_models = {device["model"] for device in board["devices"]}
        used_models |= {
            controller["model"] for controller in board.get("interrupt_controllers", [])
            if "model" in controller
        }
        self.assertEqual(set(board["models"]), used_models)


if __name__ == "__main__":
    unittest.main()
