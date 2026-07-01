# SCREEN DATA CONTEXT: territory_expansion_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Territory Expansion Manager - TerritoryExpansionManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `58`
* **App ID**: `5`
* **Role ID**: `46`
* **Screen Code**: `territory_expansion_manager_dashboard`
* **Screen Name**: `TerritoryExpansionManagerDashboardScreen`
* **Route Path**: `/offices/business_development/roles/territory_expansion_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_expansion_manager_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `46`
* **Role Code**: `territory_expansion`
* **Role Name**: `Territory Expansion Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Territory Expansion Manager personnel to oversee, audit, and coordinate operations related to territoryexpansionmanagerdashboardscreen.`
* **User Story**: `As a Territory Expansion Manager, I want to access the TerritoryExpansionManagerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritoryExpansionManagerDashboardScreen`
* **Acceptance Criteria**:
- The TerritoryExpansionManagerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Expansion Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_expansion_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_expansion_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `territory_expansion_manager_dashboard-content` (Type: layout, Required: 1)
* **territoryexpansionmanagerdashboard_content** -> `territoryexpansionmanagerdashboard-content` (Type: layout, Required: 0)
* **territoryexpansionmanagerdashboard_btn_1** -> `territoryexpansionmanagerdashboard-btn-1` (Type: button, Required: 0)
* **territoryexpansionmanagerdashboard_title** -> `territoryexpansionmanagerdashboard-title` (Type: header, Required: 0)
* **territoryexpansionmanagerdashboard_btn_2** -> `territoryexpansionmanagerdashboard-btn-2` (Type: button, Required: 0)
* **territoryexpansionmanagerdashboard_screen** -> `territoryexpansionmanagerdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `66` (Required: 1)
* Component ID: `600` (Required: 1)
* Component ID: `1134` (Required: 1)
* Component ID: `2098` (Required: 1)
* Component ID: `2099` (Required: 1)
* Component ID: `2100` (Required: 1)
* Component ID: `2101` (Required: 1)
* Component ID: `2102` (Required: 1)
* Component ID: `2103` (Required: 1)
* Component ID: `2104` (Required: 1)
* Component ID: `2105` (Required: 1)

## 7. API / Data Mapping
* API ID: `4313` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_expansion_manager_dashboard_runtime`
* **Test Name**: `TerritoryExpansionManagerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Expansion Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_expansion`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Territory Expansion Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Territory Expansion Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/territory_expansion_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
