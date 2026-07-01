# SCREEN DATA CONTEXT: operations_manager_issues

Below are the database records from `governance.db` used to configure and build the **Guest - OperationsManagerIssuesScreen** screen.

---

## 1. Screen Record
* **ID**: `803`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `operations_manager_issues`
* **Screen Name**: `OperationsManagerIssuesScreen`
* **Route Path**: `/offices/franchise/roles/operations_manager/issues`
* **Actual File Path**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_issues_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to operations manager issues.`
* **User Story**: `As a Guest, I want to access the Operations Manager Issues within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Operations Manager Issues`
* **Acceptance Criteria**:
- The Operations Manager Issues route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_issues-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_issues-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_issues-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7398` (Required: 1)
* Component ID: `7399` (Required: 1)
* Component ID: `7400` (Required: 1)
* Component ID: `7401` (Required: 1)
* Component ID: `7402` (Required: 1)

## 7. API / Data Mapping
* API ID: `5191` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_issues_runtime`
* **Test Name**: `Operations Manager Issues Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Issues`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Manager Issues`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Manager Issues`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/operations_manager/issues`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
