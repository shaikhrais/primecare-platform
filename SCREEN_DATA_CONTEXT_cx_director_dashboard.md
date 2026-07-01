# SCREEN DATA CONTEXT: cx_director_dashboard

Below are the database records from `governance.db` used to configure and build the **CX Director - CxDirectorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `37`
* **App ID**: `5`
* **Role ID**: `25`
* **Screen Code**: `cx_director_dashboard`
* **Screen Name**: `CxDirectorDashboardScreen`
* **Route Path**: `/offices/corporate/roles/cx_director/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cx_director_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `25`
* **Role Code**: `cx_director`
* **Role Name**: `CX Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable CX Director personnel to oversee, audit, and coordinate operations related to cxdirectordashboardscreen.`
* **User Story**: `As a CX Director, I want to access the CxDirectorDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CxDirectorDashboardScreen`
* **Acceptance Criteria**:
- The CxDirectorDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only CX Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cx_director_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `cx_director_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `cx_director_dashboard-content` (Type: layout, Required: 1)
* **cxdirectordashboard_btn_2** -> `cxdirectordashboard-btn-2` (Type: button, Required: 0)
* **cxdirectordashboard_btn_3** -> `cxdirectordashboard-btn-3` (Type: button, Required: 0)
* **cxdirectordashboard_content** -> `cxdirectordashboard-content` (Type: layout, Required: 0)
* **cxdirectordashboard_btn_1** -> `cxdirectordashboard-btn-1` (Type: button, Required: 0)
* **cxdirectordashboard_btn_4** -> `cxdirectordashboard-btn-4` (Type: button, Required: 0)
* **cxdirectordashboard_title** -> `cxdirectordashboard-title` (Type: header, Required: 0)
* **cxdirectordashboard_screen** -> `cxdirectordashboard-screen` (Type: layout, Required: 0)
* **cxdirectordashboard_btn_5** -> `cxdirectordashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `45` (Required: 1)
* Component ID: `579` (Required: 1)
* Component ID: `1113` (Required: 1)
* Component ID: `1904` (Required: 1)
* Component ID: `1905` (Required: 1)
* Component ID: `1906` (Required: 1)
* Component ID: `1907` (Required: 1)
* Component ID: `1908` (Required: 1)
* Component ID: `1909` (Required: 1)
* Component ID: `1910` (Required: 1)
* Component ID: `1911` (Required: 1)
* Component ID: `1912` (Required: 1)
* Component ID: `1913` (Required: 1)

## 7. API / Data Mapping
* API ID: `4292` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cx_director_dashboard_runtime`
* **Test Name**: `CxDirectorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CX Director Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cx_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CX Director Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `CX Director Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cx_director/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
