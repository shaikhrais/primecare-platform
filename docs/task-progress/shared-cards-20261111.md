# Shared card batch — 2026-11-11

## Batch summary

- Selected the complete largest compatible constructor family remaining after snack bars: 13 Material `Card` calls in 9 libraries.
- Add `PrimeCard` as a direct Flutter 3.41.5 `Card` delegate. The complete default-constructor field surface is forwarded and Material `CardTheme` defaults remain active.
- Replace constructor identifiers only. Child identity, keys, colors, shadows, elevation, shape, margin, clipping, border painting, and semantics remain unchanged.
- Pin every consumer to its reviewed whole-file SHA-256. Modified, qualified, shadowed, named-constructor, part, unsupported, or escaped sources are skipped.
- Add exact forward/reverse/idempotence tests, native field/render parity coverage, consumer compile fixtures, and a strict boundary regression.
- Expected strict reduction: 13 direct-control findings. Literal-color findings are intentionally unchanged.

Native Flutter acceptance is performed by GitHub Actions; local source checks are not runtime acceptance.
