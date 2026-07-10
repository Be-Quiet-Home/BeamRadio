# Phase 0002 - Static safety fixes

## Scope

This phase fixes small static safety issues found during the initial
BeamRadio adoption pass.

It does not change playback behavior, networking behavior, UI structure,
station finder behavior, locale policy, packaging policy, or project scope.

## Changes

### MainWindow station loading

- Avoid duplicate temporary `BEntry` construction when loading a station.
- Pass a stable stack `BEntry` to `Station::Load()`.
- Fix a missing `SetToFormat()` argument in the station-load error message.

### Clipboard station loading

- Copy clipboard URL bytes into a local `BString` while the clipboard is locked.
- Do not write a trailing NUL byte into clipboard-owned memory.
- Report an empty clipboard URL instead of silently continuing.
- Delete a temporary station object when probing or adding fails.
- Report when a station could not be loaded from the clipboard URL.

### Station flags and load failure

- Replace boolean-negation flag clearing with bitwise flag clearing.
- Delete the temporary station object before returning on oversized station files.

## Validation

Ran from `source/` because the inherited BeamRadio Makefile lives there.

```sh
cd ~/Desktop/Projekte/BeamRadio/source
make
echo "make exit=$?"
make -n
echo "make -n exit=$?"
````

Observed:

```text
make exit=0
make -n exit=0
```

The dry-run showed the expected inherited build path:

```text
cc -o objects.x86_64-cc13-release/../../dist/BeamRadio ...
xres -o objects.x86_64-cc13-release/../../dist/BeamRadio ...
mimeset -f objects.x86_64-cc13-release/../../dist/BeamRadio
```

Repository checks:

```sh
git diff --check
git diff --stat
```

## Non-goals

* No clean target was added.
* No Makefile restructuring.
* No StationFinder const-correctness changes.
* No locale cleanup.
* No BeOS language baseline work.
* No external stack changes.
