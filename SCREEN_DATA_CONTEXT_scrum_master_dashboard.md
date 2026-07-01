# SCREEN DATA CONTEXT: scrum_master_dashboard

Below are the database records from `governance.db` used to configure and build the **Scrum Master - ScrumMasterDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `57`
* **App ID**: `5`
* **Role ID**: `44`
* **Screen Code**: `scrum_master_dashboard`
* **Screen Name**: `ScrumMasterDashboardScreen`
* **Route Path**: `/management/scrum-master-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `44`
* **Role Code**: `scrum_master`
* **Role Name**: `Scrum Master`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Scrum Master personnel to oversee, audit, and coordinate operations related to scrummasterdashboardscreen.`
* **User Story**: `As a Scrum Master, I want to access the ScrumMasterDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScrumMasterDashboardScreen`
* **Acceptance Criteria**:
- The ScrumMasterDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Scrum Master access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scrum_master_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `scrum_master_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `scrum_master_dashboard-content` (Type: layout, Required: 1)
* **scrummasterdashboard_btn_2** -> `scrummasterdashboard-btn-2` (Type: button, Required: 0)
* **scrummasterdashboard_content** -> `scrummasterdashboard-content` (Type: layout, Required: 0)
* **scrummasterdashboard_btn_1** -> `scrummasterdashboard-btn-1` (Type: button, Required: 0)
* **scrummasterdashboard_btn_3** -> `scrummasterdashboard-btn-3` (Type: button, Required: 0)
* **scrummasterdashboard_title** -> `scrummasterdashboard-title` (Type: header, Required: 0)
* **scrummasterdashboard_screen** -> `scrummasterdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `65` (Required: 1)
* Component ID: `599` (Required: 1)
* Component ID: `1133` (Required: 1)
* Component ID: `2088` (Required: 1)
* Component ID: `2089` (Required: 1)
* Component ID: `2090` (Required: 1)
* Component ID: `2091` (Required: 1)
* Component ID: `2092` (Required: 1)
* Component ID: `2093` (Required: 1)
* Component ID: `2094` (Required: 1)
* Component ID: `2095` (Required: 1)
* Component ID: `2096` (Required: 1)
* Component ID: `2097` (Required: 1)

## 7. API / Data Mapping
* API ID: `4312` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scrum_master_dashboard_runtime`
* **Test Name**: `ScrumMasterDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scrum Master Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scrum_master`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scrum Master Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scrum Master Dashboard`)
5. **check_url** (Selector: `None`, Value: `/management/scrum-master-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
