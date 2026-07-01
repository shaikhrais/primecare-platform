# SCREEN DATA CONTEXT: rn_dashboard

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `62`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_dashboard`
* **Screen Name**: `RnDashboardScreen`
* **Route Path**: `/offices/clinical/roles/rn/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rndashboardscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnDashboardScreen`
* **Acceptance Criteria**:
- The RnDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `rn_dashboard-content` (Type: layout, Required: 1)
* **rndashboard_btn_2** -> `rndashboard-btn-2` (Type: button, Required: 0)
* **rndashboard_title** -> `rndashboard-title` (Type: header, Required: 0)
* **rndashboard_loading** -> `rndashboard-loading` (Type: loading, Required: 0)
* **rndashboard_btn_3** -> `rndashboard-btn-3` (Type: button, Required: 0)
* **rndashboard_screen** -> `rndashboard-screen` (Type: layout, Required: 0)
* **rndashboard_btn_1** -> `rndashboard-btn-1` (Type: button, Required: 0)
* **rndashboard_content** -> `rndashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `70` (Required: 1)
* Component ID: `604` (Required: 1)
* Component ID: `1138` (Required: 1)
* Component ID: `2130` (Required: 1)
* Component ID: `2131` (Required: 1)
* Component ID: `2132` (Required: 1)
* Component ID: `2133` (Required: 1)
* Component ID: `2134` (Required: 1)
* Component ID: `2135` (Required: 1)
* Component ID: `2136` (Required: 1)
* Component ID: `2137` (Required: 1)
* Component ID: `2138` (Required: 1)
* Component ID: `2139` (Required: 1)

## 7. API / Data Mapping
* API ID: `4317` (Required: 1)
* API ID: `4318` (Required: 1)
* API ID: `4319` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_dashboard_runtime`
* **Test Name**: `RnDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
