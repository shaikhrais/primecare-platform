# Own client care metadata — batches 172–178

These client routes use the existing unique actor-owned ClientProfile policy. Each data query binds `client_id` to that profile and `tenant_id` to the active actor tenant. The reviewed ownership relations are CarePlan.client, ClinicalAssessment.client and MedicationRecon.client in `packages/database/prisma/schema/04_clinical.prisma`; all explicitly reference ClientProfile.id. This scope is separate from authored User reads.

| Batch | Client route | Projection |
| --- | --- | --- |
| 172 | `/v1/client/care-plan-records` and `/{recordId}` | id, status, nullable review_date, created_at, updated_at |
| 173 | `/v1/client/assessment-records` and `/{recordId}` | id, type, created_at |
| 174 | `/v1/client/medication-reconciliation-records` and `/{recordId}` | id, status, created_at |
| 175 | `/v1/client/care-plan-records/summary` | status/count groups |
| 176 | `/v1/client/assessment-records/summary` | type/count groups |
| 177 | `/v1/client/medication-reconciliation-records/summary` | status/count groups |
| 178 | Original owned consents/service-authorizations/waitlist contracts | Fail closed on malformed list/group totals and Date objects in plain string fields; all generated client metadata reads receive the runtime fix |

Exact schemas and examples are generated into `own-client-care-metadata-batches-172-174.openapi.json` and `own-client-care-counts-batches-175-177.openapi.json`. Existing `/v1/premium/careplan`, `/v1/premium/clinicalassessment` and `/v1/premium/medicationrecon` compatibility reads remain authored User scope; they are not aliases for these client routes.

Lists use stable created_at/id descending order with limit 1–100 and offset 0–100000. Summary pagination totals count label groups rather than records. Active explicit bearer session, non-null matching tenant and exactly one owned profile are required. Foreign records return 404; ambiguous profiles and malformed projected data return sanitized 503. All queries run inside a no-store, read-only repeatable-read snapshot with rollback and source limits. Client/user/tenant overrides, duplicate query parameters, bodies and mutations are rejected.

No diagnoses, goals, interventions, scores, recommendations, discrepancies, reconciliation JSON, clinical contents, author or RN identifiers are exposed. Stored status/type labels and review dates do not establish safety, diagnosis, treatment instructions, eligibility or permission to act. No clinical writes, delegated family access or admin grants are introduced. Unknown clinical/admin business workflows remain blocked until their access and audit contracts are explicitly registered.

Unit fixtures cover schema/projection alignment, authored route preservation, strict paging, ownership SQL, corrupt counts/timestamps, nullable review dates, denial, limits and error sanitization. Disposable loopback auth_test PostgreSQL fixtures exercise real gateway-compatible handlers under UUID/text auth identities, same-tenant other owners, same-owner wrong-tenant rows, profile/user tenant changes, exact detail, groups, empty results, duplicate profiles and inactive/expired sessions. CI evidence is separate from production or UI verification.
