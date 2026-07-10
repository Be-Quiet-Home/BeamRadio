# Phase 0008 - Re-entry documentation refresh

## Scope

Refresh the public re-entry documentation after the build baseline work.

This phase updates documentation only. It does not change source code, build
logic, runtime behavior, station handling, streaming behavior, UI behavior, or
external dependencies.

## Documentation updates

`README.md` now describes the repository-root build path:

```sh
make clean
make
make smoke
```

It also points to `make help` for the visible root build targets.

`docs/scope.md` now describes the current baseline as phases 0001 through 0007
instead of presenting the project as still being only in the identity phase.

## Reason

Phase 0003 made the repository root the build entrypoint. Phase 0007 established
the current build flag baseline and warning cleanup. The README and scope notes
needed to match that current state so future re-entry starts from the right
terminal.

## Non-goals

- no Makefile changes
- no compiler flag changes
- no warning policy changes
- no source changes
- no UI changes
- no runtime behavior changes
- no packaging work

## Validation

Run from the repository root:

```sh
git diff --check
make clean
make
make smoke
```

## What this proves

- the updated documentation is whitespace-clean
- the documented root build path remains valid
- the existing smoke test still proves that `dist/BeamRadio` exists and is executable

## What this does not prove

- runtime streaming behavior
- station search behavior
- GUI interaction quality
- packaging readiness
- Menlo Light score
