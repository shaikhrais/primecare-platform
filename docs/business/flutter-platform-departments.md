# Flutter tenant reference records

The registered platform administration entry `/platform/administration` now has a
shared Flutter implementation for tenant selection, reference-record reads and
creation. Departments use the existing `department` master type. This entry is
not a complete replacement for the TypeScript administration console: account
provisioning, reports, onboarding, recruitment decisions and training workflows
are separate capabilities.

The account overview offers navigation only after a successful current-session
platform index read. The route itself requires authentication and its server API
authorizes every read and mutation. No role-name substring, guessed grant or UI
role check supplies authority. The repository validates the index actor, selected
tenant membership, response shapes and exact creation receipt before displaying
results. The backend retains current-role, tenant, status, rate, audit,
transaction, uniqueness and idempotency checks. No production grants or business
migrations are changed by this implementation.

`PlatformMasterRepository` inherits `BaseApiRepository` and uses the existing API
client. `PlatformMasterController` inherits `BaseWorkspaceController`. Requests
follow Flutter → API gateway → governance Worker → PostgreSQL. The browser never
receives database credentials or performs SQL. The transport excludes these real
platform operations from path caches and synthetic response fallbacks.

Reads and writes capture their original authorization token. The shared security
interceptor does not inject `X-Tenant-ID` for platform administration: the server
resolves actor scope and the selected tenant from the registered path, and rejects
tenant override headers. Explicit caller override headers remain intact for
server rejection. Other endpoints keep their existing tenant-header behavior.

User, tenant, role or token changes dispose the scoped screen and controller,
clear its drafts and prevent old replies from reappearing. An in-flight command
is single flight. Unknown write outcomes and failed post-write readbacks retain
the original immutable fields, selected tenant and idempotency key. Only an
explicit retry submits that same command. No automatic retry or new command is
allowed while it is pending. Creation is shown as successful only after the
readback contains the exact receipt. A server denial clears visible tenant data.
The in-memory pending command does not survive a full page reload; inspect the
existing reference list and audit before submitting again after such a reload.

Labels reuse registered English/French/Spanish administration resources and live
screen text. The catalog generator validates existing screen 1269 and its route;
it never registers a route or grants access. Existing stable administration
control identifiers and theme spacing/typography are reused. Narrow-width and
enlarged-text presentation, scope changes, receipt mismatch, uncertain replay,
denials and actual transport headers have dedicated tests.

The existing API returns at most 100 tenants and 100 master records per list.
The interface states that limit. It does not invent paging or assume an absent
record is deleted. A created record outside a bounded readback cannot earn a
confirmed-success notice; the pending command remains available for review.

CI verifies pinned production screen/API identities read-only, isolated native
PostgreSQL persistence/rollback/tenant denials and Flutter transport, controller,
presentation and routing. These checks do not themselves create live HR
departments or establish live Twilio/Gmail/clinical-task acceptance. Select the
intended authorized tenant, check existing codes, create the requested reference
records through the API and verify reload/audit before reporting live completion.
