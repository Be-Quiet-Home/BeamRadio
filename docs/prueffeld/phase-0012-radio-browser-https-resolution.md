# Phase 0012 - Radio Browser HTTPS resolution

## Goal

Restore the inherited Community Radio Browser search path before changing
its threading or UI ownership model.

## Initial runtime finding

The search window remained responsive, but searches for `Deutschlandfunk`
and `BBC` returned no stations.

The terminal reported a server connection using a numeric HTTPS URL:

```text
Connected to server: https://91.98.4.78/
```

This proved only that the resolved address accepted a TCP connection. It did
not prove that the following HTTPS request could use that numeric address.

## Cause

`HttpUtils::CheckPort()` had two HTTPS-specific faults:

- URLs without an explicit port were always checked on port 80.
- The returned URL replaced the DNS hostname with the reachable IP address.

The following HTTP request therefore used HTTPS against a numeric address,
where the certificate and virtual-host identity belong to the DNS hostname.
The request failed quickly and the station finder returned no results.

## Change

`HttpUtils::CheckPort()` now:

- uses port 443 as the implicit HTTPS port,
- keeps the original hostname and URL for HTTPS after connectivity was proven,
- preserves the inherited reachable-IP behavior for plain HTTP.

## Validation

Repository checks:

```sh
git diff --check
make clean
make catalogs-check
make
make smoke
```

Runtime searches used the Community Radio Browser name capability with:

```text
Deutschlandfunk
BBC
```

Observed after the change:

- the terminal reported `https://all.api.radio-browser.info/`,
- several Deutschlandfunk and BBC results appeared quickly,
- the result details were populated,
- one BBC station could be added and played,
- BeamRadio remained usable and exited normally.

No visible search-window stall was observed. The requests completed too
quickly on the test system and fibre connection to prove that the synchronous
search path is harmless under slower or failing network conditions.

## Additional runtime findings

The wider runtime test exposed separate inherited boundaries that are not
part of this phase:

- some Radio Browser entries fail the station probe and cannot be added,
- AAC and MPEG-TS streams can produce decoder and packet warnings,
- after a decoder reaches its last buffer, repeated `ReadFrames` errors can
  flood the terminal,
- the station detail text controls are too narrow for realistic metadata,
- opening a station website can produce browser-side font, CORS, and script
  messages that do not originate in BeamRadio playback.

These findings remain follow-up work and do not invalidate the restored
Radio Browser search path.

## User-data boundary

`make clean` remains limited to generated build output. It must not remove
saved stations or BeamRadio preferences.

BeamRadio currently stores `BeamRadio.settings` and a `Stations` directory in
the user's Haiku settings directory. Test-state cleanup therefore needs an
explicit, isolated application-data boundary before any automated reset target
can be considered.

## Not changed

- no worker thread,
- no UI ownership change,
- no station probe or playback change,
- no Radio Browser API endpoint change,
- no station detail layout change,
- no user-data cleanup target,
- no listenlive.eu runtime test,
- no general replacement of the inherited network stack.

## Remaining risk

The search call still runs synchronously on the station finder window looper.
Its practical impact remains unproven for slow, failing, or deliberately
delayed network conditions.

The next smallest playback brick is to stop repeated decoder reads after a
terminal media error or last-buffer condition.
