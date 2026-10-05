#!/usr/bin/env bash
# Fresh UART model from a pristine, pinned OpenTitan RTL snapshot.
set -euo pipefail
ot_experiment_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
ot_system_dir="$(cd -- "$ot_experiment_dir/../.." && pwd)"
ot_workspace_dir="$(cd -- "$ot_system_dir/.." && pwd)"
ot_source_dir="$ot_workspace_dir/opentitan"
ot_snapshot_dir=/home/kaylee/circt-workspace/environments/opentitan/rtl-c751059925
ot_model_dir="$ot_system_dir/outputs/opentitan/rtl-c751059925/models/uart"
ot_log_dir="$ot_system_dir/results/opentitan/rtl-c751059925/generation"
ot_frontend=/home/kaylee/circt-workspace/circt-aes-new/build/Release/bin/circt-verilog
ot_passes="$ot_system_dir/tools/build/qemu-passes"
ot_commit=c7510599254dcbaa6153468e696aa11299cb5b5f
test "$(git -C "$ot_source_dir" rev-parse HEAD)" = "$ot_commit"
mkdir -p "$ot_snapshot_dir" "$ot_model_dir" "$ot_log_dir"
# The existing file list supplies compilation order only. Extract every RTL
# input from the commit, so local utility/TL-UL edits do not enter this model.
mapfile -t ot_rtl_files < <(sed -n 's@^\./opentitan/@@p' "$ot_source_dir/mlir_output/uart/filelist_uart.f")
mapfile -t ot_headers < <(git -C "$ot_source_dir" ls-files hw/ip/prim/rtl hw/ip/prim_generic/rtl hw/ip/tlul/rtl hw/top_earlgrey/rtl | rg '\.svh$')
git -C "$ot_source_dir" archive "$ot_commit" "${ot_rtl_files[@]}" "${ot_headers[@]}" | tar -x -C "$ot_snapshot_dir"
ot_frontend_args=(--single-unit --top uart -ir-llhd -D SYNTHESIS=1)
for ot_inc in hw/ip/prim/rtl hw/ip/prim_generic/rtl hw/ip/tlul/rtl hw/top_earlgrey/rtl; do
    ot_frontend_args+=(-I "$ot_snapshot_dir/$ot_inc")
done
for ot_file in "${ot_rtl_files[@]}"; do
    ot_frontend_args+=("$ot_snapshot_dir/$ot_file")
done
"$ot_frontend" "${ot_frontend_args[@]}" -o "$ot_log_dir/uart.frontend.mlir" \
    > "$ot_log_dir/uart.frontend.log" 2>&1
"$ot_passes" "$ot_log_dir/uart.frontend.mlir" --all-passes --qemu-emit-c --no-reports \
    --rtl-adapter=opentitan \
    --device-catalog="$ot_system_dir/projects/opentitan/catalogs/opentitan.json" \
    --backend-binding="$ot_experiment_dir/host-test/uart.binding.json" \
    --qemu-output-dir="$ot_model_dir" -o "$ot_log_dir/uart.pipeline.mlir" \
    > "$ot_log_dir/uart.generation.log" 2>&1
sha256sum "$ot_frontend" "$ot_passes" \
    "$ot_system_dir/projects/opentitan/catalogs/opentitan.json" \
    "$ot_experiment_dir/host-test/uart.binding.json" \
    "${ot_rtl_files[@]/#/$ot_snapshot_dir/}" \
    "${ot_headers[@]/#/$ot_snapshot_dir/}" \
    "$ot_model_dir/uart/uart.c" "$ot_model_dir/uart/uart.h" \
    "$ot_model_dir/uart/uart_qp_shim.c" "$ot_model_dir/uart/uart_qp_shim.h" \
    > "$ot_log_dir/sha256sums.txt"
printf 'Generated UART model: %s\n' "$ot_model_dir/uart"
