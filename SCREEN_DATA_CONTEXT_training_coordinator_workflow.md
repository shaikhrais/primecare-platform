# SCREEN DATA CONTEXT: training_coordinator_workflow

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingCoordinatorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `274`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_coordinator_workflow`
* **Screen Name**: `TrainingCoordinatorWorkflowScreen`
* **Route Path**: `/staff/training-coordinator-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/training_coordinator_workflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to trainingcoordinatorworkflowscreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingCoordinatorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingCoordinatorWorkflowScreen`
* **Acceptance Criteria**:
- The TrainingCoordinatorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_workflow-content` (Type: layout, Required: 1)
* **trainingcoordinatorworkflow_btn_1** -> `trainingcoordinatorworkflow-btn-1` (Type: button, Required: 0)
* **trainingcoordinatorworkflow_screen** -> `trainingcoordinatorworkflow-screen` (Type: layout, Required: 0)
* **trainingcoordinatorworkflow_btn_3** -> `trainingcoordinatorworkflow-btn-3` (Type: button, Required: 0)
* **trainingcoordinatorworkflow_title** -> `trainingcoordinatorworkflow-title` (Type: header, Required: 0)
* **trainingcoordinatorworkflow_content** -> `trainingcoordinatorworkflow-content` (Type: layout, Required: 0)
* **trainingcoordinatorworkflow_btn_2** -> `trainingcoordinatorworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `282` (Required: 1)
* Component ID: `816` (Required: 1)
* Component ID: `1350` (Required: 1)
* Component ID: `4042` (Required: 1)
* Component ID: `4043` (Required: 1)
* Component ID: `4044` (Required: 1)
* Component ID: `4045` (Required: 1)
* Component ID: `4046` (Required: 1)
* Component ID: `4047` (Required: 1)
* Component ID: `4048` (Required: 1)

## 7. API / Data Mapping
* API ID: `4595` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_workflow_runtime`
* **Test Name**: `TrainingCoordinatorWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Coordinator Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Coordinator Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Coordinator Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/training-coordinator-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
