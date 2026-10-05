#!/usr/bin/env bash
set -euo pipefail
platform_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
system_dir=$(cd -- "$platform_dir/../../../.." && pwd)
qemu_dir=/home/kaylee/circt-workspace/environments/opentitan/qemu/rv-timer-qp-shim
results_dir="$system_dir/results/opentitan/rtl-c751059925/rv_timer-baseline/platform"
python3 "$platform_dir/prepare.py"
cd "$qemu_dir/build-riscv32"
../source/configure --target-list=riscv32-softmmu --disable-docs --disable-werror \
  --without-default-devices > "$results_dir/configure.log" 2>&1
ninja -j2 qemu-system-riscv32 > "$results_dir/build.log" 2>&1
