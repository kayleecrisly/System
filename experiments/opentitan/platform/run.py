#!/usr/bin/env python3
"""Run the official UART baseline using the generated core and DV status."""
import argparse
import hashlib
import json
import re
import subprocess
import tempfile
from pathlib import Path


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("elf", type=Path)
    parser.add_argument("--timeout", type=float, default=20)
    parser.add_argument("--qemu", type=Path, default=Path(
        "/home/kaylee/circt-workspace/environments/opentitan/qemu/"
        "local-10.2-prototype/build-riscv32/qemu-system-riscv32"))
    args = parser.parse_args()
    system = Path(__file__).resolve().parents[3]
    results_root = system / "results/opentitan/rtl-c751059925/uart-baseline"
    results_root.mkdir(parents=True, exist_ok=True)
    result_dir = Path(tempfile.mkdtemp(prefix="run-native-core-", dir=results_root))
    elf, qemu = args.elf.resolve(strict=True), args.qemu.resolve(strict=True)
    command = [str(qemu), "-machine", "qp-opentitan-uart-baseline",
               "-kernel", str(elf), "-display", "none", "-serial", "none",
               "-monitor", "none", "-no-reboot", "-d", "guest_errors,unimp",
               "-D", str(result_dir / "guest.log")]
    timed_out = False
    with (result_dir / "stdout.log").open("wb") as stdout, \
            (result_dir / "observation.log").open("wb") as stderr:
        try:
            process = subprocess.run(command, stdout=stdout, stderr=stderr,
                                     timeout=args.timeout, check=False)
            return_code = process.returncode
        except subprocess.TimeoutExpired:
            timed_out, return_code = True, None
    observation = (result_dir / "observation.log").read_text(errors="replace")
    statuses = [int(value, 16) for value in re.findall(
        r"OT_TEST_STATUS value=(0x[0-9a-f]+)", observation)]
    passed = (return_code == 0 and not timed_out and statuses
              and (statuses[-1] & 0xffff) == 0x900d)
    report = {
        "command": command,
        "elf": {"path": str(elf), "sha256": sha256(elf)},
        "qemu": {"path": str(qemu), "sha256": sha256(qemu)},
        "generated_core_sha256": sha256(system / "outputs/opentitan/"
            "rtl-c751059925/models/uart/uart/uart.c"),
        "board_spec_sha256": sha256(Path(__file__).with_name(
            "uart-baseline.board.json")),
        "board_generator_sha256": sha256(system / "tools/board/rehost_gen.py"),
        "uart_wrapper_sha256": sha256(Path(__file__).with_name(
            "ot_uart_core_test.c")),
        "uart_tx_writes": [int(value, 16) for value in re.findall(
            r"OT_UART_WRITE offset=0x1c size=4 value=(0x[0-9a-f]+)", observation)],
        "uart_rx_reads": [int(value, 16) for value in re.findall(
            r"OT_UART_READ offset=0x18 size=4 value=(0x[0-9a-f]+)", observation)],
        "return_code": return_code,
        "timed_out": timed_out,
        "test_status_writes": [hex(value) for value in statuses],
        "result": "passed" if passed else "incomplete" if timed_out else "failed",
        "uart_backend": "RTL-generated core with experiment-private MMIO delegation",
        "byte_backend_used": False,
        "boot": "ELF entry with official startup; secure ROM boot omitted",
        "clock_progress": "Generated bus transaction and bounded settle clocks",
        "cycle_accuracy_validated": False,
        "clock_driven_by_virtual_time": False,
        "plic_interrupt_delivery_tested": False,
    }
    (result_dir / "run.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({"result": report["result"], "results": str(result_dir)},
                     ensure_ascii=False))
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
