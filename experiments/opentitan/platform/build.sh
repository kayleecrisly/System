#!/usr/bin/env bash
set -euo pipefail
platform_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
system_dir=$(cd -- "$platform_dir/../../.." && pwd)
qemu_dir=/home/kaylee/circt-workspace/environments/opentitan/qemu/local-10.2-prototype
model_dir="$system_dir/outputs/opentitan/rtl-c751059925/models/uart/uart"
results_dir="$system_dir/results/opentitan/rtl-c751059925/platform"

# Rebuild the already prepared, isolated source. Never alter the original QEMU.
test -f "$qemu_dir/source/hw/riscv/qp_opentitan_uart_baseline.c"
test -f "$qemu_dir/source/hw/riscv/ot_uart_core_test.c"
python3 "$system_dir/tools/board/rehost_gen.py" generate \
  "$platform_dir/uart-baseline.board.json" -o "$platform_dir/generated"
cp "$platform_dir/generated/qp_opentitan_uart_baseline.c" "$qemu_dir/source/hw/riscv/"
cp "$platform_dir/ot_baseline_observer.c" "$platform_dir/ot_uart_core_test.c" \
  "$qemu_dir/source/hw/riscv/"
cp "$model_dir/uart.c" "$model_dir/uart.h" "$qemu_dir/source/hw/opentitan/qemu_passes/"
mkdir -p "$results_dir"
cd "$qemu_dir/build-riscv32"
../source/configure --target-list=riscv32-softmmu --disable-docs --disable-werror \
  --without-default-devices > "$results_dir/configure-native-core.log" 2>&1
ninja -j2 qemu-system-riscv32 > "$results_dir/build-native-core.log" 2>&1
