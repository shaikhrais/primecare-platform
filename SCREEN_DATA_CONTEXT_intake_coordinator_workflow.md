# SCREEN DATA CONTEXT: intake_coordinator_workflow

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeCoordinatorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `262`
* **App ID**: `1`
* **Role ID**: `7`
* **Screen Code**: `intake_coordinator_workflow`
* **Screen Name**: `IntakeCoordinatorWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/coordinator-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorworkflowscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeCoordinatorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorWorkflowScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_workflow-content` (Type: layout, Required: 1)
* **intakecoordinatorworkflow_screen** -> `intakecoordinatorworkflow-screen` (Type: layout, Required: 0)
* **intakecoordinatorworkflow_btn_3** -> `intakecoordinatorworkflow-btn-3` (Type: button, Required: 0)
* **intakecoordinatorworkflow_title** -> `intakecoordinatorworkflow-title` (Type: header, Required: 0)
* **intakecoordinatorworkflow_content** -> `intakecoordinatorworkflow-content` (Type: layout, Required: 0)
* **intakecoordinatorworkflow_btn_2** -> `intakecoordinatorworkflow-btn-2` (Type: button, Required: 0)
* **intakecoordinatorworkflow_btn_1** -> `intakecoordinatorworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `270` (Required: 1)
* Component ID: `804` (Required: 1)
* Component ID: `1338` (Required: 1)
* Component ID: `3933` (Required: 1)
* Component ID: `3934` (Required: 1)
* Component ID: `3935` (Required: 1)
* Component ID: `3936` (Required: 1)
* Component ID: `3937` (Required: 1)
* Component ID: `3938` (Required: 1)
* Component ID: `3939` (Required: 1)
* Component ID: `3940` (Required: 1)

## 7. API / Data Mapping
* API ID: `4581` (Required: 1)
* API ID: `4582` (Required: 1)
* API ID: `4583` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_workflow_runtime`
* **Test Name**: `IntakeCoordinatorWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeCoordinatorWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/coordinator-workflow`)
3. **should_be_visible** (Selector: `intake_coordinator_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
