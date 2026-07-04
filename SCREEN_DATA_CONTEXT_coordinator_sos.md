# SCREEN DATA CONTEXT: coordinator_sos

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - CoordinatorSosScreen** screen.

---

## 1. Screen Record
* **ID**: `252`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `coordinator_sos`
* **Screen Name**: `CoordinatorSosScreen`
* **Route Path**: `/staff/coordinator-sos`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/coordinator_sos_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to coordinatorsosscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the CoordinatorSosScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CoordinatorSosScreen`
* **Acceptance Criteria**:
- The CoordinatorSosScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coordinator_sos-screen` (Type: layout, Required: 1)
* **page_title** -> `coordinator_sos-title` (Type: header, Required: 1)
* **primary_content** -> `coordinator_sos-content` (Type: layout, Required: 1)
* **coordinatorsos_btn_2** -> `coordinatorsos-btn-2` (Type: button, Required: 0)
* **coordinatorsos_btn_9** -> `coordinatorsos-btn-9` (Type: button, Required: 0)
* **coordinatorsos_content** -> `coordinatorsos-content` (Type: layout, Required: 0)
* **coordinatorsos_btn_4** -> `coordinatorsos-btn-4` (Type: button, Required: 0)
* **coordinator_sos_screen_textfield_input_1** -> `coordinator_sos_screen_textfield_input_1` (Type: field, Required: 0)
* **coordinatorsos_btn_6** -> `coordinatorsos-btn-6` (Type: button, Required: 0)
* **coordinatorsos_btn_13** -> `coordinatorsos-btn-13` (Type: button, Required: 0)
* **coordinatorsos_btn_10** -> `coordinatorsos-btn-10` (Type: button, Required: 0)
* **coordinatorsos_screen** -> `coordinatorsos-screen` (Type: layout, Required: 0)
* **coordinatorsos_btn_7** -> `coordinatorsos-btn-7` (Type: button, Required: 0)
* **coordinatorsos_title** -> `coordinatorsos-title` (Type: header, Required: 0)
* **coordinatorsos_btn_12** -> `coordinatorsos-btn-12` (Type: button, Required: 0)
* **coordinatorsos_btn_3** -> `coordinatorsos-btn-3` (Type: button, Required: 0)
* **coordinatorsos_btn_5** -> `coordinatorsos-btn-5` (Type: button, Required: 0)
* **coordinatorsos_btn_11** -> `coordinatorsos-btn-11` (Type: button, Required: 0)
* **coordinatorsos_loading** -> `coordinatorsos-loading` (Type: loading, Required: 0)
* **coordinatorsos_btn_8** -> `coordinatorsos-btn-8` (Type: button, Required: 0)
* **coordinatorsos_btn_1** -> `coordinatorsos-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `260` (Required: 1)
* Component ID: `794` (Required: 1)
* Component ID: `1328` (Required: 1)
* Component ID: `3840` (Required: 1)
* Component ID: `3841` (Required: 1)
* Component ID: `3842` (Required: 1)
* Component ID: `3843` (Required: 1)
* Component ID: `3844` (Required: 1)
* Component ID: `3845` (Required: 1)
* Component ID: `3846` (Required: 1)
* Component ID: `3847` (Required: 1)
* Component ID: `3848` (Required: 1)
* Component ID: `3849` (Required: 1)

## 7. API / Data Mapping
* API ID: `4565` (Required: 1)
* API ID: `4566` (Required: 1)
* API ID: `4567` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coordinator_sos_runtime`
* **Test Name**: `CoordinatorSosScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CoordinatorSosScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/coordinator-sos`)
3. **should_be_visible** (Selector: `coordinator_sos-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coordinator_sos-title`, Value: `None`)
5. **should_be_visible** (Selector: `coordinator_sos-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
