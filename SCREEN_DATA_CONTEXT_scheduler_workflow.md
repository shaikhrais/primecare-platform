# SCREEN DATA CONTEXT: scheduler_workflow

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `271`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `scheduler_workflow`
* **Screen Name**: `SchedulerWorkflowScreen`
* **Route Path**: `/staff/scheduler-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_workflow_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulerworkflowscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerWorkflowScreen`
* **Acceptance Criteria**:
- The SchedulerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_workflow-content` (Type: layout, Required: 1)
* **schedulerworkflow_content** -> `schedulerworkflow-content` (Type: layout, Required: 0)
* **schedulerworkflow_btn_2** -> `schedulerworkflow-btn-2` (Type: button, Required: 0)
* **schedulerworkflow_btn_1** -> `schedulerworkflow-btn-1` (Type: button, Required: 0)
* **schedulerworkflow_screen** -> `schedulerworkflow-screen` (Type: layout, Required: 0)
* **schedulerworkflow_title** -> `schedulerworkflow-title` (Type: header, Required: 0)
* **schedulerworkflow_btn_3** -> `schedulerworkflow-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `279` (Required: 1)
* Component ID: `813` (Required: 1)
* Component ID: `1347` (Required: 1)
* Component ID: `4018` (Required: 1)
* Component ID: `4019` (Required: 1)
* Component ID: `4020` (Required: 1)
* Component ID: `4021` (Required: 1)
* Component ID: `4022` (Required: 1)
* Component ID: `4023` (Required: 1)
* Component ID: `4024` (Required: 1)
* Component ID: `4025` (Required: 1)
* Component ID: `4026` (Required: 1)
* Component ID: `4027` (Required: 1)

## 7. API / Data Mapping
* API ID: `4592` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_workflow_runtime`
* **Test Name**: `SchedulerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduler Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduler Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/scheduler-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
