# Phase 0005 - StreamIO warning cleanup

## Scope

This phase fixes compiler warnings in `StreamIO.cpp`.

It keeps the streaming, buffering, metadata, and synchronization behavior
unchanged.

## Changes

- Make the `ReadAt()` limit comparison explicit across `off_t` and `size_t`.
- Convert metadata byte counts to `size_t` before passing them to byte-oriented
  operations.
- Make metadata-start byte count handling explicit before forwarding stream data.
- Make the unsynchronized frame scan comparison explicit.
- Replace a meaningless pointer-addition NULL check with a check of the regex
  match result and the resulting metadata text.

## Validation

```sh
git diff --check
make clean
make
make smoke
````

Observed:

```text id="sir6r8"
BeamRadio: build ok: dist/BeamRadio
BeamRadio: smoke ok: dist/BeamRadio exists and is executable
```

The previous `StreamIO.cpp` signed/unsigned comparison warnings are gone.

The previous pointer-addition NULL comparison warning is gone.

Known remaining warning outside this phase:

```text id="sf9qkd"
cc1: warning: command-line option '-Wno-ctor-dtor-privacy' is valid for C++/ObjC++ but not for C
```

## Non-goals

* No stream behavior change.
* No metadata parser redesign.
* No buffering change.
* No player behavior change.
* No Makefile or compiler-flag change.
* No resource preprocessing change.
