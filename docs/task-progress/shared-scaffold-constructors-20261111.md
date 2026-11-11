# Shared scaffold constructors — 2026-11-11

## Summary before migration

- Scope: 25 real Material `Scaffold` constructors across 23 application/core
  libraries. Three `Scaffold.of` state lookups are not constructors and remain
  unchanged.
- Starting strict findings on integrated main: 686 = 148 direct controls + 538
  literal colors. The concurrent circular-progress batch removed 11 direct controls
  before this batch and is preserved, not recounted here.
- Expected findings: 658 = 120 direct controls + 538 literal colors. This is 25
  constructor replacements plus correction of 3 non-constructing `Scaffold.of`
  diagnostics; the diagnostic corrections are not source replacements.
- Publication: shared delegate, exact migration utility, tests and CI support,
  followed by source commits in parts and one expected-head update of `main`.

## Compatibility boundary

`PrimeScaffold` is a Flutter-only foundation delegate. It forwards exactly the
constructor fields used by the reviewed consumers: app bar, body, floating action
button, drawer, end drawer and background color. Omitted Material behavior keeps the
Flutter 3.41.5 defaults because the wrapper does not override those constructor fields.

The migration changes constructor ownership only. Existing app bars, drawers, keys,
bodies, navigation callbacks, colors, restoration behavior and `Scaffold.of` state
lookups remain unchanged. Complete original source hashes and exact constructor counts
must match; aliases, qualified calls, parts, symbol shadows and source drift stay
unresolved.

## Validation before publication

- All 25 constructors reconstruct the 23 original source files byte-for-byte, replay
  exactly and produce zero edits on a second full pass. Existing native compile fixtures
  reference every consumer library.
- 243 migration tests, 23 boundary tests, 7 cleanup tests and 6 dashboard-generator
  tests pass. Workflow YAML, generated shared-button checks, Dart delimiters and
  whitespace checks pass.
- Strict findings are 686 -> 658: 120 direct controls + 538 literal colors. The 28
  diagnostic reduction is 25 actual replacements plus 3 corrected read-only accessor
  diagnostics.
- Foundation widget tests compare forwarded fields, inherited Material defaults and
  both `Scaffold.of` drawer operations. They are authored but require GitHub Actions
  for native acceptance.
- Exact dispatch-head Theme Center run `43068859774` compiled all 9 app consumer
  matrices and passed the foundation suite, but Flutter core had five stale test casts:
  migrated `PrimeTextButton` widgets were still requested as SDK `TextButton`. The
  three affected test files now assert the actual shared widget type; behavior and
  application source are unchanged. Re-verification remains pending on the new head.
