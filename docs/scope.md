# BeamRadio Scope

## Purpose

BeamRadio is a revival fork of StreamRadio focused on preserving and polishing a small native Haiku internet radio player.

The project keeps the existing Haiku-native station/file model, improves buildability, responsiveness, error culture, and documentation, and deliberately avoids becoming a general media center.

## Current status

Phases 0001 through 0007 establish the BeamRadio identity, root build entrypoint, warning cleanup, and project-owned build flag baseline.

Playback, station storage behavior, search behavior, and visible UI behavior are intentionally unchanged by these baseline phases.

## Goals

- Keep a small native Haiku application for finding, saving, and listening to internet radio stations.
- Preserve the existing station-as-file model and BFS attribute direction.
- Keep Haiku-native UI and system behavior as the default path.
- Restore a clean, buildable, documented project baseline.
- Improve responsiveness and error culture in later small phases.
- Treat external, private, or fragile API use as a documented boundary.

## Non-goals

- No Qt, GTK, Electron, or foreign desktop framework.
- No general media-center scope.
- No BeTuned integration before a later explicit decision.
- No Deskbar, Replicant, or mini-mode feature work before the base app is calm.
- No migration from existing StreamRadio settings in the identity phase.
- No database replacement of the station-file model without a later explicit decision.
- No broad architecture rewrite hidden inside identity or safety phases.

## First useful version

The first useful BeamRadio version should:

- build cleanly on current Haiku,
- launch as BeamRadio,
- keep user-visible identity and application signature consistent,
- create and use BeamRadio settings without relying on StreamRadio settings migration,
- preserve existing playback and station-management behavior,
- document known inherited debt instead of hiding it.

## Deliberately postponed

- Settings migration from StreamRadio.
- True asynchronous station search/probe boundaries.
- Deskbar integration.
- Replicant or mini-mode.
- Packaging / HaikuDepot candidate work.
- Full localization refresh.
