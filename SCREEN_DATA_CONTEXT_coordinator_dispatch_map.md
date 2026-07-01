# SCREEN DATA CONTEXT: coordinator_dispatch_map

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - CoordinatorDispatchMapScreen** screen.

---

## 1. Screen Record
* **ID**: `250`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `coordinator_dispatch_map`
* **Screen Name**: `CoordinatorDispatchMapScreen`
* **Route Path**: `/staff/coordinator-dispatch-map`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/coordinator_dispatch_map_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to coordinatordispatchmapscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the CoordinatorDispatchMapScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CoordinatorDispatchMapScreen`
* **Acceptance Criteria**:
- The CoordinatorDispatchMapScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coordinator_dispatch_map-screen` (Type: layout, Required: 1)
* **page_title** -> `coordinator_dispatch_map-title` (Type: header, Required: 1)
* **primary_content** -> `coordinator_dispatch_map-content` (Type: layout, Required: 1)
* **coordinatordispatchmap_screen** -> `coordinatordispatchmap-screen` (Type: layout, Required: 0)
* **coordinatordispatchmap_loading** -> `coordinatordispatchmap-loading` (Type: loading, Required: 0)
* **coordinatordispatchmap_btn_6** -> `coordinatordispatchmap-btn-6` (Type: button, Required: 0)
* **coordinatordispatchmap_btn_2** -> `coordinatordispatchmap-btn-2` (Type: button, Required: 0)
* **coordinatordispatchmap_btn_1** -> `coordinatordispatchmap-btn-1` (Type: button, Required: 0)
* **coordinatordispatchmap_title** -> `coordinatordispatchmap-title` (Type: header, Required: 0)
* **coordinatordispatchmap_btn_3** -> `coordinatordispatchmap-btn-3` (Type: button, Required: 0)
* **coordinatordispatchmap_btn_7** -> `coordinatordispatchmap-btn-7` (Type: button, Required: 0)
* **coordinatordispatchmap_btn_4** -> `coordinatordispatchmap-btn-4` (Type: button, Required: 0)
* **coordinatordispatchmap_content** -> `coordinatordispatchmap-content` (Type: layout, Required: 0)
* **coordinatordispatchmap_btn_5** -> `coordinatordispatchmap-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `258` (Required: 1)
* Component ID: `792` (Required: 1)
* Component ID: `1326` (Required: 1)
* Component ID: `3820` (Required: 1)
* Component ID: `3821` (Required: 1)
* Component ID: `3822` (Required: 1)
* Component ID: `3823` (Required: 1)
* Component ID: `3824` (Required: 1)
* Component ID: `3825` (Required: 1)
* Component ID: `3826` (Required: 1)
* Component ID: `3827` (Required: 1)
* Component ID: `3828` (Required: 1)
* Component ID: `3829` (Required: 1)

## 7. API / Data Mapping
* API ID: `4563` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coordinator_dispatch_map_runtime`
* **Test Name**: `CoordinatorDispatchMapScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coordinator Dispatch Map`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Coordinator Dispatch Map`)
4. **click_sidebar_link** (Selector: `None`, Value: `Coordinator Dispatch Map`)
5. **check_url** (Selector: `None`, Value: `/staff/coordinator-dispatch-map`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
