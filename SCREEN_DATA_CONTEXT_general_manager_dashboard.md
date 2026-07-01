# SCREEN DATA CONTEXT: general_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **General Manager - GeneralManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `47`
* **App ID**: `5`
* **Role ID**: `35`
* **Screen Code**: `general_manager_dashboard`
* **Screen Name**: `GeneralManagerDashboardScreen`
* **Route Path**: `/offices/business_development/roles/general_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/general_manager_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `35`
* **Role Code**: `gm`
* **Role Name**: `General Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanagerdashboardscreen.`
* **User Story**: `As a General Manager, I want to access the GeneralManagerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GeneralManagerDashboardScreen`
* **Acceptance Criteria**:
- The GeneralManagerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only General Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `general_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `general_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `general_manager_dashboard-content` (Type: layout, Required: 1)
* **generalmanagerdashboard_btn_4** -> `generalmanagerdashboard-btn-4` (Type: button, Required: 0)
* **generalmanagerdashboard_screen** -> `generalmanagerdashboard-screen` (Type: layout, Required: 0)
* **generalmanagerdashboard_btn_3** -> `generalmanagerdashboard-btn-3` (Type: button, Required: 0)
* **generalmanagerdashboard_btn_2** -> `generalmanagerdashboard-btn-2` (Type: button, Required: 0)
* **generalmanagerdashboard_btn_5** -> `generalmanagerdashboard-btn-5` (Type: button, Required: 0)
* **generalmanagerdashboard_content** -> `generalmanagerdashboard-content` (Type: layout, Required: 0)
* **generalmanagerdashboard_btn_1** -> `generalmanagerdashboard-btn-1` (Type: button, Required: 0)
* **generalmanagerdashboard_title** -> `generalmanagerdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `55` (Required: 1)
* Component ID: `589` (Required: 1)
* Component ID: `1123` (Required: 1)
* Component ID: `1995` (Required: 1)
* Component ID: `1996` (Required: 1)
* Component ID: `1997` (Required: 1)
* Component ID: `1998` (Required: 1)
* Component ID: `1999` (Required: 1)
* Component ID: `2000` (Required: 1)
* Component ID: `2001` (Required: 1)
* Component ID: `2002` (Required: 1)
* Component ID: `2003` (Required: 1)
* Component ID: `2004` (Required: 1)

## 7. API / Data Mapping
* API ID: `4302` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `general_manager_dashboard_runtime`
* **Test Name**: `GeneralManagerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `General Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `gm`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `General Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `General Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/general_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
