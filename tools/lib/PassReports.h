//===- PassReports.h - Shared pass-report helper ------------------------===//
//
// Small utility every pass can use to persist a summary of its work to
// `results/common/default/generation/<pass-name>.log`.  The live stderr output is unchanged — the
// log file is an additional, overwritable record for later inspection.
//
// Usage in a pass' runOnOperation():
//
//   qemu_passes::writePassReport("drv-classification",
//       [&](llvm::raw_ostream &os) {
//         os << "ACCUMULATE: " << accumulateCount << "\n";
//         os << "LOOP_ITER: " << loopIterCount << "\n";
//         ...
//       });
//
// Reports are enabled by default.  tool_main.cpp flips `g_reportsEnabled`
// to false when the user passes --no-reports.
//===----------------------------------------------------------------------===//
#pragma once

#include "llvm/ADT/STLFunctionalExtras.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"

namespace qemu_passes {

extern bool g_reportsEnabled;

/// Write a pass report to `results/common/default/generation/<passName>.log`.  No-op when
/// `g_reportsEnabled` is false.  Any filesystem error is reported on stderr
/// but never causes the caller's pass to fail.  The `writer` callback is
/// invoked with a raw_ostream bound to the log file.
void writePassReport(
    llvm::StringRef passName,
    llvm::function_ref<void(llvm::raw_ostream &)> writer);

} // namespace qemu_passes
