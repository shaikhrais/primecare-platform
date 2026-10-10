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

Three unique Admin API operations were implemented; 20 is the number of database/gateway checks, not the number of APIs. Legacy `deactivated` or other non-active stored states project to inactive in the new account model. The account editor owns its controllers through its widget lifecycle; account identity/status and edit controls have separate accessibility nodes. Browser dropdown tests use Flutter's field semantics and menu accessibility labels.

The workflow is manual after verification. Production websites and Workers have not been redeployed for this Admin rewrite, and Admin remains incomplete against the broader role acceptance gate until its remaining scope and production E2E are finished.

## Central EN/ES/FR control and audit extension

`packages/contracts/locales/admin.json` is the single editable catalog. `scripts/generate-app-localizations.py` checks duplicate keys, nonempty values, exact EN/ES/FR key parity, and placeholder parity, and generates the Dart catalog. All nine inherited application shells install the same language controller, supported locales, and Flutter material/widget/Cupertino delegates. The Auth, Admin workspace, editor, and audit screens share the selector. Selection lives in app memory and resets to English on a fresh launch; it is not persisted in storage.

Language selection changes labels and messages, including displayed roles/status and audit dates. Canonical API roles, account status codes, tenant identity, and authorization remain unchanged. Form controllers and authenticated state are preserved when the shared app locale changes. Admin business rules remain in the TypeScript domain workflow; Dart UI/controllers inherit transport-neutral account/audit commands and presentation state. This does not claim cross-language runtime inheritance.

Audit history combines existing account-creation and account-management audit tables inside a tenant-scoped read-only repeatable-read transaction. Pagination sorts by timestamp then namespaced audit ID. Only email/role/status are projected from audit JSON; credentials, password hashes, session tokens and unrelated JSON fields are excluded. The new entity validates allowed actions, dates, and safe immutable state maps. The screen translates event labels and role/status descriptions while preserving recorded identity values.

The expanded verification includes 26 Admin database/Gateway checks, 90 existing Auth regression checks, shared model/core/UI tests, catalog parity checks, a release web build, and actual browser create/update/deactivate/audit/logout flows in all three languages. Production deployment and production Admin E2E remain separate acceptance work. Global tenant creation and any elevated-role policy remain outside this bounded tenant-account implementation.
