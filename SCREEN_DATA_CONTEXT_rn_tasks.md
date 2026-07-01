# SCREEN DATA CONTEXT: rn_tasks

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnTasksScreen** screen.

---

## 1. Screen Record
* **ID**: `366`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_tasks`
* **Screen Name**: `RnTasksScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-tasks`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_tasks_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rntasksscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnTasksScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnTasksScreen`
* **Acceptance Criteria**:
- The RnTasksScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_tasks-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_tasks-title` (Type: header, Required: 1)
* **primary_content** -> `rn_tasks-content` (Type: layout, Required: 1)
* **rntasks_btn_3** -> `rntasks-btn-3` (Type: button, Required: 0)
* **rntasks_title** -> `rntasks-title` (Type: header, Required: 0)
* **rntasks_btn_2** -> `rntasks-btn-2` (Type: button, Required: 0)
* **rntasks_screen** -> `rntasks-screen` (Type: layout, Required: 0)
* **rntasks_btn_1** -> `rntasks-btn-1` (Type: button, Required: 0)
* **rntasks_content** -> `rntasks-content` (Type: layout, Required: 0)
* **rntasks_loading** -> `rntasks-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `372` (Required: 1)
* Component ID: `906` (Required: 1)
* Component ID: `1440` (Required: 1)
* Component ID: `4834` (Required: 1)
* Component ID: `4835` (Required: 1)
* Component ID: `4836` (Required: 1)
* Component ID: `4837` (Required: 1)
* Component ID: `4838` (Required: 1)
* Component ID: `4839` (Required: 1)
* Component ID: `4840` (Required: 1)
* Component ID: `4841` (Required: 1)
* Component ID: `4842` (Required: 1)
* Component ID: `4843` (Required: 1)

## 7. API / Data Mapping
* API ID: `4725` (Required: 1)
* API ID: `4726` (Required: 1)
* API ID: `4727` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_tasks_runtime`
* **Test Name**: `RnTasksScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Tasks`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Tasks`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Tasks`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-tasks`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
