# Phase 0011: Catalog consistency

## Purpose

Bring every declared BeamRadio localization catalog to one technically consistent and bindable key set after the German runtime path exposed stale inherited catalog fingerprints and missing keys.

## Starting condition

Phase 0010 established a working German catalog with 54 current keys and a validated runtime presentation.

The remaining declared catalogs still contained the inherited 43-key set and the obsolete fingerprint `1780791103`:

- `ca`
- `en_GB`
- `en`
- `es`
- `fr`
- `fur`
- `id`
- `it`
- `nl`
- `pt`
- `ro`
- `sv`
- `tr`
- `uk`

Each lacked the same eleven keys introduced or exposed by the Phase 0010 localization work:

- two clipboard status messages,
- two `listenlive.eu` search criteria,
- seven Community Radio Browser search criteria.

No catalog contained keys outside the current 54-key set.

## Changes

- Add `source/locales/locales.mk` as the single canonical locale list.
- Share that list between the root and provider Makefiles.
- Synchronize every declared `.catkeys` file to the current 54-key set.
- Preserve every existing translated value.
- Use the English source string for newly missing entries instead of inventing translations.
- Give every catalog the current common fingerprint `3477159906`.
- Bind all declared catalogs during the normal root build.
- Add `make catalogs` for rebinding all catalogs to an existing binary.
- Add `make catalogs-check` for compiling and validating every catalog into a disposable `source/objects.catalog-check` directory without rebinding the application.
- Use `linkcatkeys` directly for that check because the local Generic Makefile Engine v2.6 cannot create its nested MIME-signature catalog directory with its non-recursive `mkdir` rule.
- Retain `make catalog-de` as a narrow convenience target.

## Validation

Run on Haiku from the repository root:

```sh
make clean
make catalogs-check
make
make smoke
make smoke-gui
```

Expected catalog-check boundary:

- all 15 declared catalogs compile through `linkcatkeys`,
- no catalog reports `Bad data`,
- no declared catalog file is missing,
- the normal build binds all declared catalogs into `dist/BeamRadio`.

The German GUI smoke should continue to show the already validated German menus, search criteria, and clipboard status messages, and closing the main window should return cleanly to the terminal.

## What this proves

- the locale list has one explicit source of truth,
- every declared catalog has the same current key/context/comment set,
- every declared catalog has a matching fingerprint,
- every declared catalog can be compiled and bound by the local Haiku catalog tools,
- normal builds no longer ship only the German resource catalog.

## What this does not prove

- linguistic correctness or completeness of non-German translations,
- native-speaker review,
- runtime testing under every Haiku language preference,
- any change to playback, station storage, network search, or application lifecycle behavior.

Newly added entries intentionally remain English in catalogs without reviewed translations. This is an explicit fallback boundary, not a claim of completed translation.
