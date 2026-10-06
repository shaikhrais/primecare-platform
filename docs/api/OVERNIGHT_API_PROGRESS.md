# Overnight API progress — 2026-10-05–06

The user authorized maximum useful API batches without routine questions, with continuation across a three-hour window. Three hourly continuation runs are scheduled; scheduled runs are not completed work. GitHub main and exact-head CI are authoritative. No deployment or production database mutation is part of this work.

## Checkpoint

- Batches 116–120 merged in [PR #70](https://github.com/shaikhrais/primecare-platform/pull/70), with 898 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 121–152 merged in [PR #71](https://github.com/shaikhrais/primecare-platform/pull/71): 32 existing GET repairs, 1,136 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 153–157 merged in [PR #72](https://github.com/shaikhrais/primecare-platform/pull/72): five singleton repairs, 1,172 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 158–163 merged in [PR #73](https://github.com/shaikhrais/primecare-platform/pull/73): six canonical list/detail metadata APIs, six existing compatibility repairs, 1,236 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 164–165 merged in [PR #74](https://github.com/shaikhrais/primecare-platform/pull/74): nullable invoice contract/schema repairs, 1,239 local fixtures and passing UUID/text PostgreSQL CI after correcting a fixture grouping assumption.
- Batches 166–171 merged in [PR #75](https://github.com/shaikhrais/primecare-platform/pull/75): own patient-linked alert/claim/prescription list/detail and status-count APIs, three compatibility repairs and timestamp validation. 1,275 local fixtures and exact-head UUID/text PostgreSQL CI passed (head `7c3043492d8cdd11eb2cfee1c60c550cb129301a`, run 37396091441).
- Batches 172–178 merged in [PR #76](https://github.com/shaikhrais/primecare-platform/pull/76): three client-owned care metadata list/detail APIs (172–174), three stored label count APIs (175–177) and fail-closed count/string validation (178). 1,320 local fixtures, Workers typecheck, governance and exact-head UUID/text PostgreSQL CI passed (head `8f60db841605651e7ee968fc7f6254e01fe06331`, run 37399655235, merge `37c0c7b571dbf6be394d21aadf518306d5f350c7`).
- Batches 179–188 implemented nine client-linked PSW metadata list/detail APIs (179–187) and own stored shiftStatus counts (188). Stable ordering uses each real registered timestamp; summaries are disabled for the eight models without status. Registration verifies explicit ClientProfile/Tenant targets, non-null timestamp ordering and existing contract authority before refreshing schemas. Local validation: 1,415 fixtures, Workers typecheck and PostgreSQL fixture syntax passed. The older governance contract fixture now searches for its target instead of assuming it is on the first page. Publication/exact-head UUID/text CI pending at this checkpoint; see `OWN_CLIENT_CARE_EVENTS.md` and exact 179–188 OpenAPI.
- Current complete compatibility contracts: `docs/api/governed-read-aliases.openapi.json`; audited definitions: `scripts/governed-read-alias-definitions.json`.
- Total operation declarations are now 1,384: the original 1,335 plus 12 canonical operations for 158–163, nine for 166–171, nine for 172–177 and 19 for 179–188. Batch 178 repairs existing contracts without adding operations. Local fixture states and missing-contract counts are generated inventory metadata, not production verification.

## Next useful work

1. Verify and finish any outstanding codex API PR before starting a new branch from latest main.
2. Finish client PSW metadata CI if pending. Then prioritize remaining explicit owner relationships or substantive contract/handler fixes rather than duplicating already-covered metadata routes.
3. Provider-authored visit note/checklist, assignment and handover metadata are covered by 160–163. Audit/system actor metadata are covered by 158–159. Inspect remaining registered User/ProviderProfile/ClientProfile relations; bind every relationship and exclude unnecessary payloads. Do not assume foreign-key names or historical visit authority.
4. PatientAlert, Claim and Prescription metadata are covered by 166–171 through trusted generated ownerField=patient_id. Claim.provider_id points to InsuranceProvider, not ProviderProfile. CarePlan, ClinicalAssessment and MedicationRecon have explicit ClientProfile relations and separately named client-owned metadata in 172–177; existing premium aliases remain authored User scope. ClinicalRecord client_id lacks an explicit Prisma ClientProfile relation; inspect registered authority before inferring it.
5. All nine explicit client relations in PSW forms are now covered by 179–187 metadata. The catalog uses reviewed orderField and summaryBatch=0 when no status exists. Eight summaries remain unavailable rather than inventing columns. VitalSign lacks tenant_id and would need an explicit current owned-profile tenant join contract; MAR_Entry has nullable patient_id/tenant_id and no created_at. Do not substitute its bare client_id for the explicit patient relation.
6. Improve registration validation and consumer-visible contract guidance while keeping actual runtime behavior and stored schemas aligned.
7. Inspect remaining declared writes separately; define real validation, authorization and workflow/audit semantics before implementing them. Do not equate a generated Prisma declaration or existing screen association with business authority.

## Known blockers

Family appointment/care-plan/message models lack registered tenant and explicit actor ownership relationships. SupportTicket uses tenant/office but has no actor ownership. API keys and subscription upgrades are tenant administration, not personal-owned reads. Referrals lack a registered actor/profile ownership contract. TrainingAssignment staff/provider strings lack explicit User relations. These require business authorization contracts; do not expose them through generic collection handlers.

## Validation and publication workflow

Run maintenance/workspace registration, `node scripts/verify-api-batches.mjs`, Workers typecheck, syntax checks and governance guardian. Run integration tests only on disposable loopback `auth_test`; GitHub Actions runs PostgreSQL 16 with UUID/text identities. Restore unrelated generated page-readiness CSV changes and exclude generated `OUTSTANDING.md`. Keep source registration changes; the tracked governance database is a local checkpoint and is not uploaded through GitHub tree tools. Publish text changes through GitHub tools, inspect current main before creating a tree, and merge only after exact-head CI succeeds. Do not mark production verification or infer UI readiness from passing API fixtures.
