# SCREEN DATA CONTEXT: psw_tasks

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - TaskListScreen** screen.

---

## 1. Screen Record
* **ID**: `236`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_tasks`
* **Screen Name**: `TaskListScreen`
* **Route Path**: `/offices/clinical/roles/psw/visit-checklist`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswtasksscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswTasksScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswTasksScreen`
* **Acceptance Criteria**:
- The PswTasksScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_tasks-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_tasks-title` (Type: header, Required: 1)
* **primary_content** -> `psw_tasks-content` (Type: layout, Required: 1)
* **pswtasks_screen** -> `pswtasks-screen` (Type: layout, Required: 0)
* **pswtasks_btn_1** -> `pswtasks-btn-1` (Type: button, Required: 0)
* **pswtasks_content** -> `pswtasks-content` (Type: layout, Required: 0)
* **pswtasks_title** -> `pswtasks-title` (Type: header, Required: 0)
* **pswtasks_loading** -> `pswtasks-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `244` (Required: 1)
* Component ID: `778` (Required: 1)
* Component ID: `1312` (Required: 1)
* Component ID: `3690` (Required: 1)
* Component ID: `3691` (Required: 1)
* Component ID: `3692` (Required: 1)
* Component ID: `3693` (Required: 1)
* Component ID: `3694` (Required: 1)
* Component ID: `3695` (Required: 1)

## 7. API / Data Mapping
* API ID: `4529` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_tasks_runtime`
* **Test Name**: `Task List Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Task List`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/visit-checklist`)
3. **should_be_visible** (Selector: `psw_tasks-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_tasks-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_tasks-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
