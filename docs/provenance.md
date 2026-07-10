# BeamRadio Provenance

## Origin

BeamRadio is a Be-Quiet-Home revival fork of HaikuArchives StreamRadio.

Original project purpose:

> A native Haiku application to search for and listen to internet radio stations.

Original authors and maintainers visible in the inherited source include Fishpond, Humdinger, Jacob Secunda, Javier Steinaker, the HaikuArchives team, and file-local contributors recorded in source headers.

## Fork decision

The fork exists to make the project buildable, calm, documented, and maintainable under the BeamRadio identity.

The fork is not intended to erase StreamRadio history. It keeps inherited authorship and records Be-Quiet-Home changes as revival work.

## License boundary

Most inherited project-owned source files declare GPL-3.0-or-later terms in their file headers.

Some inherited files carry different file-local licensing or provenance notes, including MIT-style headers and Haiku Inc. copyright notices.

Current rule:

- Keep all inherited file headers intact.
- Treat the combined application as GPL-3.0-or-later unless a later legal review documents a narrower or more precise distribution boundary.
- Do not remove attribution while adopting BeamRadio identity.
- Do not copy additional upstream code, assets, or examples into the project without updating this file.

## Phase 0001 changes

Phase 0001 changes project identity only:

- application name becomes BeamRadio,
- binary target becomes `dist/BeamRadio`,
- application signature becomes `application/x-vnd.be-quiet-home-beamradio`,
- settings file becomes `BeamRadio.settings`,
- resource definition file becomes `BeamRadio.rdef`,
- source strings and catkeys are aligned to BeamRadio,
- README and user guide describe BeamRadio as a revival fork.

Behavior intentionally unchanged:

- playback model,
- station file model,
- search providers,
- UI structure,
- network behavior,
- station directory behavior,
- no StreamRadio settings migration.

## Known inherited areas needing later review

- private Haiku headers / BPrivate network boundary,
- synchronous network work from visible UI paths,
- station save behavior that rewrites the station directory,
- clipboard text handling,
- duplicate station loading in `B_REFS_RECEIVED`,
- flag-clearing expressions using `!FLAG` instead of `~FLAG`,
- old localization catalog state.
