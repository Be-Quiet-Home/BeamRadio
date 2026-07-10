# ![icon](docs/icon.png) BeamRadio

![Screenshot](docs/screenshots/05_Station_Info.png)

BeamRadio is a revival fork of StreamRadio focused on preserving and polishing a small native Haiku internet radio player.

It keeps the existing Haiku-native station/file model, improves buildability, responsiveness, error culture, and documentation, and deliberately avoids becoming a general media center.

## Status

Early revival fork. The first project phase adopts the BeamRadio identity and documents the fork boundary without changing playback, station storage, search behavior, or UI behavior.

## Build

On Haiku, install the required development package first:

```sh
pkgman install devel:libxml2
```

Then build from the source directory:

```sh
cd source
make clean
make
```

The application binary is written to `dist/BeamRadio`.

## Scope

BeamRadio is a small native Haiku application for finding, saving, and listening to internet radio stations.

Non-goals for the revival track:

- no Qt, GTK, Electron, or foreign desktop framework
- no general media-center scope
- no BeTuned integration in the identity phase
- no Deskbar, Replicant, or mini-mode feature work before the base app is calm
- no migration from existing StreamRadio settings in the identity phase

## Origin

BeamRadio is forked from HaikuArchives StreamRadio, originally created by Fishpond and maintained by HaikuArchives contributors. See `docs/provenance.md` for the current provenance and license boundary.

More info in the [BeamRadio user guide](docs/userguide.md).
