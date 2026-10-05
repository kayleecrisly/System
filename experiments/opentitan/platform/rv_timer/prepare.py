#!/usr/bin/env python3
"""Stage an isolated QEMU using unmodified generated RV_TIMER model and shim."""
import hashlib
import json
import shutil
import subprocess
from pathlib import Path

PLATFORM = Path(__file__).resolve().parent
SYSTEM = PLATFORM.parents[3]
ENV = Path('/home/kaylee/circt-workspace/environments/opentitan/qemu')
REFERENCE = ENV / 'local-10.2-prototype/source'
QEMU = ENV / 'rv-timer-qp-shim'
SOURCE = QEMU / 'source'
MODEL = SYSTEM / 'outputs/opentitan/batch-fixed-20261005/models/rv_timer/rv_timer'
RESULTS = SYSTEM / 'results/opentitan/rtl-c751059925/rv_timer-baseline/platform'


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    RESULTS.mkdir(parents=True, exist_ok=True)
    if not SOURCE.exists():
        shutil.copytree(REFERENCE, SOURCE, symlinks=True)
    subprocess.run(['python3', str(SYSTEM / 'tools/board/rehost_gen.py'),
                    'generate', str(PLATFORM / 'rv-timer.board.json'),
                    '-o', str(PLATFORM / 'generated')], check=True)
    integration = SOURCE / 'hw/riscv/rv_timer_baseline'
    shutil.copytree(PLATFORM / 'generated', integration, dirs_exist_ok=True)
    # Meson accepts single-quoted path strings; adapt only the staged build file.
    generated_meson = integration / 'meson.build'
    generated_meson.write_text(generated_meson.read_text().replace('"', "'"))
    shutil.copy2(PLATFORM.parent / 'ot_baseline_observer.c', integration)
    installed = {}
    for name, target in {
        'rv_timer.c': SOURCE / 'hw/opentitan/qemu_passes/rv_timer.c',
        'rv_timer.h': SOURCE / 'hw/opentitan/qemu_passes/rv_timer.h',
        'rv_timer_qp_shim.c': SOURCE / 'hw/opentitan/rv_timer_qp_shim.c',
        'rv_timer_qp_shim.h': SOURCE / 'include/hw/opentitan/rv_timer_qp_shim.h',
    }.items():
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(MODEL / name, target)
        assert sha256(target) == sha256(MODEL / name)
        installed[name] = {'source': str(MODEL / name), 'installed': str(target),
                           'sha256': sha256(target)}
    # Change only this new QEMU copy's build selection, not existing sources.
    meson = SOURCE / 'hw/riscv/meson.build'
    text = meson.read_text()
    old = ("riscv_ss.add(files('qp_opentitan_uart_baseline.c', 'ot_baseline_observer.c',\n"
           "                   'ot_uart_core_test.c', '../opentitan/qemu_passes/uart.c'))\n")
    text = text.replace(old, '')
    entry = "subdir('rv_timer_baseline')\n"
    if entry not in text:
        text += '\n' + entry
    meson.write_text(text)
    kconfig = SOURCE / 'hw/riscv/Kconfig'
    text = kconfig.read_text()
    if 'config RISCV\n' not in text:
        text += ('\nconfig RISCV\n'
                 '    bool\n'
                 '    default y if RISCV32 || RISCV64\n')
    entry = 'source rv_timer_baseline/Kconfig\n'
    if entry not in text:
        text += '\n' + entry
    kconfig.write_text(text)
    defaults = SOURCE / 'configs/devices/riscv32-softmmu/default.mak'
    defaults.write_text('CONFIG_RISCV=y\nCONFIG_QP_OPENTITAN_RV_TIMER=y\n')
    (QEMU / 'build-riscv32').mkdir(exist_ok=True)
    (RESULTS / 'build-inputs.json').write_text(json.dumps({
        'qemu_reference': str(REFERENCE), 'qemu_isolated_source': str(SOURCE),
        'model_files': installed,
        'board': {'path': str(PLATFORM / 'rv-timer.board.json'),
                  'sha256': sha256(PLATFORM / 'rv-timer.board.json')},
        'board_generator_sha256': sha256(SYSTEM / 'tools/board/rehost_gen.py'),
        'irq': {'model_output': 0, 'cpu_input': 7, 'plic': False},
        'adapter': 'unmodified generated rv_timer_qp_shim.c',
        'pump_hz': 1000,
        'isolated_build_compatibility': [
            'Define RISCV Kconfig alias from RISCV32/RISCV64 and enable in default.mak',
            'Convert double-quoted source paths to single quotes in staged Meson fragment',
        ],
    }, indent=2) + '\n')
    print(QEMU)


if __name__ == '__main__':
    main()
