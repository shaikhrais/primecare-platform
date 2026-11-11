# Generated source repair and theme batch — 2026-11-11

## Summary before migration

Three generated libraries contain an unescaped apostrophe in the exact client
summary label. The Dart string is invalid and the conservative theme parser rejects
the file. Repair that exact source defect, then use the existing generated palette
utility for 72 reviewed substitutions per file. Bind each Target Role heading to
onSurface as established by 829 sibling headings. Preserve displayed text and data.
Support and three source changes will be separate main commits.

Whole-file SHA-256 manifests reject other source revisions. Dry run is the default;
symlink containment and offset/limit apply. Original source fixtures preserve exact
regressions. Native compile imports and theme tests run through GitHub Actions.
No native execution is claimed from source/delimiter tests.

## Verified source results

Three invalid strings repaired; 219 theme substitutions (73 per library).
All original fixtures reproduce exact final source, all modified-source safeguards
and idempotence checks pass. All 207 migration regressions and 16 boundary tests
pass; seven import cleanup tests pass. YAML, delimiters and whitespace pass.
The three actual classes are imported/referenced by a new native compile test.
Native Flutter execution remains queued, not locally accepted.

Strict scan: 1,856 -> 1,763 = 731 direct controls + 1,032 literal colors.
The observed decrease is 93, not 219: the malformed apostrophe previously hid 126
later literals from the lexical scanner. After syntax repair all 219 literals are
visible and removed. No strict exemptions were introduced.
