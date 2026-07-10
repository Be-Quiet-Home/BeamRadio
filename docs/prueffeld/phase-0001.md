# Phase 0001 — Adopt BeamRadio identity

Date: 2026-07-09

## Scope

Adopt the BeamRadio identity for the fresh revival fork without changing runtime behavior.

## Changed

- README now describes BeamRadio as a revival fork of StreamRadio.
- User guide now names BeamRadio and points to `Be-Quiet-Home/BeamRadio`.
- Build target changed from `dist/StreamRadio` to `dist/BeamRadio`.
- Application signature changed to `application/x-vnd.be-quiet-home-beamradio`.
- Settings file changed from `StreamRadio.settings` to `BeamRadio.settings`.
- Resource definition file renamed to `source/BeamRadio.rdef`.
- `APP_MIME_SIG`, app signature resource, user agent, window title, About title, usage text, and catkeys identity were aligned to BeamRadio.
- `docs/scope.md` records project goals, non-goals, and postponed work.
- `docs/provenance.md` records fork origin, attribution, and inherited license boundary.
- `LICENSE` added with GPL-3 text matching the main inherited source headers.

## Not changed

- Playback behavior.
- Stream decoding behavior.
- Station search behavior.
- Station file format or station directory behavior.
- Network request behavior.
- UI layout or controls.
- Deskbar, Replicant, or mini-mode behavior.
- Migration from existing StreamRadio settings.

## Validation

Performed in a non-Haiku sandbox against the uploaded ZIP tree:

```sh
rg -n "application/x-vnd\.Fishpond-StreamRadio|Fishpond-StreamRadio|StreamRadio\.settings|StreamRadio\.rdef|dist/StreamRadio|B_TRANSLATE_SYSTEM_NAME\(\"StreamRadio\"\)|Usage: StreamRadio|StreamRadio/" README.md docs/userguide.md source
```

Expected result:

- no remaining old active app identity, binary name, resource file, settings file, user agent, usage string, help URL, or old application signature in README, user guide, or source.
- historical StreamRadio mentions are allowed in README and documentation when they explain provenance or the deliberate no-migration boundary.

Build validation on Haiku is still required:

```sh
cd source
make clean
make
```

## Remaining risk

- This phase was not built on Haiku in the sandbox.
- Existing catkeys were mechanically aligned to the new BeamRadio source identity; a later localization phase should regenerate and review them on Haiku.
- Private Haiku headers and synchronous network paths remain inherited debt.
- Existing station data is not migrated from StreamRadio settings by design.

## Next smallest brick

Phase 0002: fix first static safety findings without feature work.

Candidate fixes:

- duplicate `Station::Load()` call and `BEntry` ownership in `B_REFS_RECEIVED`,
- flag clearing `!FLAG` to `~FLAG`,
- safe clipboard text handling,
- obvious `NULL` / `status_t` guardrails.

## Local Haiku build proof

Observed on local Haiku after applying the BeamRadio identity patch:

```sh
cd source
make clean
make
````

Initial result:

* compile reached the final link step
* link failed because the repository did not contain the `dist/` output directory

Repair:

* keep `dist/` present with `dist/.gitkeep`
* keep generated `dist/BeamRadio` ignored

After creating `dist/`, the build completed:

* `dist/BeamRadio` was linked
* resources were attached with `xres`
* MIME information was applied with `mimeset`

Known warnings remain and are deliberately not fixed in phase 0001:

* `MainWindow.cpp` format argument warning
* `StationFinder*` string literal to `char*` warnings
* `StreamIO.cpp` signed/unsigned and pointer-address warnings
