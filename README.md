# ![icon](docs/icon.png) BeamRadio

![Screenshot](docs/screenshots/05_Station_Info.png)

BeamRadio is a revival fork of StreamRadio focused on preserving and polishing a small native Haiku internet radio player.

It keeps the existing Haiku-native station/file model, improves buildability, responsiveness, error culture, and documentation, and deliberately avoids becoming a general media center.

## Status

Revival baseline in progress. Phases 0001 through 0011 established the BeamRadio identity, root build entrypoint, warning cleanup, build flag baseline, re-entry documentation, a repeatable GUI lifecycle smoke, a validated German localization path, and a structurally consistent multi-language catalog set.

Playback, station storage, and network search behavior remain intentionally unchanged by these baseline phases. Phases 0010 and 0011 change translated presentation and catalog build consistency only.

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

The root `Makefile` delegates visibly to `source/Makefile` and binds every declared catalog into `dist/BeamRadio` after each successful build. The canonical locale list lives in `source/locales/locales.mk` and is shared by both Makefiles.

Compile every catalog without changing the application binary with:

```sh
make catalogs-check
```

After editing catalog files, rebind all of them to an existing build with:

```sh
make catalogs
```

`make catalog-de` remains available for a targeted German-only rebind. Use `make help` to list the supported root targets.

For the interactive GUI lifecycle smoke, run:

```sh
make smoke-gui
```

Close the main window to complete the smoke. The application binary is written to `dist/BeamRadio`.

The catalog set is structurally synchronized. Existing translations are preserved; newly introduced keys remain in English in languages that have not yet received a linguistic update. Only the German runtime presentation has been manually validated in this revival track.

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
