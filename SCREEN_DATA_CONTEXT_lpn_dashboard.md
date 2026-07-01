# SCREEN DATA CONTEXT: lpn_dashboard

Below are the database records from `governance.db` used to configure and build the **Licensed Practical Nurse (LPN) - LpnDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `6`
* **App ID**: `6`
* **Role ID**: `56`
* **Screen Code**: `lpn_dashboard`
* **Screen Name**: `LpnDashboardScreen`
* **Route Path**: `/clinical/lpn-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/lpn_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `56`
* **Role Code**: `lpn`
* **Role Name**: `Licensed Practical Nurse (LPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Licensed Practical Nurse (LPN) personnel to oversee, audit, and coordinate operations related to lpndashboardscreen.`
* **User Story**: `As a Licensed Practical Nurse (LPN), I want to access the LpnDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LpnDashboardScreen`
* **Acceptance Criteria**:
- The LpnDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Licensed Practical Nurse (LPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lpn_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `lpn_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `lpn_dashboard-content` (Type: layout, Required: 1)
* **lpndashboard_btn_1** -> `lpndashboard-btn-1` (Type: button, Required: 0)
* **lpndashboard_btn_3** -> `lpndashboard-btn-3` (Type: button, Required: 0)
* **lpndashboard_loading** -> `lpndashboard-loading` (Type: loading, Required: 0)
* **lpndashboard_btn_2** -> `lpndashboard-btn-2` (Type: button, Required: 0)
* **lpndashboard_screen** -> `lpndashboard-screen` (Type: layout, Required: 0)
* **lpndashboard_title** -> `lpndashboard-title` (Type: header, Required: 0)
* **lpndashboard_content** -> `lpndashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `14` (Required: 1)
* Component ID: `548` (Required: 1)
* Component ID: `1082` (Required: 1)
* Component ID: `1647` (Required: 1)
* Component ID: `1648` (Required: 1)
* Component ID: `1649` (Required: 1)
* Component ID: `1650` (Required: 1)
* Component ID: `1651` (Required: 1)
* Component ID: `1652` (Required: 1)
* Component ID: `1653` (Required: 1)
* Component ID: `1654` (Required: 1)
* Component ID: `1655` (Required: 1)
* Component ID: `1656` (Required: 1)

## 7. API / Data Mapping
* API ID: `4255` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lpn_dashboard_runtime`
* **Test Name**: `LpnDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `LPN Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `lpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `LPN Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `LPN Dashboard`)
5. **check_url** (Selector: `None`, Value: `/clinical/lpn-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
