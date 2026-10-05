# OpenTitan：固件 Rehosting 实验

当前先评估固件 rehosting，系统性保真度验证后续补充。首个建议用例是官方 `uart_smoketest` 内部回环，随后扩展定时器中断和 GPIO 回环；用户已确认源码位于工作区 `opentitan/`，包含官方提交 `c7510599254dcbaa6153468e696aa11299cb5b5f` 及本地修改。后续配套使用该工作树中的驱动和测试，并补齐 MLIR 生成记录。

具体版本证据、示例链接和运行依赖见[首批候选清单](../BASELINE.md)。本轮仅完成准备核查，尚未编译或运行固件。

- `firmware/src/`：在目标 CPU 上运行的固件源码、启动汇编和链接脚本。
- `firmware/build/<批次>/`：编译后的固件。
- `host-test/`：在主机运行的验证脚本，用于启动仿真、通过硬件接口提供输入、核对结果。

系统生成的模型和板级代码位于 `System/outputs/opentitan/<批次>/`。生成记录位于 `System/results/opentitan/<批次>/generation/`，固件运行与验证记录位于 `System/results/opentitan/<批次>/execution/`。

每项实验需明确预期行为、参考依据和通过条件。
