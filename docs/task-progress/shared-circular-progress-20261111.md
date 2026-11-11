# Shared circular progress batch — 2026-11-11

## Summary before migration

11 remaining direct circular-progress calls in app/core libraries. Route them
through one foundation renderer and make the existing UI PrimeLoadingIndicator
use the same renderer, retaining its explicit active UI primary color.

Public constructor inspected in official Flutter 3.41.5 source, the pinned CI SDK.
Preserve nullable strokeWidth so SDK/theme defaults remain inherited. Preserve
values, animations, cap, semantics, explicit colors and const/key/layout behavior.
Do not recolor explicit caller overrides; remaining color findings stay visible.

Whole original hashes and exact edits gate the utility. Source parts: 4/4 files.
Starting findings: 717 = 159 direct controls + 558 fixed colors.
Expected final: 706 = 148 direct controls + 558 fixed colors.
The one internal shared implementation delegation is support, not another finding.

## Verified source validation

11 actual replacements in eight app/core libraries. All original SHA-256 hashes
reproduce from exact reverse edits; forward/idempotence and unchanged literal-color
sequences pass. The second full utility pass has zero eligible calls. Earlier
primitive/button history checks unwind this exact later stage first, preserving
all earlier original-hash proofs; already verified input revisions are accepted
idempotently without allowing unrelated drift.

233 migration tests, 21 boundary tests and seven cleanup tests pass. YAML, native
Dart delimiter and whitespace checks pass. Native tests compare determinate and
indeterminate values, sizing, inherited SDK defaults, animation identity, stroke
cap/width, explicit colors and semantics. All eight real consumers are imported and
referenced in core/app compile fixtures. Existing UI loading-indicator tests still
verify its active PrimeTheme primary color through the shared renderer. Native
execution is pending CI, not locally accepted.

Strict findings: 717 -> 706 = 148 direct controls + 558 fixed colors. No fixed-color
removal, diagnostic reclassification, exemptions or production writes in this
batch. The existing metadata fixture precondition remains deferred to CI.

## Concurrent main integration

Main advanced from 16c87a3f to 94ed9793 with a shared-button child validation fix
in three support files. Preserve that fix and generator/test changes. During combined
review, retain the documented nullable icon convenience API: an icon variant with
null icon takes the plain-label SDK path; the non-null icon branch keeps the
validated unwrap. Native regression covers all three families, geometry and taps.
This compatibility repair is separate from the 11 progress replacement count.
All prior source receipts continue to validate after combining the changes.
