# ![icon](docs/icon.png) BeamRadio

![Screenshot](docs/screenshots/05_Station_Info.png)

BeamRadio is a revival fork of StreamRadio focused on preserving and polishing a small native Haiku internet radio player.

It keeps the existing Haiku-native station/file model, improves buildability, responsiveness, error culture, and documentation, and deliberately avoids becoming a general media center.

## Status

Revival baseline in progress. Phases 0001 through 0009 established the BeamRadio identity, root build entrypoint, warning cleanup, build flag baseline, re-entry documentation, and a repeatable GUI lifecycle smoke.

Playback, station storage, search behavior, and visible UI behavior remain intentionally unchanged by these baseline phases.

## Build

On Haiku, install the required development package first:

```sh
pkgman install devel:libxml2
```

Then build from the repository root:

```sh
make clean
make
make smoke
```

The root `Makefile` delegates visibly to `source/Makefile`. Use `make help` to list the supported root targets.

For the interactive GUI lifecycle smoke, run:

```sh
make smoke-gui
```

Close the main window to complete the smoke. The application binary is written to `dist/BeamRadio`.

## Scope

BeamRadio is a small native Haiku application for finding, saving, and listening to internet radio stations.

Non-goals for the revival track:

- no Qt, GTK, Electron, or foreign desktop framework
- no general media-center scope
- no BeTuned integration before a later explicit decision
- no Deskbar, Replicant, or mini-mode feature work before the base app is calm
- no migration from existing StreamRadio settings in the identity phase

## Origin

BeamRadio is forked from HaikuArchives StreamRadio, originally created by Fishpond and maintained by HaikuArchives contributors. See `docs/provenance.md` for the current provenance and license boundary.

More info in the [BeamRadio user guide](docs/userguide.md).
