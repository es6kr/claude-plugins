MARKETPLACE := es6kr-plugins
PLUGIN_DIR := $(shell pwd)/plugins

.PHONY: help install list add-marketplace test update

help:
	@echo "Usage:"
	@echo "  make add-marketplace  Register marketplace"
	@echo "  make update           Update marketplace"
	@echo "  make install PLUGIN=<name>  Install plugin"
	@echo "  make uninstall PLUGIN=<name>  Uninstall plugin"
	@echo "  make list  List available plugins"

list:
	@echo "Available plugins:"
	@ls -1 $(PLUGIN_DIR) | sed 's/^/  - /'

add-marketplace:
	claude plugin marketplace add "$(shell pwd)"

install:
ifndef PLUGIN
	@echo "Error: PLUGIN required: make install PLUGIN=code-quality"
	@exit 1
endif
	@if [ ! -d "$(PLUGIN_DIR)/$(PLUGIN)" ]; then \
		echo "Error: Plugin not found: $(PLUGIN)"; \
		exit 1; \
	fi
	@echo "Installing plugin:"
	claude plugin install $(PLUGIN)@$(MARKETPLACE)

test:
	@echo "Running bats tests..."
	@bats tests/test_scripts.bats
	@echo "Running pytest..."
	@uvx --from pytest pytest tests/test_scripts.py -v

uninstall:
ifndef PLUGIN
	@echo "Error: PLUGIN required: make uninstall PLUGIN=code-quality"
	@exit 1
endif
	@echo "Uninstalling plugin:"
	claude plugin uninstall $(PLUGIN)@$(MARKETPLACE)

update:
	claude plugin marketplace update $(MARKETPLACE)
