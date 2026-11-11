# Premium semantic accent batch — 2026-11-11

## Batch summary before migration

- Scope: 251 generated `PremiumFeature` libraries.
- Planned replacements: 2,259 literal colors (nine exact consumers per library).
- Commit parts: 100 libraries, 100 libraries, 51 libraries.
- Starting strict findings: 4,246 total = 731 direct controls + 3,515 literal colors.
- Expected strict findings after this batch: 1,987 total = 731 direct controls + 1,256 literal colors.

## Existing semantic roles used

The batch does not map colors by numeric similarity. It recognizes the complete,
unchanged generated call signatures and their labels:

- API Request Latency, Trigger Audit, and Telemetry Session Start use `primary`.
- Data Ingestion Rate, Sync Schema, and Prisma Client Hydration use `success`.
- Governance Violations, the audit panel, and Export Logs use `warning`.

These roles are already established in the premium template migrations: telemetry
informational accents use `primary`, healthy/positive state uses `success`, and
governance/audit attention uses `warning`.

## Safety and acceptance

- The utility is dry-run by default and supports deterministic offset/limit parts.
- All nine exact calls, the owning `PremiumFeature`, immutable `context.theme`
  binding, imports, and unchanged local helpers must qualify together.
- Modified labels, values, callbacks, icons, helper implementations, imports,
  owners, parts, aliases, shadows, comments, and qualified calls remain unresolved.
- Source round-trip, idempotence, strict scan, Python regressions, compile imports,
  and native all-palette behavior are acceptance requirements.
- Native Flutter execution is delegated to GitHub Actions; authored tests are not
  runtime acceptance until the exact-head jobs complete.

## Local source validation

- 2,259 exact substitutions applied across all 251 libraries.
- All 251 libraries reproduce byte-for-byte from reconstructed pre-migration
  callers; the second full utility pass reports zero eligible edits.
- Existing native compile fixtures import all 251 migrated libraries.
- 229 Python tests pass: 200 migration, 16 boundary, 7 cleanup, 6 generator.
- Workflow YAML parses, new Dart fixture/test delimiters balance, and whitespace
  validation passes.
- Strict findings are 1,987 = 731 direct controls + 1,256 literal colors.
