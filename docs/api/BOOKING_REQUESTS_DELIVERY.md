# Legacy booking request action routing

Work package: one exact operation, `POST /v1/client/bookings/requests`.

The existing `btn-client-booking-request` button and `client-booking-request` interaction declare submission for approval at this path. The gateway previously forwarded it to `/bookings/requests`, which the Worker interpreted as read-only booking detail with ID `requests` and rejected with 405. This was not a list workflow.

The exact POST now forwards to the existing `/booking-requests` lifecycle, retaining body, bearer, tenant and Idempotency-Key headers. Its existing registered `authenticated_client_profile_owner` authority requires an active session, a unique own client profile and matching non-null tenant. It creates only a pending request, with the existing bounded input, source limit, transaction, audit and actor-scoped retry contract. It does not approve requests or create confirmed bookings. No permissions or role grants are expanded.

`BOOKING_REQUESTS` retains the legacy submission path used by both actions. `BOOKING_REQUEST_LIST` now names the existing canonical GET `/v1/client/booking-requests`, removing a misleading read reference. The submission actions remain declarations; rendered UI execution is not verified here. The original singular submission alias continues to work. Confirmed-booking collection POST and extra/nested paths remain unsupported.

Evidence:

- Caller paths: `packages/domain/src/registries/ButtonRegistry/tenancy-buttons.ts`, `packages/domain/src/registries/InteractionRegistry/base.ts`, `packages/domain/src/registries/ApiRegistry/tenancy.ts`.
- Registration and contract: `scripts/register-booking-requests-delivery.py`, `docs/api/booking-requests-delivery.openapi.json`. Authority and schema drift fail before writes.
- Unit and negative authorization: `scripts/test-client-booking-lifecycle-api.mjs` exercises the actual gateway and Worker; owner/profile/session/tenant rejection, malformed input, write rejection, audit failure and cross-alias replay.
- Operation-specific PostgreSQL suite: `scripts/test-client-booking-lifecycle-postgres.mjs` submits creation through this plural alias, including mixed singular/plural concurrent retries, real persistence, foreign ownership, tenant rejection and rollback. Both UUID/text identity CI jobs must pass for the unchanged PR head.

Finite checklist after unit evidence: 342 of 1,415 unique operations have unit evidence; 1,063 need reconciliation/verification; 10 retain registered blockers. This package earns one unit-evidence milestone. Registry field changes and fixture counts earn no additional API credits. PostgreSQL and production evidence remain separately reported; no production deployment or authenticated UI verification is claimed.
