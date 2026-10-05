#!/usr/bin/env python3
"""One fixed, hardware-parameter-preserving generation attempt per catalog IP."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import time

import hjson

WORKSPACE = Path(__file__).resolve().parents[4]
SYSTEM = WORKSPACE / "System"
SOURCE = WORKSPACE / "opentitan"
BATCH = "batch-fixed-20261005"
RESULTS = SYSTEM / "results/opentitan" / BATCH / "generation"
OUTPUT = SYSTEM / "outputs/opentitan" / BATCH / "models"
SNAPSHOT = Path("/home/kaylee/circt-workspace/environments/opentitan") / BATCH / "rtl"
FRONTEND = Path("/home/kaylee/circt-workspace/circt-aes-new/build/Release/bin/circt-verilog")
PASSES = SYSTEM / "tools/build/qemu-passes"
CATALOG = SYSTEM / "projects/opentitan/catalogs/opentitan.json"
COMMIT = "c7510599254dcbaa6153468e696aa11299cb5b5f"
ORDER = ["hmac", "gpio", "pinmux", "rv_timer", "aon_timer", "rv_plic",
         "spi_host", "spi_device", "i2c", "pwm", "pattgen", "adc_ctrl",
         "sysrst_ctrl", "alert_handler", "dma", "rom_ctrl", "kmac", "aes", "uart"]
ADDITIONAL_SOURCES = {
    # The existing filelist omits the instantiated USB wake detector. These
    # files are unmodified dependencies from the same official source commit.
    "pinmux": ["hw/ip/usbdev/rtl/usbdev_pkg.sv", "hw/ip/usbdev/rtl/usbdev_aon_wake.sv"],
}
KMAC_APP_CFG = "'{kmac_pkg::AppCfgKeyMgr, kmac_pkg::AppCfgLcCtrl, kmac_pkg::AppCfgRomCtrl}"


def digest(path):
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def pinned(path):
    return subprocess.check_output(["git", "-C", str(SOURCE), "show", f"{COMMIT}:{path}"])


def run(command, log, timeout):
    begin = time.monotonic()
    with log.open("wb") as out:
        try:
            process = subprocess.run(command, stdout=out, stderr=subprocess.STDOUT,
                                     timeout=timeout, check=False)
            code, timed_out = process.returncode, False
        except subprocess.TimeoutExpired:
            code, timed_out = None, True
    return {"command": command, "exit_code": code, "timed_out": timed_out,
            "seconds": round(time.monotonic() - begin, 3), "log": str(log),
            "status": "timeout" if timed_out else "passed" if code == 0 else "failed"}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--only", nargs="+", choices=ORDER)
    args = parser.parse_args()
    selected = args.only or ORDER
    assert subprocess.check_output(["git", "-C", str(SOURCE), "rev-parse", "HEAD"], text=True).strip() == COMMIT
    for folder in (RESULTS, OUTPUT, SNAPSHOT):
        folder.mkdir(parents=True, exist_ok=True)
    devices = json.loads(CATALOG.read_text())["devices"]
    assert {d["module"] for d in devices} == set(ORDER)
    filelists = {}
    all_files = set()
    for ip in ORDER:
        filelist = SOURCE / f"mlir_output/{ip}/filelist_{ip}.f"
        files = [line.removeprefix("./opentitan/") for line in filelist.read_text().splitlines()
                 if line.startswith("./opentitan/")]
        files += [path for path in ADDITIONAL_SOURCES.get(ip, []) if path not in files]
        filelists[ip] = files
        all_files.update(files)
    tracked = subprocess.check_output(["git", "-C", str(SOURCE), "ls-files", "hw"], text=True).splitlines()
    headers = [path for path in tracked if path.endswith(".svh")]
    metadata = ["hw/top_earlgrey/data/top_earlgrey.hjson",
                "hw/top_earlgrey/data/autogen/top_earlgrey.gen.hjson",
                "hw/top_earlgrey/rtl/autogen/top_earlgrey.sv"]
    all_files.update(headers + metadata)
    with subprocess.Popen(["git", "-C", str(SOURCE), "archive", COMMIT, *sorted(all_files)],
                          stdout=subprocess.PIPE) as archive:
        extraction = subprocess.run(["tar", "-x", "-C", str(SNAPSHOT)], stdin=archive.stdout, check=False)
        archive.stdout.close()
        assert extraction.returncode == 0 and archive.wait() == 0
    top = hjson.loads(pinned(metadata[1]).decode())
    top_rtl = pinned(metadata[2]).decode()
    provenance = {str(path): digest(path) for path in (FRONTEND, PASSES, CATALOG)}
    protected = [path for root in (SYSTEM / "tools/lib", SYSTEM / "tools/include", SYSTEM / "tools/board")
                 for path in root.rglob("*") if path.is_file() and path.suffix in (".cpp", ".h", ".py")]
    protected += [SYSTEM / "README.md", SYSTEM / "experiments/README.md", SYSTEM / "experiments/opentitan/README.md"]
    before = {str(path): digest(path) for path in protected}
    protected_before = RESULTS / "protected-before.json"
    if protected_before.exists():
        assert before == json.loads(protected_before.read_text()), "Protected inputs changed since initial attempt"
    else:
        protected_before.write_text(json.dumps(before, indent=2) + "\n")
    (RESULTS / "rtl-inputs.json").write_text(json.dumps(
        {path: digest(SNAPSHOT / path) for path in sorted(all_files)}, indent=2) + "\n")
    index_file = RESULTS / "results.json"
    prior_rows = {row["ip"]: row for row in json.loads(index_file.read_text())} if index_file.exists() else {}
    for ip in selected:
        folder = RESULTS / ip
        previous_attempts = []
        if (folder / "result.json").exists():
            attempt = 1
            while (RESULTS / f"{ip}-attempt-{attempt}").exists():
                attempt += 1
            archived = RESULTS / f"{ip}-attempt-{attempt}"
            folder.rename(archived)
            previous_attempts = prior_rows.get(ip, {}).get("previous_attempts", []) + [{
                "result": str(archived / "result.json"),
                "artifacts": str(archived),
                "original_artifact_location": str(folder),
            }]
        folder.mkdir(exist_ok=True)
        module = next((m for m in top["module"] if m["type"] == ip), None)
        params = {p["name"]: str(p["default"]) for p in module.get("param_list", [])
                  if "default" in p} if module else {}
        # Use hardware configuration already resolved by the official top generator.
        # Security/masking flags are retained; there are no experimental -G overrides.
        if ip == "aes":
            assert params["SecMasking"] == "1"
        if ip == "kmac":
            assert params["EnMasking"] == "1"
            assert params["AppCfg"] == KMAC_APP_CFG
            assert "'{AppCfgKeyMgr, AppCfgLcCtrl, AppCfgRomCtrl}" in (SNAPSHOT / "hw/ip/kmac/rtl/kmac.sv").read_text()
        binding_source = SYSTEM / f"projects/opentitan/bindings/{ip}.binding.json"
        binding = json.loads(binding_source.read_text()) if binding_source.exists() else {"$schema_version": 1, "design": {"top_module": ip}}
        binding.pop("_doc", None)
        removed_ties = {}
        if ip in ("aes", "kmac"):
            for name in list(binding.get("input_ties", {})):
                if "edn" in name or "entropy" in name:
                    removed_ties[name] = binding["input_ties"].pop(name)
        binding_file = folder / "binding.json"
        binding_file.write_text(json.dumps(binding, indent=2) + "\n")
        row = {"ip": ip, "source_commit": COMMIT, "top_instance": module["name"] if module else None,
               "parameters": params, "parameter_source": metadata[1],
               "parameter_scope": "Official generated top param_list; other IP parameters retain RTL defaults",
               "binding_original_sha256": digest(binding_source) if binding_source.exists() else None,
               "binding_sha256": digest(binding_file), "removed_constant_edn_responses": removed_ties,
               "filelist_sha256": digest(SOURCE / f"mlir_output/{ip}/filelist_{ip}.f"),
               "tool_hashes": provenance,
               "additional_unmodified_official_sources": ADDITIONAL_SOURCES.get(ip, []),
               "rtl_default_parameters_without_redundant_cli_override": {"AppCfg": params["AppCfg"]} if ip == "kmac" else {},
               "previous_attempts": previous_attempts}
        existing = OUTPUT / ip / ip / f"{ip}.c"
        if ip == "uart" and existing.exists():
            row["generation"] = {"status": "reused", "reason": "Unmodified previously verified UART core", "sha256": digest(existing)}
        else:
            command = [str(FRONTEND), "--single-unit", "--top", ip, "-ir-llhd", "-D", "SYNTHESIS=1"]
            for include in ("hw/ip/prim/rtl", "hw/ip/prim_generic/rtl", "hw/ip/tlul/rtl", "hw/top_earlgrey/rtl"):
                command += ["-I", str(SNAPSHOT / include)]
            for name, value in params.items():
                if ip == "kmac" and name == "AppCfg":
                    # The CLI cannot parse aggregate literals. The imported
                    # RTL default is exactly the official top's configuration.
                    continue
                command += ["-G", f"{name}={value}"]
            command += [str(SNAPSHOT / path) for path in filelists[ip]]
            command += ["-o", str(folder / "frontend.mlir")]
            row["frontend"] = run(command, folder / "frontend.log", 180)
            if row["frontend"]["status"] == "passed":
                command = [str(PASSES), str(folder / "frontend.mlir"), "--all-passes", "--qemu-emit-c", "--no-reports",
                           "--rtl-adapter=opentitan", f"--device-catalog={CATALOG}",
                           f"--backend-binding={binding_file}", f"--qemu-output-dir={OUTPUT / ip}",
                           "-o", str(folder / "pipeline.mlir")]
                row["pipeline"] = run(command, folder / "pipeline.log", 240)
                row["generation"] = {"status": row["pipeline"]["status"]}
                if row["pipeline"]["status"] == "passed" and existing.exists():
                    row["generation"]["sha256"] = digest(existing)
                elif row["pipeline"]["status"] == "passed":
                    row["generation"] = {"status": "failed", "reason": "No expected C core output"}
            else:
                row["generation"] = {"status": row["frontend"]["status"], "reason": "RTL frontend did not produce usable IR"}
        (folder / "result.json").write_text(json.dumps(row, indent=2) + "\n")
        prior_rows[ip] = row
        index_file.write_text(json.dumps([prior_rows[name] for name in ORDER if name in prior_rows], indent=2) + "\n")
        print(f"{ip}: {row['generation']['status']}", flush=True)
        # Compress completed intermediates losslessly to keep the batch bounded on disk.
        for artifact in (folder / "frontend.mlir", folder / "pipeline.mlir"):
            if artifact.exists():
                subprocess.run(["gzip", "-f", str(artifact)], check=True)
    after = {str(path): digest(path) for path in protected}
    (RESULTS / "protected-after.json").write_text(json.dumps(after, indent=2) + "\n")
    assert after == before, "Protected generator or existing Markdown changed during batch"


if __name__ == "__main__":
    main()
