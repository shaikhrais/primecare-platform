# Client booking-request lifecycle and execution gaps

## Submission, cancellation and history

`POST /v1/client/booking-requests` creates a pending request for the authenticated client's unique profile and tenant. JSON accepts only service_type (nonempty, at most 100 characters), preferred_date (valid UTC ISO timestamp), preferred_time (optional null or HH:mm) and notes (optional null or at most 2000 characters). Bodies are bounded to 8192 UTF-8 bytes. Caller-supplied owner, tenant or status fields are rejected. Service type is the existing free-form request label, not an inferred service authorization or price quote. The preferred date is a request, not a guaranteed appointment.

`POST /v1/client/booking-requests/{requestId}/cancel` accepts no body or query. It locks the owned request and only transitions pending to cancelled. Missing/foreign requests return 404; approved, rejected or cancelled requests return 409. Approval, rejection and booking/visit assignment remain separate authority-controlled workflows.

Both writes require an explicit active bearer session, matching tenant and `Idempotency-Key` of 8–100 ASCII letters, digits, underscores or hyphens. The key is scoped to actor and tenant across actions. Same normalized input returns the original response with `Idempotency-Replayed: true`; different input returns 409. Replay also checks current profile/request ownership. A submission replay still returns its original pending response after subsequent cancellation; read the detail endpoint for current state. Creation returns 201; cancellation returns 200.

`GET /v1/client/booking-requests/{requestId}/audit` reads only owned request events with bounded limit/offset pagination. Responses project event ID, action, previous/new status and timestamp. Actor IDs, keys, hashes, notes and stored response payloads are excluded.

All responses are no-store. The Worker and gateway support Idempotency-Key CORS requests and expose the replay header. Source throttling uses the existing workspace binding. Mutations lock/recheck the actor and profile, serialize identical retry keys with a transaction advisory lock, and write business changes and audit together. Cancellation locks the request row to serialize competing state changes. Audit failures roll back the business write; missing audit storage returns 503. No new role grants or runtime DDL are introduced.

Apply the additive `20261005_booking_request_audit.sql` migration through the normal database deployment workflow before using these writes. Text audit identifiers support both auth identity representations. Audit history has no cascading foreign key and survives business-row deletion; the history API still requires a currently owned request. Retention remains a separate policy decision.

See `client-booking-lifecycle-batch-19.openapi.json` for schemas. The registration script records endpoints and persistence columns before implementation and links contracts to the existing client profile screen for page blueprints.

## API execution status

`GET /v1/governance/api-execution-status` requires existing inventory authority, an active explicit bearer session and tenant match. It returns all registered operations with declared implementation, verification state, recorded local fixture status, contract gaps and linked screens/apps/roles. Filters use the governance API's search/app/role/screen conventions; paging is bounded. Linked-screen filters now work for API contract lists as well.

The generated inventory and `API_EXECUTION_INVENTORY.md` distinguish blocked operations, recorded unit fixtures and verification pending. “Active” and “healthy” declarations do not prove runtime behaviour. Missing evidence does not prove code absent. PostgreSQL and production flags are conservatively false because no live probes or CI import populate this snapshot. Test status changes regenerate the final snapshot, re-run fixtures and bind evidence hashes to the final tested content.

See `api-execution-status-batch-20.openapi.json`. No permission inheritance or new inventory role grants are introduced.

## Verification

219 local API fixtures pass. Added coverage includes creation, cancellation, idempotency conflicts/replay, ownership reassignment, audit failures, validation, authentication, tenant scope, throttling, projected history, gateway/CORS and inventory authorization/filtering. PostgreSQL CI covers concurrent identical submissions, competing cancellations, foreign owners/tenants, atomic rollback, missing audit storage, expired sessions and text/UUID auth identity schemas. Local evidence does not claim PostgreSQL or production verification. No UI changes or deployment are included.

## Shared timestamp validation

Booking input, mutation projections and audit metadata reuse `accountUtcTimestamp` from the existing `account-read-projection.ts` module. Provider timesheet-item projections use the same boundary. The helper reuses the established account calendar and intrinsic Date checks while retaining these contracts' UTC-only syntax, zero to three fractional digits, and normalized ISO output. General `accountTimestamp` read contracts retain their offset/fraction-preserving behavior.

Adapter-provided Date objects cannot override instance methods to leak private fields or masquerade as valid timestamps. Booking mutation/audit regression fixtures exercise the actual handler and verify audit-before-commit behavior. `scripts/test-shared-utc-timestamps.mjs` checks normalization, calendar boundaries, invalid input, expanded years and Date overrides; the existing API verification runner includes it. No routes, permissions, business transitions or governance records are added. This reuse repair earns zero new API completion credits. PostgreSQL, exact-head CI and production evidence remain separately required.

