# Phase 0010 - German localization catalog baseline

## Scope

Make the existing German localization data loadable and reachable through the
normal repository-root build path.

This phase corrects catalog metadata, routes existing search labels through the
Haiku translation system, completes two clipboard status translations, and
binds the validated German catalog into the application binary.

## Runtime finding

The first GUI lifecycle run showed that BeamRadio launched and exited cleanly,
but its menus, station finder, and first-run message remained English on a
German Haiku installation.

The repository already contained `source/locales/de.catkeys`, and
`source/Makefile` already listed `de` in `LOCALES`. The missing runtime
localization therefore was not caused by an absent translation file.

## Local makefile-engine authority

The local Haiku Generic Makefile Engine v2.6 keeps localization outside the
normal `default: $(TARGET)` build path.

It provides separate targets for:

- `catalogs`
- `catalogsinstall`
- `bindcatalogs`

The normal source build creates the application but does not generate, install,
or bind catalogs automatically.

## Catalog fingerprint repair

`linkcatkeys` initially rejected `source/locales/de.catkeys` with `Bad data`.
The catalog header still carried the inherited fingerprint `1780791103`, which
no longer matched its actual key set.

The German catalog fingerprint was updated as the validated key set changed:

- existing key set: `956364225`
- localized station-search criteria: `3256949250`
- clipboard status messages: `3477159906`

The final value belongs to the final German key set in this phase.

## Search criteria

The station-finder controls were already translated, but provider criteria such
as `Tag`, `Language`, `Country`, and `State/Region` were registered as raw
English strings.

The two existing station-finder providers now pass those labels through
`B_TRANSLATE()` using their existing provider translation contexts. Search
selection and provider behavior remain unchanged.

## Clipboard status messages

The source already routed both clipboard failure paths through `B_TRANSLATE()`.
The German catalog now supplies distinct translations for:

- no station URL in the clipboard
- clipboard text that cannot be loaded as a station

The underlying validation and error behavior are unchanged.

## Root build boundary

The repository-root `make` and `make build` paths now bind the validated German
catalog after the source build succeeds.

`make catalog-de` exposes the same binding operation for an existing binary,
which keeps catalog iteration visible without forcing a full rebuild.

Only `de` is bound by this phase. Other inherited language catalogs remain
outside the validated default path.

## Validation

Run from the repository root:

```sh
git diff --check
make clean
make
make smoke
make smoke-gui
```

During the GUI smoke on a German Haiku installation, verify:

- main menus and first-run text appear in German
- station-finder controls appear in German
- Community Radio Browser search criteria appear in German
- clipboard text without a valid station URL produces the German status text
- closing the main window returns to the terminal

## Non-goals

- no full translation refresh for every inherited language
- no automatic repair of third-party or inherited catalog files
- no station-search behavior change
- no new station-list download feature
- no networking change
- no settings migration
- no UI redesign

## What this proves

- the German plaintext catalog is structurally valid
- the German catalog can be bound into `dist/BeamRadio`
- the Haiku Locale Kit selects the embedded German catalog at runtime
- the normal root build produces a German-localizable application
- localized provider labels preserve existing search behavior

## What this does not prove

- translation completeness in every UI and error path
- translation quality for other languages
- successful live station search or playback
- packaging or HaikuDepot catalog placement
