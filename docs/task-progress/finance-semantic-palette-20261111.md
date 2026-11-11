# Finance and regional operations palette — 2026-11-11

## Summary before migration

142 fixed colors in 12 existing finance/regional views: billing console, financial
performance, branch operations, region dashboard/performance, cash flow,
profitability, revenue tracker, tax remittance, invoices, financial overview and
business overview. Starting strict findings: 859 = 159 controls + 700 colors.
Expected final: 717 = 159 controls + 558 colors.

Reviewed meaning determines existing roles: reconciled/paid/positive/healthy uses
success; overdue/negative/critical uses error; pending/attention uses warning;
ordinary information uses primary; comparison/finance categories use secondary;
draft/neutral/range copy uses muted. Teal profitability above threshold is success;
teal caregiver-hour information is primary. No nearest-hex mapping.

Bind filled-action foregrounds to onAccent, status/container foregrounds to their
actual paired surfaces, and ordinary foregrounds to onBase. Existing Color-variable
badges retain their branches; shared tintSurface/onTint pair actual painted colors
and readable foregrounds. Scrim/shadow tokens retain original opacity/geometry.
No financial values, thresholds, classifications, callbacks or providers change.

Whole-file SHA-256 and exact edits reject source drift. Every edit is in a method
with an actual BuildContext parameter. Dry run, deterministic offset/limit and
symlink containment precede 6/6-library source commits directly on main.

## Verified source validation

142 literal-color removals applied in 12 libraries. All original whole-file SHA-256
hashes reproduce from exact reverse edits; forward/idempotence, unchanged non-style
source and strict-count parity checks pass. A full second pass has zero eligible
edits. Three touched trailing-whitespace removals are explicit in the receipt.
Native fixture blank-line indentation is normalized; helper code and caller fields
remain identical to the actual source classes.

Shared tintSurface/onTint compute the actual opaque blended background and its
readable foreground, including mid-gray/custom surfaces. Native tests cover every
palette at 1x/2x scaling, eleven exact metric/filter helpers, the exact tax-ledger
status chip and filter callback dispatch. All 12 actual source libraries are
imported/referenced by a compile fixture. Native execution is pending CI, not local
acceptance. Existing backend values, comparisons and controller actions are intact.

230 migration tests, 20 boundary tests and seven cleanup tests pass. YAML, Dart
delimiter and whitespace checks pass. Strict findings: 859 -> 717 = 159 direct
controls + 558 literal colors. No diagnostic reclassification or exemptions in this
batch. The earlier local registration-check fixture precondition is unchanged;
this batch does not write production registrations or create an operational DB.
