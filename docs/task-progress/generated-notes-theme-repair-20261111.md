# Generated note-screen repair and theme batch — 2026-11-11

## Summary before migration

Five additional generated note screens have the exact invalid unescaped client
summary string. Repair the literal, preserving displayed text, and reuse the existing
generated theme utility. Expected 73 known palette substitutions per library,
365 total. Their Target Role headings already use onSurface and remain unchanged.

Extend the existing reviewed whole-file manifest with the five original hashes;
keep the three prior repaired-source regressions. Preserve source fixtures and add
all five actual classes to the native compile fixture. Dry run and scope checks
remain. Publish support and five source files as separate main commits.

Starting strict findings: 1,311 = 279 direct controls + 1,032 literal colors.
Malformed strings hide tail literals, so 365 actual substitutions must not be
reported as the strict finding decrease. Recount the exact final source.

## Verified result

Five invalid Dart strings repaired. 365 actual palette substitutions applied;
all eight original fixtures (three previous and five new) reproduce exact final
source and pass idempotence, hash guards and balanced-delimiter checks. The full
second utility pass has zero eligible files. Eight real classes are referenced by
the native compile fixture; runtime/native acceptance remains pending CI.

Strict findings: 1,311 -> 1,156 = 279 direct controls + 877 literal colors.
Observed decrease: 155. The invalid strings previously hid 210 additional literals
from the lexical scan; repair exposed and removed them. Do not report 365 as the
observed strict decrease. No exemptions or baseline introduced.

211 migration regressions, 17 boundary diagnostics and seven import-cleanup tests
pass. An expanded negative test was corrected to mutate an existing color in each
fixture rather than making a no-op replacement for five different palettes.
