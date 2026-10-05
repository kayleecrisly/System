#!/usr/bin/env python3
"""Record actual build inputs and verify each official input against the commit."""
import hashlib
import json
from pathlib import Path
import shlex
import subprocess
import sys

source, build, toolchain = map(Path, sys.argv[1:4])
commit = "c7510599254dcbaa6153468e696aa11299cb5b5f"
inputs = set()
for dep in (build / "objects").glob("*.d"):
    text = dep.read_text().replace("\\\n", " ")
    inputs.update(Path(item).resolve() for item in shlex.split(text.split(":", 1)[1]))
inputs.update([
    source / "sw/device/tests/uart_smoketest.c",
    source / "hw/ip/uart/data/uart.hjson",
    source / "hw/top_earlgrey/ip_autogen/rv_core_ibex/data/rv_core_ibex.hjson",
    source / "util/make_new_dif/templates/dif_autogen.h.tpl",
    source / "util/make_new_dif/templates/dif_autogen.c.tpl",
])
inputs.update(Path(item) for item in json.loads((build / "generated/generator-inputs.json").read_text()))
experiment = Path(__file__).resolve().parent
inputs.update([experiment / "build-uart-baseline", experiment / "generate_headers.py",
               experiment / "record_build.py", experiment / "src/uart/baseline/link.ld",
               experiment / "src/uart/baseline/source.json"])
official = []
private = []
for path in sorted(inputs):
    raw = path.read_bytes()
    sha = hashlib.sha256(raw).hexdigest()
    try:
        relative = path.relative_to(source)
    except ValueError:
        private.append({"path": str(path), "sha256": sha})
        continue
    pinned = subprocess.check_output(["git", "-C", str(source), "show", f"{commit}:{relative}"])
    if raw != pinned:
        raise RuntimeError(f"Official input differs from pinned commit: {relative}")
    official.append({"path": str(relative), "sha256": sha, "matches_commit": True})

compiler = toolchain / "bin/riscv32-unknown-elf-clang"
elf = build / "uart_smoketest.elf"
elf_sha256 = hashlib.sha256(elf.read_bytes()).hexdigest()
run_path = Path(sys.argv[4]) if len(sys.argv) > 4 else None
if run_path:
    run = json.loads(run_path.read_text())
    if run["elf"]["sha256"] != elf_sha256 or run["result"] != "passed":
        raise RuntimeError("Runtime result does not verify this compiled ELF")
result = {
    "status": "compiled",
    "runtime_verified": run_path is not None,
    "runtime_result": str(run_path) if run_path else None,
    "source_commit": commit,
    "compiler_version": subprocess.check_output([str(compiler), "--version"], text=True),
    "compiler_sha256": hashlib.sha256(compiler.read_bytes()).hexdigest(),
    "architecture": "rv32imc",
    "abi": "ilp32",
    "elf": str(elf),
    "elf_sha256": elf_sha256,
    "elf_metadata": subprocess.check_output(["readelf", "-h", "-l", str(elf)], text=True),
    "official_inputs": official,
    "experiment_or_generated_inputs": private,
    "simplifications": ["Direct ELF entry", "Minimal _ottf_main", "No full security boot or FreeRTOS/OTTF runtime"],
    "preserved": ["Official test source", "UART DIF", "CHECK macros", "SimDV device constants", "ottf_start.S and crt.S"],
}
(build / "build.json").write_text(json.dumps(result, indent=2) + "\n")
