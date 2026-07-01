# SCREEN DATA CONTEXT: operations_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Operations Manager - OperationsManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `210`
* **App ID**: `1`
* **Role ID**: `40`
* **Screen Code**: `operations_manager_analytics`
* **Screen Name**: `OperationsManagerAnalyticsScreen`
* **Route Path**: `/management/operations-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/operations_manager_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to operationsmanageranalyticsscreen.`
* **User Story**: `As a Operations Manager, I want to access the OperationsManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OperationsManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The OperationsManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_analytics-content` (Type: layout, Required: 1)
* **operationsmanageranalytics_btn_2** -> `operationsmanageranalytics-btn-2` (Type: button, Required: 0)
* **operationsmanageranalytics_title** -> `operationsmanageranalytics-title` (Type: header, Required: 0)
* **operationsmanageranalytics_screen** -> `operationsmanageranalytics-screen` (Type: layout, Required: 0)
* **operationsmanageranalytics_btn_1** -> `operationsmanageranalytics-btn-1` (Type: button, Required: 0)
* **operationsmanageranalytics_content** -> `operationsmanageranalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `218` (Required: 1)
* Component ID: `752` (Required: 1)
* Component ID: `1286` (Required: 1)
* Component ID: `3451` (Required: 1)
* Component ID: `3452` (Required: 1)
* Component ID: `3453` (Required: 1)
* Component ID: `3454` (Required: 1)
* Component ID: `3455` (Required: 1)
* Component ID: `3456` (Required: 1)
* Component ID: `3457` (Required: 1)
* Component ID: `3458` (Required: 1)
* Component ID: `3459` (Required: 1)
* Component ID: `3460` (Required: 1)

## 7. API / Data Mapping
* API ID: `4499` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_analytics_runtime`
* **Test Name**: `OperationsManagerAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Manager Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Manager Analytics`)
5. **check_url** (Selector: `None`, Value: `/management/operations-manager-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
