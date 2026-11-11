# Shared text migration

Preview: `python3 scripts/migrate-shared-text.py`

Apply: `python3 scripts/migrate-shared-text.py --apply`

To include files without a shared import, pass `--add-imports`. This checks that
the app declares primecare_ui as a runtime dependency before adding a narrow
`show PrimeText` import. Library directives stay before imports.

Preview plain text buttons with `python3 scripts/migrate-shared-buttons.py`;
add `--apply` to migrate eligible calls to existing `PrimeButton(isGhost: true)`.
Only key/onPressed/child signatures with an unstyled PrimeText child qualify.
Callback and localized label expressions are retained. Styled labels, additional
button options and restricted shared imports are skipped.

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

Scope a dry run to one app: `python3 scripts/migrate-shared-text.py --path apps/primecare_corporate/lib`

Repeat `--path` to select more scopes; add `--apply` after reviewing the preview.
Paths must remain inside app libraries without symlink escapes. Explicit concrete
Text type annotations, constructor tear-offs and local functions require resolved
type review and are skipped. The migration remains lexical, not a semantic proof.

PrimeText preserves Flutter's inherited typography when style is omitted, including
button foregrounds and disabled styles. Explicit styles are forwarded unchanged.
The 7,482-call batch across 274 files has constructor-only round-trip verification;
compile smoke tests import every migrated consumer library in eight app packages.
The Theme Center workflow runs those checks independently. They remain pending
until GitHub Actions completes; source migration is not screen acceptance.
