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
* **Stage/Status**: `template_created`

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
* **Test Name**: `FailedWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FailedWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **visit** (Selector: `None`, Value: `/staff/failed-workflow`)
3. **should_be_visible** (Selector: `failed_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `failed_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `failed_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
