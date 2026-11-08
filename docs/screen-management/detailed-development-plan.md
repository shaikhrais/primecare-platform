# PrimeCare Screen Manager: detailed development and delivery plan

## 1. Purpose, scope and starting evidence

Build each approved PrimeCare screen from its authoritative business and governance contract, using the existing shared architecture, and replace existing behavior only after evidence-based acceptance. “From scratch” means a fresh, reviewed screen implementation, not a rewrite of authentication, authorization, transport, shell, theme or localization.

This is an implementation plan, not a claim that implementation, production inspection or release verification has happened. It extends [the build order](from-scratch-build-order.md) and [the source-bound scaffold guide](reviewed-screen-generator.md). Repository evidence was inspected at **559c4de8b83814d18bba757f36d17a0b323b59e6**, on existing draft [PR #222](https://github.com/shaikhrais/primecare-platform/pull/222), branch `codex/screen-management`. This documentation change creates no new branch and changes no runtime code, grants, production data or deployment.

### Verified facts and their limits

- [platform-build-queue.json](platform-build-queue.json) contains **1,329 route/config entries**, not 1,329 confirmed distinct screens. Its original inspection commit is recorded in the file. Keep this denominator separate from implementation progress.
- The first 12 entries establish access and shared foundations. Entries 13–34 correspond to the 22 concrete native governance builders in [native-build-order.json](native-build-order.json). The rest are a deterministic provisional inventory, not an approved dependency order.
- [ScreenManager](../../packages/flutter_core/lib/models/screen_manager.dart) checks explicit registration and presentation contexts. [The shared catalog](../../packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart) combines explicit, workspace, module and generated presentation registrations. Neither authorizes business access.
- [The governance router](../../apps/primecare_governance/lib/core/governance/route_registry.dart) redirects unauthenticated users, but its authenticated native-route dispatch is not a complete per-route authorization guard. This remains a release blocker, not a task solved by inheritance.
- [The generator](../../tools/mvc_generator/generate_reviewed_screen.py) produces abstract state/controller/view scaffolding, state tests, skipped E2E starters and a review record. It does not create a working business screen or register a route.
- The source-bound generator verifies a hash and selected-object equality. It does not prove source approval, production parity, current grants or endpoint enforcement. Its nested metadata slots require nonempty objects, not a complete semantic policy schema.
- No production contract was read for this plan. No local test, app, generator or production workflow was executed. CI evidence for the final documentation commit must be reported separately; historical green runs do not establish current-head readiness.

## 2. Delivery principles and decision owners

Assign a named person to each role before accepting the first screen. These are responsibilities to assign, not claims that named reviewers already exist.

| Role | Owns | Required decision |
| --- | --- | --- |
| Product / workflow owner | User goal, entry/exit flow, field and action meaning | Approve the screen's business acceptance cases |
| Governance / data owner | Authoritative metadata version, identity reconciliation, read scope | Approve source and resolve missing/ambiguous records |
| Security owner | Actor/role/tenant/owner policy, API enforcement, read controls | Approve deny cases and credentialed access boundary |
| Implementation owner | Concrete view, state, service mapping and route integration | Provide code and evidence without replacing working behavior early |
| QA / accessibility owner | Unit, widget, integration and real user-flow assertions | Verify positive and negative cases, supported devices and accessibility |
| CI / release owner | Exact-ref jobs, protected approvals, rollback | Confirm complete required checks and release evidence |

Working rules:

1. Complete **one queue item at a time**, starting with Login. Independent contract review, test design and component review may run in parallel for that same item. Do not start another screen to hide a blocked contract.
2. Preserve stable queue numbers. Append new paths; retain retired entries explicitly. Record aliases as relationships to an approved screen identity, never by silently normalizing paths or guessing from class names.
3. Reuse working shared systems. A direct-widget adapter can remain if its dispatch, layout and behavior are verified; changing a parent class is not a completion criterion.
4. Keep sensitive contract details and grant rows out of repository docs, CI logs, screenshots and ordinary artifacts. Commit only approved non-sensitive metadata and evidence summaries.
5. Missing contracts, unknown authorization and unavailable services remain explicit blockers or unavailable states. Never invent a successful response, health score or completed action.
6. PR publication is not production access, policy change, deployment or release approval. Preserve mandatory approval controls.

## 3. Phase gates and concrete outputs

| Gate | Work and deliverable | Exit condition | Stops progress when |
| --- | --- | --- | --- |
| G0: scope | Classify the current queue entry; resolve actual route/import/builder and owning app; identify aliases and existing behavior | One screen or route-handler identity, owner and bounded scope recorded | Duplicate/ambiguous identity or no real dispatch |
| G1: contract | Obtain approved read-only authoritative metadata; assemble versioned contract packet and acceptance cases | Product, governance and security review of exact packet | Missing section/element/API/policy data or source cannot be authenticated |
| G2: design | Specify state transitions, user flow, shared components, navigation and errors | Every contracted action has a service/policy mapping and test case | UI implies behavior the contract does not support |
| G3: starter | Preview source-bound generator; inspect outputs; retain honest status; manually integrate reviewed code | Scaffold compiles/analyzes in GitHub Actions and protected data is absent | Generator rejects identity, existing output or source mismatch |
| G4: implementation | Add concrete controller/view, typed mapping and actual app wiring | Full current-screen functionality demonstrated in isolated tests | Placeholder, fake success, missing action or unsupported server contract |
| G5: verification | Unit, widget, router/API integration and device/browser E2E on GitHub Actions | All applicable assertions executed on identified source; no required skipped tests | Failure, cancellation, missing run, unknown result or policy gap |
| G6: acceptance | Product/security/accessibility/architecture/data/localization/performance/docs reviews; rollback plan | Evidence accepted for this screen and dependencies | Missing reviewer or unresolved critical finding |
| G7: release | Authorized staging/release validation, final-head checks and protected approvals | Release owner approves deployed artifact and rollback readiness | Production parity, deployment authorization or required controls missing |

Track G0–G7 independently. “Scaffold generated,” “registered,” “tested” and “released” must never collapse into one green status. This plan does not advance any screen through these gates.

## 4. Screen sequence and dependencies

The sequence below preserves the existing queue. Dependencies are implementation planning requirements to confirm against the contract, not newly invented production registrations. A later screen's existing working implementation can serve as an integration dependency while the earlier replacement is built.

### Access and foundation: items 1–12

| Item | Route / purpose | Dependency to verify | Acceptance emphasis |
| --- | --- | --- | --- |
| 1 | `/login` | Approved login contract; existing auth/session controller, transport, theme, localization and allowed landing rules | Validation, real auth outcomes, duplicate submit, session interruption, safe return URL, MFA handoff, locale/theme |
| 2 | `/forgot-password` | Accepted Login navigation; authoritative recovery request and disclosure policy | Non-enumerating response where policy requires it, throttling, retry and cancellation |
| 3 | `/reset-password` | Recovery contract and token/session lifecycle | Expired/invalid/reused token, password validation, interruption, no secret logging |
| 4 | `/mfa` | Login challenge contract, verification and session issuance | Wrong/expired code, retry limits, interrupted challenge, back navigation, no premature session |
| 5 | `/signup` | Approved enrollment eligibility and existing identity service | Validation, consent dependencies, duplicate account handling; no invented auto-enrollment |
| 6 | `/consent` | Authenticated state plus approved consent/version semantics | Required disclosure, permitted decisions, failed save and navigation behavior |
| 7 | `/language` | Existing Easy Localization and live-screen text ownership | Supported EN/FR/ES resources, persistence policy, live changes, text scaling and direction |
| 8 | `/auth/callback` | Existing auth redirect contract | Treat as route handler, not visual screen; validate destinations, malformed parameters and loop prevention |
| 9 | `/auth/error` | Shared error mapping and approved recovery destinations | Safe localized errors, no raw secret/provider exceptions, retry/exit works |
| 10 | `/success` | Authenticated account state and approved landing policy | Show only verified account outcomes; no generic success for failed work |
| 11 | `/common/settings` | Account ownership and setting-specific API permissions | Correct persistence, cancellation, stale session and denied mutation behavior |
| 12 | `/platform/administration` | Exact platform permission and server-authorized inventory | Denied actor and other-tenant tests; role name alone never grants platform access |

Login must integrate and test existing MFA/recovery handoffs before acceptance, even though their fresh replacements are later queue items. This prevents a circular requirement to rebuild all auth pages before finishing Login.

### Governance: items 13–34

Each row also requires accepted shared foundations and an exact screen/API policy mapping.

| Item | Screen / exact route | Dependency and required evidence |
| --- | --- | --- |
| 13 | Screen Status, `/governance/screen-status` | Authoritative inventory identity, status definitions and real query contract; truthful loading/empty/unavailable/search states |
| 14 | Screen Health, `/admin/screen-health` | Inventory mapping and diagnostic source; freshness and provenance, no fabricated latency/health |
| 15 | Audit Log, `/governance/audit` | Authorized audit read contract; attribution, pagination, sensitive-field masking |
| 16 | Ticket Center, `/governance/tickets` | Approved issue lifecycle and action permissions; actual transitions and audit evidence |
| 17 | Monitoring, `/governance/monitoring` | Real signal sources, update/freshness policy and failure handling |
| 18 | Verification Center, `/verification` | Evidence identity and verification rules; distinguish failed, pending, skipped and passed |
| 19 | Security Hub, `/governance/device-security` | Approved device/actor scope and security action contract; no broad device authority by UI role |
| 20 | Security Sentinel, `/governance/security` | Verified signal classifications and access; no simulated incident/safe-state result |
| 21 | Audit Dashboard, `/generated/audit-dashboard` | Validated audit and verification sources; reproducible aggregation and drill-down |
| 22 | Compliance Reviews, `/generated/compliance-reviews` | Approved review lifecycle, reviewer scope and attributable decisions |
| 23 | Incident Reports, `/generated/incident-reports` | Privacy classification, incident workflow and permitted readership/actions |
| 24 | Quality Metrics, `/generated/quality-metrics` | Approved measures, source lineage, denominator and observation period |
| 25 | Clinical Reference, `/governance/clinical-reference` | Authoritative content version and readership; no invented clinical recommendations |
| 26 | Control Center, `/governance/control-center` | Individually authorized operational actions and their failure/rollback semantics |
| 27 | Governance HUD, `/governance/hud` | Verified source metrics with timestamp and drill-through to evidence |
| 28 | Proposals, `/proposals` | Approved decision lifecycle, review history and action-specific rights |
| 29 | Growth Pipeline, `/generated/corporate/ceo/growth-pipeline` | Resolve exact native-to-authoritative identity and API/grants; similarly named code is not an alias |
| 30 | Regional Performance, `/generated/corporate/ceo/region-performance` | Exact mapping plus approved regional scope and reporting definitions |
| 31 | Leadership Reports, `/generated/corporate/ceo/leadership-reports` | Exact mapping plus validated reports and audience restrictions |
| 32 | Reality Check, `/admin/reality-check` | Exact native grant mapping; compare contracts with actual evidence without overclaiming |
| 33 | Role Screen Carousel, `/admin/role-screen-carousel` | Exact native grant mapping and approved role-specific preview policy; preview is not impersonation authority |
| 34 | Screenshot Gallery, `/admin/screenshot-gallery` | Exact native grant mapping; approved capture/redaction/storage policy; images are supporting evidence only |

Items 29–34 have unresolved exact grant mappings in the existing plan. The separate `/governance/placeholder` route is a fallback, not a seventh business screen. Do not “fix” ambiguity by granting guest access or mapping a similarly named CEO record.

### Remaining platform inventory

For each remaining stable queue reference, classify: distinct screen, alias to accepted screen, callback/handler, internal utility, placeholder, retired entry or unresolved. Record canonical identity and dependencies only from reviewed evidence. If the provisional sort violates a real dependency, document the blocker and obtain an explicit queue-priority decision without renumbering records. Group reporting by actual business workflow and owning app after reconciliation; do not manufacture a platform-wide screen count or delivery date.

## 5. Authoritative contract packet

Create one reviewed packet per current screen. Keep private source data in an approved restricted location; public evidence records contain only safe references/hashes and review decisions. Do not place a private export in a tracked source path merely because the generator expects a repository-relative file.

Required contents:

- **Identity:** stable queue reference; exact route pattern and parameter definitions; owning app; authoritative screen ID/code; actual source file/import/builder; aliases supported by evidence; public/protected classification.
- **Purpose and flow:** approved business requirement; actor goal; entry points; prerequisites; allowed exits; success meaning; excluded behavior.
- **Structure:** section IDs/order; element IDs; labels and localization keys; data types; required/optional fields; validation and visibility rules; approved empty-state content.
- **API bindings:** exact operation identity/method/path; request/response and error schemas; pagination/filter/sort contracts; cancellation/retry/idempotency semantics; source freshness and caching rules.
- **Authorization:** actor/role assignment source; view versus action permissions; tenant/owner constraints; field-level restrictions; server enforcement point; deny-by-default behavior; revocation expectations.
- **Presentation:** approved component identities, layout constraints, theme tokens, breakpoints, semantics labels, focus order and supported locale content.
- **Tests:** positive and negative cases tied to requirements, including session interruption and cross-tenant/owner attempts; expected observable result for every case.
- **Provenance:** source/environment identity, contract version, exact source hash, extraction scope/time, reviewer and decision; unresolved discrepancies.
- **Delivery:** code/test paths, CI run/job links and tested SHA, acceptance decisions, migration/rollback reference and residual risks.

Do not put secrets, real user/patient records or raw grant matrices in the packet committed to GitHub. If a requirement is unknown, record the missing fact and responsible owner. Unknown values must not be filled with plausible placeholders to satisfy generator validation.

### Policy reconciliation

Build a private matrix of actor × route/action × tenant/owner scope × expected result. Test both UI navigation and direct API requests. Separate a missing metadata row, an explicit denial, an inaccessible database query, a malformed contract and an empty business result. None is evidence of the others. A client-hidden button or registered route cannot enforce server access.

## 6. Production read-only governance access

This phase is **planned, not performed**.

The existing [production reader workflow](../../.github/workflows/governance-production-reader.yml) has an offline test job and a production job gated to manual dispatch on main with the production environment. Its broad diagnostics are not a narrowly scoped full-screen contract export. Do not dispatch it simply to retrieve Login metadata.

The separate [seven-route diagnostic candidate](../../tools/governance-production/narrow-authority-reader.md) is not invoked by a workflow, does not cover Login/sections/elements/localization, and cannot establish complete screen authority. It still requires independent source review, actual PostgreSQL fixture validation, TLS/driver validation, dependency provenance and trusted execution controls before credentialed use.

Required preparation:

1. Governance owner identifies the authoritative metadata relations and exact Login identity. Validate actual schema/relationships; do not assume historical numeric IDs share the same domain.
2. Specify a narrowly bounded read/export: exact screen and linked section/element/API/policy/theme/localization records, necessary columns, maximum rows/bytes/time, permitted recipient/storage and redacted output.
3. Security owner approves the exact reader revision, SELECT-only scope, credential privileges, TLS verification, snapshot/pin checks, rollback/cleanup, dependency provenance and fail-closed behavior.
4. Establish a protected execution ref/environment and private output handling. Use existing approved secret mechanisms; do not paste credentials into chat, source or logs. Never expose production secrets to arbitrary PR code.
5. Obtain any required run/access approval for that exact action. If approval is unavailable, report the blocked action and continue only noncredentialed preparation.
6. Verify read-only credentials and transaction behavior independently, perform the approved read, validate shape/provenance, and deliver only approved redacted evidence outside the private review location.
7. Reconcile observed records with approved business policy and deployed enforcement. A complete metadata read is not a runtime access test or permission to mutate missing rows.

No SQLite or historical-fixture fallback may masquerade as production authority. Missing credentials, pin mismatch, unavailable tables or ambiguous ownership must stop the read. Registration, grants, schema changes, user creation and production seeding are separate actions, outside this documentation task.

## 7. Reusable implementation architecture

Use the existing Flutter/Riverpod/GoRouter structure:

**Existing authorized router → shell → ManagedScreenBoundary → governed view → controller/provider → injected service/repository → existing authenticated API transport.**

Authorization must be checked before protected data is fetched/rendered and enforced again by the server. Presentation context checks remain separate.

| Existing reusable layer | Use | Do not infer |
| --- | --- | --- |
| `ManagedScreenRegistration`, `ScreenManager`, `ManagedScreenBoundary` | Explicit presentation identity, required shell/theme/locale/media context and feature scope | Access grants, correct builder class or complete provider wiring |
| `managedPrimeCarePage`, existing shell / `AppShellBoundary` | Adapt approved standalone or existing direct-widget pages | That a shell marker validates every layout or permission |
| `GovernedConsumerWidget`, inherited screen behavior | Consistent governed view composition | That changing inheritance finishes a screen |
| `BaseScreenState`, Riverpod controller/provider | Shared state conventions with screen-specific typed models | That an empty map means successfully loaded business data |
| `PrimeTheme`, Flutter Theme, responsive wrappers | Shared tokens, sizing, text scaling and appearance | That all controls already follow these settings |
| Easy Localization and live-screen text | Approved EN/FR/ES keys and live overrides | Translation completeness from locale context alone |
| `primecare_ui` controls | Consistent fields/buttons/errors/focus/semantics | Correct screen-specific labeling or workflow without tests |

Prefer composition and small reusable widgets to deep inheritance. Keep shared fields/buttons state-free where possible. Screen controllers own screen state; services own external behavior. Do not put API URLs, permissions or business decisions into a universal widget superclass.

State design must distinguish not-started, loading, loaded, legitimate empty, unavailable, failed and forbidden where applicable. Use typed immutable domain models for nested data. The generated state's shallow map snapshot does not make nested values immutable. Explicitly clear errors using the established rebuild semantics; inherited `copyWith(errorMessage: null)` does not clear an error.

For each async action: capture the relevant session/scope identity, prevent duplicate submissions as required, invalidate obsolete requests on disposal/navigation/session change, and discard stale results. Never restore protected content after logout or tenant switch. Avoid automatically retrying a non-idempotent mutation unless the contract makes that safe.

### Generator lifecycle and limitations

Use the existing tool; do not re-enable unsafe legacy bulk generation.

1. Prepare a reviewed source-bound request with exactly `version`, `source` and `contract`, following [the generator guide](reviewed-screen-generator.md). The contract includes all eleven slots: businessRequirement, role, screen, sections, elements, apis, permission, theme, localization, tests and documentation.
2. Preview without `--write`; inspect identity, source hash/pointer and output paths. Execute generator/test verification only in GitHub Actions for this work.
3. Generate into an absent `scratch/screen-scaffolds/<app>/<screenCode>/` directory. No overwrite/force operation. Interrupted output needs explicit review, not automatic deletion.
4. Review all six artifacts. The controller and view are abstract; the E2E file contains skipped failures, not completed coverage. Preserve `abstract_scaffold_only` and unverified statuses until implementation evidence exists.
5. Manually integrate the concrete implementation into its owning app, review imports/providers and register only after policy and route review. Keep private review metadata out of repository artifacts.
6. Run actual widget, router and E2E tests for the integrated screen. Generator state-test success is insufficient.

Observed limitations to handle, not conceal: the generator's route syntax rejects some identities preserved by the queue parser, including double-slash literals. Do not normalize those routes to make generation pass; resolve authoritative identity first. The generator validates the app name's syntax, not the existence of its app directory; review owning-app existence independently. It does not validate full metadata semantics or issue live database reads.

## 8. User-flow design and the first Login work package

Design around a user's completed task, not isolated screenshots.

**Typical protected flow:** open a deep link → initialize session → authenticate if necessary → complete required challenge/consent → revalidate safe destination and access → render authorized content → perform permitted action → observe authoritative result → exit/logout without retained protected data.

For each step, define the interrupted alternative: network loss, expiry, denied role, wrong tenant/owner, malformed response, repeat click, back/forward, close/cancel, reload or late response. Define focus and safe recovery destination after each transition.

Login implementation checklist:

1. Resolve the actual `SharedAuthRoutes` builder to `LoginView` and the existing login controller/transport. Confirm all consuming app routers rather than selecting a class by name.
2. Obtain G1 contract approval before deciding fields, providers, password rules, SSO choices, error messages or landing behavior.
3. Capture existing working behavior as GitHub Actions regression tests. Use the actual managed Login view with real theme/localization resources and injected external boundaries.
4. Specify field validation, loading, failure, challenge and authenticated transitions. Do not fabricate a user/session to show success.
5. Build the fresh view using shared controls and approved keys/tokens; preserve existing authentication/session implementation.
6. Test allowed and rejected return URLs, initialized/uninitialized sessions, failed authentication, repeated submit, expired challenge/session, recovery navigation and late completion after logout.
7. Verify narrow/wide layout, keyboard submit and focus, screen-reader labels, large text, EN/FR/ES and live locale/theme changes.
8. Integrate through the actual router without deleting the old implementation until candidate evidence is accepted. Use an explicitly reviewed reversible cutover; no ad hoc production toggle.
9. Record accepted source, checks, reviews and remaining risk. Advance to item 2 only after the Login completion gate passes.

Security expectations such as safe redirects, session isolation and non-disclosure are mandatory review concerns; exact business outcomes still come from the approved auth contract.

## 9. Test strategy and GitHub Actions delivery

All execution belongs in GitHub Actions for this task. No local tests or production test accounts are needed.

| Layer | Required assertions | Evidence / existing starting point |
| --- | --- | --- |
| Contract / inventory | Exact identity, duplicate/missing routes, unresolved expressions, unchanged queue numbers and source provenance | `screen-build-queue.yml`, `screen-candidate-inventory.yml`, source-bound generator tests |
| Unit | State transitions, mapping, error clearing, validation, scope/session changes, cancellation and retry rules | Generated state tests plus real controller/service tests |
| Widget | Actual managed screen, theme/locale, loading/empty/error/denied, focus/semantics, responsive layout, repeated actions | `auth_login_localization_test.dart`, `auth_material_surface_test.dart`, relevant existing app tests |
| Router / app integration | Correct builder/import, deep links, return URLs, public/protected paths, role change, logout/back and provider lifetime | Actual owning app router and shared auth/governance tests |
| API integration | Actor/tenant/owner authorization, contract shape, revoked sessions, direct endpoint denial and mutation semantics | Isolated backend using actual enforcement code, not a UI mock |
| E2E | Real app entry → user action → isolated backend outcome → navigation/error/recovery | Owning app's device/emulator/browser harness; replace skipped starter failures with actual assertions |
| Cross-cutting | Localization review, accessibility, performance, sensitive-data leakage and shared consumer regressions | Explicit reviewed checklist plus current-commit run/job evidence |

Synthetic fixtures are allowed **only inside isolated tests**, clearly labeled and never registered or displayed as production truth. They must exercise real UI/business/enforcement code; mocking the authorization decision itself cannot prove authorization. Never run destructive/mutating E2E against production.

CI implementation backlog:

1. Keep the existing `Reviewed screen generator` lane for Python validation, generated Dart analysis/format and state tests against actual shared packages. It proves scaffold checks only.
2. Keep `Screen build queue` for parser and catalog parity. Documentation changes under this directory match its PR path filter; verify a run actually appears.
3. Reuse `Native auth Material surface` for affected auth widget/analyzer regressions. Preserve its intentionally uncached negative-baseline proof.
4. Add or extend the owning screen's focused test selection, then include all affected consumers for shared shell/theme/localization/transport/router changes. Inspect path filters so dependencies cannot silently bypass checks.
5. Add the current screen's actual integration/E2E entry and isolated backend setup. Record skipped tests separately; a required skipped scenario blocks acceptance.
6. Use explicit source SHA, toolchain versions, dependency-lock policy, read-only job permissions, timeouts and PR-specific concurrency for ordinary test jobs. Do not cancel protected production work as a speed optimization.
7. Keep credentials out of untrusted PR jobs; keep deployment and production export lanes separate. Sanitize test artifacts and screenshots, set retention and preserve failed-job evidence.
8. Report pass/fail/skipped/not-run/blocked per job and scenario. Rerunning a failed job must not erase the failure history or replace assertions with weaker checks.
9. Before merge, inspect repository-required checks and reviews and wait for the exact final head's applicable results. Test commit versus merge-ref semantics must be recorded. “No status found” is not success.

Performance: measure initial render, API latency, payload and interaction behavior on agreed device/data-size profiles, then approve budgets with the owner. Do not invent milliseconds or universal coverage percentages. Shared changes need representative consumer regression coverage, not only a new screen's small suite.

## 10. Truthful data, security and migration

- No timer-based “audit complete,” hardcoded healthy/security status, invented metrics or fallback success. Render unavailable/pending/error with a safe action when the service/contract is unavailable.
- Legitimate empty data is a successful authorized query with zero results, not a transport error, permission failure or unimplemented endpoint.
- Include source period/freshness for aggregate reports; stale data must be labeled according to the contract.
- No secrets or personal health data in analytics, URL parameters, exception messages, snapshots or CI artifacts. Review telemetry fields explicitly.
- Verify route parameters, filters and identifiers server-side. Test unauthorized direct API requests and cross-tenant/owner reads/actions even when navigation is hidden.
- Review cached state, persisted preferences, listeners, downloads and pending requests on logout/revocation/tenant change. Clean up child views and requests without losing valid user work unexpectedly.
- Preserve existing code while preparing the replacement. Compare candidate behavior with the approved contract rather than copying old fake metrics or unsafe actions.
- Review cutover and rollback at screen scope; preserve compatible routes/contracts. No production schema/grant migration is implied. Any necessary data migration requires its own reviewed plan and authorization.
- The current native governance route authorization gap must be fixed and tested before releasing those screens. Existing working presentation is not evidence that access is safe.

## 11. Progress, estimation and evidence record

Maintain separate totals:

1. Inventory entries classified / 1,329 route/config entries (versioned denominator).
2. Distinct approved screen contracts / distinct screens whose scope has actually been reconciled.
3. Current screen's gates G0–G7 and blockers.
4. Accepted implementations, verified integrations and released screens, each counted separately.
5. Test outcomes and review decisions tied to source, not cumulative historical greens.

Example reporting format, not a completion claim:

> Queue item 1: Login. Contract: blocked pending approved authoritative read. Scaffold: available as a generic utility, not a completed Login screen. Runtime integration: not accepted. Current-head CI: report exact run results. Next action: governance/security owner approves the bounded contract-read procedure.

Minimum evidence record fields: queue reference, canonical identity, contract version/reference, source SHA, affected paths, gate statuses, implemented scenarios, executed/failed/skipped scenarios, workflow/job URLs, reviewer decisions, unresolved blocker/owner, cutover/rollback reference and release status. Do not commit private source/grant values.

For Login, Forgot password and Reset password, measure contract wait, implementation effort, CI queue/setup/test duration, review/rework, failure cycles and escaped defects separately. Only after these sequential completions establish comparable baselines should the team forecast throughput or justify additional automation. No hours-per-screen or percentage speedup is supported yet.

## 12. Release criteria and immediate next actions

### Per-screen completion

All contracted controls and actions work; actual app dispatch is verified; required backend, role, tenant and owner enforcement is tested; no fake success/data remains; interruption and error flows pass; localization, accessibility, responsive layout and performance are reviewed; all required scenarios execute; evidence and reviewers identify the exact candidate source; rollback is documented.

### PR / release completion

- All applicable required checks and reviews pass for the final head, including regressions for shared consumers.
- Authoritative contracts and exact grant mappings are reconciled; no unresolved native-route access gap.
- Production parity and staging/release validation are demonstrated through separately approved controls, not inferred from a generator or fixture.
- No required E2E starter remains skipped; no unsupported claim of “all screens complete.”
- Security/privacy review and protected approvals are complete; deployed artifact identity and rollback procedure are verified.
- PR #222 remains draft until these criteria are met. Do not merge merely because this plan or an inventory check passes.

### Next actionable sequence

1. Assign contract, security, implementation and QA owners for **item 1, Login**.
2. Approve the bounded Login contract-read design and private output handling; finish any reader/SQL/TLS/provenance prerequisites before requesting the credentialed run.
3. Reconcile the exact Login contract and policy, then create its reviewed packet and requirement-to-test matrix.
4. Use the existing source-bound starter only after that packet is approved, then implement the concrete Login view/controller integration without replacing the working route prematurely.
5. Run actual unit/widget/router/API/E2E checks on GitHub Actions, collect review decisions and accept Login before advancing to Forgot password.

**Current blockers:** approved authoritative Login contract not yet read; secure narrow full-contract read/export not established; six native business-route mappings unresolved; governance per-route authorization incomplete; runtime/E2E/release evidence not established by this plan. These are explicit dependencies, not reasons to generate fake screens or weaken gates.
