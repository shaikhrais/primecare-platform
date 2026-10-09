# Personal authorship, review and telehealth metadata — batches 86–90

These read-only routes expose directly owned metadata under the active bearer actor's User ID and matching non-null tenant. Every record query binds both values; arbitrary author/reviewer/provider/tenant/role filters are rejected. Existing provider-owned routes remain separate because their ownership uses ProviderProfile rather than the reviewer User.

| Batch | Root under `/v1/auth/me` | Registered User owner | Projection |
| --- | --- | --- | --- |
| 86 | `/authored-care-plan-records` | `care_plans.author_id` | id, status, created_at, updated_at |
| 87 | `/authored-review-records` | `performance_reviews.reviewer_id` | id, status, period_start, period_end, created_at, updated_at |
| 88 | `/reviewed-timesheet-records` | `timesheets.reviewed_by` | id, nullable status/reviewed_at, created_at, updated_at |
| 89 | `/telehealth-records` | `telehealth_sessions.provider_id` | id, status, start_time, nullable end_time, created_at |
| 90 | `/telehealth-records/summary` | Same provider User ownership | status groups and counts |

Each collection root supports GET list and GET `/{recordId}`. Responses use `plans`/`plan`, `reviews`/`review`, `timesheets`/`timesheet` and `sessions`/`session`. Lists include `pagination`, sort by created_at DESC then id DESC, and accept limit 1–100 (default 25) and offset 0–100000 (default 0). Details accept no query. Summary total counts status groups rather than sessions. Empty collections return 200; missing or foreign-owned details return 404.

The model distinguishes telehealth_sessions.provider_id (User) from performance_reviews.provider_id and timesheets.provider_id (ProviderProfile). Reviewer access binds reviewer_id/reviewed_by, never provider_id. Null care-plan authors and timesheet reviewers are excluded. Changing the author/reviewer removes the former owner's access; current ownership does not prove historical authorship or review completion.

Clinical diagnoses, goals/interventions/outcomes, patient/client IDs, reviewed-provider IDs, ratings/KPIs/notes, payroll totals/week IDs and meeting links are excluded. These metadata endpoints cannot join meetings, approve reviews/timesheets, certify session attendance or establish payroll eligibility. Statuses and timestamps are stored values, not validated outcomes or permission grants.

An active explicit bearer session and non-null tenant are required. Supplied x-tenant-id must match. Source throttling, no-store responses and read-only repeatable-read transactions with rollback apply. Errors: 400 invalid ID/query/body, 401 missing/inactive bearer, 403 absent/mismatched tenant, 405 unsupported writes, 429 source limit, 503 unavailable/malformed data. No UI, clinical writes, approval transitions, new role grants or database migration are included.

The companion OpenAPI specification defines schemas and examples. Governance registration precedes generated runtime allowlists and feeds existing execution-status/page-blueprint contracts. Metadata contracts do not imply a clinical or administration page is ready.

Local fixtures cover registered SQL ownership/projections, details, ordering, gateway forwarding, session/tenant checks, invalid filters, status summaries, throttling and sanitized errors. Disposable PostgreSQL CI tests UUID/text auth identities, other authors/reviewers/providers, foreign tenants, null authors/reviewers, ownership reassignment, nullable review/session timestamps, empty reads and inactive/expired sessions. Local fixture evidence stays separate from database and production verification.
