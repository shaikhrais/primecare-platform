# Client booking collection submission reconciliation

One exact operation: `POST /v1/client/bookings` (declaration 237).

The `client-book-req` Request Booking touchpoint uses this path. The existing GET page list and form option source use the same collection URL. Exact POST now forwards to the canonical `/v1/client/booking-requests` lifecycle; GET retains its existing read alias. PUT/PATCH/DELETE remain rejected. No confirmed appointment is created.

Governance registration copies the canonical request/response contract only after validating service, authenticated owner authority, schemas and screen links. The active explicit bearer session determines the user and tenant; a unique client profile must belong to both. No role grants are added. Inputs are service_type, preferred_date (UTC), optional preferred_time and notes; Idempotency-Key is required. Legacy field names, owner/tenant overrides and query parameters fail closed.

Actual gateway/Worker fixtures cover creation, cross-alias replay, authority failures, strict validation and audit rollback. The operation-specific `scripts/test-client-booking-lifecycle-postgres.mjs` uses this exact route for creation and negative cases, with concurrent retries through all three submission aliases and persisted request/audit counts. UUID/text PostgreSQL CI and security must pass before merge. GET read-alias regressions continue to test denied unsupported methods; its deliberate POST submission exception has separate lifecycle tests.

Finite checkpoint after passing unit evidence: 343 unit-evidenced unique operations, 1,062 pending and 10 blocked out of 1,415. This package resolves one operation; caller field/documentation edits and test totals earn no extra credits. Production deployment and authenticated UI checks remain unverified.
