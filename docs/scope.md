# BeamRadio Scope

## Purpose

BeamRadio is a revival fork of StreamRadio focused on preserving and polishing a small native Haiku internet radio player.

The project keeps the existing Haiku-native station/file model, improves buildability, responsiveness, error culture, and documentation, and deliberately avoids becoming a general media center.

## Current status

Phases 0001 through 0011 establish the BeamRadio identity, root build entrypoint, warning cleanup, project-owned build flag baseline, re-entry documentation, GUI lifecycle smoke, a validated German localization path, and a structurally consistent multi-language catalog set.

Playback, station storage behavior, and network search behavior are intentionally unchanged by these baseline phases. Phases 0010 and 0011 change translated presentation and catalog build consistency only.

## Goals

- Keep a small native Haiku application for finding, saving, and listening to internet radio stations.
- Preserve the existing station-as-file model and BFS attribute direction.
- Keep Haiku-native UI and system behavior as the default path.
- Restore a clean, buildable, documented project baseline.
- Keep every declared localization catalog structurally bindable from one canonical locale list.
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
- Linguistic review of the non-German catalogs beyond structural consistency and English fallback entries.
