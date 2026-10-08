# PrimeCare implementation plan

Source baseline: `3979ed1028c8b7dfdb9acca72b1ea53d4d034127`. This is an executable sequence of bounded work packages. Completing this plan requires code and runtime evidence as well as documents; creating the plan does not complete its API work.

## Planning rules

1. Keep the finite baseline at 1,415 exact method/path identities. Preserve declaration IDs and migration history. Report resolved, retired, pending and blocked separately.
2. Use evidence from actual grant records, source callers, schemas, models, handlers and tests. Missing endpoint metadata is a gap, not proof that every linked grant is absent. A grant from the wrong registry identity is not authority.
3. Never use a screen-visible role, a model's existence, a generated DTO, or a suffix match as authorization for a new action.
4. Recover requirements before making new business choices. Record the remaining choices as decisions; do not insert assumed rules into governance as if they were already approved.
5. Implement a complete coherent workflow, including its negative paths, rather than publishing placeholder success responses or inactive scaffolding as progress.
6. Work in parallel only on independent files or contexts. One owner integrates shared authorization, schema and release changes. Keep edits source-pinned and publication allowlisted.
7. Merge only after all applicable checks pass on the exact proposed head. Re-run those checks after a source correction. Verify that the merged tree is the tested tree.
8. Deployment is a separate release action. A documentation merge, source merge or local test does not prove production behavior.

## Roles and responsibility boundaries

These are project responsibility categories, not new application access roles or assigned people.

| Responsibility | Required decisions/evidence |
| --- | --- |
| Product/workflow owner | Actor, purpose, inputs, outputs, state transitions, conflict rules and expected user behavior |
| Security/data owner | Identity/tenant/resource scope, consent/delegation, disclosure, retention and permitted actions |
| Architecture/database reviewer | Model fit, constraints, migration plan, transactions, concurrency and compatibility |
| Implementer | Evidence recovery, code, client bindings, explicit errors and reproducible builds |
| Test reviewer | Happy path and deny paths, real persistence, race/replay checks, accessibility and exact-head evidence |
| Release/operator | Secrets/configuration, immutable artifact version, backups, rollout, monitoring and rollback |

No owner assignment is assumed. A missing owner is an open planning decision; an automated scanner cannot approve a business rule on that owner's behalf.

## Work package P00 — restore trustworthy authority evidence

**Problem:** the first audit required endpoint permission keys to match before retaining positive grants. This discarded relevant raw facts when endpoint metadata was empty. Conversely, a numeric identifier reused across governance tables can attach a different workflow's permission to an unrelated endpoint.

**Implementation tasks:**

- Read the tracked governance database in SQLite read-only mode with `query_only=ON`.
- Match each selected checklist operation by exact method and exact path. Preserve every matched declaration ID and duplicate-row ambiguity.
- Preserve raw `api_permissions` records even if endpoint keys are null, inconsistent or unbound. Include only role identifiers/codes and grant facts, never account passwords or session secrets.
- Recover exact linked screen functions and their explicit execution grants. Keep screen-view context separate from endpoint/action authority.
- Compare source registry records where an exact stored permission-key correlation exists. Report the correlation, API identity and method/path conflicts; do not treat a naming convention as proof of permission provenance.
- Include the 14 blocked operations for investigation while preserving the default 1,049 pending count and historical baseline stages.
- Keep `explicitGrants` and raw evidence distinct. Record unknowns and conflicts; never automatically promote a raw row into activation authority.
- Run tests for key absence, valid exact records, conflicting origin records, duplicate grants, unresolved roles, missing schema, method/path mismatch and database immutability.
- Run against the actual tracked database in CI, retrieve the report, inspect the first selected family's evidence and merge after exact-head checks.

**Exit criteria:** raw facts are preserved; conflicting registry identities are visible; database fingerprint is unchanged; audit tests and source checks pass; a source-pinned report is available. **API completion credit: zero.**

**Executed:** PR #151 merged as `8bea69963c12d73f0c000a2632f41d27acdf76ef`. The exact tested head was `208806f588f6688a9faa36c582c850c0178ab8f0`; both applicable workflows passed, including the 16 audit tests. Actual CI evidence covered 1,063 operations, retained 52,096 raw rows across 814 operations and found method/path mismatches in every returned registry correlation. The database SHA-256 remained `42d350b6b3ab46540cbc58f2696d896f3afe6658b1f5153bec410dfce87d1262`. No grant was promoted into activation authority. This executed P00; it did not implement P02 or complete an API.

## Work package P01 — establish the specification baseline

**Deliverables:** the documents indexed in [README.md](README.md), all 1,415 operation records, all 106 family decision records, and a verified project/manifest inventory.

**Implementation tasks:**

- Cite the repository rule or primary source behind every observed behavior and technical requirement.
- Distinguish observed, required, proposed and open statements. Do not present a default architecture preference as a deployed fact.
- Define field-level contracts, negative cases, persistence rules, authorization boundaries, configuration names, deployment/rollback procedures and evidence expectations.
- Attach stable requirement IDs and operation identity to changes and tests.
- Validate local document links, required document coverage, unique operation identities, family coverage, source hashes and honest finite counts.
- Review instructions that can mutate data or deploy resources. Mark prerequisites and confirmation mechanisms already required by the actual scripts. Use disposable fixtures for local tests.
- Make the baseline available in the repository and keep generated traceability reproducible.

**Exit criteria:** every required technical area has an indexed document; every finite operation appears once; all unresolved operations have family decisions; runbooks identify actual commands and blockers; checks pass. **API completion credit: zero.**

## Work package P02 — reconcile identity as the first runtime candidate

The detailed contract-recovery record is [identity-work-package.md](identity-work-package.md). Identity is a candidate because primary route metadata describes the current authenticated user; it is not approved merely because a generated OpenAPI type describes a response.

**Preconditions:**

- Reconcile governance's POST declaration with the source's proposed GET behavior through an explicit method/contract decision.
- Determine the authoritative DTO. Do not assume a persisted roles string is already a validated array.
- Verify that exact grant provenance refers to identity, not a clinical/CNS operation with a reused numeric ID.
- Confirm session-derived actor and tenant binding, inactive/expired/revoked session behavior, projected fields, rate limit and audit policy.
- Record the actual caller or consumer. If none exists, do not invent a UI connection.

**Implementation sequence after the preconditions are met:**

1. Record approved contract/method/permission changes in governance through a reviewed migration. Preserve the obsolete declaration's evidence and compatibility decision.
2. Implement an identity-specific DTO projector from the authenticated actor, with an explicit field allowlist and no password/token/security internals.
3. Query identity through the active-session/user/tenant boundary. Never accept a caller-supplied user ID as a substitute for session identity.
4. Add exact gateway routing and method/body enforcement. Do not forward arbitrary writes to an existing read handler.
5. Bind the real client to the correct method and response contract; handle errors without fabricated success or cached sensitive identity.
6. Test invalid/expired/revoked sessions, inactive users, tenant mismatch, malformed stored roles, request bodies, unsupported methods and DTO projection.
7. Run operation-specific PostgreSQL fixtures for each supported identity representation, then exact-head CI.
8. Map evidence to the finite declaration and report retirement/reconciliation separately from new canonical operations.

**Exit criteria:** approved identity contract and provenance, actual handler/caller, deny-path tests and mapped persistence evidence. Until then, P02 remains blocked and the route must not be activated.

## Work package P03 — repair governance integrity before bulk activation

- Inventory every API/registry identifier domain and foreign-key relationship. Explicitly distinguish `api_endpoints.id`, `api_endpoint_registry.id`, and `api_endpoint_registry.api_id`.
- Detect orphaned references, duplicate method/path records, wrong-origin permission keys, contradictory grants and scanner-created readiness labels.
- Review the code that created each relationship. Historical reports may describe an older generator; verify current code before changing it.
- Create a dry-run mapping with old row identity, proposed target, primary evidence and affected roles/functions/screens. Ambiguous mappings remain unresolved.
- Apply only evidence-backed corrections transactionally, with a backup, expected source fingerprint, row-count bounds and rollback script.
- Do not grant new access while repairing identifiers. Compare effective authority before and after the migration and test both allow and deny cases.
- Regenerate derived artifacts from the reviewed database and verify source snapshots and finite counts.

**Exit criteria:** reviewed relationships and no silent privilege expansion; migration and rollback verified on copies; mapped authority usable for contract review. Identifier repair alone is not API completion.

## Work package P04 — implement complete workflow families

The complete queue is [family-decision-register.md](family-decision-register.md). Its source priorities order investigation; they are not business approval. For each of the 106 families, perform the following sequence against its actual operations and questions:

1. Recover actor, consumer, DTO fields, model and behavior from primary evidence.
2. Resolve the listed family-specific questions and all 16 contract sections. Prefer a verified shared rule over duplicated policy text, but prove that its subject, action and disclosure boundaries are equivalent.
3. Record accepted choices with decision ID, rationale, owner responsibility, source fingerprint, effective version and impacted operations.
4. Review schema fit, tenant ownership, assignment/delegation and state transitions. Explicitly address mixed-scope reads, cross-tenant administrators and mutations of clinical or financial records.
5. Implement persistence and business rules first, with transactions, constraints and concurrency protection. Do not place authorization or business rules in screen files.
6. Implement the exact API method/path, validation, errors, rate limits, audit behavior and response projection.
7. Bind the existing UI/controller/service to that contract; replace mock-success behavior and preserve actionable error/loading/empty states.
8. Execute unit, authorization, persistence, contract and client/accessibility tests appropriate to the workflow.
9. Publish a bounded change, run exact-head checks, merge and map completion evidence to exact unique operations.
10. Deploy only after the release gates are met; record operation-specific smoke evidence and rollback readiness separately.

**Parallelization:** read-only recovery can run across families; implementation can run concurrently once authorization and shared model boundaries are defined. Serialize schema migrations, shared session changes, permission changes and publication integration. Creating hundreds of agents does not resolve shared unknown policies or make unsafe mutations independent.

## Work package P05 — make the runtime and release chain reproducible

Detailed procedures are in [runtime-operations.md](runtime-operations.md) and [testing-release.md](testing-release.md).

- Choose the maintained runtime surface explicitly: Cloudflare Workers, TypeScript websites, Flutter applications and legacy Dart services have different readiness. Directory presence is not a deployment choice.
- Pin tested toolchains and dependency locks. Verify the actual local and CI versions before changing release versions.
- Stop converting material test failures into warning-only aggregate success. Add blocking gates for the selected runtime without implying that unrelated legacy suites are clean.
- Build and deploy from one immutable reviewed commit. Review release-time governance mutations and checkout behavior; do not release untested generated changes or mixed source versions.
- Replace untracked migration reapplication with a reviewed migration ledger/checksum strategy and rollback discipline; do not blindly rewrite production tables.
- Record resource bindings, required configuration names, secret scope, certificate/domain setup, expected health behavior and environment separation.
- Run staged rollout, API/database/client compatibility checks, signed/distributable desktop/mobile artifacts where applicable and a rollback rehearsal.

**Exit criteria:** reproducible selected runtime, release evidence from one commit, a verified restoration path, and explicit failures when required checks fail.

## Work package P06 — operational acceptance and maintenance

- Map operation-specific real persistence and production evidence; the current baseline does not supply this mapping for the 343 unit-evidence operations.
- Set and record supported load, latency/error budgets, backup/restore objectives and retention policies. Numeric targets not supplied by approved sources remain proposed.
- Verify metrics, redacted logs, alerts, audit integrity, incident ownership, secret rotation and access reviews.
- Rehearse a database restore and deployment rollback in a nonproduction environment, then record timing, data verification and limitations.
- Review dependency/security updates and their effect on actual deployed artifacts. A passing build does not establish regulatory compliance.
- Keep contract versions, migrations, caller compatibility, runbooks and decision records synchronized.

## Per-operation implementation checklist

| Check | Required artifact or evidence |
| --- | --- |
| Identity | Exact method/path, declaration IDs, stable operation requirement ID |
| Source | Primary caller, schema/model, governing metadata, handler and test paths |
| Contract | All 16 sections, examples and version/compatibility behavior |
| Authority | Actor/subject/tenant/resource/action and valid grant provenance |
| Persistence | Constraints, transaction, concurrency, replay and rollback behavior |
| Runtime | Actual registered handler, service binding and client invocation |
| Negative behavior | Denial, expiry, malformed input, wrong method, wrong tenant and disclosure tests |
| Integration | Real database behavior, required external dependencies and failure handling |
| Client | Real error/loading/empty states, localization, accessibility and navigation |
| Release | Exact-head CI, reviewed commit, artifact identity and rollback version |
| Accounting | No duplicate credit; repairs/retirements separated from implementations |

## Progress recording and estimates

Use [execution-state.json](execution-state.json) for the executed phase and evidence pointers. Update it after each package; do not mark future API tasks done when only their documentation exists.

A responsible whole-project duration cannot be calculated from the number 1,049 alone. The queue includes read projections, multi-step clinical mutations, external payments, integrations and infrastructure controls. Measure recovery and implementation time per completed family, separate waiting-for-decision time from engineering time, and estimate the remaining queue by complexity and dependencies. No three-hour or overnight completion promise is supported by current evidence.
