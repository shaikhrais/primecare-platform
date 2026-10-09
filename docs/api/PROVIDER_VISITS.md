# Assigned provider visits (Batch 10)

| Method | Gateway route | Result |
|---|---|---|
| GET | /v1/provider/visits | Paginated operational summaries of assigned visits |
| GET | /v1/provider/visits/{visitId} | One assigned visit or 404 |

An active explicit bearer actor must own a provider_profiles row through user_id in the same tenant. Each visit query additionally requires assigned_provider_id to match that profile and tenant_id to match the actor tenant. Presentation grants do not bypass these checks. Unassigned, other-provider, foreign-tenant and nonexistent visits cannot be returned. Approval/status metadata does not grant clinical authority.

Returned fields are id, service_id, requested_start_at, duration_minutes, status, priority and updated_at. Client identifiers, service address, coordinates, clinical/coordinator/management notes and cancellation reasons are excluded. Stored visit status/priority values are not reinterpreted by this batch.

List accepts limit 1–100 and offset 0–100000, ordered by requested_start_at then id descending. Detail accepts no query fields and validates an exact bounded alphanumeric/hyphen/underscore identifier. Caller provider/user/tenant overrides, duplicate or unknown query fields, bodies and mutation methods are rejected. Foreign and missing detail records both return 404.

Reads reuse the provider source limiter (namespace 2026100404), explicit bearer credentials, tenant-header checking, no-store and repeatable-read read-only transactions. Existing gateway provider routing applies. Missing profile returns 404; ambiguous mappings or missing schema dependencies return generic 503. No production schema migration, UI changes or role grants.

152 fixture tests passed locally. Four new fixtures verify field exclusion, bound assignment/tenant/detail queries, paging, 404 behavior, input rejection and gateway forwarding. Four new disposable PostgreSQL checks per text/UUID auth identity variant verify real list/detail results, unassigned/cross-provider/tenant denial and empty pages. CI fixtures represent registered domain fields; production schema parity and deployment remain separate checks. OpenAPI: provider-visits-batch-10.openapi.json.

Clinical record access, check-in/out, assignment changes, visit mutations and legacy unscoped route remediation remain pending.
