# SCREEN DATA CONTEXT: schedule

Below are the database records from `governance.db` used to configure and build the **Caregiver - ScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `577`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `schedule`
* **Screen Name**: `ScheduleScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/psw-schedule`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/schedule_screen.dart`
* **Stage/Status**: `production_ready`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to schedulescreen.`
* **User Story**: `As a Caregiver, I want to access the ScheduleScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScheduleScreen`
* **Acceptance Criteria**:
- The ScheduleScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `schedule-title` (Type: header, Required: 1)
* **primary_content** -> `schedule-content` (Type: layout, Required: 1)
* **schedule_btn_2** -> `schedule-btn-2` (Type: button, Required: 0)
* **schedule_btn_1** -> `schedule-btn-1` (Type: button, Required: 0)
* **schedule_btn_3** -> `schedule-btn-3` (Type: button, Required: 0)
* **schedule_loading** -> `schedule-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `501` (Required: 1)
* Component ID: `1035` (Required: 1)
* Component ID: `1569` (Required: 1)
* Component ID: `6023` (Required: 1)
* Component ID: `6024` (Required: 1)
* Component ID: `6025` (Required: 1)
* Component ID: `6026` (Required: 1)
* Component ID: `6027` (Required: 1)
* Component ID: `6028` (Required: 1)
* Component ID: `6029` (Required: 1)
* Component ID: `6030` (Required: 1)
* Component ID: `6031` (Required: 1)
* Component ID: `6032` (Required: 1)

## 7. API / Data Mapping
* API ID: `4924` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `schedule_runtime`
* **Test Name**: `ScheduleScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Schedule`)
4. **click_sidebar_link** (Selector: `None`, Value: `Schedule`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/psw-schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
