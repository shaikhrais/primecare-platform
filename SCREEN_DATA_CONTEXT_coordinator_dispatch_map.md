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
* **Stage/Status**: `template_created`

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
* **Test Name**: `CoordinatorDispatchMapScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CoordinatorDispatchMapScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/coordinator-dispatch-map`)
3. **should_be_visible** (Selector: `coordinator_dispatch_map-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coordinator_dispatch_map-title`, Value: `None`)
5. **should_be_visible** (Selector: `coordinator_dispatch_map-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
