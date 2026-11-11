# Shared primary actions — November 11, 2026

Starting main: `e273cbf3` (concurrent core-barrel text migration preserved).
Schedule status: behind. Summary created before application.

Select 173 primary button invocations across 130 shared feature/screen libraries. Existing generated buttons already use the active primary background but override label color with literal white. Extend the existing conservative primary-action utility to recognize both Text and PrimeText labels and scan shared feature/screen libraries as well as apps.

Only exact primary-token/radius-eight/white-only-label signatures qualify. Existing PrimeButton takes ownership of readable foreground, typography, radius, focus and disabled states. Keys, label/translation expressions, callback expressions and enclosing layout/test selectors remain. This deliberately adopts shared button defaults; visual/layout acceptance remains required. No callback is executed by the migration.

Publish support and tests, then 100/30-library parts in one protected main update; no branch. Current full strict scan at this starting source finds 9,765 violations. Do not waive the guard or count all outstanding findings as fixed. Prior badge Theme Center run was cancelled externally and no green native acceptance is claimed; no validations are cancelled by this work.

Validation: 178 migration tests plus 16 boundary tests passed (194 total). All 130 libraries passed exact forward transformation and repeat-pass idempotence, with 173 new shared calls and 173 fewer literal-color diagnostics. All 130 libraries already have imports in the native compile fixtures. Complete utility preview now returns zero eligible calls. Whitespace checks pass. Existing theme_consumers_test.dart covers shared primary-button palette contrast, callbacks and disabled styling; it remains queued for current native CI. Local Flutter SDK is unavailable, so no native, deployed or visual acceptance is claimed.

Run `python3 scripts/migrate-shared-primary.py` to preview; add `--apply` to write. Modified styles, extra label options, qualified labels, shadowed symbols, unsupported signatures, comments and strings are rejected. Existing guard remains strict; no exemptions. Rollback is to revert the source adoption and utility-support commits.
