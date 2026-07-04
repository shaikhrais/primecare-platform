# SCREEN DATA CONTEXT: scheduler_command_center

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `376`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_command_center`
* **Screen Name**: `SchedulerCommandCenterScreen`
* **Route Path**: `/staff/scheduler-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_command_center_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulercommandcenterscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerCommandCenterScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerCommandCenterScreen`
* **Acceptance Criteria**:
- The SchedulerCommandCenterScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_command_center-content` (Type: layout, Required: 1)
* **schedulercommandcenter_btn_3** -> `schedulercommandcenter-btn-3` (Type: button, Required: 0)
* **schedulercommandcenter_btn_4** -> `schedulercommandcenter-btn-4` (Type: button, Required: 0)
* **schedulercommandcenter_content** -> `schedulercommandcenter-content` (Type: layout, Required: 0)
* **schedulercommandcenter_btn_2** -> `schedulercommandcenter-btn-2` (Type: button, Required: 0)
* **schedulercommandcenter_screen** -> `schedulercommandcenter-screen` (Type: layout, Required: 0)
* **schedulercommandcenter_btn_5** -> `schedulercommandcenter-btn-5` (Type: button, Required: 0)
* **schedulercommandcenter_title** -> `schedulercommandcenter-title` (Type: header, Required: 0)
* **schedulercommandcenter_btn_1** -> `schedulercommandcenter-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `382` (Required: 1)
* Component ID: `916` (Required: 1)
* Component ID: `1450` (Required: 1)
* Component ID: `4934` (Required: 1)
* Component ID: `4935` (Required: 1)
* Component ID: `4936` (Required: 1)
* Component ID: `4937` (Required: 1)
* Component ID: `4938` (Required: 1)
* Component ID: `4939` (Required: 1)
* Component ID: `4940` (Required: 1)
* Component ID: `4941` (Required: 1)
* Component ID: `4942` (Required: 1)
* Component ID: `4943` (Required: 1)

## 7. API / Data Mapping
* API ID: `4755` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_command_center_runtime`
* **Test Name**: `SchedulerCommandCenterScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerCommandCenterScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-command-center`)
3. **should_be_visible** (Selector: `scheduler_command_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_command_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_command_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
