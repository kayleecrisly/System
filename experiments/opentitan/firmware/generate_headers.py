#!/usr/bin/env python3
"""Use this pinned source tree's official register/DIF generators."""
import argparse
import json
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

for name, relative in [
    ("uart", "hw/ip/uart/data/uart.hjson"),
    ("rv_core_ibex", "hw/top_earlgrey/ip_autogen/rv_core_ibex/data/rv_core_ibex.hjson"),
]:
    cfg = args.source / relative
    dst = args.out / "hw/top" / (name + "_regs.h")
    dst.parent.mkdir(parents=True, exist_ok=True)
    with dst.open("w") as out:
        result = gen_cdefines(IpBlock.from_path(str(cfg), []), out,
                              "Apache-2.0", "lowRISC contributors")
        if result:
            raise RuntimeError(f"register generator returned {result}")

ip = Ip("uart", "UART", args.source / "hw/ip/uart/data/uart.hjson")
for suffix in [".h", ".c"]:
    template = args.source / "util/make_new_dif/templates" / ("dif_autogen" + suffix + ".tpl")
    dst = args.out / "sw/device/lib/dif/autogen" / ("dif_uart_autogen" + suffix)
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(Template(filename=str(template), strict_undefined=True).render(
        ip=ip, autogen_banner="// Generated from the pinned official UART template."))

module_inputs = []
for module in list(sys.modules.values()):
    filename = getattr(module, "__file__", None)
    if filename:
        path = Path(filename).resolve()
        if path.is_relative_to(args.source.resolve()):
            module_inputs.append(str(path))
(args.out / "generator-inputs.json").write_text(json.dumps(sorted(set(module_inputs)), indent=2) + "\n")
