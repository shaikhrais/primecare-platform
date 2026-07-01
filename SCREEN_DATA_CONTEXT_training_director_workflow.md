# SCREEN DATA CONTEXT: training_director_workflow

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingDirectorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `185`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_director_workflow`
* **Screen Name**: `TrainingDirectorWorkflowScreen`
* **Route Path**: `/executive/training-director-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/training_director_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `19`
* **Role Code**: `training`
* **Role Name**: `Training Candidate`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to trainingdirectorworkflowscreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingDirectorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingDirectorWorkflowScreen`
* **Acceptance Criteria**:
- The TrainingDirectorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_workflow-content` (Type: layout, Required: 1)
* **trainingdirectorworkflow_btn_2** -> `trainingdirectorworkflow-btn-2` (Type: button, Required: 0)
* **trainingdirectorworkflow_btn_3** -> `trainingdirectorworkflow-btn-3` (Type: button, Required: 0)
* **trainingdirectorworkflow_content** -> `trainingdirectorworkflow-content` (Type: layout, Required: 0)
* **trainingdirectorworkflow_btn_1** -> `trainingdirectorworkflow-btn-1` (Type: button, Required: 0)
* **trainingdirectorworkflow_title** -> `trainingdirectorworkflow-title` (Type: header, Required: 0)
* **trainingdirectorworkflow_screen** -> `trainingdirectorworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `193` (Required: 1)
* Component ID: `727` (Required: 1)
* Component ID: `1261` (Required: 1)
* Component ID: `3211` (Required: 1)
* Component ID: `3212` (Required: 1)
* Component ID: `3213` (Required: 1)
* Component ID: `3214` (Required: 1)
* Component ID: `3215` (Required: 1)

## 7. API / Data Mapping
* API ID: `4474` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_workflow_runtime`
* **Test Name**: `TrainingDirectorWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Director Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Director Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Director Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/training-director-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
