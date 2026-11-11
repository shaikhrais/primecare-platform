# Shared text fields — 2026-11-11

## Summary before migration

- Scope: 19 real Material `TextField` constructors across 12 reviewed application
  and core libraries.
- Starting strict findings: 658 = 120 direct controls + 538 literal colors.
- Expected findings: 639 = 101 direct controls + 538 literal colors.
- Publication: shared delegate, exact migration utility, source receipts and native
  tests, then consumer commits in parts and one expected-head update of `main`.

## Compatibility boundary

`PrimeTextField` is a Flutter-only foundation delegate pinned to the used Flutter
3.41.5 constructor surface. It forwards the exact fields present in these consumers:
key, controller, focus node, decoration, keyboard type, max lines, max length,
enabled, autofocus, obscuring, change callback and submit callback. All other SDK
behavior stays at the Material defaults because the wrapper does not override it.

The caller key is attached to the actual inner `TextField`, preserving existing
finder, focus and state identity. Controllers, drafts, validation-independent input,
callbacks, input decorations and theme resolution are unchanged. Complete source
hashes and exact constructor counts must match; aliases, parts, shadows, qualified
calls, concrete types and source drift stay unresolved.

## Validation before publication

- All 19 constructor edits reconstruct the 12 original source files byte-for-byte,
  replay exactly and produce zero edits on a second full pass. Two inherited trailing
  spaces are separately reversible in the source receipts.
- 248 migration tests, 24 boundary tests, 7 cleanup tests and 6 dashboard-generator
  tests pass. Existing native compile fixtures reference every consumer library;
  generated-button, workflow YAML and whitespace checks pass.
- Strict findings are 658 -> 639: 101 direct controls + 538 literal colors. All 19
  removals are actual constructor replacements.
- Foundation widget tests verify the actual keyed inner input, controller/focus
  identity, callbacks, keyboard options, theme updates, disabled state and retained
  draft. They are authored but require GitHub Actions for native acceptance.
