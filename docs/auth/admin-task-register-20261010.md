# Admin task register — 2026-10-10

Current status: Auth Worker and Support production EN/ES/FR E2E passed [run 38099908370](https://github.com/shaikhrais/primecare-platform/actions/runs/38099908370). See [production verification](admin-production-verification-20261010.md) for deployment provenance and remaining acceptance work.

## Implemented tasks

The authenticated workspace returns the nine task definitions from `packages/contracts/admin-tasks.json`. The inherited Admin tasks screen renders their instructions from the shared EN/ES/FR catalog. This metadata describes implemented workflows and does not grant permission. Task counts are not endpoint counts: these tasks use four unique Admin API operations and local language selection.

| Task | How the system works | Operation |
| --- | --- | --- |
| Workspace summary | Read the server-authorized organization and total/active account counts. | GET workspace |
| User directory | Read tenant accounts in pages of 25; refresh and paginate. | GET workspace |
| Account discovery | Combine a normalized literal email substring with all/active/inactive status filtering. Clear each filter independently; refresh, pagination and mutations retain the applied filters. | GET workspace with search/status |
| Create account | Enter email, password and a permitted role; validate centrally, hash the password and commit the account with its audit record. | POST workspace/users |
| Update account | Edit email or permitted role; reject protected accounts/escalation, commit changes and revoke target sessions. | PUT workspace/users/{id} |
| Activate/deactivate | Set active/inactive; revoke sessions on changes. Inactive accounts cannot authenticate; reactivated accounts can sign in again. | PUT workspace/users/{id} |
| Audit history | Read tenant creation, update and session-revocation events with safe email/role/status fields. | GET workspace/audit |
| Account audit filter | Open an account’s history; validate tenant ownership and clear the filter to return to all history. | GET workspace/audit with userId |
| Language selection | Switch English, Spanish or French through the shared app controller without losing entered form data. Selection resets to English on a new launch. | Local application state |

Sign-in, sign-out, account recovery and other common authentication workflows remain in the shared Auth layer rather than being copied into Admin.

## API mapping

All paths use the Gateway prefix `/v1/auth`. The four unique operations are `GET /admin/workspace`, `POST /admin/workspace/users`, `PUT /admin/workspace/users/{id}` and `GET /admin/workspace/audit`. Workspace reads accept offset, literal email search and canonical status (`active`, `inactive`, or empty/omitted for all). Audit reads accept offset and an account UUID. Unknown/duplicate query fields are rejected. Search and status combine with AND inside the same tenant snapshot, and both count and page queries use identical predicates. Every stored state other than case-insensitive active projects as inactive, including legacy deactivated values.

## Inheritance and centralized control

Admin screen layout now also inherits `BasePrimecareLayout` through `BasePrimecareScreen`. Shared window rules cover mobile through 4K, with readable content limits, adaptive account actions and accessibility scaling. See [layout policy and verification](admin-responsive-layout-20261011.md).

| Layer | Class hierarchy | Responsibility |
| --- | --- | --- |
| Worker task contract | AdminTask extends BaseRoleTask | Validate and serialize the central task definitions. |
| Shared Dart task model | AdminTask extends BaseRoleTask extends BaseEntity | Validate task metadata and expose it to the inherited UI. |
| Worker business rules | AdminWorkflow extends BaseTenantWorkflow | Authorize the active Admin actor, validate input, enforce role and tenant rules. |
| Persistence | AdminSqlRepository extends BaseTenantRepository | Bind tenant-scoped SQL; commit mutation, session revocation and audit atomically. |
| UI workflow | AdminController extends BaseAdminWorkflow | Maintain loading/error/search/status/audit-filter state and call the shared API transport; reject mismatched response filters and restore the last applied selector after failures. |
| Screens | AdminScreen, AdminAuditScreen and AdminTasksScreen extend BasePrimecareScreen | Render shared models and use the common navigation/language controls. |
| Localization | AppStrings extends BaseTextCatalog; AppLanguageController extends BaseLanguageWorkflow | Use one editable catalog and one language controller across inherited app shells. |

TypeScript and Dart share serialized contracts; they do not inherit across runtime languages. Account permissions remain server-controlled. The request pipeline is authenticated session → server tenant and authorization → central validation → tenant repository → safe response model → inherited localized UI. Audit-write failure rolls back the account change. Audit reads use read-only repeatable-read snapshots. No password hash, credential or session token is exposed in audit responses.

The locale generator checks duplicate keys, matching EN/ES/FR keys and placeholders, valid task definitions, and the existence of every task title/instruction. New tasks should first implement central authorization/business behavior, then add contract metadata and all three translations, thin shared UI and focused API/model/browser verification. Per-app screen copies are unnecessary.

## Remaining acceptance work

Auth Worker and Support Pages rollout and production Admin E2E are verified in EN/ES/FR. The other eight portal deployments were not republished in this work package. Native-platform verification of this newer Admin code is pending; earlier Auth native results do not certify it. Organization creation/global administration and elevated-role assignment require an explicit policy and are not implemented by these nine tasks. The historical 64-role queue still has no role marked fully accepted; Admin remains first.

## Verified task overview and activation lifecycle — 2026-10-11

[CI run 38097091443](https://github.com/shaikhrais/primecare-platform/actions/runs/38097091443) passed all steps: Worker type checks; 90 Auth regression and 39 Admin PostgreSQL/Gateway checks; 37 model, 85 core (one skipped) and 13 UI tests; 112-key EN/ES/FR catalog validation; Support release web build; and Chromium E2E in English, Spanish and French. Each browser scenario opens the inherited task overview, creates an account, changes email/role and deactivates it, reactivates it and verifies real sign-in, deactivates again and verifies the new session is revoked, then checks persistence, search, account-bound audit history, filter clearing and logout.


## Verified account status filtering — 2026-10-11

[CI run 38098719953](https://github.com/shaikhrais/primecare-platform/actions/runs/38098719953) passed all stages: Worker type checks; 90 Auth regression plus 46 Admin PostgreSQL/Gateway checks; 37 model, 90 core (one skipped) and 17 UI tests; the 114-key EN/ES/FR catalog check; Support release web build; and complete Chromium flows in English, Spanish and French. Browser tests verify combined email/status filtering, empty Active results for the inactive edited account, its return under Inactive, refresh and independent filter clearing, alongside the existing task overview, account lifecycle, audit, session-revocation and logout checks.

`GET /v1/auth/admin/workspace` now accepts optional canonical `status=active` or `status=inactive`; empty/omitted means all. The central domain workflow validates the filter, and identical tenant/search/status predicates bind both count and page queries. Legacy stored non-active states project as inactive consistently. Database tests exercise real two-page active results (28 accounts, pages of 25 and 3, with no duplicate IDs), combined filters, invalid/duplicate query fields and cross-tenant isolation. The shared core preserves filters through refresh, pagination and mutation reloads and rejects mismatched filter echoes, rows or counts.

The inherited UI uses the shared EN/ES/FR catalog. A regression test caught stale selector text after an immediate API failure; completion revisions in `BaseAdminWorkflow` now restore the last successfully applied filter even when loading/error notifications happen before a rendered frame. This is shared presentation state; permissions remain on the server.

The task catalog still describes nine workflows and the API still has four unique Admin operations. Status filtering extends account discovery rather than adding another operation. This work changed 15 source/config/test/documentation files, including two new focused test files. At that isolated verification checkpoint, production rollout/E2E remained pending; it subsequently passed as recorded at the top of this register. Native verification of the newer Admin code, organization creation and elevated-role policy remain pending. The verification workflow is manual after the passing run. The disposable isolated test build was not deployed.

## Native verification prerequisite — 2026-10-11

The five-platform native workflow now includes `packages/contracts` in its sparse checkout. Shared Admin UI tests read the central task catalog from this package, so omitting it prevents those tests from running on a clean runner. This fixes the checkout prerequisite; it does not establish a new native build or Admin integration-test result. The existing native integration suite exercises Auth, and full native Admin workflows still need their own verification.

The native harness now reuses the existing shared Admin account and status-filter tests through `native/admin_integration_test.dart`. All five platform jobs invoke both Auth and Admin suites. The six added native UI cases cover create/update, API denial, failed-filter recovery, and canonical inactive/all filtering in EN/ES/FR. Their controlled transport tests native UI behavior, not production Admin API E2E. No new native passing result is claimed until CI runs.

## Verified shared mobile-to-4K layout — 2026-10-11

[CI run 38101725450](https://github.com/shaikhrais/primecare-platform/actions/runs/38101725450) passed the shared layout revision: 19 added responsive/accessibility/state-preservation tests, all 36 UI tests, model/core and Worker/API checks, the Support release web build, and complete Admin browser E2E in EN/ES/FR. All three Admin screens inherit the shared window policy. Account actions adapt to available width and text scaling; shared form dialogs scroll title and content together, fixing a French large-text overflow. See [layout policy](admin-responsive-layout-20261011.md). This newer layout is published as code but was not deployed to production in this work package; earlier production Admin results remain historical evidence.
