# Tenant onboarding and territory allocation verification

User scope: test tenant creation and its next tasks, including selling/allocating a territory to a tenant. Work remains on main only. The review starts at `4fbd9be4`.

Registration is a requirements/specification record, not proof of a deployed Flutter screen or a completed business process. Source-mapped definitions can have implemented backend handlers, older TypeScript presentation and missing or unverified Flutter presentation. The historical export explicitly records pending end-to-end execution/reviews. Current status must be read from pinned production PostgreSQL; historical exports are not a substitute.

## Existing sequence under test

| Step | Existing source behavior | Evidence required |
| --- | --- | --- |
| Partner onboarding | Authorized activation creates a tenant and tenant-admin account | Tenant/account hashes, role and audit persist atomically; forbidden actors denied |
| Tenant creation | Global platform/central administrator creates an active named tenant with unique slug | Persistence, UUID/text identities, idempotent replay and rollback |
| Tenant setup | Authorized account and location/department/service reference setup | Correct tenant scope, no role escalation, audit and reread |
| Territory board | Available, sold and reserve areas; active operating-tenant selection | Correct catalog, scope and counts |
| Record confirmed sale | Approved agreement reference, services and explicit confirmation allocate an available area to an active tenant | One sale and audit, locked ownership, duplicate-sale race rejection, retry and reload |
| Launch | Setup/documents and explicit submitted review/approval | Prerequisites cannot be skipped; stale approval invalidated |
| Operations | Setup monitoring, renewal/support and appropriate territory enquiry routing | Tenant isolation, state changes and denied alternatives |

The territory allocation handler records an already-approved sale. It does not itself charge a payment method or execute an agreement signature. No real territory sale, agreement, payment or customer account is changed by the isolated tests.

## Verification scope

`Verify tenant onboarding and territory allocation` reads current production workflow metadata without business writes. Separately, native disposable PostgreSQL and headless Chromium execute existing tenant, territory, launch, operations and partner-onboarding suites. Browser portions exercise the existing TypeScript client; they do not earn deployed Flutter acceptance. No typed Flutter provisioning/territory binding has yet been located in the current source scan. Actual current-portal proof remains required before calling that UI ready.

Run results and exact gaps will be recorded after execution. Existing screenshots, old README deployment statements and registration counts are not current release evidence. No SQLite live authority or fallback is used.
