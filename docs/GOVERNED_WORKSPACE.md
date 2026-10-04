# Governed workspace and page creation

The shared web and Flutter workspace replaces the dashboard fallback and generated successful-offline responses. `scripts/register-workspace-governance.py` reconciles explicit office/role routes, creates missing governance sections, and exports the runtime catalog and native routes from `governance.db`.

## Behavior

- Login opens a registered page granted to the authenticated role.
- CEO telemetry reads active organization accounts, active sessions, account-role distribution and recent account/configuration audit activity. Clinical operational counts are read only when their tables have a tenant column; otherwise the metric is unavailable. No global healthcare counts or invented values are shown.
- Page navigation and inventory follow server-resolved grants. CEO, governance and maintenance can inspect readiness metadata; this does not grant access to another role's business data.
- Every generated page renders its registered sections and exposes stable test identifiers. Dashboard metric, chart, activity and navigation sections have working implementations. Sections without domain business bindings explicitly report that dependency, and no unimplemented mutation appears to succeed.
- Search, pending-work filter, pagination, CSV export, refresh, account access and sign-out work in the web workspace. Windows uses the same API and governed page/navigation model. Existing account and maintenance pages retain their implementations.

## API contract

`GET /v1/governance/workspace?screen=<screen_code>` routes through the gateway to the governance Worker. The optional code must match `[A-Za-z0-9_]{1,160}`. An explicit Bearer session is required. The active session, active user and tenant are rechecked against PostgreSQL on every request. An optional `X-Tenant-Id` must match the server-resolved tenant.

Response: `identity {userId,role}`, `landing`, granted `screens`, requested `screen` (or null), authorized `actions`, readiness `inventory`, resource-key `resources`, and `overview {activeAccounts,activeSessions,accountRoles,activity,metrics,scope}`. Lists of pages contain their registered sections, grants, lifecycle and blockers. There are no user passwords, mail credentials, session tokens or patient rows in this response.

Errors: 400 invalid code; 401 missing/expired/revoked session or disabled account; 403 tenant or page permission mismatch; 404 unknown page; 405 unsupported method; 429 source limit; 503 unavailable database/workspace. Responses use `Cache-Control: no-store`. Cloudflare enforces 120 requests per 60 seconds per source. Reads run in a read-only transaction and do not manufacture audit mutations. Account/configuration events displayed on the dashboard come from their existing audited workflows.

## Honest governance state

Page creation is separate from business-feature completion. Generated views are tagged `created` / `partial` / `workspace_connected`. Their business contracts, authenticated browser tests across all roles, translations and review must still be completed before `production_ready` can be set. Existing blanket template/API/test claims are reset. `docs/audits/page-readiness/inventory.csv` enumerates every active page and its remaining work.

## Verification

Run Node workspace security/navigation tests, the auth regression tests, TypeScript checks, disposable PostgreSQL tests with UUID and text identities, and Chromium navigation/accessibility tests. Browser previews use synthetic fixtures. The production smoke test creates a unique synthetic QA tenant, verifies real login/dashboard and role/tenant denial through the public gateway, and removes its fixtures. The release workflow rebuilds all nine Windows distributions and deploys all nine websites only after the initial checks pass. Automated accessibility checks are evidence for the tested view, not certification of every business page.
