# SCREEN DATA CONTEXT: operations_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Operations Manager - OperationsManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `52`
* **App ID**: `5`
* **Role ID**: `40`
* **Screen Code**: `operations_manager_dashboard`
* **Screen Name**: `OperationsManagerDashboardScreen`
* **Route Path**: `/offices/franchise/roles/operations_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/operations_manager_dashboard.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to operationsmanagerdashboardscreen.`
* **User Story**: `As a Operations Manager, I want to access the OperationsManagerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OperationsManagerDashboardScreen`
* **Acceptance Criteria**:
- The OperationsManagerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `60` (Required: 1)
* Component ID: `594` (Required: 1)
* Component ID: `1128` (Required: 1)
* Component ID: `2043` (Required: 1)
* Component ID: `2044` (Required: 1)
* Component ID: `2045` (Required: 1)
* Component ID: `2046` (Required: 1)
* Component ID: `2047` (Required: 1)
* Component ID: `2048` (Required: 1)
* Component ID: `2049` (Required: 1)
* Component ID: `2050` (Required: 1)
* Component ID: `2051` (Required: 1)
* Component ID: `2052` (Required: 1)

## 7. API / Data Mapping
* API ID: `4307` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_dashboard_runtime`
* **Test Name**: `OperationsManagerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/operations_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
