# Reference capture evidence

This isolated job renders the separately supplied Fuse settings panel, without
production credentials or activation. It captures desktop/tablet/mobile in light
and dark modes plus desktop palette editors and computed measurements.

These captures demonstrate the reference settings only. They do not demonstrate
complete dashboard application parity. The supplied skeleton has no dashboard
application implementation. Compare like-for-like regions; do not calculate a
pixel score between a component gallery and a settings panel.

The companion kitchen-sink job records six actual browser captures of all 36 web
examples. Both jobs must pass for the same reviewed commit before using captures
as current evidence. Record remaining differences explicitly, including fonts,
spacing, palette, layout, responsive overflow and unavailable reference views.

## Full-shell proof (task 6/200)

The isolated `surface=shell` host mounts original Layout1/2/3 with the original
navbar/navigation/quick-panel/dialog/i18n providers and a local guest hook. It
does not add business routes, production identities, APIs or permissions. The
original vendor layout/component bytes are unchanged. `shell-capture.mjs`
captures 18 complete viewports and records shell region boxes, page errors and
blocked external requests. It fails if any case fails. The artifact is separate
from the 42 Theme Center pairs. Capturing a guest reference shell does not prove
matching an authenticated native host; task 7 and state alignment remain open.
Local Chromium launch is blocked by the execution environment; cloud capture
must succeed before task 6 is marked verified.

## Actual native host fixture (task 7/200 partial)

`skeleton_shell_capture_test.dart` renders GovernanceMasterLayout across 18
layout/device/mode cases. It records region boxes and image resource failures,
using an empty authorized-module set and the existing synthetic capture account.
It never imports a new runtime route or grants production authority. It is an
actual host renderer, but its state is not yet aligned with the guest reference.
Avatar/network image failures are retained in JSON; captures with those failures
must not count as visual passes. Cloud artifact: primecare-full-shell-fixture.
