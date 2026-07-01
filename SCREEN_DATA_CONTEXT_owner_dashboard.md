# SCREEN DATA CONTEXT: owner_dashboard

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - OwnerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `41`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `owner_dashboard`
* **Screen Name**: `OwnerDashboardScreen`
* **Route Path**: `/offices/corporate/roles/owner/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/owner_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to ownerdashboardscreen.`
* **User Story**: `As a Franchise Owner, I want to access the OwnerDashboardScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OwnerDashboardScreen`
* **Acceptance Criteria**:
- The OwnerDashboardScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `owner_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `owner_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `owner_dashboard-content` (Type: layout, Required: 1)
* **ownerdashboard_screen** -> `ownerdashboard-screen` (Type: layout, Required: 0)
* **ownerdashboard_btn_2** -> `ownerdashboard-btn-2` (Type: button, Required: 0)
* **ownerdashboard_content** -> `ownerdashboard-content` (Type: layout, Required: 0)
* **ownerdashboard_title** -> `ownerdashboard-title` (Type: header, Required: 0)
* **ownerdashboard_btn_3** -> `ownerdashboard-btn-3` (Type: button, Required: 0)
* **ownerdashboard_loading** -> `ownerdashboard-loading` (Type: loading, Required: 0)
* **ownerdashboard_btn_1** -> `ownerdashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `49` (Required: 1)
* Component ID: `583` (Required: 1)
* Component ID: `1117` (Required: 1)
* Component ID: `1943` (Required: 1)
* Component ID: `1944` (Required: 1)
* Component ID: `1945` (Required: 1)
* Component ID: `1946` (Required: 1)
* Component ID: `1947` (Required: 1)
* Component ID: `1948` (Required: 1)
* Component ID: `1949` (Required: 1)
* Component ID: `1950` (Required: 1)
* Component ID: `1951` (Required: 1)
* Component ID: `1952` (Required: 1)

## 7. API / Data Mapping
* API ID: `4296` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `owner_dashboard_runtime`
* **Test Name**: `OwnerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Owner Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Owner Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Owner Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/owner/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
