# Overnight API progress — 2026-10-05

The user authorized maximum useful API batches without routine questions, with continuation across a three-hour window. Three hourly continuation runs are scheduled; scheduled runs are not completed work. GitHub main and exact-head CI are authoritative. No deployment or production database mutation is part of this work.

## Checkpoint

- Batches 116–120 merged in [PR #70](https://github.com/shaikhrais/primecare-platform/pull/70), with 898 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 121–152 merged in [PR #71](https://github.com/shaikhrais/primecare-platform/pull/71): 32 existing GET repairs, 1,136 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 153–157 merged in [PR #72](https://github.com/shaikhrais/primecare-platform/pull/72): five singleton repairs, 1,172 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 158–163 merged in [PR #73](https://github.com/shaikhrais/primecare-platform/pull/73): six canonical list/detail metadata APIs, six existing compatibility repairs, 1,236 local fixtures and passing UUID/text PostgreSQL CI.
- Batches 164–165 merged in [PR #74](https://github.com/shaikhrais/primecare-platform/pull/74): nullable invoice contract/schema repairs, 1,239 local fixtures and passing UUID/text PostgreSQL CI after correcting a fixture grouping assumption.
- Batches 166–171 implemented own patient-linked alert/claim/prescription list/detail and status-count APIs, three existing compatibility repairs and timestamp validation for generated client records. Local validation: 1,275 fixtures, Workers typecheck and governance checks passed. This checkpoint precedes PR publication; inspect its PR and exact-head CI before calling it merged.
- Current complete compatibility contracts: `docs/api/governed-read-aliases.openapi.json`; audited definitions: `scripts/governed-read-alias-definitions.json`.
- Total operation declarations are now 1,356: the original 1,335 plus 12 canonical list/detail operations for 158–163 and nine patient-linked list/detail/summary operations for 166–171. Local fixture states and missing-contract counts are generated inventory metadata, not production verification.

## Next useful work

1. Verify and finish any outstanding codex API PR before starting a new branch from latest main.
2. Finish patient metadata CI if pending. Then prioritize remaining explicit owner relationships or substantive contract/handler fixes rather than duplicating already-covered metadata routes.
3. Provider-authored visit note/checklist, assignment and handover metadata are covered by 160–163. Audit/system actor metadata are covered by 158–159. Inspect remaining registered User/ProviderProfile/ClientProfile relations; bind every relationship and exclude unnecessary payloads. Do not assume foreign-key names or historical visit authority.
4. PatientAlert, Claim and Prescription metadata are covered by 166–171 through trusted generated ownerField=patient_id. Claim.provider_id points to InsuranceProvider, not ProviderProfile. CarePlan has an explicit client_id relationship and could support separately named client-owned metadata; its existing premium alias is authored User metadata and should not be silently repurposed. ClinicalRecord client_id lacks an explicit Prisma ClientProfile relation; inspect registered authority before inferring it.
5. Improve registration validation and consumer-visible contract guidance while keeping actual runtime behavior and stored schemas aligned.
6. Inspect remaining declared writes separately; define real validation, authorization and workflow/audit semantics before implementing them. Do not equate a generated Prisma declaration or existing screen association with business authority.

## Known blockers

Family appointment/care-plan/message models lack registered tenant and explicit actor ownership relationships. SupportTicket uses tenant/office but has no actor ownership. API keys and subscription upgrades are tenant administration, not personal-owned reads. Referrals lack a registered actor/profile ownership contract. TrainingAssignment staff/provider strings lack explicit User relations. These require business authorization contracts; do not expose them through generic collection handlers.

## Validation and publication workflow

Run maintenance/workspace registration, `node scripts/verify-api-batches.mjs`, Workers typecheck, syntax checks and governance guardian. Run integration tests only on disposable loopback `auth_test`; GitHub Actions runs PostgreSQL 16 with UUID/text identities. Restore unrelated generated page-readiness CSV changes and exclude generated `OUTSTANDING.md`. Keep source registration changes; the tracked governance database is a local checkpoint and is not uploaded through GitHub tree tools. Publish text changes through GitHub tools, inspect current main before creating a tree, and merge only after exact-head CI succeeds. Do not mark production verification or infer UI readiness from passing API fixtures.
