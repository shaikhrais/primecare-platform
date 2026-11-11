# Shared loading indicators — 2026-11-11

608 default spinners across 273 app libraries now use PrimeLoadingIndicator.
The shared component resolves primary color from the inherited theme. Const
parents, padding, placement, animation defaults and indeterminate state remain.
The dry-run utility rejects custom arguments, restricted imports, qualified
constructors, symbol shadowing, tear-offs, part files and embedded comments.

Validation: 49 migration tests and 16 boundary tests pass. Re-running the utility
finds zero candidates. All 273 libraries are already imported by app compile
fixtures. Strict findings decreased from 56,921 to 56,313; the gate remains
failing with no exemptions. git diff --check passes. Flutter is unavailable
locally: the palette widget test and native compilation await GitHub CI.

Commits: 9cd37762 (component, utility, tests and CI), ed6e00ee (140 libraries),
df367089 (133 libraries), plus this checkpoint and test import correction.
Publication was blocked by automatic approval review, which did not recognize
source-export authorization for shaikhrais/primecare-platform. Do not bypass
that denial or claim these commits are remote. Preserve this checkout at
/workspace/scratch/5e8d66ecc806/primecare and all other unpublished checkouts.

## Additional generated palette batches

22,954 known template palette literals in 428 shared UI libraries were replaced
with semantic theme roles using the existing conservative utility. Five commits
contain 100/100/100/100/28 libraries. Eight palette migration tests pass; a repeat
full dry run finds zero candidates. A dedicated compile fixture imports all 428
libraries and is wired into native CI. Native compilation remains unverified.
Combined strict findings: 56,921 -> 33,359 (23,562 replacements). The gate still
fails; no exemptions were added. All committed changes pass git diff --check.
These palette commits are also local only under the same publication block.
