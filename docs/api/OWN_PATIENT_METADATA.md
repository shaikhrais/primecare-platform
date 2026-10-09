# Own patient-linked metadata — batches 166–171

These APIs use three explicit Prisma patient_id relations to ClientProfile. The actor needs an active explicit bearer, a matching non-null tenant and exactly one actor-owned client profile. Every record query binds patient_id to that profile and tenant_id to the actor tenant. ownerField is generated from reviewed governance metadata; it is not a request parameter.

| Batch | Canonical list and detail root | Returned metadata |
| --- | --- | --- |
| 166 | `/v1/client/alert-records` | ID, stored type/severity/status, creation time |
| 167 | `/v1/client/insurance-claim-records` | ID, stored status, service date and creation time |
| 168 | `/v1/client/prescription-records` | ID, stored status and creation time |
| 169 | `/v1/client/alert-records/summary` | Stored status and count |
| 170 | `/v1/client/insurance-claim-records/summary` | Stored status and count |
| 171 | `/v1/client/prescription-records/summary` | Stored status and count |

List/detail roots support bounded paging or exact owned IDs. Summaries count groups in pagination.total and preserve null stored status where present. The existing premium patientalert/claim/prescription GET roots use the canonical list projections; nested premium paths remain unhandled and writes are denied before forwarding.

Alert messages, medication names/IDs, dosage/frequency/instructions, prescriber IDs, insurance-provider IDs, amounts, denials and clinical payloads are excluded. Claim.provider_id references InsuranceProvider, not ProviderProfile. These responses do not establish diagnosis, coverage, settlement, treatment correctness or permission to accept or change care. No delegated family authority or role grants are introduced.

Client metadata timestamps now use the generated dateFields catalog for validation, rejecting malformed required dates with the existing sanitized 503 response. Nullable dates remain null. Unit fixtures use valid timestamp values; gateway/database tests cover canonical lists/details/summaries, exact profile/tenant predicates, cross-user and tenant isolation, query rejection, profile ambiguity, projections and status-group paging. UUID/text PostgreSQL CI is required before merge; no production verification is inferred.
