# Client booking requests (Batch 18)

`GET /v1/client/booking-requests` lists the authenticated client's requests with bounded limit/offset pagination. `GET /v1/client/booking-requests/{requestId}` returns one owned request or 404. Request IDs follow the existing bounded alphanumeric/underscore/hyphen convention. Detail accepts no query parameters.

The list returns `requests` and `pagination: {limit, offset, total, hasMore}`. Detail returns `request`. Metadata fields are id, service_type, preferred_date, preferred_time, status, created_at and updated_at. Notes and client/tenant identifiers are excluded. Preferred time can be null. Stored statuses are returned without interpreting approval or creating a booking.

Ownership derives from the bearer identity's unique client profile and tenant. SQL additionally restricts booking_requests.client_id and tenant_id, and detail binds its exact ID. Missing or foreign records return 404; tenant-header mismatch returns 403; invalid sessions return 401. Ambiguous profiles and backend failures return 503.

List accepts limit 1–100 (default 25) and offset 0–100000 (default 0). Ordering is created_at DESC, id DESC. Total counts owned requests and remains available on empty offset pages. Arbitrary owner/status filters, duplicated parameters and request bodies receive 400. Mutations receive 405. Reads retain source throttling, read-only repeatable-read transactions and no-store responses.

The reproducible registration script links both OpenAPI contracts to the existing client profile screen for governance page-blueprint consumers. See `client-booking-requests-batch-18.openapi.json`. No new role grants or screen production-readiness claims are added.

Validation: 202 local API fixtures, worker TypeScript and governance guardian checks pass. PostgreSQL tests add owner/tenant isolation, absent detail, null preferred time, offset pagination and empty data coverage for text/UUID auth identities in CI. Local evidence does not claim PostgreSQL or production verification. Creating, approving, rejecting and cancelling requests remain separate pending write workflows. No UI changes or deployment are included.
