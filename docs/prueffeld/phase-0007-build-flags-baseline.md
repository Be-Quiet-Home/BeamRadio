# Phase 0007 - Build flags baseline

## Scope

This phase makes BeamRadio's project-owned build flags explicit and enables a
stricter warning baseline without changing runtime behavior.

It also adds the local patch-file workflow directory to `.gitignore` so
assistant-provided patches can be stored in the repository root without becoming
source-tree dirt.

## Local makefile-engine authority

The local Haiku makefile-engine was inspected before changing optimization
flags.

Observed mapping:

```text
OPTIMIZE = FULL -> -O3
OPTIMIZE = SOME -> -O1
OPTIMIZE = NONE -> -O0
empty OPTIMIZE -> -O3
```

There is no makefile-engine-provided `-O2` symbol.

## Decision

BeamRadio now uses:

```makefile
OPTIMIZE = NONE
COMPILER_FLAGS = -O2 -Wall -Wextra -Wno-multichar
```

The generated compiler command contains the makefile-engine's `-O0` followed by
the project-owned `-O2` from `COMPILER_FLAGS`.

This is intentional for this phase:

```text
-O0 ... -O2 -Wall -Wextra -Wno-multichar
```

The project-owned optimization flag appears later in the command line and is the
visible BeamRadio baseline. Do not reinterpret `OPTIMIZE` as an `-O2` provider
without re-checking the local makefile-engine.

## Warning cleanup

After enabling `-Wextra`, the newly visible mechanical warnings were cleaned:

- unused parameters in override or callback signatures were left unnamed where
  the body does not need them;
- the `StreamIO` redirect `else` branch was braced explicitly;
- the private `BAdapterIO` copy constructor now initializes its base class and
  members even though copying remains unavailable.

## Patch workflow hygiene

The local patch directory is ignored:

```gitignore
/patches/
```

This directory is only for downloaded assistant patches and must not be
committed.

## Validation

```sh
git apply --check patches/beamradio-phase-0007-wextra-cleanup-verified.patch
git apply patches/beamradio-phase-0007-wextra-cleanup-verified.patch
git diff --check
git diff --stat
make clean
make
make smoke
```

Observed diffstat after applying the verified cleanup patch:

```text
.gitignore                 |  1 +
source/AdapterIO.cpp       |  9 ++++++++-
source/HttpUtils.cpp       |  2 +-
source/Makefile            |  4 ++--
source/RadioApp.cpp        |  2 +-
source/StationListView.cpp |  6 +++---
source/StationPanel.cpp    |  4 ++--
source/StreamIO.cpp        | 14 +++++++++-----
8 files changed, 27 insertions(+), 15 deletions(-)
```

Observed:

```text
BeamRadio: build ok: dist/BeamRadio
BeamRadio: smoke ok: dist/BeamRadio exists and is executable
```

The validated build output shows no remaining `-Wextra` warnings from the cleaned
files.

## Non-goals

* No `-Werror` enablement.
* No performance tuning beyond selecting the generic `-O2` baseline.
* No local `-march=native` or host-specific CPU floor.
* No makefile-engine copy or replacement.
* No stream, station list, station panel, HTTP, or media behavior change.
* No UI change.
