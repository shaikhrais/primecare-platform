# SCREEN DATA CONTEXT: failed_workflow

Below are the database records from `governance.db` used to configure and build the **QA Specialist - FailedWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `566`
* **App ID**: `5`
* **Role ID**: `63`
* **Screen Code**: `failed_workflow`
* **Screen Name**: `FailedWorkflowScreen`
* **Route Path**: `/staff/failed-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/failed_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to failedworkflowscreen.`
* **User Story**: `As a QA Specialist, I want to access the FailedWorkflowScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FailedWorkflowScreen`
* **Acceptance Criteria**:
- The FailedWorkflowScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `failed_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `failed_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `failed_workflow-content` (Type: layout, Required: 1)
* **failedworkflow_btn_4** -> `failedworkflow-btn-4` (Type: button, Required: 0)
* **failedworkflow_btn_1** -> `failedworkflow-btn-1` (Type: button, Required: 0)
* **failedworkflow_content** -> `failedworkflow-content` (Type: layout, Required: 0)
* **failedworkflow_btn_5** -> `failedworkflow-btn-5` (Type: button, Required: 0)
* **failedworkflow_screen** -> `failedworkflow-screen` (Type: layout, Required: 0)
* **failedworkflow_loading** -> `failedworkflow-loading` (Type: loading, Required: 0)
* **failedworkflow_btn_2** -> `failedworkflow-btn-2` (Type: button, Required: 0)
* **failedworkflow_btn_3** -> `failedworkflow-btn-3` (Type: button, Required: 0)
* **failedworkflow_title** -> `failedworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `490` (Required: 1)
* Component ID: `1024` (Required: 1)
* Component ID: `1558` (Required: 1)
* Component ID: `5951` (Required: 1)
* Component ID: `5952` (Required: 1)
* Component ID: `5953` (Required: 1)
* Component ID: `5954` (Required: 1)
* Component ID: `5955` (Required: 1)
* Component ID: `5956` (Required: 1)
* Component ID: `5957` (Required: 1)
* Component ID: `5958` (Required: 1)

## 7. API / Data Mapping
* API ID: `4913` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `failed_workflow_runtime`
* **Test Name**: `FailedWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Failed Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Failed Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Failed Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/failed-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
