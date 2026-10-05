#!/usr/bin/env python3
"""Extract a limited set of SoC facts from simple DTS input.

Emits a soc.digest.json object keyed by node label, with `base` from reg and
`plic` fields derived from numeric interrupt cells (base_src/count).

This standalone regex reader is independent of the archived experiment tools.
It does not implement general device-tree semantics such as address/size cell
decoding, interrupt-parent resolution, or bus address translation. Its output
must be checked against the target hardware description before use; it does
not generate a complete board model or establish support for a target platform.

Usage: python3 tools/board/soc_digest_dts.py <file.dts> [-o OUT] [--intc clic]
"""
import argparse
import json
import os
import re


def parse_dts(txt):
    devices = {}
    # one node: optional `label:` name@addr { body };  (non-nested bodies)
    for m in re.finditer(r'(?:(\w+)\s*:\s*)?[\w,.+-]+@([0-9a-fA-F]+)\s*\{(.*?)\}\s*;', txt, re.S):
        label, addr, body = m.group(1), m.group(2), m.group(3)
        if "reg" not in body and "interrupts" not in body:
            continue
        key = label or ("dev_" + addr.lower())
        d = {"base": "0x" + addr.lower()}
        rm = re.search(r'reg\s*=\s*<([^>]+)>', body)
        if rm:
            cells = re.findall(r'0x[0-9a-fA-F]+|\d+', rm.group(1))
            if cells:
                d["base"] = cells[0] if cells[0].lower().startswith("0x") else hex(int(cells[0]))
        im = re.search(r'interrupts\s*=\s*<([^>]+)>', body)
        if im:
            ids = [int(x, 0) for x in re.findall(r'0x[0-9a-fA-F]+|\d+', im.group(1))]
            if ids:
                d["plic"] = {"base_src": ids[0], "count": len(ids),
                             "contiguous": ids == list(range(ids[0], ids[0] + len(ids))),
                             "signals": [f"{key}_irq{i}" for i in range(len(ids))]}
        devices[key] = d
    return devices


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("dts")
    ap.add_argument("-o", "--out", default=None)
    ap.add_argument("--intc", default="clic")
    a = ap.parse_args()
    devices = parse_dts(open(a.dts).read())
    out = {"$schema_version": 1, "source": os.path.basename(a.dts),
           "intc": a.intc, "devices": devices}
    s = json.dumps(out, indent=2)
    if a.out:
        with open(a.out, "w") as f:
            f.write(s + "\n")
        nplic = sum(1 for d in devices.values() if "plic" in d)
        print(f"[soc-digest-dts] {len(devices)} nodes ({nplic} with interrupts) -> {a.out}")
    else:
        print(s)


if __name__ == "__main__":
    main()
