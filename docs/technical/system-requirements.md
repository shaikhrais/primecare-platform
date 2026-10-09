# PrimeCare system requirements and acceptance specification

## Document control and interpretation

Evidence baseline: repository commit `3979ed1028c8b7dfdb9acca72b1ea53d4d034127`. The working snapshot contains selected audit inputs, not a complete checkout. Statements labelled **verified** describe inspected source or pinned audit artifacts; they do not certify deployed behavior. Statements labelled **required** translate repository engineering rules into acceptance criteria. Statements labelled **decision required** are deliberately unapproved product or operational choices. A requirement is not a new permission grant, route declaration, clinical instruction, or production approval.

Authority: `.agents/AGENTS.md` requires governance-first development, endpoint contracts, least privilege, accessibility, localization, evidence-based implementation tags and backward compatibility. `docs/api/api-delivery-checklist.json` counts exact HTTP method plus path. A different method is a different operation; duplicate callers, generated code, field repairs and test totals earn no additional API completion credit.

Verified baseline: 1,415 unique operations; 343 with recorded unit evidence; 9 retired with evidence; 1,049 needing contract and verification; 14 blocked. The 343 have no operation-specific PostgreSQL or production evidence mapping in this checklist. `docs/api/workflow-contract-plan.json` groups 1,063 unresolved operations into 106 review families. Code-generation outputs are nonexecutable review descriptors. Treat every unresolved operation as unresolved until its own acceptance evidence exists.

## Actors and authority model

| ID | Actor or context | Verified source | Required boundary |
|---|---|---|---|
| ACT-001 | Authenticated user | `User`, `auth_sessions` queries, Flutter `AuthState` | Session subject identifies actor; request body cannot nominate a privileged actor. |
| ACT-002 | Client profile owner | `ClientProfile`, `client-self.ts`, client record registry | Identity-to-profile and tenant match must be demonstrated before disclosing records. |
| ACT-003 | Provider profile owner | `ProviderProfile`, `provider-self.ts`, provider record registry | Ownership does not grant access to all patient or organizational records. |
| ACT-004 | Tenant or administrative operator | Tenant relations, `account-admin.ts`, governance grants | Explicit operation scope and target tenant required; visible administrative UI alone is insufficient. |
| ACT-005 | Family or delegated participant | `FamilyMember`, family models | Relationship model is evidence of storage only; subject consent and delegation policy must be approved. |
| ACT-006 | Automation/integration identity | `ApiKey`, `WebhookEndpoint`, AI models | Separate machine identity, source dataset permission and delegated mutation boundary required. |
| ACT-007 | Anonymous visitor | Login/recovery handlers and public UI context | Access only to explicitly public operations; no default business-data access. |

Role names, role categories and role-to-screen links must be obtained from governance. Do not turn this actor classification into hardcoded role names in screen code. A missing endpoint permission-key column does not by itself prove no authority exists: inspect linked role grants, target scope, ownership constraints and existing policy. Conversely, a screen grant or generic all-role action cannot prove record-level authorization.

## Operation specification: mandatory fields

Every exact operation must have one controlled record containing all fields below. An omitted field is an unresolved decision, not an invitation to infer a permissive default.

| Field | Required detail and validation |
|---|---|
| Identity | Governance declaration IDs; exact method and normalized path; service; version; canonical route and each compatibility alias. |
| Purpose | User goal, permitted actor, business owner, source requirement and exclusion boundaries. |
| Trigger | Caller screen/element/controller or system event; when invoked; whether optional or required. |
| Preconditions | Active session, applicable grant, resource existence, tenant membership, workflow state and relevant consent. |
| Request | Path/query/header/body schema; requiredness; type; enum; precision; length; timezone; maximum collection size; unknown-field policy. |
| Response | Status, content type, field schema, nullability, pagination, ordering, derived-field formula and sample free of real patient data. |
| Validation | Order of structural checks; domain constraints; normalization; contradictory values; malformed identifiers; rejection behavior. |
| Authentication | Credential format; issuer/session store; expiry/revocation handling; ambiguous credential rejection; cookie protections. |
| Authorization | Approved role grant or ownership policy; target selection; scope; branch/tenant/global boundary; explicit denial tests. |
| Data handling | Tables and columns read/written; sensitive fields; minimum disclosure; redaction; retention and deletion decision references. |
| State transition | Allowed source states, resulting state, immutable history, actor, reason, timestamp and conflict response. |
| Transaction | Atomic writes, locks, unique constraints, rollback path, isolation assumptions and concurrent request behavior. |
| Idempotency | Applicable methods; scope and storage; payload hash; replay result; conflicting key response; expiry decision. |
| Audit | Event identity, actor, tenant, target, outcome, correlation ID, redacted change summary and durable recording boundary. |
| Failures | Unauthenticated, forbidden, malformed, absent resource, conflict, throttled, dependency failure and unsupported operation. |
| Rate limits | Subject/source/tenant bucket; approved thresholds; retry metadata; failure behavior when limiter unavailable. |
| Compatibility | Consumers affected; old method/route behavior; migration and retirement evidence; no silent write-to-read aliasing. |
| Verification | Unit, handler, gateway, PostgreSQL, client and release evidence; exact tested commit; owner and known limitations. |

Required implementation tags must distinguish `template_only`, missing API, connected transport, tested workflow and approved release. A passing compile or screenshot cannot change an unresolved operation into implemented.

## Functional requirements

### Identity and session lifecycle

**FR-AUTH-001 — Validate the current actor.** Required: extract supported credentials without ambiguous precedence; verify stored token hash, expiry and active-user state; derive user and tenant from the verified session. Input: session credential and optional tenant-context header. Output: only the approved actor representation. Failure: absent/expired/revoked/malformed credentials deny access; mismatched requested tenant denies access. No state-changing business effect is permitted in an identity read. Evidence: `cloudflare/workers/src/auth.ts` queries join `auth_sessions` to `users`, require future expiry and active status. Acceptance: valid subject, revoked subject, inactive user, no credential, duplicate cookie, conflicting tenant and database failure tests.

**FR-AUTH-002 — Preserve session state under client races.** Verified: `packages/flutter_core/lib/auth_service.dart` uses a session revision and serialized persistence operations. Required: a login result arriving after logout or a replacement login cannot restore the obsolete actor; storage failures cannot poison later cleanup; protected navigation must await initialization. Acceptance: delayed load/login/revoke races, logout-clears-keys, disposal during request, failed preference write and subsequent successful logout.

**FR-AUTH-003 — Recover credentials without disclosure.** Existing password recovery handlers must retain their tested contracts. Required: approved response semantics must avoid exposing whether an account exists; reset tokens and passwords must never appear in telemetry; reset success must follow the defined session invalidation rule. Decision required: policy for tenant ambiguity, reset-token lifetime, notification routing and unavailable mail dependency must be recovered from actual implementation and governance, not invented in this document.

**FR-AUTH-004 — Reconcile identity method mismatch.** Candidate `/v1/auth/whoami` appears in the finite checklist as POST. Before any fix, recover canonical OpenAPI, caller and handler evidence from the current tree; check whether GET exists and whether its response matches consumers; establish read-only active-session ownership authority. Publish no method correction until database declaration, gateway routing, client behavior and negative tests agree. Proposed candidate is not a completed operation.

**FR-AUTH-005 — Privilege-changing operations.** Role switch, impersonation, delegated access, email changes and business onboarding require independent transition rules. Do not substitute account identity for privilege approval. Each requires allowed actor/target combinations, current tenant, next tenant if applicable, session rotation/revocation, audit and failure rollback. These remain decisions unless source-backed rules are recovered.

### Client care and family access

**FR-CLIENT-001 — Owned record retrieval.** Required: verified session to client-profile relation; tenant-qualified selection; explicit field allowlist; stable pagination; empty response distinct from failed retrieval. Never satisfy a missing clinical metric with fabricated values. Acceptance: own record, another client same tenant, other tenant, missing profile, denied session, malformed database row and unavailable database.

**FR-CLIENT-002 — Booking lifecycle.** Verified gateway maps approved client submission aliases to `/booking-requests` and enforces POST. Required: preserve exact canonical lifecycle contract in `client-booking-lifecycle.ts`; approved service and tenant; one idempotent request result; transactional state changes and audit. Tests must exercise aliases through the gateway, payload/key conflicts, repeated requests and competing state transitions. A declaration for a read alias must never forward a write to the lifecycle handler.

**FR-CLIENT-003 — Family/team disclosure.** A family or care-team relation is not sufficient permission to disclose all notes, diagnoses, messages or billing. Required contract names specific subject, relationship, allowed fields, consent status, grant expiry and revocation behavior. Decision required: delegated access policy and minor/guardian rules. Exclude workflow activation until these are recorded.

**FR-CLIENT-004 — Messages and feedback.** Required: participant membership, tenant binding, attachment access if present, allowed message visibility, approved edit/delete behavior and delivery failures. Persistence success must not claim notification delivery success. Decisions include retention, moderation, recipient resolution and notification channels.

### Provider and clinical workflows

**FR-PROVIDER-001 — Self-service data.** Provider-owned availability and timesheet items require session-to-provider binding and tenant qualification; clients cannot choose another provider ID to gain write access. Evidence: provider self/records/timesheet handlers and registries. Acceptance includes same-tenant other provider, foreign tenant, stale session and prohibited field mutation.

**FR-PROVIDER-002 — Attendance and time accounting.** Require approved attendance source, valid start/end interval, timezone normalization, overlap and conflict policy, approval state and exact timesheet-item contract. Reject invalid duration and impossible transition before committing. Decision required: rounding, overtime, payroll conversion, location verification and supervisor delegation. A timestamp field alone does not establish these rules.

**FR-CLINICAL-001 — Assessments, notes, medication and care plans.** Prisma models prove data structures exist; they do not prove clinical write authority. Require assigned-care relationship and permitted professional scope, patient/tenant ownership, approved required fields, draft/sign/amend lifecycle, clinical consent and version conflict policy. Corrections must preserve legally required history according to the approved policy. No automated clinical action or medication decision follows from model existence.

**FR-CLINICAL-002 — Real dashboard data.** Required: source-specific counts, units, timestamps and denominator; visible unavailable/error state when permission or dependency fails; no mock success fallback. Asynchronous responses for an old actor/tenant must be discarded. Accessibility acceptance includes narrow viewport and enlarged text with no concealed action or overflow.

**FR-CLINICAL-003 — Handover and credentials.** Required: outgoing/incoming participants, care subject, tenant, signed acknowledgement or approved transition, immutable attribution and document verification provenance. Decision required: who verifies documents, expiry handling, scope changes and handover acceptance policy.

### Finance, administration and automation

**FR-FIN-001 — Financial reads.** Approved ownership and finance scope; explicit currency and exact decimal representation; documented amount source; minimum payment-data disclosure. Invoice ownership does not grant payroll, ledger or regional summary access.

**FR-FIN-002 — Financial writes.** Payments, payouts, settlement, expenses, reconciliation and ledger operations require approved actor, accounting period, state transitions, idempotency, transaction boundary, external-provider reconciliation and compensating failure behavior. Decision required: tax rules, fee calculation, dual approval, ledger reversal and period sealing. Never invent arithmetic or mutate historical entries silently.

**FR-ADMIN-001 — Administrative scope.** Every operation specifies tenant, branch or global authority, target and operation-specific grant. A parent/child tenant relation does not automatically allow parent users to see all child data. Bulk actions must apply authorization to every item and define atomic versus partial-result behavior.

**FR-ADMIN-002 — Reports and analytics.** Required: source dataset rights, formula, window, timezone, filter semantics, denominator, null/missing behavior and freshness. Clinical cohort output requires approved disclosure/aggregation policy. Missing data is not zero. Predictions require model version and provenance, not fabricated charts.

**FR-AUTO-001 — Integrations and automated actions.** Required: service identity, tenant binding, signature/credential verification, replay defense, approved input schema, retry/dead-letter policy and explicit delegated authority. Inferential or automated output cannot execute clinical, financial or staffing mutations without their separately approved workflow rules.

## Cross-cutting nonfunctional requirements

| ID | Requirement | Verifiable acceptance and unresolved decisions |
|---|---|---|
| NFR-SEC-001 | Least privilege and tenant isolation | Denial matrix covers actor/target/tenant/state; parameterized queries; no UI-only security; machine identities separated from users. |
| NFR-SEC-002 | Credential and secret handling | No secrets committed or logged; rotation and revocation test; appropriate credential storage verified for each client platform. Current use of SharedPreferences is observed, not a security certification. |
| NFR-SEC-003 | Browser boundary | Gateway and service CORS policies reconciled with actual deployed origins; cookies, CSRF requirements and authorization headers tested. Source policies currently differ; see architecture document. |
| NFR-DATA-001 | Sensitive-data minimization | Every output, log, export and backup has classification and approved field allowlist; no patient data in fixtures or generated examples. Retention/residency decisions remain explicit. |
| NFR-REL-001 | Honest failure | Timeouts, dependency errors and unsupported handlers cannot return fabricated success; retries restricted to safe/idempotent operations. |
| NFR-REL-002 | Integrity under concurrency | Real PostgreSQL tests for constraints, concurrent writes, rollback, idempotency and audit; mocked query tests alone insufficient. |
| NFR-OBS-001 | Diagnostic traceability | Correlation identifiers across client/gateway/service/database; redacted failure codes; separate health, business completion and external delivery signals. |
| NFR-PERF-001 | Measurable performance | Owner must approve latency percentiles, load, dataset size, regions, error budget and test duration before numeric targets become policy. Repository names performance categories but supplies no numeric SLO here. |
| NFR-A11Y-001 | Repository accessibility requirement | WCAG 2.2 AA target; keyboard, focus, screen reader, contrast, error announcements and text scaling verified. Flutter Web semantics enabled for tests, URLs include `enable-semantics=true`. |
| NFR-I18N-001 | Governed localization | Resource keys and locale values; pluralization, RTL/LTR, date/number/currency/timezone behavior; no hardcoded user-facing text or tokens in screens. |
| NFR-UI-001 | Shared governed UI | Approved component registry and design tokens; presentation-only screens; controller/service/repository responsibilities separated. |
| NFR-TEST-001 | Evidence-specific status | Unit, integration, API, end-to-end, accessibility and performance evidence tracked separately; exact commit and environment attached. |
| NFR-RELSE-001 | Controlled release | Exact-head applicable CI passes before merge; immutable build provenance; migration/rollback verified; production release is a separate deployment action. |
| NFR-DOC-001 | Traceable feature record | Purpose, business process, screen/section/element, API, permission, validation, tests, dependencies, owner and known limitations documented. |

## Requirement decision register

Each decision entry must name: requirement ID, workflow family, unresolved question, existing evidence, acceptable options, authorized owner, decision date, governance record, affected callers and acceptance tests. Use `unresolved` until an actual decision exists. Do not fill policy cells with general recommendations and call them approved.

Initial unresolved subjects include organizational permission scope; family delegation and consent; clinical signing/amendment; financial approval and tax rules; analytics formulas/cohort disclosure; automation authority; service numeric SLOs; backup/restore objectives; retention, deletion and residency; public-domain CORS reconciliation; complete current project and deployment inventory. These may be resolved by source recovery or by explicit owner policy; they are not all inherently new business decisions.

## Definition of an implemented operation

1. Exact declaration and accepted contract align with current caller, handler and gateway.
2. Authorization is established through verified grants and/or approved ownership policy, including negative cases.
3. Input validation, permitted persistence, transaction behavior, audit and errors satisfy the contract.
4. Focused handler and gateway tests pass; operation-specific PostgreSQL evidence is recorded where persistence applies.
5. Client binding handles loading, success, empty, denial and failure without fake fallback.
6. Relevant accessibility/localization/security checks pass; generated artifacts reproduce from governance.
7. Exact-head CI passes, changes merge and known release limitations are recorded.
8. Checklist transitions once for this unique operation; compilation, scaffolding and field repairs remain separate evidence.
