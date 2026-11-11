# Core shared text and icon migration — 2026-11-11

## Batch summary before selection and migration

452 compatible direct controls: 401 Text and 51 Icon constructors across 31 core
libraries. This is the next compatible remaining group, not the largest historical
batch. Previous 207 was a test count, not a replacement count.

Move the two existing shared control implementations byte-for-byte into the
Flutter-only primecare_ui_foundation package. Core and UI depend on that package;
existing primecare_ui source paths remain compatibility exports of identical class
identities. No core -> primecare_ui dependency is introduced.

Reuse the existing conservative text/icon argument and symbol checks, with an
additional reviewed whole-file SHA-256 manifest. Preserve const, style expressions,
null inheritance, labels, keys, callbacks and layout. Narrow imports only. Publish
support then source parts of 15 and 16 files. Native compile fixtures reference
actual public declarations from every changed core library.

Starting strict findings: 1,763 = 731 direct controls + 1,032 literal colors.
Expected final: 1,311 = 279 direct controls + 1,032 literal colors.
This removes direct calls; existing fixed colors remain visible and unresolved.

## Verified source validation

452 replacements applied; all 31 exact original SHA-256 hashes reconstructed from
final code, preserving every unrelated byte. Full forward/idempotence checks pass;
second utility run has zero eligible calls. Fixed-color findings are identical.
211 migration tests and 17 boundary tests pass. YAML and native test delimiter
checks pass. Existing primitive implementation files were moved byte-for-byte;
compatibility exports retain class identity and constructor APIs.

Strict findings: 1,763 -> 1,311 = 279 direct controls + 1,032 literal colors.
The gate permits only Material Text in the exact shared PrimeText implementation
and Material Icon in the exact shared PrimeIcon implementation. Wrong controls,
new feature files and all fixed colors still fail; regression tests prove this.
No control debt was hidden or baselined.

New native tests cover inherited typography/icons/scaling, disabled foregrounds,
caller overrides, semantics, wrapping and public class identity. A compile fixture
imports/references all 31 changed core libraries. Existing native all-palette shared
consumer tests continue through the public exports. These checks are authored and
wired into CI, not executed locally (Flutter SDK unavailable).
