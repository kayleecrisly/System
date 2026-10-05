#!/usr/bin/env python3
"""Verify official build inputs and record the actual RV_TIMER ELF."""
import hashlib
import importlib.metadata
import json
from pathlib import Path
import shlex
import subprocess
import sys

source, build, toolchain, results = map(Path, sys.argv[1:5])
commit = "c7510599254dcbaa6153468e696aa11299cb5b5f"
private_src = Path(__file__).resolve().parent
experiment = private_src.parents[2]
sha = lambda data: hashlib.sha256(data).hexdigest()
test_relative = "sw/device/tests/rv_timer_smoketest.c"
test_original = subprocess.check_output(["git", "-C", str(source), "show", f"{commit}:{test_relative}"])
test_copy = private_src / "official/rv_timer_smoketest.c"
assert test_copy.read_bytes() == test_original
provenance = {
    "repository": "https://github.com/lowRISC/opentitan",
    "commit": commit,
    "official_path": test_relative,
    "copied_path": "official/rv_timer_smoketest.c",
    "sha256": sha(test_original),
    "matches_commit": True,
    "test_changes": [],
    "harness": "Direct ELF _ottf_main, official startup and ISR assembly/C, official logging/status; no FreeRTOS or secure boot",
}
(private_src / "source.json").write_text(json.dumps(provenance, indent=2) + "\n")
inputs = set()
for dep in (build / "objects").glob("*.d"):
    text = dep.read_text().replace("\\\n", " ")
    inputs.update(Path(item).resolve() for item in shlex.split(text.split(":", 1)[1]))
inputs.update(Path(item) for item in json.loads((build / "generated/generator-inputs.json").read_text()))
inputs.update([source / test_relative, experiment / "build-rv-timer-baseline",
               private_src / "generate_headers.py", private_src / "record_build.py",
               private_src / "link.ld", private_src / "source.json",
               private_src / "python-requirements.txt"])
official = []
generated_or_private = []
for path in sorted(inputs):
    raw = path.read_bytes()
    digest = sha(raw)
    if not path.is_relative_to(source):
        generated_or_private.append({"path": str(path), "sha256": digest})
        continue
    relative = path.relative_to(source)
    expected = subprocess.check_output(["git", "-C", str(source), "show", f"{commit}:{relative}"])
    if raw != expected:
        raise RuntimeError(f"Official source differs from commit: {relative}")
    official.append({"path": str(relative), "sha256": digest, "matches_commit": True})
elf = build / "rv_timer_smoketest.elf"
compiler = toolchain / "bin/riscv32-unknown-elf-clang"
symbols = subprocess.check_output([str(toolchain / "bin/riscv32-unknown-elf-nm"), "-n", str(elf)], text=True)
required = ["_ottf_interrupt_vector", "handler_irq_timer", "ottf_timer_isr", "ottf_isr_exit", "pxCurrentTCB", "kOttfTestConfig"]
symbol_evidence = {}
for symbol in required:
    matches = [line for line in symbols.splitlines() if line.endswith(" " + symbol)]
    if len(matches) != 1:
        raise RuntimeError(f"Required official ISR symbol missing/ambiguous: {symbol}")
    symbol_evidence[symbol] = matches[0]
disassembly = (build / "rv_timer_smoketest.dis").read_text()
assert "mret" in disassembly
result = {
    "status": "compiled",
    "runtime_verified": False,
    "source_commit": commit,
    "compiler_version": subprocess.check_output([str(compiler), "--version"], text=True),
    "compiler_sha256": sha(compiler.read_bytes()),
    "elf": str(elf),
    "elf_sha256": sha(elf.read_bytes()),
    "official_test": provenance,
    "architecture": "rv32imc",
    "abi": "ilp32",
    "clock_source": "Official top_earlgrey/sw/dt/sim_dv.c; RV_TIMER clock io_div4 = 24000000 Hz",
    "required_isr_symbols": symbol_evidence,
    "mret_present": True,
    "additional_python_dependencies": {
        requirement.split("==")[0]: importlib.metadata.version(requirement.split("==")[0])
        for requirement in (private_src / "python-requirements.txt").read_text().splitlines()
        if requirement and not requirement.startswith("#")
    },
    "official_inputs": official,
    "experiment_or_generated_inputs": generated_or_private,
    "simplifications": ["Direct ELF entry", "Minimal _ottf_main", "No full secure boot or FreeRTOS runtime", "base_printf diagnostic stdout discards text; official DV LOG messages preserved"],
}
(build / "build.json").write_text(json.dumps(result, indent=2) + "\n")
(results / "build.json").write_text(json.dumps(result, indent=2) + "\n")
(results / "symbols.txt").write_text(symbols)
