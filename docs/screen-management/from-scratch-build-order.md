# From-scratch platform screen build queue

For the complete implementation phases, contract packet, access controls, reusable
architecture, per-screen dependencies, CI matrix and release gates, see the
[detailed development plan](detailed-development-plan.md). The queue below remains
the stable ordering reference; the detailed plan does not mark any screen complete.

The user requested sequential fresh builds: 1, then 2, then 3. Start with **Login**,
then recovery, MFA and the shared foundation. Complete each screen's contract,
implementation, GitHub Actions tests and review before advancing.

## Verified denominator
At commit `877fff1e906b51b57175ca7214956a3e1f4a4111`, the inspected presentation catalogs
contain 736 module paths and 944 workspace paths, with 394 paths in both. Including
shared/auth and native/registry-only governance entries gives **1,329 unique
registered route/config paths**. This is not 1,329 verified or distinct screens.
Callbacks, errors, placeholders, internal pages and multiple paths to the same
widget are included. Do not label progress 1/1329 screens complete. Use
`Item 1/1329: Login (screen contract pending)` until production reconciles the scope.

`platform-build-queue.json` assigns stable numbers to these exact paths. The first
12 items establish shared access/foundation, followed by the 22 concrete governance
screens below; remaining paths are sorted deterministically for an initial review
queue. That remaining order is provisional, not a dependency claim. Reconcile
production screen IDs and dependencies before implementation, retaining queue
numbers as references and recording shared-widget aliases rather than rebuilding
the same screen for each URL. Append new entries; do not silently renumber.

### First 12 items
1. Login
2. Forgot password
3. Reset password
4. MFA
5. Signup
6. Consent
7. Language
8. Authentication callback (route handler, not a screen)
9. Authentication error
10. Success
11. Common settings
12. Platform administration

Item 1 must be built from its approved production screen, section, element,
localization, appearance and authentication contract. Preserve existing login until
the fresh implementation and interruption/error tests pass on GitHub Actions.
The currently denied session-safety provenance publication is separate and remains
untouched. No live production data was accessed or modified for this queue.

## Governance subqueue

## Scope and evidence
This is the first build queue for the **22 concrete native governance screens** in
`apps/primecare_governance/lib/core/governance/route_registry.dart`, inspected at
`877fff1e906b51b57175ca7214956a3e1f4a4111`. It is not a count of all platform screens.
The placeholder, shared authentication routes and registry-driven routes are separate.
Existing implementation is retained until a fresh replacement passes its gates.
No screen is marked complete by this inventory.

The machine-readable queue is `native-build-order.json`. Each path and class is
taken from an actual native GoRoute builder, not inferred from a similarly named
screen or generated catalog. The paired CI check rejects missing, extra or changed
native routes. It verifies inventory parity only, not authorization or runtime behavior.

## Before the first screen
1. Read the pinned production governance contract for the exact route: screen,
   sections, elements, API schemas, permissions, component/theme tokens and language
   resource keys. Missing records are a blocker, not permission to invent contracts.
2. Verify the existing login, recovery, MFA, session and shell foundation. Preserve
   public/protected route behavior and current working shared components.
3. Review authoritative per-route authorization and server/API enforcement. The
   current governance router's authenticated-user redirect is not a per-route guard.
4. Use isolated synthetic fixtures to test allowed, denied, empty, malformed and
   failed responses. Never seed test users or business data in production. Fixture
   success is not production registration evidence.

## Build order
Start with the inventory, then evidence and remediation, security, operational
quality, and finally executive summaries. Earlier screens provide the evidence
needed by later screens. Each is a fresh presentation/state/service implementation
against the verified contract, reusing shared architecture rather than reusing
placeholder screen logic.

| Order | Screen | Existing route | Why now |
| --- | --- | --- | --- |
| 1 | Screen Status / Inventory | /governance/screen-status | Establish the real list and honest implementation state. |
| 2 | Screen Health | /admin/screen-health | Inspect verified diagnostics for each inventory entry. |
| 3 | Audit Log | /governance/audit | Show attributable evidence before remediation actions. |
| 4 | Ticket Center | /governance/tickets | Track gaps with a real lifecycle and audit trail. |
| 5 | Monitoring | /governance/monitoring | Add operational evidence, loading and failure handling. |
| 6 | Verification Center | /verification | Review verified checks and explicit unresolved items. |
| 7 | Security Hub / Device Security | /governance/device-security | Build constrained security workflows after access review. |
| 8 | Security Sentinel | /governance/security | Surface real security signals without simulated success. |
| 9 | Audit Dashboard | /generated/audit-dashboard | Summarize the verified evidence sources. |
| 10 | Compliance Reviews | /generated/compliance-reviews | Implement review workflow with actual permissions. |
| 11 | Incident Reports | /generated/incident-reports | Implement incident workflow with privacy and audit checks. |
| 12 | Quality Metrics | /generated/quality-metrics | Aggregate verified sources, never fabricated metrics. |
| 13 | Clinical Reference | /governance/clinical-reference | Read authoritative reference content with provenance. |
| 14 | Control Center | /governance/control-center | Coordinate only independently verified actions. |
| 15 | Governance HUD | /governance/hud | Summarize validated operational data. |
| 16 | Proposals | /proposals | Implement proposal decisions and review history. |
| 17 | Growth Pipeline | /generated/corporate/ceo/growth-pipeline | Requires exact authoritative grant mapping. |
| 18 | Regional Performance | /generated/corporate/ceo/region-performance | Requires exact authoritative grant mapping. |
| 19 | Leadership Reports | /generated/corporate/ceo/leadership-reports | Depends on verified operational reporting. |
| 20 | Reality Check | /admin/reality-check | Reconcile implemented behavior with contracts. |
| 21 | Role Screen Carousel | /admin/role-screen-carousel | Review role-specific flows after permission validation. |
| 22 | Screenshot Gallery | /admin/screenshot-gallery | Capture final evidence; screenshots alone do not prove readiness. |

## First governance screen: exact starting point
- Existing class: `ScreenStatusScreen`; route: `/governance/screen-status`.
- Existing view displays hardcoded Active/Clear/14ms metrics; its search logs text
  rather than filtering; a timed method claims a compliance audit. These are not
  verified business behavior and must not be copied into the fresh screen.
- Fresh screen requirements must come from the production contract. Proposed
  inventory/search behavior is a design intention pending that contract, not an
  invented registered feature.
- Preserve the existing screen and route until a reviewed replacement is ready;
  remove misleading success behavior as part of that approved replacement.
- No production connection was exercised during this inventory. The static
  PlatformScreenRegistry is a code catalog, not a replacement live authority.

## Per-screen completion gate
Implement one screen at a time. For each screen record production contract
provenance privately, exact source paths, dependencies, API/permission mapping,
synthetic fixture coverage and current commit's GitHub Actions results. Test
loading, empty, error/retry, forbidden/unauthenticated responses, repeated actions,
late responses, navigation dismissal, responsive layout, keyboard/semantics,
language changes and theme changes. Require architecture, database, security,
accessibility, performance, localization, API and documentation review. Do not
mark complete for compiling, registry presence or a screenshot.

## Live data access
The repository's `production_reader.connect()` uses only
`PRODUCTION_DATABASE_URL`, verifies the pinned manifest and opens a read-only
snapshot. Missing credentials or a pin mismatch must fail without SQLite fallback.
The existing production-reader workflow is manual on main and requires the
protected production environment. Its broad diagnostics are not a targeted
screen-contract export. Screen/role grant output is private security metadata:
do not publish row data in public CI logs or repository artifacts.

The existing `scripts/audit_governance_screen_grants.py` reads only screen/role
metadata for twelve explicit candidate paths. It does not cover all sections,
elements, translations or Screen Status, and cannot establish the full first
screen contract. A narrowly scoped approved read/export is still needed.

## Release blockers
- Authoritative production contracts not yet read for this build queue.
- Six native business routes have unresolved exact grant mappings; similar names
  are not aliases. The placeholder is not a business screen.
- Per-route and API authorization, current-head CI and reviews are not established
  by the queue. Keep PR #222 draft until release gates are satisfied.

## Plan to reduce screen build time

### Research basis and limits
Reviewed against `da984f2b08557acd61c175aa95360beb040292c4`. The plan reduces
repeated setup, late contract changes and slow feedback; it does not reduce the
completion gate. No PrimeCare delivery-time baseline exists in this review, so
there is no supported percentage reduction or hours-per-screen promise.
Implementation remains sequential: finish Login before Forgot password, and
each subsequent queue item before the next. Parallel work below is limited to
independent activities for the **same current screen**.

Flutter recommends separating views, UI logic and data access, reusing repositories
and injecting dependencies for tests. Apply those principles to the existing
Riverpod/GoRouter architecture, not a new state-management migration.
[Flutter architecture recommendations](https://docs.flutter.dev/app-architecture/recommendations).

### Reuse map: avoid rebuilding the foundation
- **Shell and registration:** use the existing boundaries and catalog in
  `packages/flutter_core/lib/models/screen_manager.dart` and
  `packages/primecare_ui/lib/src/screens/screen_manager_catalog.dart`.
  Resolve the actual router builder and imports first; a matching class name or
  catalog entry is not proof of dispatch or authorization.
- **Appearance, language and controls:** use existing `PrimeTheme`, Flutter
  theme, Easy Localization/live-screen text, responsive wrappers and
  `primecare_ui` controls described in [the shared responsibilities](README.md#shared-responsibilities).
  Reuse layout primitives; do not copy hardcoded labels, fabricated metrics or
  simulated business actions from old screens.
- **State and transport:** keep business/API behavior behind the established
  controller/provider and repository boundary. Preserve session and permission
  behavior while replacing presentation. Never introduce a second auth/session
  implementation to make a new screen easier to build.
- **Test mounting:** use
  `packages/primecare_ui/test/auth_login_localization_test.dart` as the first
  reference. It mounts the actual managed LoginView with shell/theme/localization,
  overrides transport and persistence, and exercises actual controller/notifier
  behavior. Extract only genuinely shared setup after review; keep each screen's
  assertions and real translation resources explicit.
- **Scaffolding:** use a reviewed manual starter first. The generator limitations
  in [the inventory](README.md) still apply. Do not re-enable the disabled
  30-screen scaffolder or use the broken legacy generator. Consider automation
  only after a second completed screen demonstrates stable boilerplate.

### Execution steps and ownership
1. **Contract owner: make one compact screen packet before coding.** Record queue
   number, exact route and actual builder, approved private contract reference
   and version, section/element IDs, permitted actions, API/error shapes,
   localization keys, appearance tokens, dependencies and acceptance cases.
   Missing contract or grant mapping blocks implementation; request the narrowly
   scoped approved read/export described above. Keep sensitive contract/grant
   contents out of public docs, logs and artifacts.
2. **Implementation owner: establish one reusable starter with Login.** Include
   the existing managed route adapter, presentation/controller separation,
   validated shared fields/buttons, typed view states, localized error mapping
   and dependency injection. Add only states and actions the contract requires.
   Maintain the existing working route until replacement gates pass.
3. **Test owner: prepare deterministic synthetic responses in parallel with the
   current screen's UI work.** Agree on the contract first. Cover loading, empty
   where applicable, success, malformed data, denied/expired sessions, transport
   errors, retries, duplicate submissions, cancellation and late responses.
   Fake the external boundary, not the UI or the business rule under assertion.
   Do not require production availability to execute these tests.
4. **UI owner: compose small shared widgets, then verify the actual screen.**
   Review narrow/wide layouts, keyboard focus, text scaling, semantics, theme
   changes and EN/FR/ES resources from the beginning. Avoid a separate late
   localization/responsive pass. Flutter recommends smaller reusable widgets
   for adaptable layouts; this is a maintainability rationale, not a measured
   PrimeCare speed result.
   [Flutter adaptive design](https://docs.flutter.dev/ui/adaptive-responsive/best-practices).
5. **CI owner: get early feedback entirely through GitHub Actions.** For each
   candidate commit, run inexpensive contract/inventory checks and focused
   controller/widget checks first, then affected router/app integration and the
   complete required checks before sign-off. All tests, analyzers and generated
   output verification run in GitHub Actions, not on a local machine. Unit/widget
   checks complement rather than replace integration coverage.
   [Flutter testing tradeoffs](https://docs.flutter.dev/testing/overview).
6. **Reviewer: close the current screen with one evidence record.** Record exact
   source commit, workflow run/job links, tested scenarios, review decisions and
   unresolved blockers. Keep route/config counts separate from accepted screen
   counts. Only advance when the per-screen completion gate above is met.

### GitHub Actions feedback improvements
The existing `.github/workflows/screen-build-queue.yml` already watches this
documentation and checks inventory parity. That job validates the queue, not
screen behavior. The auth Material workflow already has focused widget/analyzer
checks and PR-scoped cancellation; use its existing conventions rather than
creating an unrelated pipeline.

For later implementation, review workflow path coverage so shared control, theme,
translation, transport or router changes run all affected consumer checks.
A focused green job is not a substitute for those checks. Retain isolated
synthetic fixtures and protected production approval boundaries. Preserve the
auth Material workflow's intentionally uncached baseline proof; do not enable
caching there simply to improve duration. Propose cache changes elsewhere only
after timing setup separately and verifying cache keys and correctness.

Where appropriate for read-only test jobs, cancel superseded runs in a
workflow-and-PR-specific concurrency group; never cancel production/export work
as a speed shortcut. Preserve needed evidence and require the latest commit's
complete results. [GitHub concurrency controls](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/control-workflow-concurrency).

### Measure before expanding automation
For Login, Forgot password and Reset password, record:
- Time waiting for contract/permission clarification, active implementation time,
  CI queue/setup/test time and review/rework time separately.
- Number of CI correction cycles and defects found after initial review.
- Reused components versus screen-specific behavior, plus exact commit/run links.

After these three sequential completions, compare like-for-like tasks and identify
the largest avoidable delay. Keep safety/review coverage fixed; do not compare a
complex MFA flow with a simple page as if they were equivalent. Approve a small
deterministic scaffold only if the recurring work justifies its maintenance cost.
Its acceptance criteria must include no overwrites, stable IDs, explicit unresolved
contract fields, no invented permissions/endpoints, and GitHub Actions tests.
No production data access, new generator, CI configuration change or screen
replacement is performed by this documentation update.
