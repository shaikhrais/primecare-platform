# DRAFT — assigned verified branch count, pending owner choice

Local alternative against main `f9082060be9180241fca0844033b0efd9e03d5bd`. No commit, publication or production approval. Separate worktree preserves the prior booking-count candidate. This alternative must not be applied on top of that candidate; select one patch against the stated base.

## Exact behavior

GET `/v1/clinical/dashboard` returns only `{"assignedVerifiedBranchCount": 2}` when the signed-in active Clinical Director has two distinct currently assigned active verified branches in their active tenant. It is a scope count, not a working appointment dashboard or clinical activity metric.

The actual gateway forwards only this canonical GET to GOVERNANCE. The actual ServiceWorker performs session/user/tenant authorization and `COUNT(DISTINCT branch_id)` over `public.clinical_branch_director_effective_scope`, filtered by both server-derived tenant_id and director_user_id in one REPEATABLE READ READ ONLY transaction. The reviewed view enforces current grants, active user/tenant, verified/nonretired branches, expiry and revocation. Duplicate effective rows cannot multiply the count. No bookings table is queried or needed. No branch, tenant, user or patient identifiers are returned. No scope inference or fallback grants.

Missing/expired session or inactive user/tenant: 401 unauthenticated. Wrong role: 403 forbidden. Zero assigned effective branches: 403 no_scope, not a successful zero. Missing view/read access or invalid/unsafe count: sanitized 503 unavailable. No query/body/tenant overrides: 400. Non-GET: 405. Duplicate-dashboard and nested service aliases remain excluded. Responses are no-store; existing limiter behavior, token hashing and actor validation remain. No audit writes or new write paths are added.

## Evidence and reproduction

`route.test.mjs` bundles the real gateway and ServiceWorker, replacing only pg connection transport with isolated PGlite. There is no bookings table in this fixture. Cases cover distinct duplicate effective rows and historical grants, other actor/tenant isolation, retired/future-verified/revoked/expired scope, changed role/user/tenant/session, empty scope, missing view and read access, minimum column access, route/input/rate boundaries and actual read-only transaction mode. Handler SQL is asserted to contain only SELECT/BEGIN/ROLLBACK and never bookings. Fixture DDL/DML/grants are disposable local test setup only, not production actions.

Run with installed dependencies:

```sh
NODE_PATH="$PWD/node_modules" PGLITE_FIXTURE_MODULE=/absolute/path/to/@electric-sql/pglite node --test tests/fixtures/clinical-director-api-candidate/route.test.mjs
node --test scripts/test-worker-inheritance.mjs
npx --no-install tsc --noEmit --allowImportingTsExtensions --skipLibCheck --module esnext --moduleResolution bundler --target es2022 --types @cloudflare/workers-types,node cloudflare/workers/src/service.ts cloudflare/workers/src/gateway.ts
npx --no-install esbuild cloudflare/workers/src/service.ts cloudflare/workers/src/gateway.ts --bundle --platform=node --packages=external --outdir=/tmp/clinical-branch-draft-bundles
```

PGlite exercises PostgreSQL-compatible SQL, not native PostgreSQL production behavior. Local bundles are not sealed Cloudflare deployment artifacts. The existing prototype fixtures are not evidence of this implementation; the real route test above is.

Run the Windows review script or the commands above for current evidence. The prior isolated GitHub run exercised the earlier candidate, not this updated patch.

## Remaining gates — no live verification performed

First obtain owner choice of this exact branch-only response. This draft does not resolve booking timestamp provenance or serve appointment metrics. No UI edits, production connection, role grants, seeds, pushes, CI dispatch or deployments were performed. No denied setup was retried.

Runtime source is `auth.ts` withDb -> pg.Client using governance Worker env.DB_URL. Generator maps GOVERNANCE to primecare-governance-api and SERVICE_NAME=governance. Actual runtime database principal remains unverified; CI PRODUCTION_DATABASE_URL/migrator identity is not its substitute.

An independently authorized operator must verify serving bindings and principal provenance without exporting credentials, then use the reviewed `runtime-read-preflight.sql` with that same principal: read-only transaction, bounded timeouts, privilege/catalog booleans and WHERE-false compilation only, rollback. No session/clinical rows or principal identifiers are emitted; suppress raw exceptions and retain only labels/SQLSTATE. Minimum schema USAGE and SELECT columns: auth_sessions(token_hash,user_id,expires_at), users(id,tenant_id,roles,status), tenants(id,status), effective_scope(tenant_id,director_user_id,branch_id). No bookings privilege, authority-table grant or write is required. Confirm owner-rights view definition/dependencies, RLS visibility, actual rate binding and query plan separately; do not grant automatically. Empty approved authority objects imply no_scope.

Endpoint read-audit policy remains unresolved: existing access audit supports grant/revoke, not an approved read-event write. Preserve that separate gate. Follow tools/deployment/SMART_DEPLOY_OVERVIEW.md: main-only approved integration, exact-SHA API verify-only CI, and separately approved selective publisher/binding/rollback receipts before any release. This local draft is not production-ready approval.
