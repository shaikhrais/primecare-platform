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

Local checks: Worker Auth bundle succeeds; 36 domain checks pass; 175 localization keys match. Added five core workflow tests, 18 EN/ES/FR layout cases at 320/600/1024/1920/3840, three UI provisioning cases, five model checks, and Gateway/PostgreSQL provisioning checks to the isolated verification workflow. CI results must be reviewed before reporting them as passed.

Production requires migration `20261011_admin_control.sql` before the new API/UI rollout. This migration creates a reference registry and provisioning history, and accepts the existing text or UUID tenant identity type. New functionality is not yet deployed or certified on native platforms. Previous Auth/Admin verification does not prove this new scope.
