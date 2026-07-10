APP := dist/BeamRadio
SOURCE_DIR := source

.PHONY: all build clean smoke help

all: build

build:
	@echo "BeamRadio: build"
	@echo "  provider: $(SOURCE_DIR)/Makefile"
	@echo "  output:   $(APP)"
	@cd $(SOURCE_DIR) && $(MAKE)
	@if [ -x "$(APP)" ]; then \
		echo "BeamRadio: build ok: $(APP)"; \
	else \
		echo "BeamRadio: build finished, but $(APP) was not found"; \
		exit 1; \
	fi

clean:
	@echo "BeamRadio: clean"
	@rm -rf $(SOURCE_DIR)/objects.*
	@rm -f $(APP)
	@echo "BeamRadio: clean ok"

smoke:
	@echo "BeamRadio: smoke"
	@if [ -x "$(APP)" ]; then \
		echo "BeamRadio: smoke ok: $(APP) exists and is executable"; \
	else \
		echo "BeamRadio: smoke failed: $(APP) missing or not executable"; \
		exit 1; \
	fi

help:
	@echo "BeamRadio targets:"
	@echo "  make        build BeamRadio"
	@echo "  make build  build BeamRadio"
	@echo "  make clean  remove generated build output"
	@echo "  make smoke  verify built app exists"
	@echo "  make help   show this help"
