# SCREEN DATA CONTEXT: corrective_actions

Below are the database records from `governance.db` used to configure and build the **Guest - CorrectiveActionsScreen** screen.

---

## 1. Screen Record
* **ID**: `724`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `corrective_actions`
* **Screen Name**: `CorrectiveActionsScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/corrective-actions`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/corrective_actions_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to corrective actions.`
* **User Story**: `As a Guest, I want to access the Corrective Actions within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Corrective Actions`
* **Acceptance Criteria**:
- The Corrective Actions route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `corrective_actions-screen` (Type: layout, Required: 1)
* **page_title** -> `corrective_actions-title` (Type: header, Required: 1)
* **primary_content** -> `corrective_actions-content` (Type: layout, Required: 1)
* **correctiveactionsscreen_screen** -> `correctiveactionsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6974` (Required: 1)
* Component ID: `6975` (Required: 1)
* Component ID: `6976` (Required: 1)
* Component ID: `6977` (Required: 1)
* Component ID: `6978` (Required: 1)
* Component ID: `6979` (Required: 1)

## 7. API / Data Mapping
* API ID: `5102` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `corrective_actions_runtime`
* **Test Name**: `Corrective Actions Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Corrective Actions`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Corrective Actions`)
4. **click_sidebar_link** (Selector: `None`, Value: `Corrective Actions`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/corrective-actions`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
