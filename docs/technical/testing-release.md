# PrimeCare testing and release evidence

## What this document proves

Source inspected: commit `3979ed1`. The procedures below distinguish **observed** executable workflows, **required** governance gates, and **proposed** additions. No test is claimed to pass merely because it appears in a workflow. A historical passing run belongs to its exact commit and environment; it cannot certify a later source revision, deployment or all operations.

The finite baseline is 1,415 unique method/path operations. A workflow review, contract draft, generated TypeScript/Dart descriptor, field repair or route declaration is not an implemented API. Preserve declaration identities and distinguish unit evidence, PostgreSQL evidence, caller integration and production acceptance. Generated nonexecutable contracts remain nonexecutable even if their compilation and integrity tests pass.

## Existing CI map

| Workflow | Observed scope and behavior | Evidence limit |
|---|---|---|
| `auth-worker-tests.yml` | Node 22; isolated pinned dependencies; `verify-api-batches.mjs`; Worker typecheck; PostgreSQL 16 UUID/text matrix; many operation-specific database suites | Results apply to the invoked suites on the exact head. PostgreSQL matrix coverage is not automatically mapped to every finite operation. |
| `api-result-client-tests.yml` | Flutter 3.41.5; core network/auth/provider/notification tests; clinic notification controller; clinical dashboard failure tests and focused analysis | Proves selected caller behavior, not new handler implementations. Some UI analysis steps use nonfatal warning/info flags. |
| `auth-gateway.yml` | Dart services analysis/tests; PostgreSQL 15 login/logout runtime smoke; shared Flutter auth and application routing/build matrix | Separate Dart runtime evidence; does not establish every Cloudflare contract. |
| `provider-profile-client-tests.yml` | Focused provider client verification | Source-path trigger and suite contents must be checked for the changed package. |
| `primecare_ci.yml` | Node 24, Flutter 3.41.5, architecture checks, Prisma format/generate, backend analysis, frontend spider, client tests/web build | Compilation and structural checks do not establish authorization or operation completion. |
| `ci.yml` | Unified Dart aggregate: analysis, service/application tests and dependency inventory | Explicitly nonblocking: failures become WARNING and steps exit zero. Read its reports, not just its green conclusion. |
| `workflow-contract-plan.yml` | Contract-plan integrity and regeneration checks | Draft evidence consistency; zero implementation credit. |
| `pending-api-authority-audit.yml` | Read-only governance authority audit and tests | Observed grants and missing metadata are facts to investigate, not automatically a complete business authorization contract. |
| `release-primecare.yml` | Verification matrix, governance mutation, API deployment, TypeScript Pages deployment, Windows builds, production smoke | Production smoke creates a temporary QA tenant; it is a write-capable verification operation, not a read-only health probe. |
| `build_android.yml` / `build_windows.yml` | Nine-app native build matrices, maximum parallelism two, artifacts | Build artifact presence does not establish signing, store readiness or device behavior. Flutter stable is not pinned in these two workflows. |

Source-path filters can leave workflows untriggered. Before changing a handler, fixture, migration, caller or generated evidence, identify the workflows whose paths should match. A missing run is not a passing run. A generic workflow success cannot hide a failing focused job.

## Reproduce focused checks

Use an isolated checkout and dependency set described in [runtime-operations.md](runtime-operations.md). The following commands are observed in the focused caller workflow:

```bash
cd packages/flutter_core
flutter pub get
flutter test test/business_development_transport_test.dart test/own_notifications_repository_test.dart test/auth_transport_test.dart test/provider_profile_test.dart
flutter analyze lib/src/network/api_client.dart lib/src/repositories/own_notifications_repository.dart test/business_development_transport_test.dart test/own_notifications_repository_test.dart
```

Clinic notification checks:

```bash
cd apps/primecare_clinic
flutter pub get
flutter test test/psw_notifications_controller_test.dart
flutter analyze --no-fatal-warnings --no-fatal-infos lib/features/psw/screens/psw_notifications_screen.dart
```

Clinical dashboard checks:

```bash
cd packages/primecare_ui
flutter pub get
flutter test test/clinical_dashboard_failclosed_test.dart
flutter analyze --no-fatal-warnings --no-fatal-infos lib/src/components/governance_components.dart lib/src/screens/clinical/clinical_director_dashboard_screen.dart test/clinical_dashboard_failclosed_test.dart
```

Worker checks observed in `auth-worker-tests.yml`, from the repository root after isolated dependency installation:

```bash
python3 scripts/register-maintenance-governance.py
python3 scripts/register-workspace-governance.py
node scripts/verify-api-batches.mjs
node_modules/.bin/tsc --noEmit --skipLibCheck --module esnext --moduleResolution bundler --target es2022 --types @cloudflare/workers-types cloudflare/workers/src/service.ts cloudflare/workers/src/gateway.ts
```

The registration commands mutate a local governance database. Use a disposable checkout/copy; record its original hash and distinguish derived files from the committed source. Do not describe this setup as read-only. Never commit a derived governance database just because a test setup changed it.

PostgreSQL tests take `AUTH_TEST_DATABASE_URL` and `AUTH_TEST_ID_TYPE`; use only a disposable fixture database. Representative source-backed commands are:

```bash
node scripts/test-auth-postgres.mjs
node scripts/test-client-self-postgres.mjs
node scripts/test-provider-self-postgres.mjs
node scripts/test-client-booking-lifecycle-postgres.mjs
node scripts/test-tenant-authority-postgres.mjs
node scripts/test-pagination-consistency-postgres.mjs
```

The CI matrix executes these with both `uuid` and `text` identity schemas. Capture each matrix result. A fixture test using a fake adapter and a PostgreSQL integration test exercise different failure modes; retain both where transaction, type projection or query ownership behavior matters.

## Operation acceptance record

For every candidate API, create a record containing: exact method/path; finite declaration IDs; workflow and caller; source SHA; authentication mechanism; exact role/API grant facts; tenant/ownership/delegation/state constraints; request and response schemas; persistence mappings; validation bounds; rate/audit/idempotency contracts; handler and gateway locations; schema dependency/migration; unit and PostgreSQL suite names; caller tests; run IDs; accepted statuses; known gaps. No API receives completion credit while required facts are invented or unresolved.

Existing grant facts deserve precision: an enabled `api_permissions` row for the exact API ID and role is evidence even when endpoint metadata is incomplete. Missing `permission_key` metadata is not proof that all authority is absent. Conversely, a generic feature grant, a role name, a table’s tenant column or a generated `auth_required=1` flag cannot prove actor-specific workflow authorization. Preserve both known facts and unknown scope rules.

## Required negative and positive coverage

These are required test categories for a new executable workflow; only applicable cases with documented contracts should be implemented. Do not invent a business rule merely to obtain a green test.

| Area | Concrete cases | Assertions |
|---|---|---|
| Exact routing | Correct method/path; wrong method; unknown path; misleading plural/prefix; dynamic ID capture | Intended handler only; correct 404/405 and `Allow`; no accidental generic detail route. |
| Authentication | Missing bearer; malformed token; expired/revoked session; inactive user; valid active actor | Contract-specific 401; no write or data disclosure on failure. |
| Role/API authority | Exact enabled API/role grant; denied/disabled grant; unrelated generic rule; role changed after session | Defined authorization enforced; no role-name bypass or stale privilege. |
| Tenant | Actor’s own tenant; conflicting tenant header; another tenant’s record; absent tenant | Server-derived scope; denial without cross-tenant output or mutation. |
| Ownership | Own record/profile; another actor in same tenant; nonexistent record; ambiguous duplicate profile | Scope predicate maintained; safe not-found/denial; ambiguity fails closed. |
| Delegation | Explicit permitted delegation; expired/revoked/unrelated link | Only the defined delegated operation and data projection allowed; a family link alone is insufficient. |
| State | Eligible transition; terminal/ineligible state; concurrent transition | Contract-specific conflict; no silent overwrite; audit and state stay consistent. |
| Request | Unknown fields; missing required fields; bodyless operation with injected body; duplicate query keys; malformed IDs/dates; limits | Exact validation; no arbitrary actor/client/tenant override; no normalized impossible dates. |
| Response | Correct rows; unexpected identity/status; sparse/invalid rows; invalid timestamps/counts; extra sensitive fields | Validated projection; sanitized 503 on invalid dependency data; no sample or cached false success. |
| Paging | Limit/offset bounds; empty page; final page; grouped counts; concurrent insert/delete | Stable ordering; contract pagination math; snapshot consistency where promised. |
| Failure | Database disconnected; schema missing; limiter unavailable; malformed stored result | Safe error; no success header/body, partial write or leaked driver details. |
| Audit | Successful action; denied action policy; failed transaction; wrong actor binding | Defined event attribution/redaction; atomic success audit where specified. |

### Mutation and idempotency scenarios

For an operation whose contract defines idempotency, test the same actor/tenant/key/payload twice, the same key with a changed payload, different keys under concurrent requests, the same key under a different actor or tenant, response replay after success, and a failure before commit. Verify row counts, persisted state, audit counts and replay headers. Do not merely compare response codes.

Booking-request lifecycle source supplies a concrete reference: create returns an owned pending request; cancel is restricted to pending state; actor/profile locks and session recheck protect writes; audit and stored retry binding validate request identity and expected state. No test should relabel that pending request as a confirmed appointment. Tests must verify a stored malformed retry response cannot manufacture a replay success.

For workflows without an approved idempotency contract, mark the policy gap. Adding a key header does not decide duplicate business intent or settlement behavior.

## Flutter caller verification

Each changed screen/controller/repository should prove loading, valid data, empty result, 401/403, 404/405, invalid DTO, network failure and retry. A later denial must clear or hide prior data where the contract requires it. Concurrent loads need a test that older success cannot override newer denial. Cached data must not fabricate successful execution for a mutation or unavailable clinical workflow.

Check widgets at realistic narrow and wide sizes, long translated text, large text scale, keyboard navigation and error states. The clinical dashboard precedent requires metrics to disappear when validation fails, mock actions not to claim completed work, and unbound chart/census baselines not to display fabricated results. These are caller repairs; they are not proof that the clinical dashboard API exists.

Tests should use injected transports or controllers to control failure cases. Also run a real end-to-end session/tenant test against the accepted environment before production acceptance. Do not use production patient records to generate screenshot fixtures.

## Accessibility and navigation

Repository requirement `.agents/AGENTS.md`: shared widgets expose stable identification; Cypress uses `data-cy`; Flutter web Selenium uses semantic labels and XPath via `aria-label`, because Flutter widgets do not map directly to HTML `data-cy`; navigated testing URLs append `enable-semantics=true`.

Proposed acceptance set: login field labels and submit action; sidebar and topbar keyboard focus; dashboard metric labels; disabled/loading state announcement; error message association; focus restoration after modal close; visible focus; contrast; text scaling; screen-reader order; no keyboard trap. Record browser/device, screen-reader version, viewport, locale and source SHA. A screenshot alone does not prove accessibility.

Observed release verification builds TypeScript websites, installs Chromium and invokes `scripts/test-workspace-playwright.mjs`, uploading `artifacts/workspace-browser/`. Treat automated checks as part of evidence, not a blanket WCAG compliance claim. Manual assistive-technology testing and any unresolved findings must remain visible.

## Handling failures without weakening gates

1. Retrieve the failing job and exact step logs for the tested head. Identify whether it is dependency resolution, compilation, analysis, fixture assertion, PostgreSQL behavior or browser layout.
2. Reproduce the narrow failing case with the same tool versions. A successful command against another checkout is not a fix.
3. Correct source or a demonstrably incorrect fixture. Preserve assertions about ownership, tenant scope and denial. Do not change a failing expectation to success merely because existing code returns it.
4. Rerun affected tests and analysis. Broaden only for new changes, uncovered regressions or required workflow gates.
5. Push the changed source; wait for all applicable exact-head CI conclusions. Older head success does not carry forward automatically.
6. Record warnings that remain nonblocking. A dependency failure, timed-out run, absent test directory or WARNING is not a pass.

The Unified Dart aggregate currently returns exit zero after warnings. Proposed improvement: report aggregate detail while making changed-package checks and required security/authorization tests blocking. Do not silently claim that improvement exists.

## Merge gate and source integrity

Required workflow: implementation and documentation reviewed; concrete authorized scope; finite identities stable; appropriate tests and migrations reviewed; applicable CI successful on the exact final head; merge with expected-head protection; verify merged source and artifact versions. Avoid completing operations based on generated code or field repairs.

Proposed review checklist:

- Request and response examples agree with schemas and actual callers.
- Gateway path transformations preserve method, query, headers and bodyless semantics.
- Principal and tenant come from authenticated server state; identifiers cannot grant authority.
- Writes and audit/replay records share the required transaction and scope.
- Error paths preserve no-store behavior and do not leak clinical/security details.
- Schema changes remain compatible with the rollback version.
- Generated files reproduce and source hashes match; no transient database, cache or secret entered the change.
- Evidence records name the actual suite and result rather than a generic “tests passed”.

## Native Windows and Android release

Observed Windows workflow builds nine apps on `windows-2022`, enables Windows desktop, runs `flutter pub get`, and invokes:

```bash
flutter build windows --release --dart-define=API_BASE_URL=https://primecare-api-gateway.itpro-mohammed.workers.dev
```

Artifacts contain the full `build/windows/x64/runner/Release/` directory under `windows-build-<app>`. Distribute the complete bundle, including dependent DLLs and data, rather than the executable alone. The workflow’s stable Flutter channel is unpinned; proposed improvement is to pin the same accepted toolchain as focused CI and record it in artifact metadata. Code-signing and an installer pipeline are not established by this workflow.

Observed Android workflow uses Java 17 and stable Flutter, building both formats:

```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://primecare-api-gateway.itpro-mohammed.workers.dev
flutter build apk --release --dart-define=API_BASE_URL=https://primecare-api-gateway.itpro-mohammed.workers.dev
```

APK path: `build/app/outputs/flutter-apk/app-release.apk`; AAB path: `build/app/outputs/bundle/release/app-release.aab`. Artifact names include the app identity. No inspected workflow establishes production signing-key custody or store approval; verify each app’s Gradle signing and manifest separately before calling it distributable to a store.

Proposed native acceptance: checksum and source/build SHA recorded; supported OS/device matrix; clean install and upgrade preserving approved data; correct API target; login/logout and reset-password deep link; offline/retry behavior; denied role/tenant screens; secure storage behavior; notification permission; back/navigation; accessibility; app version/build number; signed binary verification; uninstall/reinstall behavior. Exercise Windows plugin behavior on a real Windows host and Android on at least a real supported device. A web test does not substitute for either.

## Release orchestration and rollback gate

`release-primecare.yml` cancels selected superseded standalone builds, verifies UUID/text PostgreSQL jobs and Chromium navigation, persists governance changes, deploys APIs then TypeScript websites, builds Windows and runs production auth smoke. Android is a separate workflow. Production smoke is configured through `CONFIRM_AUTH_SMOKE=VERIFY_AUTH`, `PRODUCTION_DATABASE_URL` and `GATEWAY_URL`; inspect the script’s temporary-tenant cleanup before running it.

Observed source-integrity gap: the governance job can commit to `main` after verification, and downstream workflows check out separately. Proposed correction: compute one immutable release SHA, pin every job to it, and verify all generated governance changes before merge. Until corrected, compare verified head, deployed head and native artifact head explicitly.

Before publishing, record the previous Worker and Pages versions and whether the previous application can use the new schema. Rehearse rollback in a nonproduction environment. A failed API deployment can leave only some services updated; a Pages failure can leave a mixed website release. Capture an explicit component/version map, then restore or forward-fix the affected set. Use [runtime-operations.md](runtime-operations.md) for the proposed recovery process.

## Evidence storage and final reporting

Retain workflow conclusions and matrix results, sanitized logs, diagnostic JSON/Postman artifacts, PostgreSQL suite mapping, browser evidence, build artifact checksums and deployment IDs. Do not retain live tokens or patient data in those artifacts. Retention periods, access rights and audit requirements need owner decisions; the repository’s 14-day retention on some CI artifacts is not a complete organizational retention policy.

Final reports state unique operations newly resolved, pending and explicitly blocked; caller repairs separately; exact tested/merged SHA; tests actually executed; unexecuted tests or warnings; deployment status; policy or dependency blockers. An API can have passing unit tests while remaining unresolved for missing authorization, persistence or operation-specific PostgreSQL evidence. Maintain that distinction throughout the master plan.

## Source references

All inspected at `3979ed1`: `.github/workflows/auth-worker-tests.yml`; `.github/workflows/api-result-client-tests.yml`; `.github/workflows/auth-gateway.yml`; `.github/workflows/primecare_ci.yml`; `.github/workflows/ci.yml`; `.github/workflows/release-primecare.yml`; `.github/workflows/build_android.yml`; `.github/workflows/build_windows.yml`; `.github/workflows/workflow-contract-plan.yml`; `.github/workflows/pending-api-authority-audit.yml`; `packages/flutter_core/pubspec.yaml`; `packages/database/package.json`; `package.json`; `cloudflare/workers/src/client-booking-lifecycle.ts`; `.agents/AGENTS.md`.
