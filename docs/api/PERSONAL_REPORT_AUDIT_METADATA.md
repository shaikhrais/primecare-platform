# Personal report, clinical authorship and audit metadata — batches 81–85

The five families below expose only directly owned metadata. They require an active explicit bearer session and a matching non-null actor tenant. Registered User relationships determine ownership; an RN-labelled database field does not establish professional credentials or grant clinical privileges.

| Batch | Root under `/v1/auth/me` | Registered owner | Projection |
| --- | --- | --- | --- |
| 81 | `/reported-incident-records` | `incidents.reporter_user_id` → User | id, nullable status, created_at, updated_at |
| 82 | `/assessment-records` | `clinical_assessments.rn_id` → User | id, created_at, updated_at |
| 83 | `/medication-reconciliation-records` | `medication_reconciliations.rn_id` → User | id, status, created_at |
| 84 | `/supervision-records` | `supervision_logs.rn_id` → User | id, created_at |
| 85 | `/technical-audit-records` | `technical_audits.performed_by_id` → User | id, status, performed_at |

Each root supports GET list and GET `/{recordId}`. Lists return the registered collection plus `pagination`; detail returns the corresponding single item. Lists default to limit 25 and offset 0; limit 1–100 and offset 0–100000 are accepted. Lists sort newest by registered created_at or performed_at, then id. Details accept no query. An empty list returns 200 and an absent or foreign-owned detail returns 404.

SQL binds actor User ID and tenant for every read. Incident ownership comes from reporter_user_id; acknowledgement by the actor does not grant access to another reporter's incident. Supervision ownership comes from rn_id, not provider_id, which refers to ProviderProfile. Technical audits with a null performer or tenant are excluded; global audit scope is not inferred. Other authors/performers and other tenants are excluded even if the record is known to the actor.

Projections omit descriptions, resolutions, patient/client/visit/provider identifiers, assessment data and scores, recommendations, reconciliation contents and discrepancies, competencies, supervision feedback and audit summaries/details/issue counts. Stored status and timestamps do not certify resolution, medication correctness, competence, audit success or compliance. No clinical charts, clinical writes, permission grants, business transitions, schema migrations or UI changes are included.

Reads use the existing source limiter, no-store responses, a read-only repeatable-read transaction and rollback on all paths. Errors are 400 invalid ID/query, 401 missing/inactive bearer, 403 absent or mismatched tenant, 405 writes, 429 throttled source and 503 unavailable/malformed data. Database errors do not expose connection credentials.

Governance registration precedes the runtime allowlist. The companion OpenAPI contract supplies examples, schemas, paging and authentication. Existing execution-status and page-blueprint APIs receive the new contracts for page builders; metadata alone cannot make clinical or administration pages complete.

Unit fixtures check owner/tenant SQL, projection whitelists, details, sorting, session/tenant checks, invalid filters, throttling, gateway forwarding and error sanitization. Disposable PostgreSQL CI runs with UUID and text auth identities, foreign authors in the same tenant, own records in foreign tenants, nullable incident status and technical-audit ownership/tenant, empty results and expired/inactive actors. Local fixture evidence stays separate from PostgreSQL and production verification.
