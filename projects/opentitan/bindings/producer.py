#!/usr/bin/env python3
"""Backend-role binding producer with a pluggable MODEL interface.

The producer turns an IR digest + backend-binding.txt into a binding JSON. The model that
does the recognition sits behind ONE small interface so swapping provider/model
is a single flag and nothing else changes:

    class ModelBackend:
        def complete(self, system: str, user: str) -> str   # the only contract

Built-in backends (register a new provider by subclassing + adding to BACKENDS):
  - 'anthropic'  Claude   (ANTHROPIC_API_KEY)  default model claude-haiku-4-5
  - 'openai'     GPT      (OPENAI_API_KEY)      default model gpt-4.1-mini
  - 'stub'       offline: echoes the committed bindings/<dev>.binding.json
                 (no network/key — for CI / smoke runs)

CLI — produce a candidate binding into bindings/<dev>.binding.json, or use
--out to keep the candidate separate from the maintained project inputs:

    export ANTHROPIC_API_KEY=sk-ant-...
    python3 projects/opentitan/bindings/producer.py uart                                 # anthropic / claude-haiku-4-5
    python3 projects/opentitan/bindings/producer.py uart --backend openai --model gpt-4.1-mini
    python3 projects/opentitan/bindings/producer.py gpio --out bindings/gpio.ai.json
    PRODUCER_BACKEND=stub python3 projects/opentitan/bindings/producer.py uart           # offline

The output is a candidate, not a validated hardware description. Validate it
with the generator's --backend-binding option against the corresponding IR
before adopting it; generation checks alone do not establish behavioral fidelity.

NOTE: a networked backend sends the digest to a third-party API; running this
from inside Claude Code is blocked as data-exfiltration — run it in your shell.
Stdlib only (urllib).
"""
import argparse
import json
import os
import re
import sys
import urllib.request

HOST = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # projects/opentitan


def read(p):
    with open(p) as f:
        return f.read()


def _require(env):
    v = os.environ.get(env)
    if not v:
        sys.exit(f"ERROR: this backend needs {env} in the environment.")
    return v


# ---------------------------------------------------------------------------
# MODEL INTERFACE — a backend only has to turn (system, user) into text.
# ---------------------------------------------------------------------------
class ModelBackend:
    name = "base"
    DEFAULT_MODEL = None

    def __init__(self, model=None):
        self.model = model or self.DEFAULT_MODEL

    def complete(self, system: str, user: str) -> str:
        raise NotImplementedError


class AnthropicBackend(ModelBackend):
    name = "anthropic"
    DEFAULT_MODEL = "claude-haiku-4-5"

    def complete(self, system, user):
        key = _require("ANTHROPIC_API_KEY")
        body = json.dumps({
            "model": self.model, "max_tokens": 2000, "system": system,
            "messages": [{"role": "user", "content": user}],
        }).encode()
        req = urllib.request.Request(
            "https://api.anthropic.com/v1/messages", data=body,
            headers={"x-api-key": key, "anthropic-version": "2023-06-01",
                     "content-type": "application/json"})
        with urllib.request.urlopen(req, timeout=120) as r:
            resp = json.load(r)
        return "".join(b.get("text", "") for b in resp.get("content", [])
                       if b.get("type") == "text")


class OpenAIBackend(ModelBackend):
    name = "openai"
    DEFAULT_MODEL = "gpt-4.1-mini"

    def complete(self, system, user):
        key = _require("OPENAI_API_KEY")
        body = json.dumps({
            "model": self.model,
            "messages": [{"role": "system", "content": system},
                         {"role": "user", "content": user}],
            "response_format": {"type": "json_object"},
        }).encode()
        req = urllib.request.Request(
            "https://api.openai.com/v1/chat/completions", data=body,
            headers={"Authorization": f"Bearer {key}", "Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=120) as r:
            resp = json.load(r)
        return resp["choices"][0]["message"]["content"]


class StubBackend(ModelBackend):
    """Offline: return the committed bindings/<dev>.binding.json. Lets the whole
    pipeline run with no network/key (CI, smoke). Recovers <dev> from the prompt."""
    name = "stub"
    DEFAULT_MODEL = "committed"

    def complete(self, system, user):
        m = re.search(r'device "([^"]+)"', user)
        dev = m.group(1) if m else "uart"
        return read(os.path.join(HOST, "bindings", f"{dev}.binding.json"))


BACKENDS = {b.name: b for b in (AnthropicBackend, OpenAIBackend, StubBackend)}


def make_backend(name, model=None):
    if name not in BACKENDS:
        sys.exit(f"unknown backend {name!r}; choices: {', '.join(BACKENDS)}")
    return BACKENDS[name](model)


# ---------------------------------------------------------------------------
# Prompt + extraction used by the producer CLI.
# ---------------------------------------------------------------------------
SYSTEM = (
    "You are the PRODUCER in an AI-fillable hardware-recognition pipeline. You read a "
    "STRUCTURAL IR digest of a hardware peripheral plus a schema contract and emit a "
    "'backend role binding' JSON. Derive everything PURELY from the digest + schema. "
    "Respond with ONE JSON object (the binding) and nothing else — no prose, no fences."
)


def build_prompt(dev):
    digest = read(os.environ.get("DIGEST") or os.path.join(HOST, "bindings", f"{dev}.digest.json"))
    schema = read(os.path.join(HOST, "..", "..", "tools", "schemas", "backend-binding.txt"))
    return f"""Emit the backend role binding for device "{dev}", conforming to the schema below.

Role-mapping rules (apply to the digest's own evidence):
- TX fifo = the prim_fifo_sync whose wvalid_source contains ".qe" (a register write strobe);
  trigger_offset = that write register's offset from addr_decode.
- RX fifo = the prim_fifo_sync whose wvalid_source traces to a top-level serial input
  (cio_*_i / rx_valid); pop_offset = the read-data register's offset that drains it.
- If the digest contains an "irq_suggestion" object, COPY its intr_state_offset /
  intr_enable_offset / alert_test_offset / irq_count VERBATIM into the binding's irq block.
  Otherwise derive irq offsets from addr_decode (register name STARTS WITH intr_state /
  intr_enable / alert_test — NOT intr_test) and irq_count from the intr_*_o ports.
- If fifo_instances is empty, OMIT the chardev block entirely.
- clocks: look at the digest's "clock_roots" table. The root with "primary": true is the
  bus clock — never declare it. For every OTHER root decide from the port's ROLE: a
  serial/bus clock or chip-select that arrives from a PAD (SPI sck / csb, I2C scl used as
  a clock) is "event" (its edges carry data or mark an event); a free-running clock from
  the clock manager (clk_aon_i, clk_core_i, clk_*_i in general) is "beat" (or just omit
  it); DFT inputs (scan_clk_i, mbist_en_i) are noise from scan muxes — omit them.
  If no non-primary root needs "event", OMIT the clocks block.

Output ONLY the binding JSON (include "$schema_version":1 and design.top_module).

=== {dev}.digest.json ===
{digest}

=== backend-binding.txt ===
{schema}
"""


def extract_binding(text):
    """Lenient: strip ``` fences, take the outermost {...}, parse."""
    t = re.sub(r"^```(?:json)?\s*|\s*```$", "", text.strip(), flags=re.MULTILINE).strip()
    s, e = t.find("{"), t.rfind("}")
    if s < 0 or e < 0:
        raise ValueError(f"no JSON object in model output: {text[:200]!r}")
    return json.loads(t[s:e + 1])


def produce(dev, backend, out=None):
    """Run the backend and write bindings/<dev>.binding.json. Returns (path, obj)."""
    out = out or os.path.join(HOST, "bindings", f"{dev}.binding.json")
    binding = extract_binding(backend.complete(SYSTEM, build_prompt(dev)))
    with open(out, "w") as f:
        json.dump(binding, f, indent=2)
        f.write("\n")
    return out, binding


def main():
    ap = argparse.ArgumentParser(description="Produce a backend role binding via a model backend.")
    ap.add_argument("device", nargs="?", default="uart")
    ap.add_argument("--backend", default=os.environ.get("PRODUCER_BACKEND", "anthropic"),
                    choices=list(BACKENDS))
    ap.add_argument("--model", default=os.environ.get("PRODUCER_MODEL"))
    ap.add_argument("--out", default=os.environ.get("OUT"))
    a = ap.parse_args()
    backend = make_backend(a.backend, a.model)
    print(f"[producer] device={a.device} backend={backend.name} model={backend.model}")
    out, _ = produce(a.device, backend, a.out)
    print(f"[producer] wrote {out}")
    print("[producer] candidate only: validate with the generator's --backend-binding option "
          "against the corresponding IR before adopting it; behavioral fidelity still needs verification.")


if __name__ == "__main__":
    main()
