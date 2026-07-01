# SCREEN DATA CONTEXT: employee_analytics

Below are the database records from `governance.db` used to configure and build the **Employee - EmployeeAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `617`
* **App ID**: `1`
* **Role ID**: `57`
* **Screen Code**: `employee_analytics`
* **Screen Name**: `EmployeeAnalyticsScreen`
* **Route Path**: `/staff/employee-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/employee_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `57`
* **Role Code**: `employee`
* **Role Name**: `Employee`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Employee personnel to oversee, audit, and coordinate operations related to employee analytics.`
* **User Story**: `As a Employee, I want to access the Employee Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Employee Analytics`
* **Acceptance Criteria**:
- The Employee Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Employee access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `employee_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `employee_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `employee_analytics-content` (Type: layout, Required: 1)
* **employee analytics_btn_2** -> `employee analytics-btn-2` (Type: button, Required: 0)
* **employee analytics_btn_1** -> `employee analytics-btn-1` (Type: button, Required: 0)
* **employee analytics_btn_3** -> `employee analytics-btn-3` (Type: button, Required: 0)
* **employee analytics_content** -> `employee analytics-content` (Type: layout, Required: 0)
* **employee analytics_title** -> `employee analytics-title` (Type: header, Required: 0)
* **employee analytics_loading** -> `employee analytics-loading` (Type: loading, Required: 0)
* **employee analytics_screen** -> `employee analytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `541` (Required: 1)
* Component ID: `1075` (Required: 1)
* Component ID: `1609` (Required: 1)
* Component ID: `6391` (Required: 1)
* Component ID: `6392` (Required: 1)
* Component ID: `6393` (Required: 1)
* Component ID: `6394` (Required: 1)
* Component ID: `6395` (Required: 1)
* Component ID: `6396` (Required: 1)
* Component ID: `6397` (Required: 1)
* Component ID: `6398` (Required: 1)

## 7. API / Data Mapping
* API ID: `4970` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `employee_analytics_runtime`
* **Test Name**: `Employee Analytics Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Employee Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `employee`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Employee Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Employee Analytics`)
5. **check_url** (Selector: `None`, Value: `/staff/employee-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
