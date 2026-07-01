# SCREEN DATA CONTEXT: shift_tasks

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - ShiftTasksScreen** screen.

---

## 1. Screen Record
* **ID**: `533`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `shift_tasks`
* **Screen Name**: `ShiftTasksScreen`
* **Route Path**: `/offices/clinical/roles/psw/shift-tasks`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to shifttasksscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the ShiftTasksScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ShiftTasksScreen`
* **Acceptance Criteria**:
- The ShiftTasksScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shift_tasks-screen` (Type: layout, Required: 1)
* **page_title** -> `shift_tasks-title` (Type: header, Required: 1)
* **primary_content** -> `shift_tasks-content` (Type: layout, Required: 1)
* **shifttasks_btn_1** -> `shifttasks-btn-1` (Type: button, Required: 0)
* **shifttasks_content** -> `shifttasks-content` (Type: layout, Required: 0)
* **shifttasks_screen** -> `shifttasks-screen` (Type: layout, Required: 0)
* **shifttasks_title** -> `shifttasks-title` (Type: header, Required: 0)
* **shifttasks_loading** -> `shifttasks-loading` (Type: loading, Required: 0)
* **shifttasks_btn_3** -> `shifttasks-btn-3` (Type: button, Required: 0)
* **shifttasks_btn_2** -> `shifttasks-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `461` (Required: 1)
* Component ID: `995` (Required: 1)
* Component ID: `1529` (Required: 1)
* Component ID: `5692` (Required: 1)
* Component ID: `5693` (Required: 1)
* Component ID: `5694` (Required: 1)
* Component ID: `5695` (Required: 1)
* Component ID: `5696` (Required: 1)
* Component ID: `5697` (Required: 1)
* Component ID: `5698` (Required: 1)
* Component ID: `5699` (Required: 1)

## 7. API / Data Mapping
* API ID: `4864` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shift_tasks_runtime`
* **Test Name**: `ShiftTasksScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Shift Tasks`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Shift Tasks`)
4. **click_sidebar_link** (Selector: `None`, Value: `Shift Tasks`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/shift-tasks`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
