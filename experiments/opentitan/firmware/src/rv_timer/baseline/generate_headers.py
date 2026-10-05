#!/usr/bin/env python3
"""Generate this experiment's headers with pinned official tools/templates."""
import argparse
import json
import runpy
import sys
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("source", type=Path)
parser.add_argument("out", type=Path)
args = parser.parse_args()
sys.path.insert(0, str(args.source / "util"))
from reggen.ip_block import IpBlock
from reggen.gen_cheader import gen_cdefines
from make_new_dif.ip import Ip
from mako.template import Template

configs = {
    "rv_timer": "hw/ip/rv_timer/data/rv_timer.hjson",
    "rv_core_ibex": "hw/top_earlgrey/ip_autogen/rv_core_ibex/data/rv_core_ibex.hjson",
    "rv_plic": "hw/top_earlgrey/ip_autogen/rv_plic/data/rv_plic.hjson",
    "sram_ctrl": "hw/ip/sram_ctrl/data/sram_ctrl.hjson",
}
inputs = {args.source / relative for relative in configs.values()}
for name, relative in configs.items():
    cfg = args.source / relative
    target = args.out / "hw/top" / f"{name}_regs.h"
    target.parent.mkdir(parents=True, exist_ok=True)
    with target.open("w") as stream:
        if gen_cdefines(IpBlock.from_path(str(cfg), []), stream,
                        "Apache-2.0", "lowRISC contributors"):
            raise RuntimeError(f"reggen failed: {name}")
    if name not in ("rv_timer", "rv_plic"):
        continue
    ip = Ip(name, name, cfg)
    for suffix in (".h", ".c"):
        template = args.source / "util/make_new_dif/templates" / f"dif_autogen{suffix}.tpl"
        inputs.add(template)
        target = args.out / "sw/device/lib/dif/autogen" / f"dif_{name}_autogen{suffix}"
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(Template(filename=str(template), strict_undefined=True).render(
            ip=ip, autogen_banner="// Generated with pinned official OpenTitan template."))

top = args.source / "hw/top_earlgrey/data/autogen/top_earlgrey.gen.hjson"
inputs.add(top)
dttool = args.source / "util/dttool.py"
inputs.add(dttool)
sys.argv = [str(dttool), "--topgencfg", str(top), "--outdir",
            str(args.out / "hw/top/dt"), "--gen-top", "--gen-ip"]
for relative in configs.values():
    sys.argv.extend(["--ip", str(args.source / relative)])
try:
    runpy.run_path(str(dttool), run_name="__main__")
except SystemExit as exc:
    if exc.code:
        raise
inputs.update((args.source / "util/dtgen").glob("*.tpl"))
for module in tuple(sys.modules.values()):
    filename = getattr(module, "__file__", None)
    if filename:
        path = Path(filename).resolve()
        if path.is_relative_to(args.source.resolve()):
            inputs.add(path)
(args.out / "generator-inputs.json").write_text(
    json.dumps(sorted(map(str, inputs)), indent=2) + "\n")
