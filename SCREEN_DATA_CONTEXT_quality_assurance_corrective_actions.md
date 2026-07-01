# SCREEN DATA CONTEXT: quality_assurance_corrective_actions

Below are the database records from `governance.db` used to configure and build the **Guest - QualityAssuranceCorrectiveActionsScreen** screen.

---

## 1. Screen Record
* **ID**: `883`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `quality_assurance_corrective_actions`
* **Screen Name**: `QualityAssuranceCorrectiveActionsScreen`
* **Route Path**: `/generated/quality-assurance-corrective-actions`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/quality_assurance_corrective_actions_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to quality assurance corrective actions.`
* **User Story**: `As a Guest, I want to access the Quality Assurance Corrective Actions within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Quality Assurance Corrective Actions`
* **Acceptance Criteria**:
- The Quality Assurance Corrective Actions route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `quality_assurance_corrective_actions-screen` (Type: layout, Required: 1)
* **page_title** -> `quality_assurance_corrective_actions-title` (Type: header, Required: 1)
* **primary_content** -> `quality_assurance_corrective_actions-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7861` (Required: 1)
* Component ID: `7862` (Required: 1)
* Component ID: `7863` (Required: 1)
* Component ID: `7864` (Required: 1)
* Component ID: `7865` (Required: 1)

## 7. API / Data Mapping
* API ID: `5297` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `quality_assurance_corrective_actions_runtime`
* **Test Name**: `Quality Assurance Corrective Actions Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Quality Assurance Corrective Actions`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Quality Assurance Corrective Actions`)
4. **click_sidebar_link** (Selector: `None`, Value: `Quality Assurance Corrective Actions`)
5. **check_url** (Selector: `None`, Value: `/generated/quality-assurance-corrective-actions`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
