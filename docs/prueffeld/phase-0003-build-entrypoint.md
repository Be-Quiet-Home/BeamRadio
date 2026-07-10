# Phase 0003 - Build entrypoint

## Scope

This phase adds a repository-root Makefile for BeamRadio.

The root Makefile is the project entrypoint. It delegates visibly to the
inherited provider Makefile in `source/`.

## Purpose

BeamRadio previously built from `source/`, but the repository root had no
Makefile. That made the build entrypoint unclear.

Quietcode projects build from the repository root with `make`.

## Changes

- Add root `Makefile`.
- Keep the inherited `source/Makefile` unchanged.
- Add visible build delegation.
- Add root targets:
  - `make`
  - `make build`
  - `make clean`
  - `make smoke`
  - `make help`

## Validation

```sh
make clean
make
make smoke
make help
git diff --check
````

## Non-goals

* No rewrite of `source/Makefile`.
* No change to compiler flags.
* No change to link libraries.
* No change to app identity.
* No packaging changes.
* No playback, UI, networking, station, or locale changes.
