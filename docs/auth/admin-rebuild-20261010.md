# Fresh inherited Admin implementation

The executable legacy `AdminService`, its old tests, and the placeholder Dart `AdminDashboardScreenRoutes` were removed. The new Admin starts from shared parents and contracts. Billing Admin, IT Admin, and the existing CEO account-management API are distinct authorities and were not removed. Historical catalogs, screenshots, and archived role evidence are not executable implementations of this new role.

## Class hierarchy

| Layer | Inheritance or contract | Responsibility |
| --- | --- | --- |
| Dart models | `AdminUser` and `AdminAuditEvent` extend `BaseEntity<String>` | Secret-free account and audit projections |
| Central backend business | `AdminWorkflow extends BaseTenantWorkflow` | Admin authority, allowed roles, protected accounts, input validation |
| PostgreSQL adapter | `AdminSqlRepository extends BaseTenantRepository implements AdminRepository` | Tenant-scoped SQL, password hashing, audit persistence |
| Shared Dart workflow | `BaseAdminWorkflow` | Transport-neutral loading, commands, pagination, errors |
| UI controller | `AdminController extends BaseAdminWorkflow` | Notify Flutter of state changes |
| UI screens | `AdminScreen` and `AdminAuditScreen` extend `BasePrimecareScreen` | Render shared account/audit workflows and pagination |
| Language control | `AppLanguageController extends BaseLanguageWorkflow` | One EN/ES/FR selection across inherited app shells and routes |
| Text catalog | `AppStrings extends BaseTextCatalog` | Shared labels, validation, errors, roles, status and parameter substitution |

Central backend business code is in `packages/domain/src/workflows/admin-workflow.ts`. SQL is in `cloudflare/workers/src/admin/admin-repository.ts`; HTTP routing and session verification remain in the deployed auth Worker host. Dart workflows are in `primecare_core`; presentation is in `primecare_ui`. TypeScript and Dart share serialized contracts and policy semantics rather than inheriting across languages.

## Contract

All requests require an explicit bearer session for an active `admin` user. The server derives the tenant from that user. A mismatched tenant header is forbidden; no request body can supply a tenant or grant global access.

| Method | Gateway path | Behavior |
| --- | --- | --- |
| GET | `/v1/auth/admin/workspace?offset=0` | Organization identity, exact account counts, 25-user page, assignable roles |
| GET | `/v1/auth/admin/workspace/audit?offset=0` | Tenant-scoped creation/update/session-revocation audit events, 25 per page |
| POST | `/v1/auth/admin/workspace/users` | Create an active account with a hashed initial password and creation audit |
| PUT | `/v1/auth/admin/workspace/users/{id}` | Update email, role and status; revoke sessions and append audit atomically |

Assignable roles are explicitly limited to client, employee, PSW, RN, RPN, RMT, physiotherapist (`physio`), scheduler, customer support, and intake. Admin cannot create or edit privileged accounts, modify itself, or manage another tenant. Deactivation and every account update revoke target sessions. Duplicate email returns 409; invalid fields return 400; unauthorized access returns 401/403; out-of-tenant targets return 404. Audit failure rolls back account changes and session revocation.

After Admin signs in, **Open admin workspace** opens the inherited screen. It shows organization and counts, paginated accounts, protected-account labels, create/edit forms, loading, error, refresh, and empty-page states. New passwords are never exposed in account responses.

## Verification and remaining role scope

`verify-admin-rebuild.yml` runs Worker type checks, the existing real-PostgreSQL auth regression, new gateway/PostgreSQL Admin checks (including audit-failure rollback), shared package analysis/tests, Admin widget workflow tests, a Support web release build, and real browser E2E through Gateway/Worker/PostgreSQL. It uses a disposable PostgreSQL database, never production credentials.

This is the fresh tenant-account Admin implementation. Global tenant creation, unspecified elevated role assignment, deployment, and production browser E2E are separate remaining acceptance items before Admin can be marked role-complete. Existing authentication production verification does not cover these new Admin operations. No fake organization-creation action was added.

## Verified result — 2026-10-10

[Final CI run 38092892268](https://github.com/shaikhrais/primecare-platform/actions/runs/38092892268) passed. It verified Worker type checks, 90 existing auth/PostgreSQL regression checks, 20 new Admin gateway/PostgreSQL checks, shared model/core/UI analysis and tests (including both new Admin widget tests), a Support web release build, and Chromium browser E2E through the real Gateway, Worker, and disposable PostgreSQL database.

Browser E2E signed in as Admin, opened the inherited workspace, created a Client account, authenticated that new account through the API, edited its email and role, deactivated it, confirmed durable database state and session denial, refreshed the workspace, and signed out. All test accounts and their related tenant/session/audit records were cleaned up; the disposable database was destroyed by CI. These are isolated CI results, not production rollout evidence. The local-test web build uses a loopback HTTPS API and is never uploaded to production.

The initial rebuild implemented three unique Admin API operations; the audit extension adds a fourth. Check totals count database/Gateway cases, not API operations. Legacy `deactivated` or other non-active stored states project to inactive in the new account model. The account editor owns its controllers through its widget lifecycle; account identity/status and edit controls have separate accessibility nodes. Browser dropdown tests use Flutter's field semantics and menu accessibility labels.

The workflow is manual after verification. Production websites and Workers have not been redeployed for this Admin rewrite, and Admin remains incomplete against the broader role acceptance gate until its remaining scope and production E2E are finished.

## Central EN/ES/FR control and audit extension

`packages/contracts/locales/admin.json` is the single editable catalog. `scripts/generate-app-localizations.py` checks duplicate keys, nonempty values, exact EN/ES/FR key parity, and placeholder parity, and generates the Dart catalog. All nine inherited application shells install the same language controller, supported locales, and Flutter material/widget/Cupertino delegates. The Auth, Admin workspace, editor, and audit screens share the selector. Selection lives in app memory and resets to English on a fresh launch; it is not persisted in storage.

Language selection changes labels and messages, including displayed roles/status and audit dates. Canonical API roles, account status codes, tenant identity, and authorization remain unchanged. Form controllers and authenticated state are preserved when the shared app locale changes. Admin business rules remain in the TypeScript domain workflow; Dart UI/controllers inherit transport-neutral account/audit commands and presentation state. This does not claim cross-language runtime inheritance.

Audit history combines existing account-creation and account-management audit tables inside a tenant-scoped read-only repeatable-read transaction. Pagination sorts by timestamp then namespaced audit ID. Only email/role/status are projected from audit JSON; credentials, password hashes, session tokens and unrelated JSON fields are excluded. The new entity validates allowed actions, dates, and safe immutable state maps. The screen translates event labels and role/status descriptions while preserving recorded identity values.

The expanded verification includes 26 Admin database/Gateway checks, 90 existing Auth regression checks, shared model/core/UI tests, catalog parity checks, a release web build, and actual browser create/update/deactivate/audit/logout flows in all three languages. Production deployment and production Admin E2E remain separate acceptance work. Global tenant creation and any elevated-role policy remain outside this bounded tenant-account implementation.

### Verified extension result

[CI run 38094865819](https://github.com/shaikhrais/primecare-platform/actions/runs/38094865819) passed all steps: Worker type checks; 90 Auth and 26 Admin real-PostgreSQL/Gateway checks; model/core/UI analysis and tests; 85-key EN/ES/FR catalog parity; Support release web build; and Chromium create/update/deactivate/audit/logout flows in English, Spanish, and French. UI tests also verify language changes preserve entered Auth form data and localize permission-denied states. Audit cards expose event labels/details through separate accessibility nodes.

This extension changes 29 source/config/test/documentation files (19 existing files and 10 new files). All nine app shells inherit the localization setup without per-app copies. This file count describes the scoped extension, not completion of the whole legacy repository. The verification workflow is manual again after the passing run.

New Admin/localization production rollout, native-platform verification of this extension, and production E2E have not been performed. The prior Auth deployment/native results do not certify this newer Admin code. Admin remains first in the queue; no additional role is marked complete.

## Account discovery and audit targeting extension

The existing two Admin read operations now support tenant-scoped discovery; the unique API operation count remains four.

- `GET /v1/auth/admin/workspace?offset=0&search=...` searches email substrings, normalizes trim/case in `AdminWorkflow`, and reports matching total/active counts. Search is limited to 254 characters and rejects control characters. PostgreSQL binds the literal search parameter using `POSITION`; percent/underscore characters are not SQL wildcards. No tenant override is accepted.
- `GET /v1/auth/admin/workspace/audit?offset=0&userId=...` selects one account’s audit history. The central workflow validates and normalizes the UUID. The repository checks that the account belongs to the actor’s tenant before reading events; nonexistent and cross-tenant accounts both return 404. Omitting the filter selects all history in the authorized tenant.

`BaseAdminWorkflow` retains the applied search and audit target through refresh/pagination; account mutation reloads retain the search. The shared UI adds search/clear controls, matching-count labels, each account’s history action, and a clear-filter action on the inherited audit screen. Screens receive the same `AdminUser` model used by the workflow; API authorization remains authoritative. Search/filter responses are bound to their echoed query, and filtered events with a different target are rejected by the core workflow.

The editable catalog contains 92 keys in each of EN/ES/FR. This adds no per-app screen copies, runtime role subclasses, elevated privileges, or database migration. The focused verification adds literal-search, normalization, invalid-query, pagination, cross-tenant, missing-target, query-state, response-binding, and localized rate-limit cases. Browser tests exercise search, filtered history, clearing filters and the existing create/update/deactivate/logout flow in all three languages.

### Verified search/filter result

[CI run 38095857175](https://github.com/shaikhrais/primecare-platform/actions/runs/38095857175) passed: Worker type checks; 90 Auth regression and 36 Admin PostgreSQL/Gateway checks; shared package analysis/tests (including four new core filter tests); the 92-key EN/ES/FR catalog check; a Support release build; and Chromium E2E in English, Spanish, and French. Each browser flow creates/updates/deactivates an account, searches its email, opens its two-event audit history, clears the audit filter, clears search, reviews all tenant history and signs out. Fixtures are cleaned up by the scripts and the disposable database is destroyed by CI.

Four unique Admin API operations remain implemented. This package enhances two existing read operations; it does not add two new API operations. Inheritance and tenant authority stay centralized. Production rollout, native-platform verification of the newer Admin code, broader organization setup/elevated-role policy, and production E2E remain outside this isolated verification result. No additional role is marked complete. The verification workflow is manual after the passing run.

## Verified task overview and activation lifecycle — 2026-10-11

[CI run 38097091443](https://github.com/shaikhrais/primecare-platform/actions/runs/38097091443) passed all steps: Worker type checks; 90 Auth regression and 39 Admin PostgreSQL/Gateway checks; 37 model, 85 core (one skipped) and 13 UI tests; 112-key EN/ES/FR catalog validation; Support release web build; and Chromium E2E in English, Spanish and French. Each browser scenario opens the inherited task overview, creates an account, changes email/role and deactivates it, reactivates it and verifies real sign-in, deactivates again and verifies the new session is revoked, then checks persistence, search, account-bound audit history, filter clearing and logout.

The nine task definitions are centralized in `packages/contracts/admin-tasks.json`. Worker `AdminTask` inherits `BaseRoleTask`; the Dart task model inherits `BaseRoleTask`/`BaseEntity`; `AdminTasksScreen` inherits `BasePrimecareScreen`. The existing workspace read returns the task metadata, so the unique Admin API operation count stays four. Unknown task translations render a localized error; malformed or duplicate definitions preserve the last valid workspace. The task metadata never grants permission.

The first browser run passed English and Spanish but correctly hit the shared actor mutation rate limit during French. The disposable fixture now resets only its owned actor mutation counters between independent language scenarios. Production security policy is unchanged, and database/API rate-limit coverage remains in the suite. No loopback test bundle is deployed. The workflow is manual after verification.

See [Admin task register](admin-task-register-20261010.md) for every implemented task and class responsibility. Production deployment/E2E, newer Admin native verification, organization creation and elevated-role policy remain pending. No role is marked fully accepted.

## Verified account status filtering — 2026-10-11

[CI run 38098719953](https://github.com/shaikhrais/primecare-platform/actions/runs/38098719953) passed all stages: Worker type checks; 90 Auth regression plus 46 Admin PostgreSQL/Gateway checks; 37 model, 90 core (one skipped) and 17 UI tests; the 114-key EN/ES/FR catalog check; Support release web build; and complete Chromium flows in English, Spanish and French. Browser tests verify combined email/status filtering, empty Active results for the inactive edited account, its return under Inactive, refresh and independent filter clearing, alongside the existing task overview, account lifecycle, audit, session-revocation and logout checks.

`GET /v1/auth/admin/workspace` now accepts optional canonical `status=active` or `status=inactive`; empty/omitted means all. The central domain workflow validates the filter, and identical tenant/search/status predicates bind both count and page queries. Legacy stored non-active states project as inactive consistently. Database tests exercise real two-page active results (28 accounts, pages of 25 and 3, with no duplicate IDs), combined filters, invalid/duplicate query fields and cross-tenant isolation. The shared core preserves filters through refresh, pagination and mutation reloads and rejects mismatched filter echoes, rows or counts.

The inherited UI uses the shared EN/ES/FR catalog. A regression test caught stale selector text after an immediate API failure; completion revisions in `BaseAdminWorkflow` now restore the last successfully applied filter even when loading/error notifications happen before a rendered frame. This is shared presentation state; permissions remain on the server.

The task catalog still describes nine workflows and the API still has four unique Admin operations. Status filtering extends account discovery rather than adding another operation. This work changes 15 source/config/test/documentation files, including two new focused test files. Production rollout/E2E, native verification of the newer Admin code, organization creation and elevated-role policy remain pending. The verification workflow is manual after the passing run. The disposable test build is not deployed.

## Support production rollout and E2E — 2026-10-10 Toronto

Auth Worker and Support Pages were published in run 38099296450. [Final run 38099908370](https://github.com/shaikhrais/primecare-platform/actions/runs/38099908370) passed the complete reusable isolated gate and actual public EN/ES/FR Admin browser/policy verification. Each language used an independent owned tenant; all fixture accounts, sessions, audits and rate counters were removed. A refresh synchronization issue in the first live test was repaired in the single shared browser scenario, and the existing deployment was verified without republishing.

See [production verification report](admin-production-verification-20261010.md) for source/version provenance, exact coverage, the distinction between CI pagination and live fixtures, and cleanup evidence. Nine workflows and four unique Admin operations remain. Native Admin verification, organization/global administration/elevated-role policy and the other eight portal rollouts remain separate work. No broader role is marked fully accepted.
