# Bounded developer QA feedback

This is an additive, local feedback tier for the existing TypeScript presentation
and manager work. It is not a substitute for required CI or release acceptance.
`npm test` and `test:fast` still invoke the existing Vitest setup; they are not
aliases for these Node suites. The CI integration changes only the existing fixture steps and their exact path
filters. Package scripts and required full gates remain unchanged.

## Commands

From the repository root, after the existing toolchain has been provisioned:

```sh
node scripts/qa-fast.mjs quick-unit
node scripts/qa-fast.mjs e2e-smoke
```

Both commands emit one scoped JSON result to stdout. All captured child diagnostics
go to stderr unchanged. For machine ingestion, redirect stdout to a file and retain
stderr in the terminal or a separate CI artifact. Exit 0 means the requested tests
passed, exit 1 means execution/evidence failed, and exit 2 means prerequisites or
CLI arguments blocked execution. `wholeTaskVerified` and `releaseReady` are always
false. A test count is not a count of screens, users, roles or completed workflows.

To inspect static prerequisites without executing tests:

```sh
node scripts/qa-fast.mjs quick-unit --check
node scripts/qa-fast.mjs e2e-smoke --check
node --test scripts/test-qa-fast.mjs
```

`--check` may exit 0 with `status: "not_run"` and `passed: false`. It cannot verify
browser launch, OS shared libraries or any assertion. Missing prerequisites still
exit 2. Do not treat a preflight-only result as a test pass.

## Scope and prerequisites

### quick-unit

Requires Node 22+ and the repository's existing esbuild and Twilio browser SDK
dependencies. No browser, Flutter, database URL or production credentials are
needed. It runs these complete files serially with the Node test runner:

- `test-platform-browser-fixture.mjs`: actual presentation bootstrap and bounded
  request-arrival contracts, with synthetic browser peripheral probes.
- `test-platform-bundle-session.mjs`: session-bound client/download behavior.
- `test-platform-admin-manager.mjs`: manager installation and ownership failures.
- `test-typescript-screen-manager.mjs`: manager/dispatcher contracts.
- `test-enquiry-manager.mjs`: existing enquiry presentation contracts.
- `test-admin-child-sessions.mjs`: session retirement and stale work boundaries.

Existing fixture imports and production renderer/manager connections are reused;
the runner adds no substitute business API or production data. These are synthetic
DOM/transport contracts, not real-browser or database acceptance. The current
reviewed minimum is 348 Node checks. Missing summaries, reduced counts, skipped,
cancelled, TODO or failing tests cannot be successful. Increasing coverage does
not require changing the minimum; lowering it requires review.

The six selected suites compile into memory. A 60-second Node timeout and a
90-second process ceiling bound pathological failures; these are ceilings, not
performance targets. Diagnosing a timeout must not mean raising it automatically
or weakening assertions.

### e2e-smoke

Requires the same dependencies plus `playwright`, its matching Chromium install,
browser OS libraries, a working video encoder, loopback server access and enough
artifact space. Provision these using the existing approved toolchain, for example
the versions/setup in `growth-marketing.yml`; the runner never downloads or installs
anything. No database is used by this intentionally narrow renderer smoke.

The command runs `scripts/test-growth-loading-browser.mjs` with an opt-in evidence
identity and output directory; its complete browser scenario is unchanged. It preserves
all six existing EN/FR/ES x 320/1440 cases and their loading, HTTP 503, HTTP 403,
transport failure, retry, stale-content clearing and console-error assertions.
It uses the real Growth renderer and `presentPlatformFixture`, the synthetic
`look-test-theme.json`, `growth-read-model.mjs` and bounded
`waitForFixtureRequest`. URLs retain `enable-semantics=true`.

Its existing success response is explicitly a synthetic empty read model for
renderer recovery. It is not proof of authentication, role grants, persisted
business operations or tenant isolation. Do not replace backend acceptance with
this fixture or relabel its successful responses as real API success.

The wrapper generates a random UUID and exclusively reserves a new directory at
`test-results/growth/loading/runs/<UUID>/`. Existing run directories are never
reused, and symlink/junction artifact parents are rejected. The report and the
child's final stdout summary must contain the generated UUID. The summary must
also name the exact report and match its SHA-256 digest; all reported source
hashes must match current repository bytes. A complete six-case report remains
required. Timestamps grant no authority, including future timestamps or clock
skew. Missing/foreign stdout or evidence is a failure.

Direct invocation without `QA_FAST_RUN_ID` retains the original
`test-results/growth/loading/` output and summary shape. All existing screenshots,
videos, cases and assertions remain. The current workflow's `test-results/`
artifact collection also includes the isolated run directories. The runner
generates its own identity after sanitization; callers must not supply one.

The process ceiling is 180 seconds. Browser
startup/runtime failures remain failed, not skipped. A machine with less than the
required artifact budget must stop before this stage; a prerequisite-only run is
not a workaround for browser acceptance.

## Keep the comprehensive gates

Always run the existing suites appropriate to the change and all required CI:

- Keep `node --test scripts/test-look-browser-fixture.mjs` as a separate mandatory
  contract check. Its seven checks exercise the real Look bridge, renderer and
  authenticated no-store client request with synthetic DOM/transport probes. It is
  deliberately separate from the reviewed six-file `quick-unit` profile and does
  not replace `scripts/test-look-manager.mjs` real browser acceptance.

- Keep `node --test scripts/test-growth-manager.mjs`. Its current 234 checks cover
  broader Growth ownership and mutation behavior. The current fixture temporarily
  writes its compiled module; it is outside the no-disk-bundle quick profile.
- Keep platform and Growth PostgreSQL authority, transactions, concurrency,
  rollback, actual backend/browser, session and tenant-isolation acceptance. Those
  tests require `pg`, explicit isolated `PLATFORM_TEST_DATABASE_URL` and their
  other documented fixtures. A missing database is a blocker, never a reason to
  replace it with a successful stub or a production connection.
- Keep all existing browser engines and matrices. Chromium smoke does not replace
  the Chromium/Firefox/WebKit checks in `account-password-acceptance.yml` or the
  corresponding lifecycle evidence workflow.
- Keep accessibility, security, localization, native transport/device, governance,
  migration and release gates, including fail-closed review requirements.
- Preserve Java/Selenium/TestNG where already applicable. `testingFramework1.0/`
  and `maven-test.yml` are real existing coverage. Do not add TestNG around the
  Node/Flutter code or remove the existing Java suite merely for speed.

For native changes, use Flutter 3.41.5 stable, matching existing CI, and provision
package dependencies through the existing setup. Useful separate focused commands:

```sh
cd packages/flutter_core
flutter test --no-pub test/screen_manager_test.dart test/auth_session_test.dart test/auth_route_guard_test.dart
```

From a fresh terminal at the repository root:

```sh
cd packages/primecare_ui
flutter test --no-pub test/base_primecare_app_test.dart test/base_workspace_controller_test.dart
```

`--no-pub` does not install dependencies. Missing Flutter/package configuration must
be reported as blocked/failing, not skipped. These native commands have not been
executed for this candidate; the available cloud host has no Flutter SDK. A
prerelease laptop SDK does not establish stable-CI compatibility.

## Existing CI wiring

The existing `platform-admin-acceptance.yml` fixture step runs these four commands
in a sanitized environment, in this order:

```sh
node --test scripts/test-qa-fast.mjs
node --test scripts/test-look-browser-fixture.mjs
node scripts/qa-fast.mjs quick-unit
node --test scripts/test-growth-manager.mjs
```

The second command is mandatory and separate from quick-unit. The six selected
quick files execute once, while the existing Growth manager suite remains intact.
The earlier read-only governed CSS theme checks and all subsequent native,
database, browser and accessibility gates remain unchanged.

In `growth-marketing.yml`, the existing loading/retry step calls `e2e-smoke`.
Its six cases, artifact collection and all later full browser/database steps,
including the full Look browser check, remain. Exact path filters cover the new
runner, identity helper, runner tests and Look contracts/harness, alongside the
existing bootstrap/theme/DOM dependencies. No broad workflow, permission,
timeout, trigger type, branch-protection or required-check change is introduced.
This wiring has local contract evidence; it is not evidence that CI or browser
acceptance has passed.

The combined integration was checked in a verified in-memory source projection:
360 selected checks, seven separate Look contracts and 51 runner regressions
passed. This is new projection evidence, not a rerun of the historical 348-check
record below or a stock CI/browser run.

## Isolation, portability and observed timings

Child processes receive an explicit environment allowlist. Database/cloud secrets,
`NODE_OPTIONS`, `NODE_PATH`, test adapters and custom browser overrides are not
passed through. PATH/HOME and Windows executable/cache/temp variables are retained.
No shell is involved; arguments and paths with spaces remain separate values.
Dependency resolution runs in a separate Node process with this same sanitized
environment and ESM resolution from the repository root. Ambient parent
`NODE_PATH` packages cannot satisfy prerequisites for the test child.
The optional `--root <repository>` supports inspecting this private candidate
without copying it into the source tree.

The CLI and CRLF/environment handling have source-level and regression coverage.
Windows execution, process-tree cleanup on timeout, Flutter and native device
behavior remain unverified. Some existing esbuild fixture plugins use POSIX-style
importer suffixes; review/run them on Windows before claiming Windows support.
Normal browser teardown remains owned by the existing fixture. On timeout, the
wrapper kills the direct Node child; it does not guarantee cleanup of browser
descendants. Inspect remaining test processes after a timeout before rerunning.

Historical QA revision2 measurements, 2026-11-08, Linux cloud runner:
These results belong to the frozen pre-integration candidate, not a new CI run.

- 348/348 existing quick checks, no skipped/TODO/cancelled tests, about 2.4 seconds
  including wrapper overhead, using Node 24.22.1 and esbuild 0.27.7.
- 51/51 dependency-free wrapper regressions passed in about 0.10 seconds, including
  real filesystem reservation/collision tests. No browser was used for those tests.
- Browser smoke is blocked at sanitized preflight because Playwright is not
  resolvable from this source's dependency tree. Ambient and clean parent probes
  returned identical results. The browser has not run or passed. This unapplied
  revision also requires its new identity helper in the target repository.
- Growth manager, Flutter, databases, full browsers and release gates are not
  rerun as part of this bounded candidate validation.

These are observations, not guaranteed developer timings. Local installed
TypeScript is 5.8.3 (not invoked by this runner). Do not call this parity with
CI's requested Node 22 / esbuild 0.27.2 / TypeScript 5.9.3 toolchain. This private
candidate also depends on the reviewed fixture-bootstrap repair being present;
it must not be applied independently to an older tree missing those fixtures.
