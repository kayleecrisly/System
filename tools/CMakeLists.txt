cmake_minimum_required(VERSION 3.20)
project(qemu-passes LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# --- Find LLVM / MLIR / CIRCT ---
include(cmake/DefaultCIRCT.cmake)
find_package(LLVM REQUIRED CONFIG)
find_package(MLIR REQUIRED CONFIG)
find_package(CIRCT REQUIRED CONFIG)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddLLVM)
include(TableGen)
include(AddMLIR)

# Include dirs
include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/lib
  ${CIRCT_INCLUDE_DIRS}
  ${MLIR_INCLUDE_DIRS}
  ${LLVM_INCLUDE_DIRS}
)

# --- TableGen: generate Passes.h.inc ---
set(LLVM_TARGET_DEFINITIONS ${CMAKE_CURRENT_SOURCE_DIR}/include/Passes.td)

set(_TBLGEN_I_ARGS)
foreach(inc_dir ${CIRCT_INCLUDE_DIRS} ${MLIR_INCLUDE_DIRS} ${LLVM_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/include)
  list(APPEND _TBLGEN_I_ARGS -I${inc_dir})
endforeach()

mlir_tablegen(Passes.h.inc -gen-pass-decls ${_TBLGEN_I_ARGS})
add_public_tablegen_target(QemuPassesIncGen)

# --- Build the executable ---
add_executable(qemu-passes
  tool_main.cpp
  lib/PassReports.cpp
  lib/Passes.cpp
  lib/BusProfileQuery.cpp
  lib/BusProfileLoadPass.cpp
  lib/BusProfileResolvePass.cpp
  lib/ForwardConstrainPass.cpp
  lib/TLULControlInferencePass.cpp
  lib/FunctionalBusTxnInferPass.cpp
  lib/CombLogicExtractPass.cpp
  lib/LowerValueStructsPass.cpp
  lib/ExplodeStructSigsPass.cpp
  lib/ProcessLoopUnrollPass.cpp
  lib/QEMUEmitCPass.cpp
  lib/DeviceCatalog.cpp
  lib/GenericSysBusEmitter.cpp
  lib/BackendCharDevDetectPass.cpp
  lib/BackendBlueprint.cpp
  lib/BackendBindingLoadPass.cpp
)
add_dependencies(qemu-passes QemuPassesIncGen)

# Runtime JSON, not a compiled device table. --device-catalog overrides this
# absolute path, so invocations from other working directories also work.
target_compile_definitions(qemu-passes PRIVATE
  QP_DEFAULT_DEVICE_CATALOG="${CMAKE_CURRENT_SOURCE_DIR}/defaults/generic.json"
)

target_link_libraries(qemu-passes PRIVATE
  # MLIR core
  MLIRIR
  MLIRParser
  MLIRPass
  MLIRSupport
  MLIRTransforms
  MLIRFuncInlinerExtension
  MLIRAnalysis
  MLIRRewrite
  MLIRAsmParser
  MLIRBytecodeReader
  MLIRControlFlowDialect
  MLIRSCFDialect

  # CIRCT dialects
  CIRCTHW
  CIRCTHWTransforms   # hw-flatten-io pass
  CIRCTSV
  CIRCTComb
  CIRCTSeq
  CIRCTLLHD

  # LLVM support
  LLVMSupport
)

target_compile_options(qemu-passes PRIVATE -fno-rtti)

include(CTest)
if(BUILD_TESTING)
  find_package(Python3 COMPONENTS Interpreter QUIET)
  if(Python3_Interpreter_FOUND)
    add_test(NAME device-catalog
      COMMAND ${Python3_EXECUTABLE}
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_device_catalog.py
        --qemu-passes $<TARGET_FILE:qemu-passes>)
    add_test(NAME unified-project
      COMMAND ${Python3_EXECUTABLE}
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_unified_project.py
        --qemu-passes $<TARGET_FILE:qemu-passes>)
    add_test(NAME rehost-board
      COMMAND ${Python3_EXECUTABLE}
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/board/test_rehost_gen.py)
  endif()
endif()
