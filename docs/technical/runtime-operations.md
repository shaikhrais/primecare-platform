# PrimeCare runtime and operations manual

## Evidence boundary

This manual describes repository behavior inspected at source commit `3979ed1`. It does not establish that a service is deployed, a secret exists, a backup is recoverable, or an API has production acceptance evidence. **Observed** means executable source or workflow configuration was inspected. **Required** means a repository governance requirement. **Proposed** means an operating procedure or control that still needs implementation or owner agreement.

All commands assume the repository root unless a working directory is specified. Commands against production change external state; this documentation does not execute them. Substitute a reviewed environment and source revision rather than copying production settings into local development. Preserve the finite operation identity as HTTP method plus path; a renamed route, field repair or generated descriptor does not establish an implemented API.

## Runtime inventory and source anchors

| Component | Observed implementation | Operational consequence |
|---|---|---|
| Cloudflare APIs | `cloudflare/workers/src/service.ts` and `gateway.ts` | A shared service entry is compiled separately for each `SERVICE_NAME`; gateway uses service bindings. |
| Worker configurations | `scripts/generate-cloudflare-worker-config.mjs` | Generated `.cloudflare-workers/*.jsonc`, rather than a checked-in `cloudflare/workers/wrangler.toml`, are the deployment inputs. |
| API set | Auth, client, provider, visit, notes, billing, scheduling, notification, verification, compliance, governance, franchise-reporting | Twelve independent service Workers plus the gateway; existence of a Worker does not mean every declared endpoint exists. |
| PostgreSQL access | Worker `DB_URL` secret; auth schema checker | Runtime database and schema privileges must be verified separately. |
| Governance | `.agents/governance/governance.db` and registration scripts | SQLite declarations and permissions describe governed requirements; they are distinct from PostgreSQL application records. |
| TypeScript websites | `scripts/build-typescript-websites.mjs`, `websites/typescript/projects.json` | Release pipeline builds nine Pages projects from governed data. |
| Flutter applications | `apps/primecare_*`, `packages/flutter_core`, `packages/primecare_ui` | Shared auth/network/UI packages support web and native products. |
| Legacy/alternative Dart runtime | `compose.auth.yml`, `services/auth_api`, `services/api_gateway` | Separate PostgreSQL-backed Docker development path and Cloud Run workflow exist; do not assume it is identical to the Workers deployment. |

The alternative Cloud Run path is real repository configuration: `_deploy-api.yml` deploys to `northamerica-northeast1`, uses Artifact Registry repository `primecare`, and publishes Dart service containers. `production-deploy.yml` also references Google Cloud secrets and Cloudflare. Select one release topology deliberately; running every deployment workflow can publish different implementations or overwrite websites.

## Toolchain installation and verification

Observed version pins differ by workflow. Root `package.json` declares `npm@10.8.2`; the Worker test/deployment jobs use Node 22, TypeScript 5.9.3, Wrangler 4.68.1, esbuild 0.27.2 and `pg` 8.16.3 in isolated dependency directories. The monorepo validation job uses Node 24. Focused Flutter CI pins Flutter 3.41.5; `packages/flutter_core/pubspec.yaml` requires Dart `^3.11.3`. Android uses Java 17. Windows builds use `windows-2022` because the repository records a coroutine-toolchain compatibility issue with `local_auth_windows`.

Run this inspection before installing dependencies:

```bash
node --version
npm --version
python3 --version
flutter --version
dart --version
flutter doctor -v
git status --short
```

Record output with the source revision in the work package. A successful `flutter doctor` does not prove an application test. Android development also needs Android SDK/licenses and an emulator or physical device; Windows native builds need a supported Windows machine and Visual Studio C++ desktop build tools. These host requirements are proposed onboarding prerequisites; the CI runner is the observed reference environment.

Root dependency installation observed in `primecare_ci.yml` is `npm install`; Worker CI deliberately installs isolated dependencies with `--ignore-scripts`. Prefer a disposable checkout for reproducing the latter. The following is a source-backed reproduction of that dependency set, with a local temporary prefix replacing the Actions runner variable:

```bash
mkdir -p /tmp/primecare-worker-dependencies
npm install --prefix /tmp/primecare-worker-dependencies --ignore-scripts esbuild@0.27.2 pg@8.16.3 bcryptjs@3.0.2 typescript@5.9.3 @types/pg@8.15.5 @cloudflare/workers-types@4.20260403.1 newman@6.2.1
```

The workflow links that directory as root `node_modules`. Do not replace an existing developer dependency tree blindly. Use an isolated checkout or review the existing link first. Flutter package resolution is performed inside each package:

```bash
cd packages/flutter_core
flutter pub get
```

Offline dependency resolution is usable only when the complete dependency cache exists. A failed fetch or missing plugin is a failed prerequisite, not a skipped passing test. Do not commit transient dependency caches or platform build directories.

## Configuration and secrets ledger

Store values in approved secret managers or local ignored development configuration. Never paste connection strings, tokens, password hashes, session tokens or reset tokens into issue bodies, manifests, logs or these documents.

| Name | Observed consumer | Type and operational treatment |
|---|---|---|
| `CLOUDFLARE_API_TOKEN` | Worker and Pages deployment workflows | Cloudflare deployment credential; validate presence and scope without printing it. |
| `CLOUDFLARE_ACCOUNT_ID` | Same workflows | Deployment account identifier; select the intended account explicitly. |
| `PRODUCTION_DATABASE_URL` | Worker deployment, schema preflight, SQL migration workflow, production smoke | GitHub secret; deployment transfers it into Worker secret `DB_URL`. |
| `DB_URL` | Independent service Workers | Encrypted Worker secret; must be configured on each service that uses PostgreSQL. Gateway uses service bindings. |
| `SERVICE_NAME` | Generated service config | Nonsecret selector identifying the shared service entry’s behavior. |
| `AUTH_SOURCE_LIMIT` | Auth config | Cloudflare rate-limit binding generated from `auth-source-policy.json`; source policy supplies its limit/window. |
| `WORKSPACE_SOURCE_LIMIT` | Auth/client/provider/governance configs | Generated binding with 120 requests per 60 seconds in the inspected generator. This is not a global product SLO. |
| `EMAIL`, `EMAIL_FROM`, `EMAIL_ALLOWED_SENDER` | Generated auth config | Native send-email binding and sender configuration. Sender/domain authorization must exist externally. Binding existence is not delivery evidence. |
| `API_GATEWAY_URL` | TypeScript website build and Flutter reusable website workflow variable | Public endpoint, not a secret; build-time target must match the intended release environment. |
| `API_BASE_URL`, `APP_BASE_URL` | Flutter `--dart-define` flags | Compiled public configuration. Credentials must never be supplied as Dart defines. |
| `PRIMECARE_DB_PASSWORD` | `compose.auth.yml` | Required local development value supplied through the environment. |
| `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `DB_SSL_MODE`, `AUTH_SERVICE_URL`, `PORT` | Dart development/CI services | Per-service environment values; `disable` TLS is used only by the disposable local/CI fixtures. |
| `GCP_PROJECT_ID`, `GCP_WORKLOAD_IDENTITY_PROVIDER`, `GCP_SERVICE_ACCOUNT` | Alternative Cloud Run deployment | Google Cloud identity configuration. Cloud Run database secret name is `primecare-database-url`. |

**Proposed rotation procedure:** identify consumers and account scope; create the replacement credential; configure a nonproduction environment; verify a real authorized operation and a denied operation; update production through the approved change; verify; revoke the old credential; record timestamps and revision IDs without values. Database rotation must account for every independent Worker and any Cloud Run consumer. Changing only the gateway does not update its bound services’ secrets.

## Local development: start, inspect, stop

### Docker-backed Dart auth/gateway path

`compose.auth.yml` exposes gateway port 8700; auth remains internal to the Compose network. It initializes a persistent PostgreSQL volume from the development schema and auth-session migration on first database creation.

```bash
# Set PRIMECARE_DB_PASSWORD through your local secret mechanism first.
docker compose -f compose.auth.yml up --build -d
docker compose -f compose.auth.yml ps
docker compose -f compose.auth.yml logs --tail=100 auth_api api_gateway
curl --fail --show-error --max-time 5 http://localhost:8700/v1/auth/health
```

Verify that logs contain no credentials before attaching them to a report. A health response proves the checked health path, not all workflows. Initialize only disposable test users and test tenants. Existing volumes retain earlier schema: changing an initialization SQL file does not automatically migrate an existing volume.

Stop services while keeping the local database:

```bash
docker compose -f compose.auth.yml down
```

Do not append volume deletion for routine stopping. Deleting the named volume destroys its local records; a reset needs a distinct, explicitly reviewed development procedure. A reset is never a substitute for an application migration.

### Worker development path

Generate service configuration first:

```bash
node scripts/generate-cloudflare-worker-config.mjs
```

The generator sets compatibility date `2026-09-27`, `nodejs_compat` on services, observability, per-service variables, rate limits, auth email binding and gateway service bindings. Generated `main` paths are relative to `.cloudflare-workers`; moving these files changes entry-path resolution.

**Proposed local launch, not an observed tested development workflow:** use the installed pinned Wrangler with a selected generated configuration, for example `npx wrangler@4.68.1 dev --config .cloudflare-workers/auth.jsonc`. Confirm how local service bindings, PostgreSQL access, email and rate-limit bindings are emulated before using the gateway. The deployed gateway expects twelve named service bindings; running just a gateway process is not an end-to-end environment. Keep `.dev.vars` and local database credentials out of Git. Stop the foreground development process with Ctrl+C and verify the listening port is released.

### Flutter web application

A proposed local command, derived from the app build structure, is:

```bash
cd apps/primecare_client
flutter pub get
flutter run -d chrome --web-port=8085 --dart-define=API_BASE_URL=http://localhost:8700
```

The Compose gateway’s observed CORS origin is `http://localhost:8085`; choose that exact origin for this local topology. Worker production gateway CORS uses a separate Pages-domain policy. Verify login/logout and a failed request in the actual browser; compilation cannot establish cookie, bearer-session, CORS or tenant behavior. Flutter test navigation URLs must include `enable-semantics=true` according to `.agents/AGENTS.md`.

## Database preflight, migrations and dependency changes

`node scripts/check-auth-schema.mjs` reads `PRODUCTION_DATABASE_URL`, starts a read-only transaction, inspects column types and selected privileges, rolls back, and emits sanitized classifications. It does not select account data or prove a login. Its required relations include auth sessions/resets/audits/rate limits and tenant mail configuration/audit. Missing SELECT or INSERT privileges are detected; the checker is not a comprehensive authorization proof for every mutation.

The observed migration workflow dispatches manually, runs each `packages/database/migrations/*.sql` in filename order with `psql -v ON_ERROR_STOP=1`, and then checks connectivity. It has no visible applied-migration ledger or automatic rollback in that file. Do not assume every SQL file is repeatable or that the whole loop is one transaction.

**Required work package before a migration:** identify exact APIs depending on it; inspect the SQL; classify locks and destructive statements; verify schema and data types; test on a disposable database with the same identity representation; capture backup and restore evidence; define expand/contract compatibility; and link approval and execution evidence. Prisma `db-sync` is `prisma db push` in `packages/database/package.json`; it is not the production SQL workflow and must not be used as an unreviewed production repair.

**Proposed controlled migration procedure:**

1. Record release SHA, migration filenames and hashes, database environment identifier, reviewer, planned maintenance window and expected lock impact.
2. Obtain a recent verified backup and confirm its restoration path before changing data.
3. Rehearse exactly the SQL set in an isolated copy; check row counts and constraints before and after, without exporting patient records to reports.
4. Quiesce only the affected write workflow if compatibility requires it; preserve unrelated availability where safe.
5. Apply reviewed SQL with `ON_ERROR_STOP`; capture the failing filename and sanitized error classification on failure.
6. Confirm expected columns, indexes and constraints, then run operation-specific positive, denied, ownership, tenant and transaction tests.
7. Enable the new caller only after dependencies pass. Avoid removing old columns until all callers and rollback versions stop using them.
8. Record an applied-migration ledger as a proposed improvement; until implemented, verify prior application manually rather than rerunning every migration blindly.

## Backup and restore runbook

No automatic backup retention, encryption policy, restore schedule, RPO or RTO is established by the inspected workflows. These are open operational decisions. PostgreSQL and governance SQLite require distinct backups; repository history is not a complete application-data backup.

**Proposed PostgreSQL backup procedure:** use a dedicated backup identity and PostgreSQL client compatible with the server; target an approved storage location; produce a custom-format logical backup; encrypt and restrict access; record timestamp, database environment, client/server versions, size and checksum; inspect the archive inventory; restore into an isolated environment; verify schema, representative counts, relations and session behavior; then mark it recoverable. Use service connection configuration or a protected password file rather than putting a connection URI on an exposed command line.

Example templates are proposed and intentionally contain no live destination:

```bash
pg_dump --format=custom --no-owner --file=reviewed-backup.dump --dbname=reviewed-backup-service
pg_restore --list reviewed-backup.dump
pg_restore --no-owner --exit-on-error --dbname=isolated-restore-service reviewed-backup.dump
```

Never restore over production to test recoverability. Do not use `--clean` without reviewing deletion effects. A logical restore may require extension/role prerequisites and does not automatically restore Cloudflare secrets or external email configuration. Session and reset-token retention needs a security decision during disaster recovery; restoring old sessions can restore credentials that had been revoked after backup.

**Proposed governance backup:** use SQLite’s consistent backup API or a stopped-writer snapshot, retain the database hash plus source SHA, and run `PRAGMA integrity_check` on the copy. Do not copy a live database while ignoring WAL/SHM state. Preserve audit and finite-checklist identity when reconciling a restored database. An authority audit must not mutate the original database.

## Deployment sequence and verification

Observed `.github/workflows/deploy-cloudflare-workers.yml` requires `confirm=DEPLOY`, production environment selection and three secrets. It installs pinned dependencies; registers maintenance/workspace governance; typechecks Workers; generates configs; runs auth schema preflight; deploys each service; attaches `DB_URL`; checks independent health; deploys the gateway; checks aggregate health, all twelve `/v1/<service>/health` routes and browser CORS; uploads `worker-urls.txt`.

This order creates a brief interval between publishing a service and attaching its secret. Health propagation has retries. A secret or schema failure can leave a partial deployment. Treat the resulting URL artifact as an inventory, not endpoint acceptance evidence.

Observed TypeScript website deployment verifies gateway health, builds once, uploads the build artifact, deploys nine Pages projects with maximum parallelism three, and checks HTML plus `portal.json` propagation. Flutter `_deploy-web.yml` is a separate route using Flutter 3.41.5 and Wrangler 3.90.0. Do not publish both website families to the same Pages project without intentionally selecting which implementation should be served.

**Proposed release record:** immutable tested source SHA; operation package IDs; applicable workflow run IDs and conclusions; migration hashes; old/new Worker version IDs; old/new Pages deployment IDs; public configuration; secret revision identifiers; native artifact checksums; smoke-test evidence; rollback owner. No secret values or patient data belong in this record.

## Rollback and partial-deployment response

No single verified rollback script was found in the inspected files. Therefore rollback is a proposed procedure requiring a rehearsal, not a promise of automatic recovery.

1. Identify the failed component and last accepted artifact/version. Stop overlapping release dispatches; preserve diagnostics before changing anything.
2. Assess whether the previous code remains compatible with migrated schema and secret versions. A code rollback cannot undo data written under a changed contract.
3. For a service-only failure, restore its previous accepted Worker version through the approved Cloudflare deployment mechanism, preserving reviewed bindings and secrets. Verify version ID and API behavior.
4. For a website-only failure, restore the previous Pages deployment for each affected project; verify its compiled gateway target and cache behavior.
5. For a database failure, prefer a forward fix when compatibility permits. Restore requires the separate recovery procedure and a decision about writes made after the backup.
6. Verify positive and denied operations, login/logout, tenant isolation and idempotency after rollback. Health alone is insufficient.
7. Close the incident only after the public source/version map and finite readiness evidence agree.

A notable observed release risk: `release-primecare.yml` runs a governance job that commits the database to `main`, while downstream reusable jobs perform their own checkout. The verification source and deployed source need explicit comparison. Proposed improvement: pin every checkout to the same immutable tested SHA and publish governance changes through a separately validated change.

## Monitoring, performance and incident handling

Generated Worker configurations enable observability. This is configuration evidence; log retention, sampling, alarm recipients and production dashboards remain to be verified. `.agents/AGENTS.md` requires audit logging and security controls but does not supply numeric latency, throughput, RPO/RTO or alert thresholds.

**Proposed telemetry:** request count and duration by normalized operation identity; response status class; auth rejection and source-limit counts; database connection/query duration; dependency failures; idempotency conflicts/replays; migration status; deployment versions. Exclude bearer tokens, passwords, reset tokens, raw request bodies, names and clinical notes. Use correlation identifiers and a tenant-safe hashed attribution policy only after that policy is defined. Avoid unbounded labels such as record IDs and full query strings.

**Proposed performance test:** use disposable synthetic tenants; measure cold/warm requests separately; exercise paging boundaries and concurrent writes; capture p50/p95/p99 and error rate with load shape, duration and environment; verify that rate-limit rejection is distinguished from server failure. Set pass thresholds only after product targets and workload are agreed. A 0.21-second draft generator or a diagnostic scan duration is not an API latency benchmark.

Incident triage:

| Symptom | First source-backed checks | Safe next action |
|---|---|---|
| Gateway 404 | Exact method/path, gateway mapping, bound service version | Compare caller with registered handler; do not invent a broad catch-all alias. |
| 405 | `Allow` header and operation contract | Fix the caller’s method only when semantics match; do not treat it as an authorization failure. |
| 401/403 | Active session, actor/tenant binding, explicit API permission and ownership | Preserve denial; investigate scope without granting a generic admin bypass. |
| 503 | Sanitized schema preflight, secret presence, DB connectivity, result validation | Check dependencies and projection validity; do not substitute sample metrics. |
| Retry conflicts | Idempotency key, normalized payload, actor/tenant scope, stored response binding | Reuse the same key for the same intent; do not blindly create another write. |
| Email reset failure | Sender/domain authorization, binding configuration, reset expiry, template configuration | Avoid logging tokens; verify delivery separately from API acceptance. |
| Native app points to wrong API | Artifact build SHA and compiled `API_BASE_URL` | Rebuild from the accepted revision; a runtime website change does not alter an installed binary. |

Capture timestamps, source/deployment versions, normalized operation, status and sanitized classification. Preserve relevant test/run artifacts. Correct source and tests, rerun applicable gates, deploy the reviewed fix and verify actual behavior. An incident fix counts toward API completion only when that exact operation meets the finite checklist evidence requirements.

## Sources inspected

All at `3979ed1`: `package.json`; `packages/database/package.json`; `packages/flutter_core/pubspec.yaml`; `compose.auth.yml`; `scripts/generate-cloudflare-worker-config.mjs`; `scripts/check-auth-schema.mjs`; `scripts/cleanup-auth-rate-limits.mjs`; `.github/workflows/deploy-cloudflare-workers.yml`; `.github/workflows/deploy-database-migrations.yml`; `.github/workflows/deploy-typescript-websites.yml`; `.github/workflows/_deploy-web.yml`; `.github/workflows/_deploy-api.yml`; `.github/workflows/production-deploy.yml`; `.github/workflows/release-primecare.yml`; `.github/workflows/build_android.yml`; `.github/workflows/build_windows.yml`; `.github/workflows/primecare_ci.yml`; `.github/workflows/ci.yml`. Governance requirements: `.agents/AGENTS.md`.
