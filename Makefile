APP := dist/BeamRadio
SOURCE_DIR := source
CATALOG_LOCALES := de

.PHONY: all build catalog-de clean smoke smoke-gui help

all: build

build:
	@echo "BeamRadio: build"
	@echo "  provider: $(SOURCE_DIR)/Makefile"
	@echo "  output:   $(APP)"
	@cd $(SOURCE_DIR) && $(MAKE)
	@echo "BeamRadio: catalog"
	@echo "  locales:  $(CATALOG_LOCALES)"
	@cd $(SOURCE_DIR) && $(MAKE) bindcatalogs LOCALES="$(CATALOG_LOCALES)"
	@if [ -x "$(APP)" ]; then \
		echo "BeamRadio: build ok: $(APP)"; \
	else \
		echo "BeamRadio: build finished, but $(APP) was not found"; \
		exit 1; \
	fi

catalog-de:
	@echo "BeamRadio: catalog-de"
	@if [ ! -x "$(APP)" ]; then \
		echo "BeamRadio: catalog-de failed: run make first"; \
		exit 1; \
	fi
	@cd $(SOURCE_DIR) && $(MAKE) bindcatalogs LOCALES=de
	@echo "BeamRadio: catalog-de ok: German catalog bound"

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

smoke-gui: build
	@echo "BeamRadio: smoke-gui"
	@echo "  close the main window to complete the smoke"
	@./$(APP)
	@echo "BeamRadio: smoke-gui ok: application exited cleanly"

help:
	@echo "BeamRadio targets:"
	@echo "  make             build BeamRadio and bind the German catalog"
	@echo "  make build       build BeamRadio and bind the German catalog"
	@echo "  make catalog-de  rebind the German catalog to an existing build"
	@echo "  make clean       remove generated build output"
	@echo "  make smoke       verify built app exists"
	@echo "  make smoke-gui   launch app and verify clean exit"
	@echo "  make help        show this help"
