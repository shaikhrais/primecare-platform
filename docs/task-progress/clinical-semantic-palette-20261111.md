# Clinical and verification semantic theme batch — 2026-11-11

## Summary before migration

96 fixed colors across 31 libraries: 66 Clinical Director dashboard literals,
including two shadow groups, plus 30 exact Verification Audits/Compliant metric
consumers. The full remaining inventory is 1,156 findings: 877 colors + 279 controls.

Clinical meaning determines each existing role: emergency/danger/error -> error;
healthy/clear/resident -> success; caution/compliance/low stock -> warning;
brand/staffing/information -> primary; operations -> muted. Container, border,
base foreground and filled-action foreground are paired by the shared
PrimeActionPalette using existing theme slots and WCAG-readable foregrounds.
No clinical thresholds, labels, controller actions, callbacks or data are changed.
Fixed black shadows use the existing shared shadow token.

Complete original SHA-256 hashes and exact edit spans reject source drift. Preserve
all non-palette source bytes and only remove necessary const ancestors. Default dry
run, bounded offset/limit and symlink checks. Source parts: 15 and 16 libraries.
Native palette and actual quick-action behavior tests are acceptance requirements.
Expected strict findings: 1,060 = 279 direct controls + 781 literal colors.

## Verified source validation

All 96 removals applied across 31 libraries. Every original SHA-256 hash reproduces
from exact reverse edits; forward/idempotence checks and unchanged clinical branch,
threshold and callback checks pass. Shared palette slots are checked against the
actual runtime PrimeColors declaration. Strict findings: 1,156 -> 1,060.

215 migration tests pass. Native all-palette foreground contrast, actual clinical
quick-action category updates, all 31 compile imports, and existing fail-closed
clinical controller tests are wired to CI. Native execution remains pending; local
YAML, Dart delimiter and whitespace checks pass.
