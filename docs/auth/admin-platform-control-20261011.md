# Platform Admin control

## Authority and inheritance

The requested policy gives an active database-backed `admin` session control across platform tenants in `/admin/control/*`. Existing `/admin/workspace/*` operations remain scoped to the actor's home tenant. A client header never grants authority. Operational account roles retain the existing ten-role allowlist; Admin cannot provision another privileged Admin through these commands.

| Layer | Inheritance | Responsibility |
|---|---|---|
| API business rules | PlatformAdminWorkflow → BaseTenantWorkflow | Authorization, input validation and commands |
| Database | PlatformSqlRepository → BaseTenantRepository | Queries and transactional provisioning history |
| Shared client business state | BasePlatformAdminWorkflow → BaseAdminWorkflow | Busy/error lifecycle, scope selection, pagination and commands |
| UI | PlatformAdminScreen → BasePrimecareScreen → BasePrimecareLayout | Presentation, shared translations and responsive policy |
| Data | AdminTenant, AdminMasterRecord, AdminControlEvent, AdminPlatformSnapshot → BaseEntity | Typed business projections |

The API and UI share business contracts and concepts across TypeScript and Dart. They do not literally inherit one class across two languages.

## Tasks and behavior

| Task | System behavior |
|---|---|
| Create tenant | Validate name/unique slug; create tenant and audit event in one transaction |
| Select tenant | Load that tenant's accounts and references; clear old rows before switching |
| Create account | Validate selected tenant, email, password and permitted role; hash password and record history atomically |
| Account administration | Selected-tenant control supports email/role/status updates with session revocation; the existing home-tenant workspace also supports search and status filters |
| Maintain references | Create records or edit EN/ES/FR labels and active status; category/code/scope remain immutable |
| Global references | Global scope is explicit and separate from tenant scope; code uniqueness applies within category/scope |
| Monitor | Read timestamped counts of tenants, accounts, active sessions and references |
| Review history | Read paginated provisioning actions without credentials or secret snapshots |
| Change language | Shared EN/ES/FR catalog; all 176 keys and placeholders match |

There are 12 task definitions, four existing Admin API operations and ten platform-control operations. The central reference registry exposes 16 categories: services, locations, regions, departments, staff groups, insurance providers, training categories, document types, specialties, credentials, referral sources, incident types, payment methods, cancellation reasons, contact types and equipment types.

These are reference definitions. They do not yet integrate the existing rich Service, Region, StaffGroup, InsuranceProvider or TrainingModule tables. Service prices, claims, training assignments and clinical workflows retain their existing business logic. Monitoring is an administrative database snapshot; Worker uptime, latency and alerting are not implemented here.

## Shared layout

| Logical width | Layout |
|---|---|
| Under 600 | Mobile, 12px padding, stacked details/actions |
| 600–1023 | Tablet, 20px padding |
| 1024–1919 | Desktop, 24px padding, content capped at 1200px |
| 1920–2559 | Wide display, 32px padding, content capped at 1440px |
| 2560 and above | Ultra-wide/4K, 32px padding, content capped at 1600px, 1.2 font factor |

A 75-inch screen follows its logical resolution and operating-system scaling; physical inches are not observable by the application. Accessibility text scaling remains enabled. Auth and Admin use the same base layout. Platform sections prevent long tenant lists from hiding unrelated tools; dialogs scroll and action buttons wrap.

## Validation and rollout

CI run [38107169545](https://github.com/shaikhrais/primecare-platform/actions/runs/38107169545) passed against source `e291c93bae94a9321f399144b54b96325fff978f`: Worker type checks; 90 Auth, 46 original Admin, 39 platform domain and 48 platform Gateway/PostgreSQL checks; 42 model, 97 core and 78 UI tests (217 passed, one pre-existing core test skipped); release Support web build; original and platform browser workflows in EN/ES/FR. The browser tests include selected-tenant email/role/status edits and session revocation. Database checks verify wrong-tenant rejection, protected accounts, and rollback of account changes/session deletion on audit failure. Layout tests cover 320–3840 logical pixels and double-size mobile text; translated account-editor drafts survive resizing to 4K. These are isolated tests, not production verification. All 176 localization keys match across the three languages.

Production requires migrations `20261011_admin_control.sql` and `20261011_admin_account_updates.sql`, in that order, before the new API/UI rollout. This migration creates a reference registry and provisioning history, and accepts the existing text or UUID tenant identity type. New functionality is not yet deployed or certified on native platforms. Previous Auth/Admin verification does not prove this new scope.

## Complete task catalog

| Task | Behavior |
|---|---|
| View organization and counts | Open the Admin workspace to see your organization and its account counts. |
| Browse accounts | Review accounts in pages of 25. Refresh the page to load current records. |
| Find an account | Search accounts by email and optionally filter active or inactive accounts. Clear search or choose All statuses to remove the corresponding filter. |
| Create an account | Choose Create user, enter an email and initial password, and select a permitted role. The account is saved with a creation audit event. |
| Update email or role | Choose Edit on an account and save its email or permitted role. Your own account and privileged accounts are protected. Saving revokes the account’s existing sessions. |
| Activate or deactivate an account | Edit the account status and save. An inactive account cannot sign in, and existing sessions are revoked. |
| Review account history | Open Audit history to review creation, update and session-revocation events in your organization. Credentials are excluded. |
| Review one account’s history | Use the history button beside an account to filter its audit events. Choose Show all account history to clear the filter. |
| Choose English, Spanish or French | Use the language button in the page header. Labels change while entered form data is preserved. The language resets to English on a fresh launch. |
| Create tenants | Create organizations and select one for account provisioning. |
| Manage master records | Maintain global or tenant reference definitions with EN, ES and FR labels. |
| Monitor platform | Review tenant, account, session and reference counts and provisioning history. |

Latest batch inventory: 12 code files added or changed; 21,392 tracked code files untouched by this batch. This is a batch inventory, not a claim about the remaining migration backlog.

## Selected-tenant account updates

`PUT /admin/control/accounts/{id}` accepts exactly `tenantId`, `email`, `role`, and `status`. An active database-backed platform Admin is required. The tenant is selected explicitly; the account must already belong to it. Tenant identity and passwords cannot be changed through this command. Self and privileged accounts remain protected.

`PlatformSqlRepository.updateAccount` reuses `AdminSqlRepository.update`, which locks the account, applies existing validation/protection, revokes sessions and writes account history. Platform history is added in the same transaction. Any audit failure rolls back the account change and session deletion. The inherited client workflow owns busy/error state and refreshes the selected tenant after completion. The shared editor supports EN/ES/FR and keeps drafts during mobile/4K resizing.
