APP := dist/BeamRadio
SOURCE_DIR := source

include $(SOURCE_DIR)/locales/locales.mk
CATALOG_LOCALES := $(BEAMRADIO_LOCALES)

VICTIM_PROFILE_DIR := $(CURDIR)/test-state/victim
VICTIM_PROFILE_MARKER := $(VICTIM_PROFILE_DIR)/.beamradio-victim-profile

.PHONY: all build catalog-de catalogs catalogs-check clean smoke smoke-gui \
	prepare-victim reset-victim run-victim help

all: build

build:
	@echo "BeamRadio: build"
	@echo "  provider: $(SOURCE_DIR)/Makefile"
	@echo "  output:   $(APP)"
	@cd $(SOURCE_DIR) && $(MAKE)
	@echo "BeamRadio: catalogs"
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

catalogs:
	@echo "BeamRadio: catalogs"
	@if [ ! -x "$(APP)" ]; then \
		echo "BeamRadio: catalogs failed: run make first"; \
		exit 1; \
	fi
	@echo "  locales:  $(CATALOG_LOCALES)"
	@cd $(SOURCE_DIR) && $(MAKE) bindcatalogs LOCALES="$(CATALOG_LOCALES)"
	@echo "BeamRadio: catalogs ok: all declared catalogs bound"

catalogs-check:
	@echo "BeamRadio: catalogs-check"
	@echo "  locales:  $(CATALOG_LOCALES)"
	@cd $(SOURCE_DIR) && $(MAKE) catalogs-check LOCALES="$(CATALOG_LOCALES)"
	@echo "BeamRadio: catalogs-check ok: all declared catalogs compiled"

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


prepare-victim: reset-victim
	@mkdir -p "$(VICTIM_PROFILE_DIR)"
	@touch "$(VICTIM_PROFILE_MARKER)"
	@echo "BeamRadio: fresh developer victim profile prepared"
	@echo "  path: $(VICTIM_PROFILE_DIR)"

reset-victim:
	@if [ -e "$(VICTIM_PROFILE_DIR)" ] && [ ! -f "$(VICTIM_PROFILE_MARKER)" ]; then \
		echo "BeamRadio: reset-victim refused: marker missing"; \
		echo "  path: $(VICTIM_PROFILE_DIR)"; \
		exit 1; \
	fi
	@rm -rf "$(VICTIM_PROFILE_DIR)"
	@echo "BeamRadio: developer victim profile reset"

run-victim: build
	@$(MAKE) prepare-victim
	@echo "BeamRadio: run-victim"
	@echo "  isolated profile: $(VICTIM_PROFILE_DIR)"
	@./$(APP) --developer --victim-profile "$(VICTIM_PROFILE_DIR)"
	@echo "BeamRadio: run-victim ok: application exited cleanly"

smoke-gui: build
	@echo "BeamRadio: smoke-gui"
	@echo "  close the main window to complete the smoke"
	@./$(APP)
	@echo "BeamRadio: smoke-gui ok: application exited cleanly"

help:
	@echo "BeamRadio targets:"
	@echo "  make             build BeamRadio and bind all declared catalogs"
	@echo "  make build       build BeamRadio and bind all declared catalogs"
	@echo "  make catalog-de  rebind only the German catalog"
	@echo "  make catalogs    rebind all declared catalogs"
	@echo "  make catalogs-check  compile and validate all declared catalogs"
	@echo "  make clean       remove generated build output"
	@echo "  make smoke       verify built app exists"
	@echo "  make smoke-gui   launch app and verify clean exit"
	@echo "  make run-victim  [developer] launch with a fresh isolated profile"
	@echo "  make reset-victim  [developer] remove only the isolated profile"
	@echo "  make help        show this help"
