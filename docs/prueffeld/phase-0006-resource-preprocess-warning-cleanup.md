# Phase 0006 - Resource preprocess warning cleanup

## Scope

This phase removes the remaining resource preprocessing warning from the
BeamRadio build.

The warning was caused by the generic Haiku makefile-engine warning preset
adding a C++-only warning suppressor to the `cc -E` resource definition
preprocess step.

## Changes

- Leave the makefile-engine warning preset blank.
- Set the explicit compiler flags to `-Wall -Wno-multichar`.
- Keep the existing optimization level unchanged.

## Validation

```sh
git diff --check
make clean
make
make smoke
````

Observed:

```text
BeamRadio: build ok: dist/BeamRadio
BeamRadio: smoke ok: dist/BeamRadio exists and is executable
```

The previous resource preprocessing warning is gone:

```text
cc1: warning: command-line option '-Wno-ctor-dtor-privacy' is valid for C++/ObjC++ but not for C
```

## Non-goals

* No optimization-level change.
* No `-Wextra` enablement.
* No `-Werror` enablement.
* No root Makefile change.
* No source-code change.
* No resource-definition change.
