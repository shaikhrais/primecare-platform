# Administrative diagnostic palette — 2026-11-11

## Summary before migration

Review the complete fixed-color group in four existing diagnostic views: health
overlay, reality check, role carousel and screenshot gallery. Use success for
ready/clear/passed; warning for incomplete/unclear/low-interaction; error for failed,
no-value/zero-interaction; primary for ordinary information; secondary for duplicate/
false-progress and visual-quality categories; muted for neutral initialization.

These are existing theme slots, not new business classifications. Shared
PrimeActionPalette gains secondary/secondaryContainer pairing. Status surfaces and
foregrounds use matched readable pairs. Scrim and shadow use their active Material
theme tokens; transparent fills retain zero alpha. Preserve thresholds, readiness,
filters, routing, metadata, callbacks, labels and badge geometry.

Pin four original whole-file hashes and exact edits; only necessary const ancestors
are removed. Source commits: two/two libraries. Every actual view must compile;
exact private status-helper fixtures validate palette/state/contrast behavior.
Starting findings: 940 = 159 direct controls + 781 literal colors.

## Compositing detail

The gallery header used a white icon under a shader with two identical theme-color
stops. Replace that exact redundant ShaderMask with a direct icon in the same
resolved theme color. White is the multiplicative identity in this shader; changing
its mask to a dark foreground would alter the visible color. Source regression
checks prove the two old stops match the new icon color, preserving size/appearance.

## Verified source validation

81 actual fixed-color removals across four views. All original SHA-256 hashes,
exact reverse/forward edits, idempotence, source-only edit boundaries and private
status-helper fixture parity pass. Foregrounds pair with actual decoration color,
not a border's tint. The second utility pass reports zero eligible edits.

227 migration tests, 20 boundary tests and seven import-cleanup tests pass. Native
fixtures cover real purpose/health helper branches, every theme preset and 1x/2x
text scaling with 4.5 contrast and retained padding/labels. All four actual views
are imported/referenced by native compile tests. Native execution remains pending.
YAML, Dart delimiter and whitespace checks pass. Existing enum ordinal order is
preserved; the new secondary role is appended.

Role Carousel localization validates 69 keys and parameter agreement in en/es/fr.
The separate admin-reality metadata registration check could not run locally because
its historical SQLite test fixture is absent. Existing CI prepares the isolated
fixture; this local precondition failure is not claimed as a passing registration
check. No operational database was recreated or production registration changed.

Strict findings: 940 -> 859 = 159 direct controls + 700 fixed colors.
