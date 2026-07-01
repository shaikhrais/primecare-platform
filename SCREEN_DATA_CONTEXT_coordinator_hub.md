# SCREEN DATA CONTEXT: coordinator_hub

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - CoordinatorHubScreen** screen.

---

## 1. Screen Record
* **ID**: `251`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `coordinator_hub`
* **Screen Name**: `CoordinatorHubScreen`
* **Route Path**: `/staff/coordinator-hub`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/coordinator_hub_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to coordinatorhubscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the CoordinatorHubScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CoordinatorHubScreen`
* **Acceptance Criteria**:
- The CoordinatorHubScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coordinator_hub-screen` (Type: layout, Required: 1)
* **page_title** -> `coordinator_hub-title` (Type: header, Required: 1)
* **primary_content** -> `coordinator_hub-content` (Type: layout, Required: 1)
* **coordinatorhub_btn_4** -> `coordinatorhub-btn-4` (Type: button, Required: 0)
* **coordinatorhub_content** -> `coordinatorhub-content` (Type: layout, Required: 0)
* **coordinatorhub_btn_6** -> `coordinatorhub-btn-6` (Type: button, Required: 0)
* **coordinatorhub_btn_5** -> `coordinatorhub-btn-5` (Type: button, Required: 0)
* **coordinatorhub_loading** -> `coordinatorhub-loading` (Type: loading, Required: 0)
* **coordinatorhub_title** -> `coordinatorhub-title` (Type: header, Required: 0)
* **coordinatorhub_btn_2** -> `coordinatorhub-btn-2` (Type: button, Required: 0)
* **coordinatorhub_btn_7** -> `coordinatorhub-btn-7` (Type: button, Required: 0)
* **coordinatorhub_screen** -> `coordinatorhub-screen` (Type: layout, Required: 0)
* **coordinatorhub_btn_3** -> `coordinatorhub-btn-3` (Type: button, Required: 0)
* **coordinatorhub_btn_1** -> `coordinatorhub-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `259` (Required: 1)
* Component ID: `793` (Required: 1)
* Component ID: `1327` (Required: 1)
* Component ID: `3830` (Required: 1)
* Component ID: `3831` (Required: 1)
* Component ID: `3832` (Required: 1)
* Component ID: `3833` (Required: 1)
* Component ID: `3834` (Required: 1)
* Component ID: `3835` (Required: 1)
* Component ID: `3836` (Required: 1)
* Component ID: `3837` (Required: 1)
* Component ID: `3838` (Required: 1)
* Component ID: `3839` (Required: 1)

## 7. API / Data Mapping
* API ID: `4564` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coordinator_hub_runtime`
* **Test Name**: `CoordinatorHubScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coordinator Hub`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Coordinator Hub`)
4. **click_sidebar_link** (Selector: `None`, Value: `Coordinator Hub`)
5. **check_url** (Selector: `None`, Value: `/staff/coordinator-hub`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
