# Shared text migration

Preview: `python3 scripts/migrate-shared-text.py`

Apply: `python3 scripts/migrate-shared-text.py --apply`

The tool only changes unqualified `Text(...)` calls in app library files with
unrestricted Material and PrimeCare UI imports. It preserves argument expressions,
keys, explicit styles, alignment, line limits, overflow and const construction.
Calls with unsupported parameters, named constructors, qualified references,
local Text/PrimeText types and part files are left for explicit migration. Comments
and string text are preserved; executable interpolation expressions are scanned.
This is a conservative lexical codemod, not resolved Dart analysis. Analyze and
test changed apps in GitHub Actions before accepting the migration.

Run `python3 -m unittest discover -s scripts/tests -p test_migrate_shared_text.py`
and `python3 scripts/check-shared-ui-boundary.py` after applying. The strict
boundary gate continues to reject all remaining direct controls and literal colors.
The migration does not map color literals to guessed semantic roles or remove
unsupported options. Those findings remain backlog.
