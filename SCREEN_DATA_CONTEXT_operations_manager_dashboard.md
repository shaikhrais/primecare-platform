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
* **Stage/Status**: `template_created`

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
* **Test Name**: `OperationsManagerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OperationsManagerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/operations_manager/dashboard`)
3. **should_be_visible** (Selector: `operations_manager_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `operations_manager_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `operations_manager_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
