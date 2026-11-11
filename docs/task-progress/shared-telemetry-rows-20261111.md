# Shared telemetry rows — November 11, 2026

Starting main: `13669915c91a2c578329552b95d355293818f387`.
Schedule status: behind. Summary created before application.

Select all 251 identical generated telemetry/audit helper blocks: six fixed-color fact rows per library, 1,506 total. Consolidate the duplicate row renderer in shared PrimeTelemetryRow. Preserve existing text, icons, values, typography, spacing and flexible wrapping. Informational row accents use the active primary/secondary/tertiary palette in display order; the existing System Isolation status row uses success. These accent assignments are presentation roles, not new business-status assessments. Existing synthetic/template values and compliance claims are not newly verified by this migration.

Use exact full-block matching and unrestricted imports; modified helpers/panels remain untouched. Retain concurrent changes with an expected-head update. Publish support then 100/100/51-library commits on main; no branch or guard exemptions. Native CI remains pending and the wider strict backlog is open.

Validation: 186 migration tests plus 16 boundary diagnostic tests pass after preserving concurrent section-copy changes on `856b2f0db7f6a0188ac4eefe24b54879876c9d25` (202 total). All 251 libraries passed exact forward transformation, reverse byte equality, repeat-pass idempotence and existing native compile-import checks. Per-file diagnostics verify 1,506 fewer color findings. Complete utility preview returns zero eligible rows. Whitespace and new Dart delimiter checks pass.

The health fixture now uses the production shared row. Historical layout tests still compare the exact pre-consolidation panel/renderer to the pinned block, then verify the shared renderer transformation and all 251 current panels. New native tests cover row wrapping at 320px/1x/2x, live icon/text theme updates and preserved typography. Existing health tests cover original values/progress/status labels. Native tests are authored but not executed locally because Flutter SDK is unavailable; no native/visual/release acceptance is claimed.

Utility: `python3 scripts/migrate-premium-telemetry-rows.py --limit 1000` previews; add `--apply` to write. `--offset`/`--limit` select sorted library parts. Only the exact complete known helper block qualifies; altered labels/values/styles/panels, restricted imports, parts, shadowed names, strings and comments are skipped. Rollback by reverting support and adoption commits. Other strict guard findings remain open; no waivers.
