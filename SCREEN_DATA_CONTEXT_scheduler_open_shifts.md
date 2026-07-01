# SCREEN DATA CONTEXT: scheduler_open_shifts

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerOpenShiftsScreen** screen.

---

## 1. Screen Record
* **ID**: `380`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_open_shifts`
* **Screen Name**: `SchedulerOpenShiftsScreen`
* **Route Path**: `/staff/scheduler-open-shifts`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_open_shifts_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to scheduleropenshiftsscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerOpenShiftsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerOpenShiftsScreen`
* **Acceptance Criteria**:
- The SchedulerOpenShiftsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_open_shifts-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_open_shifts-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_open_shifts-content` (Type: layout, Required: 1)
* **scheduleropenshifts_btn_3** -> `scheduleropenshifts-btn-3` (Type: button, Required: 0)
* **scheduleropenshifts_btn_4** -> `scheduleropenshifts-btn-4` (Type: button, Required: 0)
* **scheduleropenshifts_btn_2** -> `scheduleropenshifts-btn-2` (Type: button, Required: 0)
* **scheduleropenshifts_btn_1** -> `scheduleropenshifts-btn-1` (Type: button, Required: 0)
* **scheduleropenshifts_btn_5** -> `scheduleropenshifts-btn-5` (Type: button, Required: 0)
* **scheduleropenshifts_title** -> `scheduleropenshifts-title` (Type: header, Required: 0)
* **scheduleropenshifts_screen** -> `scheduleropenshifts-screen` (Type: layout, Required: 0)
* **scheduleropenshifts_content** -> `scheduleropenshifts-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `386` (Required: 1)
* Component ID: `920` (Required: 1)
* Component ID: `1454` (Required: 1)
* Component ID: `4974` (Required: 1)
* Component ID: `4975` (Required: 1)
* Component ID: `4976` (Required: 1)
* Component ID: `4977` (Required: 1)
* Component ID: `4978` (Required: 1)
* Component ID: `4979` (Required: 1)
* Component ID: `4980` (Required: 1)
* Component ID: `4981` (Required: 1)

## 7. API / Data Mapping
* API ID: `4761` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_open_shifts_runtime`
* **Test Name**: `SchedulerOpenShiftsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Open Shifts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduler Open Shifts`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduler Open Shifts`)
5. **check_url** (Selector: `None`, Value: `/staff/scheduler-open-shifts`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
