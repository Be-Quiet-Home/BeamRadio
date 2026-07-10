# Phase 0004 - StationFinder const correctness

## Scope

This phase fixes StationFinder const-correctness for read-only service and
capability names.

It removes compiler warnings caused by passing string literals to APIs that
declared read/write `char*` parameters.

## Changes

- Change StationFinder service registration names from `char*` to `const char*`.
- Store registered service names as `const char*`.
- Return service names as `const char*`.
- Change search capability names, keyword strings, and delimiters to `const char*`.
- Update the local selected-service variable to `const char*`.

## Validation

```sh
make clean
make
make smoke
git diff --check
````

Observed:

```text
BeamRadio: build ok: dist/BeamRadio
BeamRadio: smoke ok: dist/BeamRadio exists and is executable
```

The previous StationFinder string-literal warnings are gone.

Known remaining warnings are outside this phase:

```text
StreamIO.cpp signed/unsigned comparisons
StreamIO.cpp pointer-addition NULL comparison
resource preprocessing receives a C++-only warning flag
```

## Non-goals

* No StationFinder behavior changes.
* No search-provider logic changes.
* No StreamIO changes.
* No Makefile changes.
* No UI changes.
* No locale changes.
