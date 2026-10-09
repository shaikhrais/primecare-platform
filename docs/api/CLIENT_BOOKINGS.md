# Own client bookings (Batch 9)

| Method | Gateway route | Response |
|---|---|---|
| GET | /v1/client/bookings | Own booking list with bounded pagination |
| GET | /v1/client/bookings/{bookingId} | One own booking or 404 |

The active bearer actor must own a client_profiles row through user_id, with matching tenant_id. Every booking query checks both that profile's client_id and the actor tenant. Screen grants do not bypass ownership. No arbitrary client/user/tenant filter is accepted. Optional X-Tenant-Id must match the actor. No profile returns 404; ambiguous ownership fails closed. Foreign and nonexistent bookings both return 404.

Returned fields: id, start_at, end_at, service_type, priority, status and recurrence_rule. Notes, branch identifiers and unrelated clinical data are excluded. Recurrence rules and statuses are stored values; no new scheduling semantics are inferred. List supports limit 1–100 and offset 0–100000, ordered by start_at descending then id descending. Detail accepts no query fields. Malformed IDs, duplicate/unknown query fields, bodies and unsupported methods are rejected.

Both routes reuse client source throttling (namespace 2026100403), no-store headers, explicit bearer credentials and repeatable-read read-only transactions. Existing gateway client-prefix forwarding applies. No schema migration, UI changes or role grants. Missing schema dependencies return generic 503.

148 local fixtures pass. Four new booking fixtures cover projection, pagination, bound ownership/detail IDs, missing records, strict validation and gateway forwarding. Four additional real PostgreSQL checks per text/UUID auth identity variant cover owner list/detail, same-tenant other-client and foreign-tenant denial, and empty pages. Production schema parity and deployment are separate gates. OpenAPI: client-bookings-batch-9.openapi.json.

Booking creation, modification, cancellation, schedule conflict handling and legacy unscoped routes remain separate work. These GET APIs do not implement the existing POST registry entry.
