# Phase 0014 - Stop on terminal decoder read failure

## Goal

Stop a failing radio stream after the first terminal decoder read error instead
of repeatedly asking the media decoder for frames and flooding the terminal
with identical `BMediaTrack::ReadFrames` errors.

## Runtime finding

A BBC stream reached a terminal decoder state and repeatedly printed:

```text
BMediaTrack::ReadFrames: decoder returned error 0x80004007 (Last buffer)
```

BeamRadio's sound callback ignored the return value from `ReadFrames()` and
continued requesting audio indefinitely.

## Change

The audio callback now:

- checks the `ReadFrames()` result,
- fills the requested output buffer with silence after a terminal error,
- reports the first failure only once,
- sends a `BMessage` to the main-window looper,
- returns immediately on any later callback while shutdown is pending.

The callback does not stop or delete `BSoundPlayer` itself. The main window
handles the notification and uses the existing `_TogglePlay()` path. This
keeps these states consistent:

- `StreamPlayer`,
- station-list play/stop state,
- station-panel volume state,
- `fActiveStations`.

## UI observation recorded for the next phase

Double-clicking a station is an acceptable Haiku activation gesture and may
remain available.

The inherited list also contains 16-pixel play/stop resources, but they are
small and easy to miss inside the station artwork. The vertical control in the
station panel is the volume slider; it is enabled only while the selected
station is playing and has no visible label.

These are discoverability and layout issues for Phase 0015. They are not mixed
into this decoder-lifetime phase.

## Validation

```sh
git diff --check
make clean
make catalogs-check
make
make smoke
make run-victim
```

In victim mode:

1. search for and add a station that previously reached `Last buffer`,
2. start playback,
3. wait for the decoder failure,
4. confirm only one BeamRadio decoder-failure line is printed,
5. confirm repeated `BMediaTrack::ReadFrames` lines stop,
6. confirm the station returns to its stopped state,
7. start another working station and stop it normally.

Then:

```sh
make reset-victim
make smoke-gui
```

## Not changed

- no playback-control redesign,
- no new user-visible or translated string,
- no play/stop resource replacement,
- no volume-slider layout change,
- no decoder retry or stream reconnection policy,
- no changes to station search or probe behavior.

## Remaining risk

Some corrupt or intermittently damaged streams may still need a bounded retry
or reconnect policy. This phase treats every non-`B_OK` media-track read result
as terminal because the inherited implementation has no deterministic recovery
contract.
