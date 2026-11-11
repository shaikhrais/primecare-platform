# Live dispatch semantic palette — 2026-11-11

## Summary before migration

- Scope: `live_dispatch_map.dart`, one shared screen with 20 fixed colors.
- Starting strict findings: 717 = 159 direct controls + 558 literal colors.
- Expected findings: 697 = 159 direct controls + 538 literal colors.
- Publication: support/verification commit, then one source commit, followed by one
  expected-head update of `main`.

## Grounded role mapping

- Delayed visits use the existing warning accent, surface, border and readable text.
- Pending shifts use the existing error surface and readable text.
- Online and confirmed assignment use success; ordinary map telemetry uses primary.
- Dark map labels use inverse surface/inverse text; marker glyphs use the readable
  foreground paired with their actual warning or primary fill.
- Map/grid transparency derives from the active surface, and shadows use the active
  Material shadow token with the original alpha.

No visit status, severity, filtering, coordinates, assignment callback, telemetry,
labels, spacing, opacity or geometry changes. The migration requires the complete
reviewed source hash and exact source fragments; any source drift remains unresolved.

## Validation before publication

- 20 exact fixed-color findings removed; reverse reconstruction matches the original
  source SHA-256 and a second full utility pass has zero eligible edits.
- 234 migration tests, 20 boundary regressions, 7 cleanup tests and 6 dashboard
  generator tests pass. Shared-button generation, workflow YAML and whitespace checks
  pass.
- The strict scan is 717 -> 697: 159 direct controls + 538 literal colors. The gate
  remains intentionally failing on the real backlog.
- Theme Center now runs the actual dispatch widget across every palette, checking
  delayed/pending contrast, inverse labels and primary/success assignment behavior.
  This Flutter test is authored but requires GitHub Actions for native acceptance.

