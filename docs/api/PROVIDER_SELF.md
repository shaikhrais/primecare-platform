# Own provider profile and availability (Batch 8)

| Method | Gateway route | Scope |
|---|---|---|
| GET | /v1/provider/profile | Bearer actor's provider_profiles row in the same tenant |
| GET | /v1/provider/availability | That provider's availability rows, also checked against tenant |

Access uses the registered provider_profiles.user_id relationship, not caller-selected provider identifiers or screen grants. Active explicit bearer authentication is required, and optional X-Tenant-Id must match the actor. Missing profiles return 404; ambiguous mappings fail closed. Cookie-only credentials, owner overrides, unknown/duplicate fields and unsupported methods are rejected. GET endpoints accept no body.

Profile exposes id, full_name, bio, languages, service_areas, provider_type, is_approved and skills. Internal trust/retraining/induction fields, address, free-form availability JSON and client records are excluded. Approval is a recorded profile value, not a grant of clinical authority.

Availability returns id, day_of_week, start_time and end_time. These are stored values; this batch does not define a new weekday convention, timezone conversion or booking/conflict calculation. Pagination accepts limit 1–100 and offset 0–100000, ordered by day_of_week, start_time and id. Empty availability is a genuine empty database result.

Both APIs use read-only repeatable-read transactions and no-store responses. Provider source throttling uses namespace 2026100404, 120 requests per 60 seconds. Existing gateway provider prefix forwards requests. Missing domain schema dependencies return generic 503. No production schema migration is included; definitions match registered ProviderProfile and ProviderAvailability models.

144 fixture tests passed locally. Seven new PostgreSQL checks per text/UUID auth identity variant cover profile field exclusion, same-tenant other-provider isolation, foreign-tenant availability exclusion, pagination, tenant-header mismatch, profile tenant mismatch and deactivated sessions. CI uses representative disposable domain tables; this does not prove production schema parity. OpenAPI: provider-self-batch-8.openapi.json.

No UI or role grants changed. Provider edits, availability mutation, scheduling conflicts, clinical access policies, legacy domain route remediation, production schema checks and deployment remain separate work.
