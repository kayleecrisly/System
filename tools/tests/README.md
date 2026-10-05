# 生成器回归测试

这里检查设备配置、统一模型生成流程和板级生成器的软件功能。`qstub/` 提供测试编译所需的简化 QEMU 接口，不能替代真实 QEMU 平台。板级用例核对项目配置、地址和中断连接；需要生成产物的测试在临时目录中生成，不依赖 outputs 中的历史模型。

从 System 目录执行 `ctest --test-dir tools/build --output-on-failure`。这些测试通过不代表真实硬件保真度已验证；项目固件与主机验证脚本分别放在 `experiments/<项目>/firmware/` 和 `experiments/<项目>/host-test/`。
