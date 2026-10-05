#!/usr/bin/env python3
"""Contract validation and real generic-emitter regression tests."""
import argparse
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
TEST_ROOT = Path(__file__).resolve().parent
p = argparse.ArgumentParser()
p.add_argument('--qemu-passes', required=True, type=Path)
a, remainder = p.parse_known_args()
BINARY = a.qemu_passes.resolve()
descriptor = importlib.util.spec_from_file_location('qp_project', ROOT / 'driver/project.py')
project = importlib.util.module_from_spec(descriptor)
descriptor.loader.exec_module(project)
BASE = ROOT.parent / 'projects/common/examples'


class UnifiedProjectTests(unittest.TestCase):
    def setUp(self):
        self.spec = project.read_json(BASE / 'demo.project.json')
        self.tmp = tempfile.TemporaryDirectory(prefix='qp-unified-test-')
        self.addCleanup(self.tmp.cleanup)
        self.work = Path(self.tmp.name)

    def reject(self, text):
        with self.assertRaisesRegex(project.ContractError, text):
            project.validate(self.spec, BASE)

    def test_examples_conform_to_schema(self):
        for path in (ROOT.parent / 'projects').rglob('*.project.json'):
            spec = project.read_json(path)
            project.schema_validate(spec)
        project.validate(self.spec, BASE)

    def test_unknown_and_conflict_are_not_generation_permission(self):
        f = self.spec['devices'][0]['facts']['irq_count']
        f.update(value=None, status='unknown')
        self.reject('unresolved')
        self.assertTrue(project.validate(self.spec, BASE, draft=True))
        f.update(value=0, status='conflict')
        self.reject('unresolved')

    def test_missing_or_invented_evidence(self):
        self.spec['devices'][0]['facts']['irq_count']['evidence'] = []
        self.reject('requires evidence')
        self.spec['devices'][0]['facts']['irq_count']['evidence'] = [{'source': 'invented', 'location': 'x'}]
        self.reject('unknown source')

    def test_unknown_fields_and_capability_mismatches(self):
        self.spec['devices'][0]['backend_typo'] = 'generic-sysbus'
        self.reject('Additional properties')
        del self.spec['devices'][0]['backend_typo']
        self.spec['devices'][0]['facts']['data_width']['value'] = 64
        self.reject('32-bit')

    def test_missing_reset_and_conflicting_ties_are_rejected(self):
        d = self.spec['devices'][0]
        del d['reset']
        self.reject('declare reset')
        d['reset'] = None
        d['input_ties'] = {'addr': 0}
        d['evidence']['input_ties'] = d['evidence']['bus']
        self.reject('input ties conflict')

    def test_register_field_bounds(self):
        def fact(value):
            return {'value': value, 'status': 'confirmed',
                    'evidence': self.spec['devices'][0]['evidence']['bus']}
        self.spec['devices'][0]['registers'] = [{
            'name': 'CTRL', 'width': fact(32), 'offset': fact(0),
            'access': fact('rw'), 'reset_value': fact(0),
            'fields': [{'name': 'BAD', 'lsb': fact(31), 'width': fact(2), 'access': fact('rw')}]}]
        self.reject('field exceeds')

    def test_conflicting_control_and_fold_are_rejected(self):
        bus = self.spec['devices'][0]['bus']
        bus['controls'] = {phase: {'enable': 1} for phase in ['read', 'write', 'idle']}
        bus['noise_signals'] = ['enable']
        self.reject('also be folded')

    def test_pin_input_width_is_checked_against_actual_ir(self):
        d = self.spec['devices'][0]
        d['pin_io'] = {'data_in': {'port': 'x_a_valid', 'width': 32}}
        d['evidence']['pin_io'] = d['evidence']['bus']
        with self.assertRaisesRegex(project.ContractError, 'pin_io width differs'):
            self.generate()
        self.assertFalse((self.work / 'generated').exists())
        d['pin_io']['data_in']['width'] = 1
        self.generate()

    def test_pin_roles_cannot_overwrite_bus_or_mismatch_direction_width(self):
        d = self.spec['devices'][0]
        d['pin_io'] = {'data_in': {'port': 'wdata', 'width': 32}}
        d['evidence']['pin_io'] = d['evidence']['bus']
        self.reject('pin roles conflict')
        d['pin_io'] = {'data_out': {'port': 'pins', 'width': 32},
                       'output_enable': {'port': 'enable', 'width': 1}}
        self.reject('matching data_out width')

    def test_deterministic_prepare_and_no_overwrite(self):
        project.validate(self.spec, BASE)
        for name in ['a', 'b']:
            project.write_project(self.spec, BASE, self.work / name)
        for p in (self.work / 'a').rglob('*'):
            if p.is_file():
                self.assertEqual(p.read_bytes(), (self.work / 'b' / p.relative_to(self.work / 'a')).read_bytes())
        with self.assertRaisesRegex(project.ContractError, 'already exists'):
            project.write_project(self.spec, BASE, self.work / 'a')

    def rtl_frontend_fixture(self):
        rtl = self.work / 'demo.sv'
        rtl.write_text('module demo; endmodule\n')
        self.spec['devices'][0]['input'] = {'rtl': {'top': 'demo', 'files': [str(rtl)]}}
        config = self.work / 'config/toolchain.json'
        config.parent.mkdir()
        config.write_text(json.dumps({'root': '../upgraded', 'circt_verilog': 'bin/circt-verilog'}))
        return config, self.work / 'upgraded/bin/circt-verilog'

    def fake_frontend(self, path):
        # A minimal subprocess fixture tests tool selection and provenance;
        # the real model generator still consumes the emitted fixture IR.
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text('#!' + sys.executable + '\n'
                        'import pathlib, sys\n'
                        'pathlib.Path(sys.argv[sys.argv.index("-o") + 1]).write_text('
                        + repr((BASE / 'demo.mlir').read_text()) + ')\n'
                        'pathlib.Path(__file__ + ".invoked").touch()\n')
        path.chmod(0o755)

    def test_rtl_prepare_uses_configured_absolute_frontend_without_running_it(self):
        config, frontend = self.rtl_frontend_fixture()
        project.validate(self.spec, BASE)
        out = self.work / 'prepared'
        # Preparation can describe a toolchain that has not been built yet.
        with patch.object(project, 'TOOLCHAIN', config):
            project.write_project(self.spec, BASE, out)
        command = project.read_json(out / 'commands.json')[0]
        self.assertEqual(command[0], str(frontend))
        lock = project.read_json(out / 'manifest.lock.json')
        self.assertEqual(lock['frontend_path'], str(frontend))
        self.assertIsNone(lock['frontend_sha256'])

    def test_rtl_generation_selects_default_or_explicit_frontend_and_records_hash(self):
        config, default = self.rtl_frontend_fixture()
        override = self.work / 'explicit/circt-verilog'
        self.fake_frontend(default)
        self.fake_frontend(override)
        project.validate(self.spec, BASE)
        for selected, argument in [(default, None), (override, override)]:
            with self.subTest(frontend=selected):
                # Explicit selection must not depend on a valid default config.
                if argument:
                    config.unlink()
                out = self.work / ('explicit-out' if argument else 'default-out')
                with patch.object(project, 'TOOLCHAIN', config):
                    project.write_project(self.spec, BASE, out, BINARY, frontend=argument)
                self.assertTrue(Path(str(selected) + '.invoked').is_file())
                lock = project.read_json(out / 'manifest.lock.json')
                self.assertEqual(lock['frontend_path'], str(selected))
                self.assertEqual(lock['frontend_sha256'], hashlib.sha256(selected.read_bytes()).hexdigest())
                self.assertEqual(project.read_json(out / 'commands.json')[0][0], str(selected))
                self.assertTrue((out / 'models/demo/demo/demo.c').is_file())

    def test_unavailable_default_never_uses_path_or_creates_staging_output(self):
        config, default = self.rtl_frontend_fixture()
        path_frontend = self.work / 'old-bin/circt-verilog'
        self.fake_frontend(path_frontend)
        for nonexecutable in (False, True):
            with self.subTest(nonexecutable=nonexecutable):
                if nonexecutable:
                    self.fake_frontend(default)
                    default.chmod(0o644)
                out = self.work / 'uncreated-parent/output'
                with patch.object(project, 'TOOLCHAIN', config), patch.dict(os.environ, {'PATH': str(path_frontend.parent)}):
                    with self.assertRaisesRegex(project.ContractError, 'PATH fallback is disabled'):
                        project.write_project(self.spec, BASE, out, BINARY)
                self.assertFalse(out.parent.exists())
                self.assertFalse(Path(str(path_frontend) + '.invoked').exists())

    def test_mlir_generation_does_not_require_frontend_configuration(self):
        with patch.object(project, 'TOOLCHAIN', self.work / 'missing-toolchain.json'):
            out, model = self.generate()
        self.assertTrue((model / 'demo.c').is_file())
        lock = project.read_json(out / 'manifest.lock.json')
        self.assertIsNone(lock['frontend_path'])
        self.assertIsNone(lock['frontend_sha256'])

    def generate(self):
        project.validate(self.spec, BASE)
        out = self.work / 'generated'
        project.write_project(self.spec, BASE, out, BINARY)
        return out, out / 'models/demo/demo'

    def test_separate_generation_results_preserve_model_contract(self):
        out = self.work / 'generated'
        results = self.work / 'results/generation'
        project.validate(self.spec, BASE)
        project.write_project(self.spec, BASE, out, BINARY, results_dir=results)
        self.assertEqual({p.name for p in out.iterdir()},
                         {'models', 'board', 'configs', 'project.json', 'manifest.lock.json'})
        self.assertEqual({p.name for p in results.iterdir()}, {'logs', 'ir', 'commands.json'})
        board = project.read_json(out / 'configs/board.json')
        for model in board['models'].values():
            for name in [model['header']] + model['sources']:
                self.assertTrue((out / 'board' / name).is_file(), name)
        lock = project.read_json(out / 'manifest.lock.json')
        self.assertEqual((out / lock['results_dir']).resolve(), results)
        for root, key in [(out, 'artifact_sha256'), (results, 'generation_sha256')]:
            for name, expected in lock[key].items():
                self.assertEqual(hashlib.sha256((root / name).read_bytes()).hexdigest(), expected)
        commands = project.read_json(results / 'commands.json')
        self.assertIn(str(results / 'ir/demo.pipeline.mlir'), commands[0])
        self.assertTrue((results / 'logs/demo.generation.log').is_file())

    def test_canonical_output_defaults_to_separate_results(self):
        spec = copy.deepcopy(self.spec)
        del spec['board']
        root = self.work / 'System'
        out = root / 'outputs/example/run'
        with patch.object(project, 'ROOT', root / 'tools'):
            project.write_project(spec, BASE, out)
        results = root / 'results/example/run/generation'
        self.assertTrue((results / 'commands.json').is_file())
        self.assertFalse((out / 'commands.json').exists())

    def test_results_collision_or_generation_failure_does_not_publish(self):
        out = self.work / 'generated'
        results = self.work / 'results'
        results.mkdir()
        sentinel = results / 'existing.txt'
        sentinel.write_text('keep')
        with self.assertRaisesRegex(project.ContractError, 'results already exists'):
            project.write_project(self.spec, BASE, out, BINARY, results_dir=results)
        self.assertEqual(sentinel.read_text(), 'keep')
        self.assertFalse(out.exists())
        fresh = self.work / 'fresh-results'
        d = self.spec['devices'][0]
        d['bus']['roles']['addr']['port'] = 'rdata'
        d['bus']['roles']['rdata']['port'] = 'addr'
        with self.assertRaisesRegex(project.ContractError, 'correct direction'):
            project.write_project(self.spec, BASE, out, BINARY, results_dir=fresh)
        self.assertFalse(out.exists())
        self.assertFalse(fresh.exists())

    def test_failed_output_publication_rolls_back_results(self):
        out = self.work / 'generated'
        results = self.work / 'results'
        rename = Path.rename

        def fail_publish(source, target):
            if target == out:
                raise OSError('publication failure')
            return rename(source, target)

        with patch.object(Path, 'rename', fail_publish):
            with self.assertRaisesRegex(OSError, 'publication failure'):
                project.write_project(self.spec, BASE, out, results_dir=results)
        self.assertFalse(out.exists())
        self.assertFalse(results.exists())

    def test_nested_results_are_rejected(self):
        out = self.work / 'generated'
        for results in (out, out / 'results', self.work):
            with self.subTest(results=results):
                with self.assertRaisesRegex(project.ContractError, 'non-nested'):
                    project.write_project(self.spec, BASE, out, results_dir=results)
        self.assertFalse(out.exists())

    def test_generic_behavior_survives_vendor_names(self):
        out, model = self.generate()
        c = (model / 'demo.c').read_text()
        self.assertIn('s->u_ecc_err_i = s->wdata;', c)
        self.assertIn('s->u_value = s->u_ecc_err_i;', c)
        self.assertNotIn('s->rst_diagnostic_ni = 1;', c)
        self.assertNotIn('hw/opentitan/', (model / 'demo_qp_shim.c').read_text())
        log = (out / 'logs/demo.generation.log').read_text()
        self.assertNotIn('[TL-UL override]', log)
        self.assertNotIn('using built-in OpenTitan', log)
        # Execute the actual generated core with the repository's QEMU API stubs.
        harness = self.work / 'harness.c'
        harness.write_text('''#include "qemu/osdep.h"
#include "demo.h"
#include <assert.h>
int main(void) {
  demo_state s = {0};
  demo_reset(&s);
  assert(s.rst_diagnostic_ni == 0);
  demo_write(&s, 0x24, 0xa53c8921u, 4);
  assert(s.addr == 0x24);
  assert(s.x_a_address == 0);
  assert(demo_read(&s, 0x24, 4) == 0xa53c8921u);
  return 0;
}
''')
        command = ['cc', '-std=gnu11', '-O0', '-I' + str(TEST_ROOT / 'qstub'),
                   '-I' + str(model), str(model / 'demo.c'), str(harness), '-o', str(self.work / 'harness')]
        result = subprocess.run(command, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr[-4000:])
        subprocess.run([str(self.work / 'harness')], check=True, timeout=10)

    def test_wrong_port_direction_and_width_fail_before_publish(self):
        self.spec['devices'][0]['bus']['roles']['addr']['port'] = 'rdata'
        # Keep schema's roles distinct while intentionally swapping directions.
        self.spec['devices'][0]['bus']['roles']['rdata']['port'] = 'addr'
        with self.assertRaisesRegex(project.ContractError, 'correct direction'):
            self.generate()
        self.assertFalse((self.work / 'generated').exists())

    def test_board_uses_generated_contract_and_rejects_mismatch(self):
        out, model = self.generate()
        board = (out / 'board/qp_demo.c').read_text()
        self.assertIn('qdev_new("example-demo-qp")', board)
        self.assertIn('memory_region_init_ram(&s->mem_ram, NULL', board)
        self.assertNotIn('hw/opentitan/', board)
        self.spec['board']['devices'][0]['mmio'][0]['size'] = '0x2000'
        self.reject('MMIO size disagrees')

    def test_tim0_load_after_idle_and_pump_only_progress(self):
        tim0_base = ROOT.parent / 'projects/wujian100/examples'
        config = tim0_base / 'wujian100-tim0.project.json'
        if not config.is_file():
            self.skipTest('Wujian100 configuration cleared; new behavior test plan pending')
        spec = project.read_json(config)
        if not (tim0_base / spec['devices'][0]['input']['mlir']).is_file():
            self.skipTest('optional Wujian100 workspace IR is unavailable')
        project.validate(spec, tim0_base)
        out = self.work / 'tim0'
        project.write_project(spec, tim0_base, out, BINARY)
        model = out / 'models/tim0/tim0_sec_top'
        harness = self.work / 'timer.c'
        harness.write_text('''#include "qemu/osdep.h"
#include "tim0_sec_top.h"
#include <assert.h>
static unsigned rd(tim0_sec_top_state *s, unsigned addr, unsigned size) {
  s->psel = 1; s->penable = 0;
  unsigned value = tim0_sec_top_read(s, addr, size);
  s->psel = 0; s->penable = 1; tim0_sec_top_settle(s);
  return value;
}
static void wr(tim0_sec_top_state *s, unsigned addr, unsigned value, unsigned size) {
  s->psel = 1; s->penable = 1;
  tim0_sec_top_write(s, addr, value, size);
  s->psel = 0; s->penable = 1; tim0_sec_top_settle(s);
}
int main(void) {
  tim0_sec_top_state s = {0};
  tim0_sec_top_reset(&s);
  assert(rd(&s, 28, 4) == 0);
  for (unsigned i = 0; i < 40; ++i) tim0_sec_top_advance_tick(&s);
  wr(&s, 20, 20, 4);
  wr(&s, 28, 3, 4);
  unsigned current = rd(&s, 24, 4);
  assert(current == 20);
  for (unsigned i = 0; i < 40; ++i) {
    assert(rd(&s, 24, 4) == current);
    assert(!(s.intr & 2));
  }
  for (unsigned i = 0; i < 40 && !(s.intr & 2); ++i)
    tim0_sec_top_advance_tick(&s);
  assert(s.intr & 2);
  (void)rd(&s, 32, 4);
  wr(&s, 28, 0, 4);
  assert(!(s.intr & 2));
  return 0;
}
''')
        executable = self.work / 'timer-test'
        subprocess.run(['cc', '-std=gnu11', '-O0',
                        '-I' + str(TEST_ROOT / 'qstub'),
                        '-I' + str(model), str(model / 'tim0_sec_top.c'), str(harness),
                        '-o', str(executable)], check=True, capture_output=True)
        subprocess.run([str(executable)], check=True, timeout=10)

    def test_neutral_digest_lists_arbitrary_modules(self):
        dst = self.work / 'digest.json'
        result = subprocess.run([str(BINARY), str(BASE / 'demo.mlir'), f'--dump-ir-digest={dst}', '--no-reports'],
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        digest = json.loads(dst.read_text())
        self.assertEqual(digest['kind'], 'generic-ir-digest')
        child = next(m for m in digest['modules'] if m['name'] == 'example_prim_reg_we_check')
        self.assertEqual(child['ports'][0]['name'], 'ecc_err_i')
        self.assertNotIn('irq_suggestion', digest)


if __name__ == '__main__':
    unittest.main(argv=['test_unified_project.py'] + remainder)
