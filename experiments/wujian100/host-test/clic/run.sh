#!/usr/bin/env bash
# Reproduce the isolated, host-only CLIC core experiment.
# No CPU execution and no generic SysBus IRQ adapter are tested here.
set -euo pipefail
clic_test_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
clic_system_dir="$(cd -- "$clic_test_dir/../../../.." && pwd)"
clic_rtl_dir="$clic_system_dir/../wujian100_open_original"
clic_result_dir="$clic_system_dir/results/wujian100/rtl-83e29758/clic-prototype"
clic_output_dir="$clic_system_dir/outputs/wujian100/rtl-83e29758/models/clic-prototype"
clic_frontend="${CLIC_FRONTEND:-/home/kaylee/circt-workspace/circt-aes-new/build/Release/bin/circt-verilog}"
clic_passes="${CLIC_PASSES:-$clic_system_dir/tools/build/qemu-passes}"
test "$(git -C "$clic_rtl_dir" rev-parse HEAD)" = 83e297583bb3454b688f9f27d6bc20ff3276ad32
git -C "$clic_rtl_dir" diff --exit-code HEAD -- soc/E902_20191018.v soc/common.v soc/core_top.v
mkdir -p "$clic_result_dir" "$clic_output_dir"
# Official FPGA define bypasses clock-gating cells; test functional behavior,
# not ASIC gate timing. The original RTL files are not edited.
"$clic_frontend" -D FPGA --top cr_clic_top -ir-llhd \
    "$clic_rtl_dir/soc/E902_20191018.v" "$clic_rtl_dir/soc/common.v" \
    -o "$clic_result_dir/frontend.mlir" > "$clic_result_dir/frontend.log" 2>&1
"$clic_passes" "$clic_result_dir/frontend.mlir" --all-passes --no-reports \
    --binding-path="$clic_test_dir/bus.json" \
    --backend-binding="$clic_test_dir/binding.json" \
    --device-catalog="$clic_test_dir/catalog.json" --qemu-emit-c \
    --qemu-output-dir="$clic_output_dir" -o "$clic_result_dir/pipeline.mlir" \
    > "$clic_result_dir/generation.log" 2>&1
cc -std=gnu11 -O0 -I "$clic_system_dir/tools/tests/qstub" \
    -I "$clic_output_dir/cr_clic_top" \
    "$clic_output_dir/cr_clic_top/cr_clic_top.c" "$clic_test_dir/test_core.c" \
    -o "$clic_result_dir/test_core" > "$clic_result_dir/compile.log" 2>&1
sha256sum "$clic_frontend" "$clic_passes" \
    "$clic_rtl_dir/soc/E902_20191018.v" "$clic_rtl_dir/soc/common.v" \
    "$clic_test_dir/"*.json "$clic_test_dir/test_core.c" "$clic_test_dir/run.sh" \
    "$clic_output_dir/cr_clic_top/cr_clic_top.c" \
    "$clic_output_dir/cr_clic_top/cr_clic_top.h" "$clic_result_dir/test_core" \
    > "$clic_result_dir/sha256sums.txt"
"$clic_result_dir/test_core" | tee "$clic_result_dir/test.log"
