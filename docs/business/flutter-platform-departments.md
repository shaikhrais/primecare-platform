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
transaction, uniqueness and idempotency checks. No production grants are changed
by this interface.

The selected tenant's reference list must load successfully before creation is
enabled. A failed list read never establishes an empty list or permits a write.

Global administration does not require a tenant claim in the client session
projection. The API resolves the current native tenant itself; an absent or
unauthorized native scope is still denied by the server and displays an error
rather than an empty page. A nullable client tenant remains part of the local
session-change boundary, so later tenant changes dispose the previous view.

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

## Production storage repair

Live testing reached the tenant selector, then the Admin HQ list read failed.
Read-only production schema inspection in run 40092411726 confirmed that all four
platform administration tables were absent. No department write was attempted.
The existing migration `20261011_platform_administration.sql` is the source for
the repair; no substitute schema or guessed business records are introduced.

The dedicated foundations workflow first validates native PostgreSQL schema
profiles for all UUID/text parent identity combinations, dry-run rollback,
idempotency, unique department codes and foreign keys. It also reruns the actual
platform API persistence/authorization tests. Production application requires
that same source-specific artifact, an exact migration digest/opt-in, the pinned
governance manifest, screen 1269 and API identities 16434/16441/16442. It rejects
partial or differing existing schemas, validates the complete resulting columns,
constraints and indexes, and checks the dry-run rollback or committed result in
a new read-only transaction. It creates no accounts, permission grants or master
records. Completion still requires its passing application receipt and live API
creation/reload, not merely the presence of this workflow.
