# Remaining shared primitive migration — 2026-11-11

## Batch summary before migration

50 calls in 22 libraries: 23 Icon, 22 IconButton, four Text and one RichText.
Complete the compatible remaining primitive group, including narrow-import callers
that earlier conservative utilities deliberately skipped.

Move the existing PrimeIconButton into the shared foundation and retain the UI
compatibility export. Add tooltip, focus, autofocus and compact density/padding/
constraint options, forwarding the exact SDK fields. PrimeText gains optional
semanticsLabel; PrimeRichText retains exact caller spans/recognizers/alignment, inherits the active
DefaultTextStyle and MediaQuery scaler, and delegates layout to SDK RichText. Existing inherited theme/style/disabled behavior remains intact.

Whole-source hashes pin the reviewed actual callers. The clinical term highlighter
has a generated Riverpod part; pin that part's complete hash and verify it declares
none of the affected symbols. Do not loosen generic migration guards for part files.
Unchanged callback, color, rich-text span and part bytes must be verified.

Starting strict findings: 993 = 212 direct controls + 781 literal colors.
Expected after 50 actual replacements: 943 findings. Three additional PDF Text
namespace false positives are corrected separately; final expected real findings:
940 = 159 direct controls + 781 literal colors.
Publish shared support, then 11/11 source parts directly on main.

## Diagnostic correction

The PDF report generator imports package:pdf/widgets.dart as pw. Its three pw.Text
calls are PDF widgets, not Material widgets. The scanner now resolves that exact
real import before classifying qualified controls. Material aliases, comments,
unrelated namespaces and shadowed PDF alias names still fail, as regression tests
prove. The three corrected diagnostics are not counted as source replacements.

## Verified source validation

All 50 constructor replacements applied across 22 source libraries; every original
hash, exact reverse/forward byte receipt, fixed-color sequence and callback/span
argument is retained. The full utility rerun reports zero eligible edits. Pinned
Riverpod part bytes and alias-scope checks remain strict. Historical core/button
migration tests compose the exact later edits in reverse and still validate their
original hashes. Only touched trailing whitespace is included in the edit receipt.

223 migration tests, 20 boundary tests and seven import-cleanup tests pass. YAML,
Dart delimiter and whitespace checks pass. Native focus/tooltip/compact geometry,
semantics, span recognizer callbacks, actual clinical highlighter loading/empty/rich
states and all 22 public compile imports are authored and wired to CI. They remain
unexecuted locally (Flutter unavailable), not claimed as native acceptance.

Final strict findings: 940 = 159 direct controls + 781 fixed colors.
Observed decrease 53 = 50 real constructor migrations + three corrected PDF
namespace diagnostics. No fixed-color removal is claimed in this batch.

Shared rich text now gives previously unstyled spans the inherited theme foreground
and typography, with the active text scale. Explicit span styles and recognizer
objects remain intact. Native tests assert inherited color/font/1.5x scaling and
actual pointer dispatch, rather than accepting a wrapper that keeps fixed defaults.
