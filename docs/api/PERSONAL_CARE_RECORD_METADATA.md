# Personal authored care-record metadata — batches 71–75

These read-only APIs expose record IDs and recording timestamps for records authored by the active bearer actor in the actor's current tenant. The registered model relationships bind `provider_id` to **User.id**, not ProviderProfile.id. Metadata ownership does not grant access to patient records or clinical write operations.

| Batch | Root under `/v1/auth/me` | Registered table |
| --- | --- | --- |
| 71 | `/vital-sign-records` | `psw_vital_signs` |
| 72 | `/behavior-note-records` | `behavior_notes` |
| 73 | `/nutrition-records` | `nutrition_records` |
| 74 | `/mobility-records` | `mobility_logs` |
| 75 | `/infection-control-records` | `infection_control_checklists` |

Each root accepts GET for a list and GET `/{recordId}` for an owned detail. Lists return `records` and `pagination`; details return `record`. Every record contains exactly `id` and `recorded_at`. These endpoints exclude patient/client IDs, measurements, mood and behavioral narratives, meals/fluids, mobility findings, infection-control answers, signatures and raw clinical contents. A stored recording timestamp does not establish care completion, clinical correctness or compliance.

Lists sort by `recorded_at DESC, id DESC`. `limit` defaults to 25 and accepts 1–100; `offset` defaults to 0 and accepts 0–100000. Details accept no query. Arbitrary tenant, owner, role and clinical filters are rejected. An empty owned collection returns 200; an absent or foreign owned detail returns 404 without disclosing its existence.

An active explicit bearer session and non-null tenant are required. If supplied, `x-tenant-id` must match the actor tenant. Each SQL query binds actor User ID and tenant, excluding null and other tenants. Responses use `Cache-Control: no-store`; the existing source limiter covers list and detail. Reads run within a read-only repeatable-read transaction with rollback on completion and failure. No new role grants, business transitions, database migration or clinical mutations are added.

Error contracts: 400 invalid ID/query, 401 missing or inactive bearer session, 403 tenant absent/mismatched, 405 unsupported write, 429 source throttle, 503 unavailable database or malformed projected data. GET never changes the records.

The companion OpenAPI document provides schemas, paging and examples. Registration happens in governance before generation of the runtime allowlist; the governance execution-status and page-blueprint APIs retain these contracts for page builders. These metadata APIs cannot build a clinical chart or patient-detail page without separately authorized clinical contracts.

Unit fixtures cover SQL actor/tenant binding, exact projections, ordering, details, invalid filters, bearer and tenant checks, throttling, error sanitization and gateway forwarding. The disposable PostgreSQL CI fixture seeds same-tenant foreign authors and actor-owned foreign-tenant records and checks exclusion, paging and inactive sessions with both UUID and text auth identities. Local fixture results and CI database results remain separate; neither marks a screen or deployment production-ready.
