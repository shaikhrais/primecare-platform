# Personal device and wellness reads — batches 31–35

| Batch | GET endpoint | Result |
| --- | --- | --- |
| 31 | `/v1/auth/me/wellness-pulses` | Own wellness-pulse metadata |
| 31 | `/v1/auth/me/wellness-pulses/{recordId}` | One owned pulse |
| 32 | `/v1/auth/me/wellness-pulses/summary` | Counts by recorded status |
| 33 | `/v1/auth/me/device-events` | Own device-event metadata |
| 33 | `/v1/auth/me/device-events/{recordId}` | One owned event |
| 34 | `/v1/auth/me/device-events/summary` | Counts by recorded status |
| 35 | `/v1/auth/me/devices` | Own registered device metadata |
| 35 | `/v1/auth/me/devices/{recordId}` | One owned registered device |

These are read-only personal account APIs requiring an active explicit bearer and matching non-null actor tenant. Wellness pulses and device events bind both `user_id` and `tenant_id`, excluding foreign tenants and events without an assigned user/tenant. UserDevice has no tenant column: every query joins its owning User, binds device `user_id` to the actor and the owning user's tenant to the actor's current tenant. Device records are personal to that user, not historical tenant-tagged records. The optional tenant header must match. No caller-selected user, tenant or role, new grants, client/provider-profile dependency or state mutation is introduced.

Pulse responses contain id, nullable recorded score, status and created_at. Scores/statuses are stored observations, not diagnoses, thresholds or clinical conclusions. Notes and provider identifiers are excluded. Event responses contain id, device_type, status and created_at; device fingerprints and raw telemetry payloads are excluded. Device responses contain id, nullable device_name/device_type, is_authorized, is_temporary, nullable authorized_at/expires_at, last_active_at, status, created_at and updated_at. Fingerprints and IP addresses are excluded. Device flags/dates are recorded metadata; they do not authorize a session, prove trust or revoke a device. No devices summary endpoint is added in this batch.

List/summary requests accept only `limit` (default 25, 1–100) and `offset` (default 0, 0–100000). Detail accepts no query. Invalid IDs, duplicate/unknown parameters, owner overrides, bodies and writes are rejected. Lists sort by created_at and id descending. Summaries group stored status and sort status with null last; pagination total counts groups. Empty owned collections return empty arrays and zero total; missing or foreign detail returns 404. Required and nullable field types, valid dates and safe integer counts/scores are checked; malformed records fail closed with 503.

The existing personal record handler uses generated governance projections, source throttling, no-store responses and read-only repeatable-read snapshots. `scripts/register-self-records-api.py` verifies projection/ownership columns, including the User tenant relationship, before implementation and reproduces the runtime catalog, eight contracts, existing authenticated-account screen links and batches 31–35. Existing batches 26–30 retain separate OpenAPI output. See `self-device-wellness-batches-31-35.openapi.json` for schemas, examples and errors.

Unit tests verify all modes, exact projection and SQL scope, current owning-user tenant joins, nullable score/dates, invalid numbers/flags, paging, denial, throttling and gateway/auth routing. Disposable PostgreSQL CI verifies other users, other tenants, unassigned/null-tenant events, list/group paging, empty results, detail denial, nullable values, current device reassignment, expired sessions and inactive actors for UUID/text identities. No migration or UI changes are required. CI and authenticated production checks remain distinct release gates.
