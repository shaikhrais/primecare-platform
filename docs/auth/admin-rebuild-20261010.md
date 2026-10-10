# Fresh inherited Admin implementation

The executable legacy `AdminService`, its old tests, and the placeholder Dart `AdminDashboardScreenRoutes` were removed. The new Admin starts from shared parents and contracts. Billing Admin, IT Admin, and the existing CEO account-management API are distinct authorities and were not removed. Historical catalogs, screenshots, and archived role evidence are not executable implementations of this new role.

## Class hierarchy

| Layer | Inheritance or contract | Responsibility |
| --- | --- | --- |
| Dart model | `AdminUser extends BaseEntity<String>` | Secret-free account identity, email, role, status |
| Central backend business | `AdminWorkflow extends BaseTenantWorkflow` | Admin authority, allowed roles, protected accounts, input validation |
| PostgreSQL adapter | `AdminSqlRepository extends BaseTenantRepository implements AdminRepository` | Tenant-scoped SQL, password hashing, audit persistence |
| Shared Dart workflow | `BaseAdminWorkflow` | Transport-neutral loading, commands, pagination, errors |
| UI controller | `AdminController extends BaseAdminWorkflow` | Notify Flutter of state changes |
| UI screen | `AdminScreen extends BasePrimecareScreen` | Render the shared workflow, account editor, pagination |

Central backend business code is in `packages/domain/src/workflows/admin-workflow.ts`. SQL is in `cloudflare/workers/src/admin/admin-repository.ts`; HTTP routing and session verification remain in the deployed auth Worker host. Dart workflows are in `primecare_core`; presentation is in `primecare_ui`. TypeScript and Dart share serialized contracts and policy semantics rather than inheriting across languages.

## Contract

All requests require an explicit bearer session for an active `admin` user. The server derives the tenant from that user. A mismatched tenant header is forbidden; no request body can supply a tenant or grant global access.

| Method | Gateway path | Behavior |
| --- | --- | --- |
| GET | `/v1/auth/admin/workspace?offset=0` | Organization identity, exact account counts, 25-user page, assignable roles |
| POST | `/v1/auth/admin/workspace/users` | Create an active account with a hashed initial password and creation audit |
| PUT | `/v1/auth/admin/workspace/users/{id}` | Update email, role and status; revoke sessions and append audit atomically |

Assignable roles are explicitly limited to client, employee, PSW, RN, RPN, RMT, physiotherapist (`physio`), scheduler, customer support, and intake. Admin cannot create or edit privileged accounts, modify itself, or manage another tenant. Deactivation and every account update revoke target sessions. Duplicate email returns 409; invalid fields return 400; unauthorized access returns 401/403; out-of-tenant targets return 404. Audit failure rolls back account changes and session revocation.

After Admin signs in, **Open admin workspace** opens the inherited screen. It shows organization and counts, paginated accounts, protected-account labels, create/edit forms, loading, error, refresh, and empty-page states. New passwords are never exposed in account responses.

## Verification and remaining role scope

`verify-admin-rebuild.yml` runs Worker type checks, the existing real-PostgreSQL auth regression, new gateway/PostgreSQL Admin checks (including audit-failure rollback), shared package analysis/tests, Admin widget workflow tests, a Support web release build, and real browser E2E through Gateway/Worker/PostgreSQL. It uses a disposable PostgreSQL database, never production credentials.

This is the fresh tenant-account Admin implementation. Global tenant creation, unspecified elevated role assignment, audit browsing UI, deployment, and production browser E2E are separate remaining acceptance items before Admin can be marked role-complete. Existing authentication production verification does not cover these new Admin operations. No fake organization-creation action was added.

## Verified result — 2026-10-10

[Final CI run 38092892268](https://github.com/shaikhrais/primecare-platform/actions/runs/38092892268) passed. It verified Worker type checks, 90 existing auth/PostgreSQL regression checks, 20 new Admin gateway/PostgreSQL checks, shared model/core/UI analysis and tests (including both new Admin widget tests), a Support web release build, and Chromium browser E2E through the real Gateway, Worker, and disposable PostgreSQL database.

Browser E2E signed in as Admin, opened the inherited workspace, created a Client account, authenticated that new account through the API, edited its email and role, deactivated it, confirmed durable database state and session denial, refreshed the workspace, and signed out. All test accounts and their related tenant/session/audit records were cleaned up; the disposable database was destroyed by CI. These are isolated CI results, not production rollout evidence. The local-test web build uses a loopback HTTPS API and is never uploaded to production.

Three unique Admin API operations were implemented; 20 is the number of database/gateway checks, not the number of APIs. Legacy `deactivated` or other non-active stored states project to inactive in the new account model. The account editor owns its controllers through its widget lifecycle; account identity/status and edit controls have separate accessibility nodes. Browser dropdown tests use Flutter's field semantics and menu accessibility labels.

The workflow is manual after verification. Production websites and Workers have not been redeployed for this Admin rewrite, and Admin remains incomplete against the broader role acceptance gate until its remaining scope and production E2E are finished.
