#!/usr/bin/env python3
"""Run unchanged official RV_TIMER smoke ELF through its generated QEMU shim."""
import argparse
import hashlib
import json
import os
import re
import struct
import subprocess
import time
from pathlib import Path

PLATFORM = Path(__file__).resolve().parent
SYSTEM = PLATFORM.parents[3]
RESULTS = SYSTEM / 'results/opentitan/rtl-c751059925/rv_timer-baseline/platform/run'
QEMU = Path('/home/kaylee/circt-workspace/environments/opentitan/qemu/'
            'rv-timer-qp-shim/build-riscv32/qemu-system-riscv32')


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


class Elf32:
    def __init__(self, path):
        self.data = path.read_bytes()
        if self.data[:6] != b'\x7fELF\x01\x01':
            raise ValueError('Expected little endian ELF32')
        offset = struct.unpack_from('<I', self.data, 32)[0]
        size, count = struct.unpack_from('<HH', self.data, 46)
        self.sections = [struct.unpack_from('<10I', self.data, offset + i * size)
                         for i in range(count)]

    def read(self, address, size):
        for section in self.sections:
            _, kind, _, base, offset, length, *_ = section
            if kind != 8 and base <= address and address + size <= base + length:
                return self.data[offset + address - base:offset + address - base + size]
        raise ValueError(f'Address 0x{address:x} absent from ELF sections')

    def string(self, address):
        result = bytearray()
        for i in range(2048):
            value = self.read(address + i, 1)
            if value == b'\0':
                return result.decode(errors='replace')
            result.extend(value)
        raise ValueError('Unterminated ELF string')


def decode_logs(elf_path, words):
    elf, output, index = Elf32(elf_path), [], 0
    while index < len(words):
        pointer = words[index]
        index += 1
        try:
            severity, filename, line, nargs, fmt = struct.unpack('<5I', elf.read(pointer, 20))
            if nargs > 64 or index + nargs > len(words):
                raise ValueError(f'Incomplete log arguments ({nargs})')
            args = words[index:index + nargs]
            index += nargs
            output.append({'metadata_address': hex(pointer), 'severity': severity,
                           'file': elf.string(filename), 'line': line,
                           'format': elf.string(fmt), 'arguments': args})
        except (ValueError, struct.error) as exc:
            output.append({'word': hex(pointer), 'decode_error': str(exc)})
    return output


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--elf', type=Path, default=SYSTEM / 'experiments/opentitan/'
                        'firmware/build/rv_timer-baseline/rv_timer_smoketest.elf')
    parser.add_argument('--timeout', type=float, default=20)
    args = parser.parse_args()
    elf = args.elf.resolve(strict=True)
    RESULTS.mkdir(parents=True, exist_ok=True)
    command = [str(QEMU), '-machine', 'qp-opentitan-rv-timer', '-kernel', str(elf),
               '-display', 'none', '-serial', 'none', '-monitor', 'none',
               '-no-reboot', '-d', 'guest_errors,unimp,int,in_asm',
               '-D', str(RESULTS / 'guest.log'),
               '-trace', 'enable=memory_region_ops_read',
               '-trace', 'enable=memory_region_ops_write']
    environment = os.environ.copy()
    environment['QP_COV'] = str(RESULTS / 'register-coverage.log')
    # Generated QP_COV opens append mode. Each invocation represents one run.
    (RESULTS / 'register-coverage.log').write_text('')
    timed_out = False
    started = time.monotonic()
    with (RESULTS / 'stdout.log').open('wb') as stdout, \
            (RESULTS / 'observation.log').open('wb') as stderr:
        try:
            process = subprocess.run(command, env=environment, stdout=stdout,
                                     stderr=stderr, timeout=args.timeout, check=False)
            return_code = process.returncode
        except subprocess.TimeoutExpired:
            timed_out, return_code = True, None
    elapsed = time.monotonic() - started
    observation = (RESULTS / 'observation.log').read_text(errors='replace')
    guest = (RESULTS / 'guest.log').read_text(errors='replace')
    statuses = [int(value, 16) for value in re.findall(
        r'OT_TEST_STATUS value=(0x[0-9a-f]+)', observation)]
    words = [int(value, 16) for value in re.findall(
        r'OT_DV_LOG_WORD value=(0x[0-9a-f]+)', observation)]
    logs = decode_logs(elf, words)
    passed = return_code == 0 and not timed_out and statuses and statuses[-1] == 0x900d
    mmio = []
    for line in (observation + '\n' + guest).splitlines():
        match = re.search(r'memory_region_ops_(read|write).*addr (0x[0-9a-f]+) '
                          r'value (0x[0-9a-f]+) size (\d+) name \'ot-rv-timer-qp\'', line)
        if match:
            operation, offset, value, size = match.groups()
            mmio.append({'operation': operation, 'address': offset,
                         'offset': hex(int(offset, 16) - 0x40100000),
                         'value': value, 'size': int(size)})
    report = {
        'result': 'passed' if passed else 'timeout' if timed_out else 'failed',
        'command': command, 'return_code': return_code, 'timed_out': timed_out,
        'elapsed_host_seconds': elapsed,
        'elf': {'path': str(elf), 'sha256': sha256(elf)},
        'qemu': {'path': str(QEMU), 'sha256': sha256(QEMU)},
        'adapter': 'unmodified generated rv_timer_qp_shim.c',
        'status_writes': [hex(value) for value in statuses],
        'official_firmware_logs': logs,
        'cpu_interrupt_log': [line for line in guest.splitlines()
                              if 'riscv_cpu_do_interrupt' in line],
        'timer_mmio': mmio,
        'settle_warning_count': sum('settle' in line and 'budget' in line
                                    for line in guest.splitlines()),
        'clock_mapping_verified': False,
        'raw_clock_pump_hz': 1000,
        'note': 'A functional pass does not establish the physical timer frequency.',
    }
    (RESULTS / 'run.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'result': report['result'], 'elapsed_host_seconds': elapsed,
                      'report': str(RESULTS / 'run.json')}))
    return 0 if passed else 1


if __name__ == '__main__':
    raise SystemExit(main())
