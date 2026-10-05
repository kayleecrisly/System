#!/usr/bin/env python3
"""Validate, compile, and generate a versioned hardware project contract."""
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

ROOT = Path(__file__).resolve().parents[1]
SCHEMA = Path(__file__).with_name('schema') / 'project.schema.json'
TOOLCHAIN = ROOT / 'toolchain.json'


class ContractError(ValueError):
    pass


def read_json(path):
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ContractError(f'duplicate JSON key: {key}')
            result[key] = value
        return result
    return json.loads(Path(path).read_text(), object_pairs_hook=unique)


def canonical(value):
    return json.dumps(value, indent=2, sort_keys=True) + '\n'


def schema_validate(spec):
    try:
        from jsonschema import Draft202012Validator
    except ImportError as exc:
        raise ContractError('Install tools/driver/requirements.txt to validate the input schema') from exc
    validator = Draft202012Validator(read_json(SCHEMA))
    errors = sorted(validator.iter_errors(spec), key=lambda e: str(list(e.absolute_path)))
    if errors:
        raise ContractError('\n'.join('/' + '/'.join(map(str, e.absolute_path)) + ': ' + e.message for e in errors[:20]))


def references(entries, sources, where):
    if not entries:
        raise ContractError(f'{where}: confirmed information requires evidence')
    for entry in entries:
        if entry['source'] not in sources:
            raise ContractError(f"{where}: unknown source {entry['source']}")


def validate(spec, base, draft=False):
    schema_validate(spec)
    if not spec['devices']:
        raise ContractError('devices must not be empty')
    sources = {s['id']: s for s in spec['sources']}
    if len(sources) != len(spec['sources']):
        raise ContractError('duplicate source id')
    incomplete = []

    def facts(node, path):
        if isinstance(node, dict):
            if {'value', 'status', 'evidence'} <= node.keys():
                if node['status'] != 'confirmed' or node['value'] is None:
                    incomplete.append(path)
                else:
                    references(node['evidence'], sources, path)
                return
            for k, v in node.items():
                facts(v, path + '/' + k)
        elif isinstance(node, list):
            for i, v in enumerate(node):
                facts(v, path + '/' + str(i))
    facts(spec, '')
    ids = set()
    top_modules = set()
    for d in spec['devices']:
        label = d['id']
        if label in ids:
            raise ContractError(f'duplicate device id: {label}')
        ids.add(label)
        if d['top_module'] in top_modules:
            raise ContractError('duplicate model top_module; instantiate one model multiple times in board.devices')
        top_modules.add(d['top_module'])
        if d['backend'] == 'opentitan' and d['rtl_adapter'] != 'opentitan':
            raise ContractError(f'{label}: opentitan backend requires an explicit opentitan RTL adapter')
        for key in ('top_module', 'bus'):
            references(d['evidence'].get(key, []), sources, f'{label}/evidence/{key}')
        for key in ('irq_outputs', 'reset', 'input_ties', 'clocks', 'pin_io'):
            if d.get(key):
                references(d['evidence'].get(key, []), sources, f'{label}/evidence/{key}')
        for key, entries in d['evidence'].items():
            references(entries, sources, f'{label}/evidence/{key}')
        inp = d['input']
        paths = [inp['mlir']] if 'mlir' in inp else inp['rtl']['files']
        if not paths:
            raise ContractError(f'{label}: input files must not be empty')
        for path in paths:
            if not (base / path).is_file():
                raise ContractError(f'{label}: input file does not exist: {path}')
        if 'rtl' in inp and inp['rtl']['top'] != d['top_module']:
            raise ContractError(f'{label}: frontend top differs from top_module')
        bus = d['bus']
        if bus['kind'] == 'adapter':
            if d['rtl_adapter'] != 'opentitan' or any(k != 'kind' for k in bus):
                raise ContractError(f'{label}: adapter bus currently requires opentitan and cannot contain ignored role/constraint fields')
        else:
            if not {'roles', 'noise_signals', 'controls'} <= bus.keys():
                raise ContractError(f'{label}: functional-mmio requires roles, noise_signals and controls')
            roles = bus['roles']
            if roles['wr_enable']['width'] != 1:
                raise ContractError(f'{label}: functional-mmio direction must be one bit')
            if len({v['port'] for v in roles.values()}) != 4:
                raise ContractError(f'{label}: bus roles must use distinct top ports')
            controlled = set()
            for phase in ('read', 'write', 'idle'):
                controlled.update(bus['controls'][phase])
            if controlled & {v['port'] for v in roles.values()}:
                raise ContractError(f'{label}: bus controls cannot overwrite address/data/direction roles')
            if any(set(bus['controls'][p]) != controlled for p in ('read', 'write', 'idle')):
                raise ContractError(f'{label}: each bus control must have read, write and idle values')
            if controlled & set(bus['noise_signals']):
                raise ContractError(f'{label}: a driven bus control cannot also be folded as noise')
            if controlled & set(d.get('input_ties', {})):
                raise ContractError(f'{label}: bus controls conflict with input ties')
        clock_ports = [c['port'] for c in d.get('clocks', [])]
        if len(clock_ports) != len(set(clock_ports)):
            raise ContractError(f'{label}: duplicate clock port')
        if d['backend'] == 'generic-sysbus':
            if 'reset' not in d or 'irq_outputs' not in d:
                raise ContractError(f'{label}: declare reset (or null) and irq_outputs (or []) explicitly')
            ties = set(d.get('input_ties', {}))
            reserved = set(clock_ports)
            if d.get('reset'):
                reserved.add(d['reset']['port'])
            if bus['kind'] == 'functional-mmio':
                reserved.update(v['port'] for v in bus['roles'].values())
                reserved.update(bus['noise_signals'])
            if ties & reserved:
                raise ContractError(f'{label}: input ties conflict with bus/reset/clock declarations')
        if d.get('pin_io'):
            if d['backend'] != 'generic-sysbus':
                raise ContractError(f'{label}: project pin_io currently requires generic-sysbus')
            pins = d['pin_io']
            if 'output_enable' in pins and ('data_out' not in pins or
                    pins['output_enable']['width'] != pins['data_out']['width']):
                raise ContractError(f'{label}: output_enable requires matching data_out width')
            ports = [v['port'] for v in pins.values()]
            if len(ports) != len(set(ports)):
                raise ContractError(f'{label}: pin roles must use distinct ports')
            reserved = set(d.get('input_ties', {})) | set(clock_ports)
            if d.get('reset'): reserved.add(d['reset']['port'])
            if bus['kind'] == 'functional-mmio':
                reserved.update(v['port'] for v in bus['roles'].values())
                reserved.update(bus['noise_signals'])
                reserved.update(bus['controls']['read'])
            if reserved & set(ports):
                raise ContractError(f'{label}: pin roles conflict with other input/bus declarations')
        if 'pump_hz' in d['simulation'] and 'timer' in d.get('binding', {}):
            raise ContractError(f'{label}: timer policy must not be duplicated in legacy binding')
        f = d['facts']
        values = {k: v['value'] for k, v in f.items()}
        if any(v is None for v in values.values()):
            continue
        if values['mmio_size'] <= 0 or values['irq_count'] > 32:
            raise ContractError(f'{label}: invalid MMIO size or unsupported IRQ count (current limit 32)')
        if values['data_width'] != 32 or values['byte_order'] != 'little' or values['access_sizes'] != [4]:
            raise ContractError(f'{label}: v1 contract currently supports 32-bit little-endian MMIO with 4-byte accesses')
        if bus['kind'] == 'functional-mmio' and any(bus['roles'][k]['width'] != 32 for k in ('addr', 'wdata', 'rdata')):
            raise ContractError(f'{label}: v1 functional-mmio requires 32-bit address/data ports')
        if d['backend'] == 'generic-sysbus':
            if d.get('binding'):
                raise ContractError(f'{label}: legacy backend binding is only available in the opentitan backend')
            if len(d.get('irq_outputs', [])) != values['irq_count']:
                raise ContractError(f'{label}: irq_outputs must map every declared IRQ')
            pairs = [(x['port'], x['bit']) for x in d.get('irq_outputs', [])]
            if len(set(pairs)) != len(pairs):
                raise ContractError(f'{label}: duplicate IRQ source bit')
        elif any(d.get(k) for k in ('irq_outputs', 'reset', 'input_ties')):
            raise ContractError(f'{label}: explicit port IRQ/reset/ties require generic-sysbus in v1')
        regs = set()
        for reg in d.get('registers', []):
            if reg['name'] in regs:
                raise ContractError(f'{label}: duplicate register {reg["name"]}')
            regs.add(reg['name'])
            width, offset, rv = (reg[k]['value'] for k in ('width', 'offset', 'reset_value'))
            if None not in (width, offset, rv):
                if width < 1 or width > 64 or offset + (width + 7) // 8 > values['mmio_size'] or rv >= 1 << width:
                    raise ContractError(f'{label}: register {reg["name"]} exceeds its window or width')
            field_names, field_bits = set(), set()
            for field in reg.get('fields', []):
                if field['name'] in field_names:
                    raise ContractError(f'{label}: duplicate register field {field["name"]}')
                field_names.add(field['name'])
                lsb, fw = field['lsb']['value'], field['width']['value']
                if None not in (width, lsb, fw):
                    if fw < 1 or lsb + fw > width:
                        raise ContractError(f'{label}: register field exceeds register width')
                    bits = set(range(lsb, lsb + fw))
                    if bits & field_bits:
                        raise ContractError(f'{label}: overlapping register fields')
                    field_bits.update(bits)

    if incomplete and not draft:
        raise ContractError('unresolved/conflicting facts block generation: ' + ', '.join(incomplete))
    # Board facts have their own formal schema and validator. Compiled model
    # contracts below replace board.models; board wiring is never inferred.
    if 'board' in spec and not incomplete:
        board_spec = compile_board(spec)
        board_module().validate(board_spec)
    return incomplete


def names(spec, d):
    project = spec['project']
    top = d['top_module']
    return {'qom_type': project.replace('_', '-') + '-' + top.replace('_', '-') + '-qp',
            'state_type': ''.join(p[:1].upper() + p[1:] for p in (project + '_' + top).split('_')) + 'QpState',
            'type_macro': (project + '_' + top + '_QP').upper()}


def compile_device(spec, d):
    top = d['top_module']
    entry = {'module': top, 'irq_count': d['facts']['irq_count']['value'],
             'mmio_size': d['facts']['mmio_size']['value'], 'properties': [], **names(spec, d)}
    catalog = {'$schema_version': 1, 'project': spec['project'], 'backend': d['backend'],
               'fallback': 'error', 'naming': {'qom_prefix': spec['project'].replace('_', '-'),
               'state_prefix': 'Project', 'macro_prefix': spec['project'].upper()}, 'devices': [entry]}
    binding = copy.deepcopy(d.get('binding', {}))
    if '$schema_version' in binding or 'design' in binding:
        raise ContractError(f'{d["id"]}: legacy binding must not override schema/design')
    binding.update({'$schema_version': 1, 'design': {'top_module': top}})
    if d['backend'] == 'generic-sysbus':
        binding['irq_outputs'] = [{'index': i, 'source': {'kind': 'port', 'name': x['port'], 'bit': x['bit']}}
                                  for i, x in enumerate(d.get('irq_outputs', []))]
        if d.get('reset'):
            binding['reset'] = d['reset']
        if d.get('input_ties'):
            binding['input_ties'] = d['input_ties']
        if d.get('pin_io'):
            binding['pin_io'] = d['pin_io']
    if 'pump_hz' in d['simulation']:
        binding['timer'] = {'pump_hz': d['simulation']['pump_hz']}
    if d.get('clocks'):
        binding['clocks'] = {c['port']: c['kind'] for c in d['clocks']}
    bus = None
    if d['bus']['kind'] == 'functional-mmio':
        bus = {'$schema_version': 1, 'design': {'top_module': top, 'bus_adapter_modules': []},
               'bindings': {k: {'kind': 'signal', 'name': v['port'], 'module': top, 'width': v['width']}
                            for k, v in d['bus']['roles'].items()},
               'noise_signals': d['bus']['noise_signals'],
               'transactions': [{'kind': kind, 'guard': [{'role': 'wr_enable', 'op': 'eq', 'value': value}]}
                                for kind, value in [('READ', 0), ('WRITE', 1)]]}
        binding['bus_controls'] = d['bus']['controls']
    return catalog, binding, bus


def board_module():
    descriptor = importlib.util.spec_from_file_location('qp_rehost', ROOT / 'board/rehost_gen.py')
    module = importlib.util.module_from_spec(descriptor)
    descriptor.loader.exec_module(module)
    return module


def compile_board(spec):
    board = copy.deepcopy(spec['board'])
    if board.get('models'):
        raise ContractError('board.models is generated from devices; do not duplicate model contracts')
    devices = {d['id']: d for d in spec['devices']}
    board['models'] = {}
    for label, d in devices.items():
        top = d['top_module']
        prefix = f'../models/{label}/{top}'
        board['models'][label] = {'qom_type': names(spec, d)['qom_type'],
            'header': f'{prefix}/{top}_qp_shim.h',
            'sources': [f'{prefix}/{top}.c', f'{prefix}/{top}_qp_shim.c'],
            'mmio_regions': 1, 'irq_outputs': d['facts']['irq_count']['value']}
    for device in board.get('devices', []):
        if device['model'] not in devices:
            raise ContractError(f'board: unknown model {device["model"]}')
        d = devices[device['model']]
        qom = names(spec, d)['qom_type']
        if 'qom_type' in device and device['qom_type'] != qom:
            raise ContractError('board qom_type disagrees with generated model')
        device['qom_type'] = qom
        for mmio in device.get('mmio', []):
            if int(str(mmio['size']), 0) != d['facts']['mmio_size']['value']:
                raise ContractError('board MMIO size disagrees with peripheral contract')
    return board


def run(command, cwd, log):
    result = subprocess.run(command, cwd=cwd, text=True, stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, timeout=900)
    log.write_text(result.stdout)
    if result.returncode:
        raise ContractError(f'command failed ({result.returncode}); see {log}:\n' + result.stdout[-4000:])


def generation_results_dir(out, results_dir=None):
    if results_dir is not None:
        return Path(results_dir).resolve()
    system = ROOT.parent
    try:
        relative = out.resolve().relative_to((system / 'outputs').resolve())
    except ValueError:
        return None
    if len(relative.parts) < 2:
        raise ContractError('canonical output must include a project and run directory')
    return system / 'results' / relative / 'generation'


def require_new_directory(path, label):
    if path.exists() or path.is_symlink():
        raise ContractError(f'{label} already exists; choose a fresh directory: {path}')


def resolve_frontend(spec, frontend, executable=False):
    if not any('rtl' in d['input'] for d in spec['devices']):
        return None
    if frontend is not None:
        frontend = Path(frontend).resolve()
        origin = '--circt-verilog'
    else:
        try:
            config = read_json(TOOLCHAIN)
            root, program = config['root'], config['circt_verilog']
            if not isinstance(root, str) or not root or not isinstance(program, str) or not program:
                raise ValueError('root and circt_verilog must be nonempty paths')
            frontend = (TOOLCHAIN.parent / root / program).resolve()
        except (OSError, ValueError, KeyError, TypeError) as exc:
            raise ContractError(f'cannot resolve default CIRCT frontend from {TOOLCHAIN}: {exc}; '
                                'configure the upgraded toolchain or pass --circt-verilog') from exc
        origin = f'default toolchain {TOOLCHAIN}'
    if executable and (not frontend.is_file() or not os.access(frontend, os.X_OK)):
        raise ContractError(f'CIRCT frontend is missing or not executable: {frontend} ({origin}); '
                            'build/configure the upgraded toolchain or pass --circt-verilog; '
                            'PATH fallback is disabled')
    return frontend


def write_project(spec, base, out, binary=None, frontend=None, results_dir=None):
    # Never overwrite a previous successful model with a partial/failed run.
    frontend = resolve_frontend(spec, frontend, executable=binary is not None)
    out = Path(out).resolve()
    results_dir = generation_results_dir(out, results_dir)
    require_new_directory(out, 'output')
    if results_dir is not None:
        if out == results_dir or out in results_dir.parents or results_dir in out.parents:
            raise ContractError('output and results directories must be separate, non-nested directories')
        require_new_directory(results_dir, 'results')
    out.parent.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix=out.name + '.pending-', dir=out.parent))
    result_stage = None
    results_published = False
    commands = []
    inputs = {}
    try:
        (stage / 'configs').mkdir()
        (stage / 'logs').mkdir()
        (stage / 'ir').mkdir()
        for d in spec['devices']:
            label = d['id']
            catalog, binding, bus = compile_device(spec, d)
            for suffix, data in [('catalog', catalog), ('binding', binding), ('bus', bus)]:
                if data is not None:
                    (stage / f'configs/{label}.{suffix}.json').write_text(canonical(data))
            inp = d['input']
            if 'mlir' in inp:
                ir = str((base / inp['mlir']).resolve())
                inputs[inp['mlir']] = hashlib.sha256(Path(ir).read_bytes()).hexdigest()
            else:
                rtl = inp['rtl']
                ir = f'ir/{label}.mlir'
                cmd = [str(frontend), '--top', rtl['top'], '-ir-llhd']
                for path in rtl.get('include_dirs', []):
                    cmd += ['-I', str((base / path).resolve())]
                for define in rtl.get('defines', []):
                    cmd += ['-D', define]
                for path in rtl['files']:
                    resolved = (base / path).resolve()
                    inputs[path] = hashlib.sha256(resolved.read_bytes()).hexdigest()
                    cmd.append(str(resolved))
                cmd += ['-o', ir]
                commands.append(cmd)
                if binary:
                    run(cmd, stage, stage / f'logs/{label}.frontend.log')
            cmd = [str(binary or 'qemu-passes'), ir, '--all-passes', '--qemu-emit-c', '--no-reports',
                   f'--rtl-adapter={d["rtl_adapter"]}', f'--device-catalog=configs/{label}.catalog.json',
                   f'--backend-binding=configs/{label}.binding.json', f'--qemu-output-dir=models/{label}',
                   '-o', f'ir/{label}.pipeline.mlir']
            if bus is not None:
                cmd.append(f'--binding-path=configs/{label}.bus.json')
            commands.append(cmd)
            if binary:
                run(cmd, stage, stage / f'logs/{label}.generation.log')
                model = stage / 'models' / label / d['top_module']
                for suffix in ('.c', '.h', '_qp_shim.c', '_qp_shim.h'):
                    if not (model / (d['top_module'] + suffix)).is_file():
                        raise ContractError(f'{label}: expected generated file missing: {suffix}')
                if d['backend'] == 'generic-sysbus':
                    shim = (model / (d['top_module'] + '_qp_shim.c')).read_text()
                    if 'hw/opentitan/' in shim or 'IbexIRQ' in shim:
                        raise ContractError(f'{label}: generic wrapper unexpectedly depends on OpenTitan')
        if 'board' in spec:
            board = compile_board(spec)
            (stage / 'configs/board.json').write_text(canonical(board))
            board_module().write_artifacts(board, stage / 'board')
        (stage / 'project.json').write_text(canonical(spec))
        if results_dir is not None:
            results_dir.parent.mkdir(parents=True, exist_ok=True)
            result_stage = Path(tempfile.mkdtemp(prefix=results_dir.name + '.pending-', dir=results_dir.parent))
            for name in ('logs', 'ir'):
                (stage / name).rename(result_stage / name)
            # Commands are replayed from the output directory. IR lives with
            # diagnostics after publication, while configs/models stay here.
            commands = [[str(results_dir / arg) if arg.startswith('ir/') else arg
                         for arg in command] for command in commands]
        (result_stage or stage).joinpath('commands.json').write_text(canonical(commands))
        files = {str(p.relative_to(stage)): hashlib.sha256(p.read_bytes()).hexdigest()
                 for p in sorted(stage.rglob('*')) if p.is_file() and 'logs' not in p.parts}
        lock = {'schema_version': 1, 'project_sha256': hashlib.sha256(canonical(spec).encode()).hexdigest(),
                'input_sha256': inputs, 'artifact_sha256': files,
                'state': 'generated' if binary else 'prepared',
                'tool_sha256': hashlib.sha256(binary.read_bytes()).hexdigest() if binary else None,
                'frontend_path': str(frontend) if frontend else None,
                'frontend_sha256': hashlib.sha256(frontend.read_bytes()).hexdigest() if binary and frontend else None,
                'source_sha256': {s['id']: hashlib.sha256((base / s['path']).read_bytes()).hexdigest()
                                  if (base / s['path']).is_file() else None for s in spec['sources']}}
        if results_dir is not None:
            lock['results_dir'] = os.path.relpath(results_dir, out)
            lock['generation_sha256'] = {
                str(p.relative_to(result_stage)): hashlib.sha256(p.read_bytes()).hexdigest()
                for p in sorted(result_stage.rglob('*')) if p.is_file()}
        (stage / 'manifest.lock.json').write_text(canonical(lock))
        require_new_directory(out, 'output')
        if results_dir is not None:
            require_new_directory(results_dir, 'results')
            result_stage.rename(results_dir)
            results_published = True
        stage.rename(out)
    except Exception:
        if results_published:
            results_dir.rename(result_stage)
        print(f'Incomplete output retained for diagnosis: {stage}', file=sys.stderr)
        if result_stage is not None:
            print(f'Incomplete generation results retained for diagnosis: {result_stage}', file=sys.stderr)
        raise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=['validate', 'prepare', 'generate'])
    parser.add_argument('project', type=Path)
    parser.add_argument('-o', '--output', type=Path)
    parser.add_argument('--results-dir', type=Path,
                        help='generation diagnostics directory (logs, IR, commands); canonical outputs default to results/<project>/<run>/generation')
    parser.add_argument('--qemu-passes', type=Path)
    parser.add_argument('--circt-verilog', type=Path,
                        help='override RTL frontend; default: tools/toolchain.json (circt-aes-new), never PATH; unused for MLIR inputs')
    parser.add_argument('--draft', action='store_true', help='validate draft facts without authorizing generation')
    args = parser.parse_args()
    try:
        if args.draft and args.command != 'validate':
            raise ContractError('--draft is only allowed for validation')
        spec = read_json(args.project)
        base = args.project.resolve().parent
        incomplete = validate(spec, base, args.draft)
        if args.command == 'validate':
            print('DRAFT: unresolved facts: ' + ', '.join(incomplete) if incomplete else 'VALID: input contract and available capabilities checked')
            return
        if not args.output or (args.command == 'generate' and not args.qemu_passes):
            raise ContractError('prepare requires -o; generate also requires --qemu-passes')
        binary = args.qemu_passes.resolve() if args.command == 'generate' else None
        if binary and not binary.is_file():
            raise ContractError(f'generator not found: {binary}')
        write_project(spec, base, args.output.resolve(), binary,
                      args.circt_verilog.resolve() if args.circt_verilog else None,
                      args.results_dir)
        print(f'{args.command.upper()}: {args.output.resolve()}')
    except (ContractError, OSError, ValueError, subprocess.TimeoutExpired) as exc:
        print(f'ERROR: {exc}', file=sys.stderr)
        raise SystemExit(1)


if __name__ == '__main__':
    main()
