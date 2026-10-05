# Shared with driver/project.py. All relative paths are based on tools/.
file(READ "${CMAKE_CURRENT_LIST_DIR}/../toolchain.json" QP_TOOLCHAIN_JSON)
string(JSON QP_DEFAULT_ROOT GET "${QP_TOOLCHAIN_JSON}" root)
get_filename_component(QP_DEFAULT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../${QP_DEFAULT_ROOT}" ABSOLUTE)
set(QP_CIRCT_ROOT "${QP_DEFAULT_ROOT}" CACHE PATH "CIRCT checkout used for default package discovery")

foreach(QP_PACKAGE IN ITEMS LLVM MLIR CIRCT)
  string(TOLOWER "${QP_PACKAGE}" QP_PACKAGE_KEY)
  string(JSON QP_PACKAGE_RELATIVE GET "${QP_TOOLCHAIN_JSON}" "${QP_PACKAGE_KEY}_cmake")
  # Explicit package locations and existing caches remain valid overrides.
  if(NOT DEFINED ${QP_PACKAGE}_DIR OR "${${QP_PACKAGE}_DIR}" MATCHES "-NOTFOUND$")
    if(NOT EXISTS "${QP_CIRCT_ROOT}/${QP_PACKAGE_RELATIVE}/${QP_PACKAGE}Config.cmake")
      message(FATAL_ERROR "Default ${QP_PACKAGE} package missing in ${QP_CIRCT_ROOT}/${QP_PACKAGE_RELATIVE}; update tools/toolchain.json or provide explicit package paths.")
    endif()
    set(${QP_PACKAGE}_DIR "${QP_CIRCT_ROOT}/${QP_PACKAGE_RELATIVE}"
        CACHE PATH "${QP_PACKAGE} package directory" FORCE)
  endif()
  message(STATUS "${QP_PACKAGE} package directory: ${${QP_PACKAGE}_DIR}")
endforeach()
message(STATUS "Default CIRCT checkout: ${QP_CIRCT_ROOT}")
