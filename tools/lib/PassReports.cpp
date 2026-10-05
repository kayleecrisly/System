//===- PassReports.cpp - Shared pass-report helper ----------------------===//

#include "PassReports.h"

#include "llvm/Support/FileSystem.h"
#include <system_error>

namespace qemu_passes {

bool g_reportsEnabled = true;

void writePassReport(
    llvm::StringRef passName,
    llvm::function_ref<void(llvm::raw_ostream &)> writer) {
  if (!g_reportsEnabled)
    return;

  std::error_code ec;
  (void)llvm::sys::fs::create_directories("results/common/default/generation");
  std::string path = ("results/common/default/generation/" + passName + ".log").str();
  llvm::raw_fd_ostream out(path, ec);
  if (ec) {
    llvm::errs() << "[PassReports] cannot open " << path << ": "
                 << ec.message() << "\n";
    return;
  }
  writer(out);
}

} // namespace qemu_passes
