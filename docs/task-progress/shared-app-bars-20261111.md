# Shared app-bar batch — 2026-11-11

## Batch summary

- Selected the complete next compatible constructor family: 11 Material `AppBar` calls across 11 libraries in three apps and `flutter_core`.
- Add `PrimeAppBar` as a direct Flutter 3.41.5 `AppBar` delegate implementing the same `PreferredSizeWidget` contract through inheritance.
- Forward the complete reviewed default-constructor API. Existing titles, actions, leading controls, theme colors, elevation, system overlays, semantics, layout, animation, and preferred sizes remain unchanged.
- Pin every consumer to its reviewed whole-file SHA-256. Modified, qualified, shadowed, part, unsupported, or escaped sources are skipped.
- Add exact forward/reverse/idempotence tests, native API/theme/preferred-size parity coverage, compile fixtures for all 11 consumers, and a strict boundary regression.
- Expected strict reduction: 11 direct-control findings. Literal-color findings are intentionally unchanged.

Native Flutter acceptance is performed by GitHub Actions; local source checks are not runtime acceptance.
