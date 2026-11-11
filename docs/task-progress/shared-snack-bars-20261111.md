# Shared snack-bar batch — 2026-11-11

## Batch summary

- Selected the complete grounded family: 16 Material `SnackBar` constructors in 11 application and `flutter_core` libraries.
- Add `PrimeSnackBar` as a direct SDK-compatible delegate for Flutter 3.41.5. It forwards the complete reviewed constructor surface and keeps Material theme defaults.
- Replace constructor names only. Content, colors, actions, duration, visibility callbacks, dismissal, shape, padding, margin, animation, and behavior remain unchanged.
- Pin every consumer to its reviewed whole-file SHA-256. Modified, qualified, shadowed, part, unsupported, or escaped sources are not migrated.
- Add exact forward/reverse/idempotence tests, native field/render parity tests, consumer compile fixtures, and a strict boundary regression.
- Expected strict reduction: 16 direct-control findings. Literal-color findings are deliberately unchanged by this batch.

Native Flutter acceptance is performed by GitHub Actions; local source checks are not runtime acceptance.
