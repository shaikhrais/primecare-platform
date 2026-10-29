# PSW Coordinator additional charge

Tenant Admin and PSW Coordinator remain separate responsibilities. An active tenant administrator may receive an explicit additional-charge assignment, perform coordination with existing `scheduler` permissions, and return to Tenant Admin using the same login. Existing Tenant Admin permissions are preserved; this feature does not remove the administrator's existing scheduling access. Dedicated schedulers keep their existing workspace.

## User flow

Open Administration → Coordinator additional charge. A central administrator selects an organization; tenant administrators are scoped to their own organization. Select an active Tenant Admin, start date, optional exclusive end date and reason. The recipient opens this same page and chooses Open coordinator workspace. End additional charge records a reason and removes access through that assignment. Historical data and the primary role are retained.

The initial self-contained HTML is `docs/care/previews/coordinator-additional-charge.html`. Its controls explicitly report preview-only behavior. Production uses the same view renderer with authenticated database responses, not HTML sample records.

## Authority and storage

- Governance catalogue: `packages/shared/src/coordinator-charge/catalog.json`, scoped by `pswCoordinatorChargeWriter` in the production pin; registration runs before runtime publication.
- Operational PostgreSQL: `psw_coordinator_charges`, `psw_coordinator_charge_events`. Native user/tenant identity column types are preserved by migration.
- No assignments, accounts, clinical approvals or sample staff are seeded in production.
- Assignment creation is serialized per tenant; overlapping unrevoked assignments for the same employee are rejected. Revocation requires the current version.
- Dates are resolved by PostgreSQL at midnight America/Toronto. End is exclusive. Null end means until explicitly revoked.
- Current primary role must remain Tenant Admin; active account and tenant are rechecked. Changing role/tenant or suspending an account invalidates coordinator context.

## Transport and permissions

GET/POST `/v1/governance/care/additional-charge`; optional `tenant` query is restricted to central administrator roles. Explicit bearer session, no tenant header, JSON mutation body and 16–100 character idempotency key. Post actions: assign, revoke, enter. Primary manager roles are listed in the catalogue. An employee can enter only their own active assignment.

The browser stores only a token-bound workspace selection in sessionStorage. Care-domain clients send `X-Requested-With: primecare:psw-coordinator:<charge UUID>`, supported by existing gateway CORS. This header is never sufficient authority. Every care API transaction verifies the current assignment with a shared row lock and uses the existing scheduler authorization policy. The charge-management API always checks the primary role. No other domain receives this context.

Care writes and PSW request/demo writes append a separate immutable coordinator audit containing actor ID, primary role, effective role, charge ID, action and path/dataset. Existing clinical audit remains intact. Idempotency fingerprints include the context. No self-time or own-request review; clinical approval remains restricted to the native clinical workflow. A changed charge is denied even when replaying an earlier care request.

## Validation and limits

`node scripts/test-psw-charge.mjs` exercises independent PostgreSQL readback, role preservation, grant/revoke/expiry, same-tenant isolation, replay/overlap, native staffing save, own-time denial, clinical denial and immutable audit. Existing workspace and personal suites run in release CI. Browser QA uses disposable isolated fixtures; it does not grant access to real staff or prove an authenticated real-employee production session.

Latest 100 eligible administrators, assignments and audit events are displayed; central organization picker is capped at 500 and reports truncation. Assignment mutations are limited to 30 recent audit events/minute/actor. The live UI is English; independent translation and formal accessibility review are not claimed. Governance status remains implemented-unverified until independent review.
