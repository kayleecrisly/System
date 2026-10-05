# Wujian100：固件 Rehosting 实验

当前先评估固件 rehosting，系统性保真度验证后续补充。建议使用干净提交 `83e297583bb3454b688f9f27d6bc20ff3276ad32` 的官方 SDK，首个候选为裸机 `example_timer`，随后扩展 USART 收发和 GPIO 下降沿中断。

具体版本证据、示例链接和运行依赖见[首批候选清单](../BASELINE.md)。E902／CLIC 运行环境、SDK 链接脚本及编译兼容性尚待核对，本轮尚未编译或运行固件。

- `firmware/src/`：在目标 CPU 上运行的固件源码、启动汇编和链接脚本。
- `firmware/build/<批次>/`：编译后的固件。
- `host-test/`：在主机运行的验证脚本，用于启动仿真、通过硬件接口提供输入、核对结果。

系统生成的模型和板级代码位于 `System/outputs/wujian100/<批次>/`。生成记录位于 `System/results/wujian100/<批次>/generation/`，固件运行与验证记录位于 `System/results/wujian100/<批次>/execution/`。

每项实验需明确预期行为、参考依据和通过条件。
