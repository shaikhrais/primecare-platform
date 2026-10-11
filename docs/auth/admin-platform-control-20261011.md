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
| Existing account administration | Existing tenant workspace supports search, status filters, creation and updates with session revocation |
| Maintain references | Create records or edit EN/ES/FR labels and active status; category/code/scope remain immutable |
| Global references | Global scope is explicit and separate from tenant scope; code uniqueness applies within category/scope |
| Monitor | Read timestamped counts of tenants, accounts, active sessions and references |
| Review history | Read paginated provisioning actions without credentials or secret snapshots |
| Change language | Shared EN/ES/FR catalog; all 175 keys and placeholders match |

There are 12 task definitions, four existing Admin API operations and nine new platform-control operations. The central reference registry exposes 16 categories: services, locations, regions, departments, staff groups, insurance providers, training categories, document types, specialties, credentials, referral sources, incident types, payment methods, cancellation reasons, contact types and equipment types.

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

Local checks: Worker Auth bundle succeeds; 36 domain checks pass; 175 localization keys match. Added five core workflow tests, 18 EN/ES/FR layout cases at 320/600/1024/1920/3840, three UI provisioning cases, five model checks, and Gateway/PostgreSQL provisioning checks to the isolated verification workflow. CI run [38104776020](https://github.com/shaikhrais/primecare-platform/actions/runs/38104776020) passed against source `042669ba173db3fac5e28f10f9e3edac46a6502e`: Worker type checks; 90 Auth, 46 existing Admin, 36 new domain and 40 new Gateway/PostgreSQL checks; 42 model, 95 core and 75 UI tests (212 passed, one pre-existing core test skipped); release Support web build; existing and new browser workflows in EN/ES/FR. These are isolated tests, not production verification.

Production requires migration `20261011_admin_control.sql` before the new API/UI rollout. This migration creates a reference registry and provisioning history, and accepts the existing text or UUID tenant identity type. New functionality is not yet deployed or certified on native platforms. Previous Auth/Admin verification does not prove this new scope.

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

Batch inventory: 25 code files added or changed; 21,378 tracked code files untouched by this batch. This is a batch inventory, not a claim about the remaining migration backlog.
