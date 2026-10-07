# Booking submission work package

Fixed scope: **1 unique operation**, `POST /v1/client/bookings/request`.

The routing audit found this POST rejected by the client booking detail handler. Caller review found two explicit POST forms in `packages/domain/src/registries/FormRegistry/client-forms.ts`. Their request intent matches the existing pending-request lifecycle at `POST /v1/client/booking-requests`.

The gateway now forwards only this exact POST to the canonical lifecycle. It preserves bearer, body, tenant header and Idempotency-Key; other methods receive 405 with Allow: POST before forwarding. Booking collection/list POSTs remain denied. This creates a pending request, not a confirmed appointment. No new role grants or independent write implementation are introduced.

The two form declarations now use service_type, preferred_date (explicit UTC timestamp), optional preferred_time and notes, and declare the required Idempotency-Key. Old serviceTypeId/date/time/duration bodies fail validation instead of being silently interpreted. Form catalog alignment does not establish an authenticated browser journey or UI readiness.

Authority: active explicit bearer session, actor tenant and a unique owned client_profiles row. The canonical handler derives client/tenant, rechecks session validity, locks actor/profile and stores the request and audit atomically. Both routes share actor/tenant idempotency semantics. Arbitrary owner/tenant fields are rejected.

Registration validates canonical authority, matching request/response contracts, screen links and the unique alias before writing. Six authority/contract drift cases prove that failure leaves the database and existing artifact unchanged.

Verification:

- Actual gateway and Worker fixtures: audited creation, replay, missing session, tenant mismatch, absent profile, invalid legacy/override body, missing key, query override, wrong methods and audit rollback.
- Caller contract checks for both forms.
- `scripts/test-client-booking-lifecycle-postgres.mjs` submits creations through the gateway route and checks persisted request/audit state, concurrent retries, tenant rejection, stored-result validation, source limits, rollback, expired/inactive sessions and profile reassignment. CI runs UUID and text auth identities.
- Full API fixtures, authority regressions, Worker typechecks and governance guardian.

Finite counters after source-bound unit evidence: **341 unique unit-evidenced operations, 1,064 pending and 10 blocked, out of 1,415**. This package resolves one routing/contract milestone. Test cases and field edits are not extra operations. Exact-head PostgreSQL/security evidence is recorded in the merge checkpoint; production remains unverified.
