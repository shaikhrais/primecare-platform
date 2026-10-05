# Own client visits (Batch 11)

| Method | Gateway route | Result |
|---|---|---|
| GET | /v1/client/visits | Paginated summaries of own visits |
| GET | /v1/client/visits/{visitId} | One own visit or 404 |

An active explicit bearer actor must own a client_profiles row through user_id in the same tenant. Every visit query binds client_id to that profile and tenant_id to the actor tenant. Presentation grants do not bypass ownership. Other-client, foreign-tenant and nonexistent visit detail records return 404.

Fields returned: id, service_id, requested_start_at, duration_minutes, status, priority and updated_at. Clinical, coordinator and management notes, addresses, coordinates and unrelated records are excluded. Stored status and priority are not reinterpreted. This read API does not expose treatment notes or implement clinical record access.

List supports limit 1–100 and offset 0–100000, ordered by requested_start_at and id descending. Detail accepts no query fields and validates a bounded alphanumeric/hyphen/underscore identifier. Arbitrary owner/tenant fields, duplicate or unknown queries, bodies and mutation methods are rejected. Optional X-Tenant-Id must match the actor tenant. Cookie-only credentials fail.

Routes reuse client source throttling (namespace 2026100403), no-store, read-only repeatable-read transactions and the existing client gateway prefix. Missing profiles return 404; ambiguous mappings or missing schema dependencies return generic 503. No UI, schema migration or role grants.

156 local fixture tests pass. Four new fixtures verify field projection, owner/tenant/detail SQL, paging, 404 behavior, validation and gateway forwarding. Four additional disposable PostgreSQL checks per text/UUID auth identity variant verify real list/detail, cross-client/tenant denial and empty pages. Production schema parity and deployment remain separate checks. OpenAPI: client-visits-batch-11.openapi.json.

Visit mutations, clinical note access, cancellation workflows and legacy unscoped route remediation remain pending.
