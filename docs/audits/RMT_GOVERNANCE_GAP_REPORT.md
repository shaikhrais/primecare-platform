# PrimeCare RMT Governance Gap Report

Date: 2026-09-28

Scope: `primecare-clinic` / `clinical` / `Registered Massage Therapist (RMT)`

Source of truth: `.agents/governance/governance.db`

## Decision

Implementation is blocked by contradictory and incomplete governance records. No governance data was changed during this audit.

Approved by the product owner on 2026-09-28:

- RMT Clinic scope is limited to the nine screens owned by `apps.id=6`.
- RMT authorization must use least privilege rather than the existing all-actions defaults.
- TypeScript web on Cloudflare Pages is the production frontend for this phase.

Still blocked: governance does not define the business meaning of the 29 placeholder buttons, service/database ownership for the 27 mocked endpoints, or the tenant and organization claim contract. These cannot be inferred safely for a healthcare application.

## Governed Clinic Inventory

The Clinic application (`apps.id = 6`) assigns nine active screens to the RMT role.

| Screen | Governed route | Sections | Elements | Planned buttons | Mocked endpoints | Current verification conflict |
|---|---|---:|---:|---:|---:|---|
| Dashboard | `/offices/clinical/roles/rmt/dashboard` | 5 | 11 | 5 | 3 | `test_passed`, but Cypress is not verified |
| Command Center | `/offices/clinical/roles/rmt/command-center` | 4 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Appointments | `/offices/clinical/roles/rmt/appointments` | 5 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Client Intake | `/offices/clinical/roles/rmt/client-intake` | 4 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Assessment | `/offices/clinical/roles/rmt/assessment` | 4 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Treatment Notes | `/offices/clinical/roles/rmt/treatment-notes` | 5 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Exercise Plan | `/offices/clinical/roles/rmt/exercise-plan` | 4 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Billing Link | `/offices/clinical/roles/rmt/billing-link` | 4 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |
| Reports | `/offices/clinical/roles/rmt/reports` | 5 | 10 | 3 | 3 | `test_passed`, but Cypress is not verified |

Totals: 40 sections, 91 elements, 29 planned buttons, and 27 mocked endpoint mappings.

## Blocking Governance Conflicts

1. **App ownership conflict**
   - RMT has three active workflows with the same workflow code across Clinic (`app_id=6`), UI (`app_id=1`), and Client (`app_id=5`).
   - The Clinic workflow contains only five steps and omits four Clinic screens: Treatment Notes, Exercise Plan, Billing Link, and Reports.
   - The Client workflow contains Massage Assessment, Home Care Plan, and Client Progress using RMT routes. Governance does not state whether these belong in the Clinic sidebar.

2. **Sidebar is not release-ready**
   - All 15 RMT sidebar records use `route_tag=placeholder` and `test_tag=no_test`.
   - Every record uses display order `1`, so ordering is undefined.
   - Most labels are internal class names rather than user-facing localized labels.
   - Sidebar permission keys do not have corresponding entries in `role_permission_matrix`.

3. **Permission model is overbroad and contradictory**
   - All nine Clinic screens grant view/create/edit/delete/export.
   - All 13 generic features grant every action, including nonsensical combinations such as delete/export on notification or profile capabilities.
   - API endpoint records require only `authenticated`, not the RMT role, tenant, organization, or resource ownership.
   - No role permission matrix records exist for RMT.

4. **Implementation status is inaccurate**
   - Screens claim `implemented`, `api_connected`, `test_passed`, and often `production_ready=1`.
   - All 29 governed button actions are `planned`.
   - All 27 required endpoint mappings are `mocked`.
   - `cypress_verified=0` on all 15 RMT screens.
   - 82 of 91 Clinic elements are not tagged implemented; all 91 lack resolved API and passing-test tags.

5. **API mapping is incomplete**
   - Workflow steps have no API IDs and use the generic expected result `Success`.
   - Endpoint paths such as `/v1/rmt-appointments` do not map to a deployed gateway service prefix.
   - Registry service and test paths are Windows-local paths and do not identify deployable repository artifacts.
   - Only the dashboard has `screen_api_links`, and those references do not resolve to matching `api_registry` records.

6. **Authentication is not connected to portal authorization**
   - The Auth page can submit credentials and store a token.
   - It does not call `/me`, validate role/tenant claims, redirect to the authorized portal, or establish an authenticated portal state.
   - Clinic is directly accessible without authentication.
   - Clinic exposes a public role selector, allowing the visitor to simulate another role.
   - Domain API routes do not enforce a session before reading or writing data.
   - Database queries are not tenant-scoped.

7. **Test evidence is insufficient**
   - Existing RMT test definitions prove only that a screen mounts and contains three generic elements.
   - They do not test login, role resolution, forbidden access, tenant isolation, workflows, persistence, accessibility, logout, expiry, or AI safety.
   - The recorded test-user login verification is historical and is not evidence of the current production deployment.

8. **Secrets governance issue**
   - A plaintext test password exists in the role data model even though a secret reference also exists.
   - Test credentials must be removed from governance records and resolved only through an approved secret mechanism.

## Required Governance Decisions

Before implementation, resolve these points:

1. **Approved:** limit the Clinic sidebar to the nine `app_id=6` screens.
2. Define the intended order and user-facing group/label for the nine Clinic screens.
3. **Direction approved:** use least privilege. Exact permissions must still be mapped per screen and action.
4. Define the real business action for each of the 29 placeholder buttons, including validation, endpoint, permission, success result, audit event, and failure behavior.
5. Define the service ownership and PostgreSQL tables for the 27 mocked endpoints.
6. Define authenticated claims: user ID, RMT role, tenant ID, organization/clinic ID, permissions, expiry, and token/cookie strategy.
7. **Approved:** TypeScript web is the production frontend for this phase; Flutter artifacts remain historical until separately governed.
8. Define approved knowledge sources and safety policy before enabling the AI role assistant.

## Proposed Safe Implementation Order

1. Approve the eight governance decisions above.
2. Add a reviewed governance migration and validation checks.
3. Implement authenticated `/login`, `/me`, `/logout`, session expiry, role and tenant guards.
4. Remove the public role selector and derive role context from `/me`.
5. Generate the nine-screen sidebar from approved records.
6. Implement one vertical business workflow with real persistence and read-back.
7. Add unit and contract tests, then critical browser tests.
8. Update tags only after evidence passes.
9. Deploy APIs, gateway, and websites in that order.
