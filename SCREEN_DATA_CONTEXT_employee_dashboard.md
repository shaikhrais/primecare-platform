# SCREEN DATA CONTEXT: employee_dashboard

Below are the database records from `governance.db` used to configure and build the **Employee - EmployeeDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `66`
* **App ID**: `5`
* **Role ID**: `57`
* **Screen Code**: `employee_dashboard`
* **Screen Name**: `EmployeeDashboardScreen`
* **Route Path**: `/staff/employee-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `57`
* **Role Code**: `employee`
* **Role Name**: `Employee`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Employee personnel to oversee, audit, and coordinate operations related to employeedashboardscreen.`
* **User Story**: `As a Employee, I want to access the EmployeeDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `EmployeeDashboardScreen`
* **Acceptance Criteria**:
- The EmployeeDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Employee access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `employee_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `employee_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `employee_dashboard-content` (Type: layout, Required: 1)
* **employeedashboard_content** -> `employeedashboard-content` (Type: layout, Required: 0)
* **employeedashboard_btn_2** -> `employeedashboard-btn-2` (Type: button, Required: 0)
* **employeedashboard_btn_1** -> `employeedashboard-btn-1` (Type: button, Required: 0)
* **employeedashboard_loading** -> `employeedashboard-loading` (Type: loading, Required: 0)
* **employeedashboard_btn_3** -> `employeedashboard-btn-3` (Type: button, Required: 0)
* **employeedashboard_screen** -> `employeedashboard-screen` (Type: layout, Required: 0)
* **employeedashboard_title** -> `employeedashboard-title` (Type: header, Required: 0)
* **employeedashboard_btn_4** -> `employeedashboard-btn-4` (Type: button, Required: 0)
* **employeedashboard_btn_5** -> `employeedashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `74` (Required: 1)
* Component ID: `608` (Required: 1)
* Component ID: `1142` (Required: 1)
* Component ID: `2170` (Required: 1)
* Component ID: `2171` (Required: 1)
* Component ID: `2172` (Required: 1)
* Component ID: `2173` (Required: 1)

## 7. API / Data Mapping
* API ID: `4327` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `employee_dashboard_runtime`
* **Test Name**: `EmployeeDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `EmployeeDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `employee`)
2. **visit** (Selector: `None`, Value: `/staff/employee-dashboard`)
3. **should_be_visible** (Selector: `employee_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `employee_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `employee_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
