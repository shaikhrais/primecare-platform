# Tenant operations overview

This adds one API-connected section under **Platform Administration → Tenant operations**. It helps central/platform administrators find administrative gaps across tenants, while tenant administrators can inspect only their own organization. The implementation is local; human review, PostgreSQL CI and live deployment remain pending.

## Completed work

1. Registered the requirement, role scopes, section, approved components, stable test selectors, read API, request/response schemas and EN/FR/ES resources in governance before implementation. The existing administration shell and theme are reused.
2. Added search by tenant name or slug, All/Needs attention/Active/Inactive filters, and bounded 25-row pagination. Search is literal and case-insensitive. Summaries cover the complete filtered result, not just the visible page.
3. Added API-derived active account/administrator counts, active location and service-category counts, sold territory counts, and senior totals from the governed territory catalog. Separate SQL aggregates prevent counts being multiplied when a tenant has several accounts, reference records and territories.
4. Added setup findings and direct links to manage accounts, manage reference records and view the territory board. The accounts/reference links select the corresponding tenant. Navigation and Refresh retain tenants outside the topbar’s first hundred choices.
5. Added a responsive mobile presentation of the same native table as stacked tenant cards. All action buttons fit the viewport. Labels, filters, findings, notices and navigation have English, French and Spanish resources.
6. Added API/role, aggregation, filtering, pagination, failure/retry, clean-registration and browser checks. Screenshots use synthetic tenants. Test schemas are dropped and their removal is verified.

## How an administrator uses it

1. Open Tenant operations and choose **Needs attention** or search for an organization.
2. Read its findings. Use **Manage accounts** for missing administrators, or **Manage reference records** for missing location/service-category entries.
3. Save corrections through the existing administration forms. Account/master writes retain their existing API authorization, optimistic versions, idempotency and audit behavior.
4. Return to Tenant operations to recalculate the findings. A corrected tenant leaves the Needs attention filter. Use **All tenants** to inspect its updated counts.

Global administrators receive all permitted tenants. Tenant administrators receive only their own tenant, including matching summary totals; search and pagination cannot broaden that scope. The operations endpoint never returns account emails, credentials, patient records or staff contact details.

## Governed checks and boundaries

For an active tenant, Needs attention means at least one of these is absent:

- One active administrator account with role `tenant_admin`, `platform_admin` or `central_admin`.
- One active `location` reference record.
- One active `service_category` reference record.

An inactive tenant needs attention when it still owns sold territory. An unrecognized tenant status is flagged for review. Paused tenants without territory are not automatically treated as behind schedule. Counts are descriptive: the system does not reactivate tenants, create accounts or modify territory ownership automatically.

These are **administrative setup checks**, not clinical authorization, staffing coverage, deadline/payroll compliance, PSW qualification or care quality certification. A service-category record’s existence does not prove that a particular care service is staffed or approved. Territory senior totals are from the 2021 Census planning catalog, not current population or client counts. The territory board retains its existing global-versus-own scope; its navigation link does not add a new map filter.

## Architecture and API

- Read API: `GET /v1/governance/platform/operations`.
- Optional query fields: `search` (100 characters maximum), `filter` and `offset` (0–100,000). Unknown, repeated and invalid query parameters are rejected. `X-Tenant-Id` is rejected; session identity determines scope.
- Authentication: active bearer session, active user and active home tenant. Only the three governed administration roles may read it. Source limiting is enforced when `WORKSPACE_SOURCE_LIMIT` is configured.
- Consistency: aggregate totals and the visible page come from one read-only, repeatable-read transaction. The governed territory catalog is checked before senior totals are returned. Failure returns an error rather than a partial success response. A failed refresh clears stale counts in the UI while preserving search/filter input.
- Separation: the browser client contains HTTP calls; the controller handles presentation state; the panel renders data. SQL, role checks and setup classification are in the API. The browser has no database adapter.

The complete contract is [openapi.json](openapi.json). The new read-only API is additive and does not count as closing any legacy API backlog entry.

## Installation and verification

The platform administration and territory migrations must already be installed. `20261016_tenant_operations_indexes.sql` adds two repeatable optional performance indexes; it creates no new business tables.

```sh
python3 scripts/register-tenant-operations.py
python3 scripts/register-tenant-operations.py --check
PLATFORM_TEST_DATABASE_URL=postgresql://... node --test scripts/test-tenant-operations.mjs
```

The website build runs the registrar automatically. It installs the existing approved admin/growth dependencies before adding its section and exporting policy/OpenAPI from governance. `--database PATH --check` checks an isolated in-memory copy of a selected governance database. Registration/export checks pass against both the current working database and a snapshot of the committed database. The local governance database is not part of the source commit.

Local verification uses PGlite and headless Chromium. All **16 new checks passed**, including six English/French/Spanish cases at 320 and 1440 CSS pixels. Browser tests correct a caregiver’s role to tenant administrator, create location and service-category records through the existing forms, then confirm the tenant leaves the attention filter. Additional cases cover more than 100 directory entries, literal search, wrong roles, expired sessions, inactive tenants, text/UUID keys, malformed limiter results and stale-count removal on failure.

Existing administration/territory regression suites add **24 passed checks**, with one independent-connection PostgreSQL race test skipped locally. That race remains a PostgreSQL 16 CI requirement; these local checks are not concurrency proof. TypeScript 5.9.3 and all nine website builds pass. The browser bundle contains zero worker/database modules. Physical-device testing, full accessibility review, production scale measurements, human approval and deployment are pending. See [test-results.txt](test-results.txt) for the recorded local output.

## Visual evidence

All screenshots show **synthetic QA data**, not real organizations or business results.

| Screenshot | Review result |
| --- | --- |
| [Before setup](screenshots/before-setup.png) | Three missing setup items and the corresponding correction actions |
| [After setup](screenshots/after-setup-1440.png) | Administrator, location and category present; attention count becomes zero |
| [Mobile overview](screenshots/after-setup-320.png) | Compact summaries and translated filters at 320 CSS pixels |
| [Mobile tenant card](screenshots/mobile-setup-card.png) | Readable setup details and full-width actions without horizontal clipping |

Visual review found and corrected an untranslated check label and an inherited wide-table rule that clipped mobile actions. Human approval is still pending.
