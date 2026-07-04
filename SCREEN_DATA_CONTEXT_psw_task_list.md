# SCREEN DATA CONTEXT: psw_task_list

Below are the database records from `governance.db` used to configure and build the **Guest - PswTaskListScreen** screen.

---

## 1. Screen Record
* **ID**: `698`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_task_list`
* **Screen Name**: `PswTaskListScreen`
* **Route Path**: `/generated/psw-task-list`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_task_list_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw task list.`
* **User Story**: `As a Guest, I want to access the Psw Task List within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Task List`
* **Acceptance Criteria**:
- The Psw Task List route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_task_list-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_task_list-title` (Type: header, Required: 1)
* **primary_content** -> `psw_task_list-content` (Type: layout, Required: 1)
* **tasklist_btn_add** -> `tasklist-btn-add` (Type: button, Required: 0)
* **pswtasklist_content** -> `pswtasklist-content` (Type: layout, Required: 0)
* **tasklist_btn_add_item** -> `tasklist-btn-add-item` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6832` (Required: 1)
* Component ID: `6833` (Required: 1)
* Component ID: `6834` (Required: 1)
* Component ID: `6835` (Required: 1)
* Component ID: `6836` (Required: 1)

## 7. API / Data Mapping
* API ID: `5070` (Required: 1)
* API ID: `5071` (Required: 1)
* API ID: `5072` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_task_list_runtime`
* **Test Name**: `Psw Task List Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Task List`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-task-list`)
3. **should_be_visible** (Selector: `psw_task_list-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_task_list-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_task_list-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
