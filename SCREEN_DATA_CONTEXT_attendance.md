# SCREEN DATA CONTEXT: attendance

Below are the database records from `governance.db` used to configure and build the **Operations Manager - AttendanceScreen** screen.

---

## 1. Screen Record
* **ID**: `509`
* **App ID**: `5`
* **Role ID**: `40`
* **Screen Code**: `attendance`
* **Screen Name**: `AttendanceScreen`
* **Route Path**: `/management/attendance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/attendance_screen.dart`
* **Stage/Status**: `production_ready`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to attendancescreen.`
* **User Story**: `As a Operations Manager, I want to access the AttendanceScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AttendanceScreen`
* **Acceptance Criteria**:
- The AttendanceScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `attendance-screen` (Type: layout, Required: 1)
* **page_title** -> `attendance-title` (Type: header, Required: 1)
* **primary_content** -> `attendance-content` (Type: layout, Required: 1)
* **attendance_loading** -> `attendance-loading` (Type: loading, Required: 0)
* **attendance_btn_2** -> `attendance-btn-2` (Type: button, Required: 0)
* **attendance_btn_3** -> `attendance-btn-3` (Type: button, Required: 0)
* **attendance_btn_1** -> `attendance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `438` (Required: 1)
* Component ID: `972` (Required: 1)
* Component ID: `1506` (Required: 1)
* Component ID: `5469` (Required: 1)
* Component ID: `5470` (Required: 1)
* Component ID: `5471` (Required: 1)
* Component ID: `5472` (Required: 1)
* Component ID: `5473` (Required: 1)
* Component ID: `5474` (Required: 1)
* Component ID: `5475` (Required: 1)
* Component ID: `5476` (Required: 1)
* Component ID: `5477` (Required: 1)
* Component ID: `5478` (Required: 1)

## 7. API / Data Mapping
* API ID: `4825` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `attendance_runtime`
* **Test Name**: `AttendanceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Attendance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Attendance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Attendance`)
5. **check_url** (Selector: `None`, Value: `/management/attendance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
