# Own client PSW record metadata — batches 179–188

Each route follows an explicit ClientProfile relationship in `packages/database/prisma/schema/09_psw_forms.prisma` and a registered Tenant foreign key. Registration checks the exact client_profiles.id and tenants.id targets; column names alone are insufficient authority. The catalog requires a projected, non-null timestamp for stable list order. No role or delegated access grants are added.

| Batch | Route under `/v1/client` | Metadata | List order |
| --- | --- | --- | --- |
| 179 | `/shift-log-records` | id, shiftStatus, start_time, nullable end_time | start_time, id descending |
| 180 | `/adl-records` | id, created_at | created_at, id descending |
| 181 | `/vital-observation-records` | id, recorded_at | recorded_at, id descending |
| 182 | `/behavior-observation-records` | id, recorded_at | recorded_at, id descending |
| 183 | `/nutrition-observation-records` | id, recorded_at | recorded_at, id descending |
| 184 | `/mobility-observation-records` | id, recorded_at | recorded_at, id descending |
| 185 | `/infection-checklist-records` | id, recorded_at | recorded_at, id descending |
| 186 | `/progress-note-records` | id, recorded_at | recorded_at, id descending |
| 187 | `/care-follow-up-records` | id, recorded_at | recorded_at, id descending |
| 188 | `/shift-log-records/summary` | shiftStatus/count groups | shiftStatus ascending, null last |

All nine collections include an exact `/{recordId}` GET. Lists use limit 1–100 and offset 0–100000; summary pagination totals count groups. Eight models have no registered status, so they have no summary operation. Unknown summary and nested paths are rejected. The registered camel-case shiftStatus column is quoted exactly in projection/group SQL.

Every count, list and detail query binds client_id to exactly one actor-owned ClientProfile and tenant_id to the active actor tenant. Profile/user tenant changes revoke access to historical rows. Session expiry/inactive users, missing or ambiguous owned profiles and tenant mismatch fail closed. Read-only repeatable-read transactions, rollback, no-store, source throttling, strict paging/IDs and sanitized errors remain active.

No measurements, behavior/nutrition/mobility values, checklist answers, narrative contents, care tasks, provider/staff identifiers, location or signatures are returned. Metadata does not establish delivered or approved care, diagnosis, infection-control compliance, correct medication, payroll, billability or authority to act. Existing clinician-authored compatibility routes retain their current scope.

Exact OpenAPI is generated in `own-client-care-events-batches-179-187.openapi.json` and `own-client-shift-counts-batch-188.openapi.json`. Canonical request/response schemas are refreshed from reviewed definitions only after checking that the existing registered service, authentication and ownership permission agree. Conflicting contracts stop registration.

Unit tests cover gateway/service ownership, schema projections, timestamp ordering, unsupported summaries, malformed data/counts, denials and limits. A disposable governance snapshot tests incorrect ownership targets, absent foreign-key flags and nullable/non-timestamp ordering failures. Disposable loopback auth_test PostgreSQL tests exercise UUID/text auth identities, same-tenant other owners, wrong-tenant rows, tenant revocation, exact detail, paging, shift groups, empty results and session/profile failures. No production verification or UI readiness is inferred from this evidence.

VitalSign requires an explicit owned-profile tenant join because it has no tenant_id. MAR_Entry has nullable patient_id/tenant_id and no created_at; its bare client_id is not the registered patient ownership relation. ClinicalRecord's client_id has no explicit ClientProfile relation. These remain separate contract dependencies. Clinical/admin writes still require registered business access and audit semantics.
