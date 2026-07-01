# SCREEN DATA CONTEXT: nursing_task

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - NursingTaskScreen** screen.

---

## 1. Screen Record
* **ID**: `529`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `nursing_task`
* **Screen Name**: `NursingTaskScreen`
* **Route Path**: `/offices/clinical/roles/rpn/nursing-task`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/nursing_task_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to nursingtaskscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the NursingTaskScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `NursingTaskScreen`
* **Acceptance Criteria**:
- The NursingTaskScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `nursing_task-screen` (Type: layout, Required: 1)
* **page_title** -> `nursing_task-title` (Type: header, Required: 1)
* **primary_content** -> `nursing_task-content` (Type: layout, Required: 1)
* **nursingtask_title** -> `nursingtask-title` (Type: header, Required: 0)
* **nursingtask_btn_1** -> `nursingtask-btn-1` (Type: button, Required: 0)
* **nursingtask_loading** -> `nursingtask-loading` (Type: loading, Required: 0)
* **nursingtask_screen** -> `nursingtask-screen` (Type: layout, Required: 0)
* **nursingtask_btn_2** -> `nursingtask-btn-2` (Type: button, Required: 0)
* **nursingtask_content** -> `nursingtask-content` (Type: layout, Required: 0)
* **nursingtask_btn_3** -> `nursingtask-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `457` (Required: 1)
* Component ID: `991` (Required: 1)
* Component ID: `1525` (Required: 1)
* Component ID: `5652` (Required: 1)
* Component ID: `5653` (Required: 1)
* Component ID: `5654` (Required: 1)
* Component ID: `5655` (Required: 1)
* Component ID: `5656` (Required: 1)
* Component ID: `5657` (Required: 1)
* Component ID: `5658` (Required: 1)
* Component ID: `5659` (Required: 1)
* Component ID: `5660` (Required: 1)
* Component ID: `5661` (Required: 1)

## 7. API / Data Mapping
* API ID: `4852` (Required: 1)
* API ID: `4853` (Required: 1)
* API ID: `4854` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `nursing_task_runtime`
* **Test Name**: `NursingTaskScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Nursing Task`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Nursing Task`)
4. **click_sidebar_link** (Selector: `None`, Value: `Nursing Task`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/nursing-task`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
