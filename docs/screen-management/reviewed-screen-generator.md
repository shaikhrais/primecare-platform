# Source-bound screen scaffold utility

`tools/mvc_generator/generate_reviewed_screen.py` produces an **abstract review
scaffold**, not a finished screen. Use it instead of free-form, name-only
generation when preparing a new governed screen. The older Dart MVC generator
is unchanged for compatibility; it is not evidence of contract readiness.

## Inputs

Prepare a reviewed JSON contract from existing, authoritative governance
metadata. Do not invent a missing requirement, screen, route, API, permission,
localization key, component or test expectation. Never include credentials,
patient information or real test-user records. Keep private governance exports
private; the tool copies the selected contract into its local review bundle.

The request is a JSON object with exactly three keys:

- `version`: integer `1`.
- `source`: `path` (repository-relative JSON source), `sha256` (SHA-256 of its
  exact bytes), and `pointer` (RFC 6901 pointer selecting the whole contract).
- `contract`: the exact object selected from that source.

The selected contract requires exactly these keys:

- `app`: an existing app name beginning `primecare_`.
- `className`: PascalCase class stem. The utility appends `State`, `Controller`
  and `View`.
- `route`, `screenCode`, `titleKey`, `semanticsLabel`: registered identities.
- `slots`: exactly `businessRequirement`, `role`, `screen`, `sections`,
  `elements`, `apis`, `permission`, `theme`, `localization`, `tests`, and
  `documentation`. Each must be an object containing explicit nonempty metadata from the
  reviewed source. Describe API, role and permission identities here, not in UI
  source code. Include expected positive, negative, tenant/ownership, interrupted
  session and accessibility scenarios in `tests`.

The utility checks source integrity, exact selected-object equality, required
fields, safe identity syntax and output paths. **A matching hash does not prove
governance approval, live production parity, policy completeness or permission
enforcement.** Those remain independent review gates. The utility never connects
to the governance database and cannot certify a caller-supplied export.

## Generate

From the repository root, preview without writing:

```sh
python3 tools/mvc_generator/generate_reviewed_screen.py --request path/to/reviewed-request.json
```

After reviewing the preview, use the same command with `--write`. Output is
restricted to `scratch/screen-scaffolds/<app>/<screenCode>/`. The entire output
directory must be absent; existing output, traversal and symlinks are refused.
If a disk write is interrupted, preserve/review the partial directory before
explicitly removing it. There is no force or overwrite option.

The six outputs are:

1. `lib/features/<stem>/<stem>_state.dart`, inheriting `BaseScreenState`.
2. `lib/features/<stem>/<stem>_controller.dart`, an abstract `StateNotifier`.
3. `lib/features/<stem>/<stem>_view.dart`, an abstract `GovernedConsumerWidget`.
4. `test/<stem>_state_test.dart`, executable state unit tests.
5. `integration_test/<stem>_starter_test.dart`, explicitly skipped E2E scenarios.
6. `review.json`, source metadata and honest unverified implementation statuses.

Output is deterministic. Preview is the no-write mode. Repeat generation to the
same directory intentionally fails rather than silently replacing handwritten
work. The tool does not alter shared libraries, imports, catalogs, build queues,
routes, grants, APIs, source databases, production or deployment configuration.

## Complete the implementation

Review the bundle before copying it into its owning application. Add a separate
concrete controller that injects the existing authorized service/repository and
implements the reviewed response mapping. Add a concrete view using approved
PrimeCare components, live localization keys and inherited theme tokens. The
abstract scaffold cannot render an invented success or simulate an API call.

The owning application's existing dependency injection must supply the
controller/state, and its existing shell/router must enforce authentication and
authorization. Inheritance is not permission. Keep tenant, owner, role and
server/API checks intact. No generated route is registered automatically.

The base state's `copyWith(errorMessage: null)` retains an existing error by
design. Use `rebuild(..., errorMessage: null, ...)` to clear it explicitly. The
generated rebuild takes a shallow unmodifiable snapshot of the data map; nested
values still require immutable, reviewed domain models.

## GitHub-only verification

The **Reviewed screen generator** GitHub Actions workflow uses an isolated
temporary synthetic metadata fixture, runs generator validation/negative tests,
resolves dependencies against the actual shared packages, formats and analyzes
the generated Dart, and executes its state unit tests. No tests need to run
locally. The workflow has read-only repository permissions, pinned actions and
no production credentials or deployment steps.

Generated E2E tests are **starters only**, not passing E2E coverage. Each is
skipped with an explicit reason and fails if unskipped without implementation.
Wire them to the owning app's integration-test harness and isolated backend/test
identities, replace each failure with real assertions, then run on a target
device/emulator in GitHub Actions. For Flutter Web navigation append
`enable-semantics=true` and use registered semantics labels, not HTML data-cy.
Cover unauthorized deep links, other tenants/owners, loading/empty/error states,
logout/Back/stale responses, locale/theme updates and accessibility. Do not use
`pumpAndSettle` while an indefinite loading animation is active.

A successful generator workflow proves only these isolated scaffold checks.
It does not prove every screen, backend E2E, production parity, accessibility,
registration, approval or release readiness. Keep `review.json` status fields
unverified until separate evidence justifies updating a reviewed implementation.
