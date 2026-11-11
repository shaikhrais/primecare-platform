# Target role heading batch — 2026-11-11

## Summary before migration

131 exact generated role heading literals across 131 shared libraries.
Use the existing onSurface text role already used by 698 sibling generated headings
on their themed surface header cards. This is a heading foreground, not a status or
brand accent. Preserve labels, typography, data providers, callbacks and layout.
Publish support then 100/31 library parts directly on main.
Starting strict findings: 1,987 = 731 direct controls + 1,256 literal colors.
Expected after: 1,856 = 731 direct controls + 1,125 literal colors.

## Acceptance

Whole-file SHA-256 input manifests admit only the reviewed current files; modified
imports, bindings, layout, helpers, labels, comments or callbacks remain unresolved.
Dry run by default, offset/limit and symlink containment checks. Exact reverse byte
round trips, idempotence, fixture parity and full migration regressions required.
All-palette native contrast and live update tests are authored; native execution is
required in GitHub Actions and is not claimed from local Python validation.
Existing generated screen placeholders and provider fallbacks remain unresolved.

## Review findings

Three initially counted headings were excluded: adjustment_notes, rmt_treatment_notes,
and chiropractor_treatment_notes. Their files still have fixed white surfaces and unescaped apostrophe
syntax defects. They require a source repair and complete palette migration before
acceptance; they were not hidden from the strict scan.

## Local validation

131 exact replacements; all 131 reverse byte round trips, idempotence and existing
native compile imports verified. A full second utility pass reports zero edits.
204 migration regressions + 16 boundary diagnostic tests pass. Workflow YAML,
Dart fixture/test delimiter checks and whitespace checks pass. Native all-palette
runtime/contrast tests are authored but unexecuted locally (Flutter unavailable).
