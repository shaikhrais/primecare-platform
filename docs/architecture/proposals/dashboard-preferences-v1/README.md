# Dashboard preference contract candidate

Status: draft, not registered or activated. These files are not imported by runtime code or the migration runner. API 777 still accepts its existing three kinds. No endpoint, grant, widget binding or database record is created here.

The candidate adds `kind: dashboard` to the existing POST `/v1/user/preferences` envelope. It preserves API ID 777, version 1, existing kind names and `DashboardSession`/master interfaces. Only layout placements are stored: version 1 plus views containing widget ID, span and row count. Financial values, labels, source credentials and business data are forbidden in this document.

The request and response schemas share bounded definitions: at most eight viewports, 60 placements per view, 12 columns, 20 rows, safe revisions and v4 request IDs. The existing 64 KiB encoded-document limit must still be enforced by the server. JSON schema validates structure, not ownership, registered IDs or permissions.

## Required server binding

A resource is the existing DashboardSession-compatible lower-case/hyphen key, at most 64 characters. It must resolve through an explicitly registered server binding to an existing screen and its authorized widget/view registry. It is not inferred from a DOM ID, URL, client-supplied registry or automatically transformed screen code. Existing underscore screen codes need no renaming.

For every read, write, reset and delete, the server must derive tenant, user, active role and dataset from the authenticated session, compare the expected scope and dataset, recheck active screen/view grants and load the approved registry. Missing bindings deny access. Each widget must retain registered component/source/workflow identities and per-view bounds. The current validateDashboard validator must run against this server-owned registry; duplicate widget IDs, unknown IDs, forbidden views and out-of-bounds spans must fail even when structural JSON schema accepts them.

Writes use the existing revision, request ID, actor locking, receipt and independent readback rules. The HTTP adapter must verify the API snapshot scope, kind, resource and revision before mapping it to the unchanged DashboardSnapshot port shape. No save is reported successful merely because a request was dispatched or a write response arrived.

## Database and rollout gates

The checked-in preference migration restricts kind in both account_preference_documents and account_preference_audit to theme/workspace/shortcuts. migration.draft.sql describes the additive constraint change; it has not been applied or tested against live physical constraints. No new table or role grant is proposed.

The current worker also compares registered request/response schemas with its bundled contract exactly. Updating API 777 metadata first would make the old worker reject existing preferences with contract_unavailable. A coordinated, governance-approved compatibility rollout is required:

1. Register/approve the staged contract and migration authority through the existing governance process without replacing the active API schema prematurely. Confirm the available staged-contract mechanism; none is invented by this proposal.
2. Verify the actual preference-table constraint names, definitions and migration target in a read-only preflight. Prepare rollback without deleting personal settings.
3. Prepare a backward-compatible worker and clients that accept the exact approved old/new contract versions, while denying dashboard operations until both registration and server-owned bindings are present.
4. Apply the authorized additive storage migration and coordinate worker promotion with the active metadata transition. Retest existing theme/workspace/shortcuts throughout; do not introduce a contract mismatch outage.
5. Approve each real dashboard binding, then verify owner isolation, forbidden roles, revision conflicts, lost acknowledgements, independent readback, retries, reload and account changes before activating consumers.

The fixture tests check candidate payloads, the existing registry validator and the fact that current runtime still rejects the unregistered kind. They do not certify a server implementation, migration, live write or full Fuse dashboard acceptance.
