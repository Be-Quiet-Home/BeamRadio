# Phase 0013 - Isolated developer victim profile

## Goal

Provide a disposable, repository-local BeamRadio test state without exposing a
destructive reset control to normal users and without letting build cleanup
touch real Haiku settings or saved stations.

## Developer boundary

Victim mode is not a normal application preference and is never persisted.

It requires both explicit startup arguments:

```text
--developer --victim-profile <absolute-path>
```

The profile directory must already contain this marker file:

```text
.beamradio-victim-profile
```

BeamRadio refuses incomplete, relative, or unmarked victim-profile requests.

## Developer targets

A fresh isolated session is started with:

```sh
make run-victim
```

This target:

1. builds BeamRadio,
2. removes only a previously marked repository-local victim profile,
3. creates `test-state/victim`,
4. writes the victim marker,
5. starts BeamRadio with the explicit developer arguments.

The profile remains available for inspection after BeamRadio exits. The next
`make run-victim` recreates it from a virgin state.

An explicit cleanup is available as:

```sh
make reset-victim
```

It refuses to remove an existing directory when the marker is missing.

`make clean` remains build-only and does not touch the victim profile or any
user data.

## Runtime paths

Normal mode keeps the inherited Haiku paths.

Victim mode redirects both:

- `BeamRadio.settings`
- `Stations/`

to the selected victim-profile directory before `RadioApp` and
`RadioSettings` are constructed.

## Visible distinction

Victim mode changes the main-window title to:

```text
BeamRadio [DEVELOPER - VICTIM]
```

The status line also displays the active profile path.

The normal application has no Victim option, Developer menu, reset item, or
persistent developer switch.

## Validation

```sh
git diff --check
make clean
make catalogs-check
make
make smoke
make run-victim
```

Inside the victim session:

- confirm the developer/victim title,
- add a test station,
- close BeamRadio normally,
- confirm files exist only below `test-state/victim`,
- run `make run-victim` again,
- confirm the station list starts empty.

Then:

```sh
make reset-victim
make smoke-gui
```

Confirm the normal application still reads its existing normal profile.

## Not changed

- no normal App-menu reset function,
- no persistent developer setting,
- no deletion from `/boot/home/config/settings`,
- no change to playback, probing, search, or station file format,
- no change to `make clean`.

## Remaining risk

The inherited normal station directory is still the generic
`settings/Stations` path. Migration to a BeamRadio-owned normal data directory
requires a separate compatibility decision and is not hidden inside this test
profile phase.
