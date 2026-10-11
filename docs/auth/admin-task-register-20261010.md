# Admin task register — 2026-10-10

## Implemented tasks

The authenticated workspace returns the nine task definitions from `packages/contracts/admin-tasks.json`. The inherited Admin tasks screen renders their instructions from the shared EN/ES/FR catalog. This metadata describes implemented workflows and does not grant permission. Task counts are not endpoint counts: these tasks use four unique Admin API operations and local language selection.

| Task | How the system works | Operation |
| --- | --- | --- |
| Workspace summary | Read the server-authorized organization and total/active account counts. | GET workspace |
| User directory | Read tenant accounts in pages of 25; refresh and paginate. | GET workspace |
| Account search | Apply a normalized literal email substring; clear it to restore all tenant accounts. | GET workspace with search |
| Create account | Enter email, password and a permitted role; validate centrally, hash the password and commit the account with its audit record. | POST workspace/users |
| Update account | Edit email or permitted role; reject protected accounts/escalation, commit changes and revoke target sessions. | PUT workspace/users/{id} |
| Activate/deactivate | Set active/inactive; revoke sessions on changes. Inactive accounts cannot authenticate; reactivated accounts can sign in again. | PUT workspace/users/{id} |
| Audit history | Read tenant creation, update and session-revocation events with safe email/role/status fields. | GET workspace/audit |
| Account audit filter | Open an account’s history; validate tenant ownership and clear the filter to return to all history. | GET workspace/audit with userId |
| Language selection | Switch English, Spanish or French through the shared app controller without losing entered form data. Selection resets to English on a new launch. | Local application state |

Sign-in, sign-out, account recovery and other common authentication workflows remain in the shared Auth layer rather than being copied into Admin.

## Inheritance and centralized control

| Layer | Class hierarchy | Responsibility |
| --- | --- | --- |
| Worker task contract | AdminTask extends BaseRoleTask | Validate and serialize the central task definitions. |
| Shared Dart task model | AdminTask extends BaseRoleTask extends BaseEntity | Validate task metadata and expose it to the inherited UI. |
| Worker business rules | AdminWorkflow extends BaseTenantWorkflow | Authorize the active Admin actor, validate input, enforce role and tenant rules. |
| Persistence | AdminSqlRepository extends BaseTenantRepository | Bind tenant-scoped SQL; commit mutation, session revocation and audit atomically. |
| UI workflow | AdminController extends BaseAdminWorkflow | Maintain loading/error/search/filter state and call the shared API transport. |
| Screens | AdminScreen, AdminAuditScreen and AdminTasksScreen extend BasePrimecareScreen | Render shared models and use the common navigation/language controls. |
| Localization | AppStrings extends BaseTextCatalog; AppLanguageController extends BaseLanguageWorkflow | Use one editable catalog and one language controller across inherited app shells. |

TypeScript and Dart share serialized contracts; they do not inherit across runtime languages. Account permissions remain server-controlled. The request pipeline is authenticated session → server tenant and authorization → central validation → tenant repository → safe response model → inherited localized UI. Audit-write failure rolls back the account change. Audit reads use read-only repeatable-read snapshots. No password hash, credential or session token is exposed in audit responses.

The locale generator checks duplicate keys, matching EN/ES/FR keys and placeholders, valid task definitions, and the existence of every task title/instruction. New tasks should first implement central authorization/business behavior, then add contract metadata and all three translations, thin shared UI and focused API/model/browser verification. Per-app screen copies are unnecessary.

## Remaining acceptance work

Production Worker/Pages rollout and production Admin E2E are pending. Native-platform verification of this newer Admin code is pending; earlier Auth native results do not certify it. Organization creation/global administration and elevated-role assignment require an explicit policy and are not implemented by these nine tasks. The historical 64-role queue still has no role marked fully accepted; Admin remains first.

## Verified task overview and activation lifecycle — 2026-10-11

[CI run 38097091443](https://github.com/shaikhrais/primecare-platform/actions/runs/38097091443) passed all steps: Worker type checks; 90 Auth regression and 39 Admin PostgreSQL/Gateway checks; 37 model, 85 core (one skipped) and 13 UI tests; 112-key EN/ES/FR catalog validation; Support release web build; and Chromium E2E in English, Spanish and French. Each browser scenario opens the inherited task overview, creates an account, changes email/role and deactivates it, reactivates it and verifies real sign-in, deactivates again and verifies the new session is revoked, then checks persistence, search, account-bound audit history, filter clearing and logout.

