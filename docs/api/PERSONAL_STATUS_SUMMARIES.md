# Personal owned status summaries — batches 91–95

These GET endpoints count stored statuses for records directly owned by the active bearer User in the matching tenant. They reuse the list/detail ownership predicates. Every record and grouping query binds actor User and tenant; null owners/tenants and foreign ownership/tenants do not contribute.

| Batch | Endpoint | Registered User owner |
| --- | --- | --- |
| 91 | `/v1/auth/me/authored-care-plan-records/summary` | `care_plans.author_id` |
| 92 | `/v1/auth/me/authored-review-records/summary` | `performance_reviews.reviewer_id` |
| 93 | `/v1/auth/me/reviewed-timesheet-records/summary` | `timesheets.reviewed_by` |
| 94 | `/v1/auth/me/reported-incident-records/summary` | `incidents.reporter_user_id` |
| 95 | `/v1/auth/me/medication-reconciliation-records/summary` | `medication_reconciliations.rn_id` |

Responses contain `groups` of `{status, count}` and `pagination` with limit, offset, total and hasMore. Total counts status groups, not records. Stored labels are preserved; nullable timesheet/incident statuses form a null group sorted last. Empty results return 200 with no groups. Default limit is 25; allowed limit is 1–100 and offset 0–100000. No status/owner/tenant/role filters are accepted. Explicit bearer and non-null tenant are required; supplied x-tenant-id must match.

Counts exclude clinical contents, patient IDs, reviewer/provider identities, payroll totals, incident descriptions and medication contents. A stored status does not establish completed care, review approval, payroll eligibility, incident resolution or medication correctness. Reviewer ownership uses User reviewer_id/reviewed_by, not ProviderProfile provider_id; incident acknowledgement does not grant reporter access. Reassignment removes the former owner's contribution.

The shared handler supplies read-only repeatable-read snapshots, no-store responses, bounded paging, source throttling and sanitized errors. No new role grants, mutations, approval actions, UI or migration are included. OpenAPI and generated governance execution/page-building metadata describe the five contracts.

Local fixtures cover SQL actor/tenant bindings, null groups, empty and out-of-range paging, invalid filters, inactive sessions, tenant checks, malformed data, gateway forwarding and throttling. Disposable PostgreSQL suites cover UUID/text identities, foreign/null ownership and tenant exclusion, reassignment and nullable statuses. Database CI and production verification remain separate from local fixture evidence.
