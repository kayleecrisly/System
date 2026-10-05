# 工作区维护

`verify_layout.py` 根据 `System/.layout.json` 指向的快照，核对快照记录的文件、符号链接和生成产物清单。

从 System 目录执行 `python3 tools/maintenance/verify_layout.py`。快照记录整理结束时的内容；后续主动修改文件需要审查后建立新的记录，不能用更新哈希掩盖意外变更。
