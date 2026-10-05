PYTHON ?= python3
SYSTEM_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../../..)
BOARD_TOOL := $(SYSTEM_DIR)/tools/board/rehost_gen.py
EXAMPLE := $(SYSTEM_DIR)/projects/common/boards/mini_riscv.board.json
EARLGREY := $(SYSTEM_DIR)/projects/opentitan/boards/earlgrey_rehost.board.json
TEST_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
.PHONY: check validate test example earlgrey
check: validate test
validate:
	$(PYTHON) $(BOARD_TOOL) validate $(EXAMPLE)
	$(PYTHON) $(BOARD_TOOL) validate $(EARLGREY)
test:
	$(PYTHON) -m unittest discover -s $(TEST_DIR) -v
example:
	@test -n "$(OUT)" || { echo "Set OUT to a new output directory" >&2; exit 2; }
	$(PYTHON) $(BOARD_TOOL) generate $(EXAMPLE) -o $(OUT)
earlgrey:
	@test -n "$(OUT)" || { echo "Set OUT to a new output directory" >&2; exit 2; }
	$(PYTHON) $(BOARD_TOOL) generate $(EARLGREY) -o $(OUT)
