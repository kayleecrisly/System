# System：面向固件 Rehosting 的外设模型与板级代码生成系统

本项目旨在构建通用的固件 rehosting 系统：根据 RTL/MLIR 和从手册、官方硬件资料中整理并确认的信息，生成外设行为模型及 QEMU 板级代码，组装能够仿真目标硬件行为、运行真实目标固件的平台。

OpenTitan 和 Wujian100 是当前选取的验证案例。生成规则应由统一的输入描述与组件接口驱动，避免依赖项目名称或针对某个实验的特殊处理。当前实验先评估固件 rehosting 效果，系统性的硬件行为保真度（faithfulness）验证在后续补充。

## 系统职责与生成流程

```text
RTL 源码 → CIRCT → MLIR → 外设行为模型与 QEMU 包装
经过确认的硬件信息 + 组件接口 → 板级代码与平台组装
目标固件 → 集成生成模型的 QEMU 平台 → rehosting 效果评估
```

外设模型负责寄存器、状态变化和信号等行为；板级代码负责创建组件、映射内存与外设地址、连接中断和其他接口。CPU 复用兼容的现有 QEMU 实现，CPU 模型生成不属于当前系统范围；运行平台还需配套的内存、启动和中断等支持。

## 目录结构与文件用途

| 目录 | 用途 |
|---|---|
| `tools/` | 通用模型生成器、项目驱动、板级生成器、工具链配置和接口契约 |
| `projects/<项目>/` | RTL、原始 MLIR、手册、bindings、板级配置和项目输入工具 |
| `experiments/<项目>/` | 固件 rehosting 实验，后续补充保真度验证 |
| `experiments/<项目>/firmware/src/` | 后续实验使用的固件源码、启动汇编和链接脚本 |
| `experiments/<项目>/firmware/build/<批次>/` | 编译后的固件，如 ELF、BIN |
| `experiments/<项目>/host-test/` | 在主机运行的验证脚本：启动仿真、提供输入、检查结果 |
| `tools/tests/` | 生成器软件回归测试与 QEMU 测试用头文件桩 |
| `tools/maintenance/` | 目录与文件完整性检查等维护工具 |
| `outputs/<项目>/<批次>/` | 系统生成的模型、板级代码及必要配置与清单 |
| `results/<项目>/<批次>/generation/` | 生成日志、中间 MLIR 等生成过程记录 |
| `results/<项目>/<批次>/execution/` | 固件执行日志与实验验证结果 |

## 当前实验方案：评估固件 Rehosting 效果

`tools/tests/` 检查生成器自身的软件功能；`experiments/` 用目标固件评估生成平台的 rehosting 能力。实验参考 [P2IM 的固件单元测试组织方式](https://github.com/RiS3-Lab/p2im-unit_tests)，优先复用与目标 RTL 版本、硬件配置匹配的官方示例和已有驱动测试，按需做最小适配与功能补充，保留真实驱动执行路径。

当前检查固件启动、驱动初始化和目标外设操作的执行情况，系统性保真度验证在后续补充。固件选取、版本匹配、环境准备、实施流程和结果记录见[实验设计 README](experiments/README.md)。

## 当前实现能力与限制

目前系统具备部分模型与板级生成能力。回归通过不等于真实硬件保真度已得到验证。OpenTitan 的 `earlgrey_rehost.board.json` 仍是声明了未支持项的 `peripheral-test` 配置，不能据此认定完整硬件仿真或真实固件 rehosting 已完成。

## 工具链配置、构建与模型生成

默认 CIRCT 工具链由 [tools/toolchain.json](tools/toolchain.json) 指定，当前为升级后的 `circt-aes-new`。RTL 项目生成默认使用其中的 `build/Release/bin/circt-verilog`，显式 `--circt-verilog` 可覆盖。默认前端缺失时会报错，不通过 PATH 寻找其他版本。新建 CMake 构建目录默认使用同一工具链的 LLVM/MLIR/CIRCT 包；已有缓存或显式包路径覆盖仍有效。

项目中保留的 MLIR 尚未批量重新生成。切换默认工具链不会更新已有文件，也不会撤销外部 OpenTitan 源码树中曾经应用的修改。后续重建需要明确记录实际 RTL 来源、修改情况和工具版本，不能默认旧产物来自未修改 RTL 或新版 CIRCT。

从本目录执行：

```bash
cmake -S tools -B tools/build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build tools/build -j 2
ctest --test-dir tools/build --output-on-failure
python3 tools/driver/project.py generate projects/common/examples/demo-rtl.project.json \
  --qemu-passes tools/build/qemu-passes -o outputs/common/demo-new-run
```

生成工具：[统一驱动](tools/driver/project.py)、[板级生成器](tools/board/rehost_gen.py)。上述示例从 RTL 开始生成，诊断产物写入 `results/common/demo-new-run/generation/`。若从已有 MLIR 开始，可改用 `projects/common/examples/demo.project.json`。每次使用新的批次目录。

## 开发与实验边界

- 区分硬件事实、当前仿真能力和实验假设；缺失或冲突的信息明确记录，不通过猜测补齐。
- 测试邮箱、人工状态或中断注入等实验设施不属于默认目标硬件；验证机制应与目标平台描述分开。
- 通过条件须覆盖目标外设操作的实际执行，不能仅以编译成功或固件未崩溃判定；rehosting 成功不直接等同于已证明高保真。
- 每项实验明确记录预期行为、参考依据和验证结果。

## 实验说明与完整性检查

实验分工见 [experiments/README.md](experiments/README.md)。目录与文件完整性检查：

```bash
python3 tools/maintenance/verify_layout.py
```
