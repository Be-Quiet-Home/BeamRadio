# Phase 0009 - GUI lifecycle smoke

## Scope

Add a repeatable interactive smoke target for the existing BeamRadio GUI lifecycle.

This phase does not change application source code, UI behavior, station handling,
streaming behavior, localization, settings behavior, or external dependencies.

## Observed local baseline

The first local runtime probe established the following behavior:

- `make help` reports the repository-root targets.
- `./dist/BeamRadio` starts the application and creates a Deskbar entry.
- On first start, BeamRadio reports that a station settings directory was created.
- The main window opens without an observed BeamRadio runtime error.
- Closing the main window removes the Deskbar entry.
- The process exits and control returns to the Terminal.

The same run also exposed product findings that are not changed in this phase:

- visible UI text was not localized,
- Help and service-homepage actions open external web pages,
- browser console messages from those pages are not BeamRadio lifecycle failures,
- in-application station search results were not yet proven by this smoke.

## Root target

The repository root provides:

```sh
make smoke-gui
```

The target builds BeamRadio, launches `dist/BeamRadio`, waits for the application
to exit, and reports success after the main window has been closed cleanly.

This is intentionally interactive. It does not add a timeout, background process,
automated window control, or hidden process management.

## Manual observation

While `make smoke-gui` is running, verify:

1. The main window opens.
2. A Deskbar entry exists while the application is running.
3. The main window can be closed normally.
4. The Deskbar entry disappears.
5. The target returns to the Terminal and prints the success line.

## Validation

Run from the repository root:

```sh
git diff --check
make clean
make
make smoke
make smoke-gui
```

## What this proves

- the root build entrypoint still works,
- the built application can be launched interactively,
- closing the main window ends the application process cleanly,
- the root smoke workflow can reproduce the lifecycle check.

## What this does not prove

- German or other catalog availability,
- station search success,
- station list download or bulk import behavior,
- stream playback,
- external website correctness,
- absence of browser-side console messages,
- GUI dignity or Menlo Light score.
