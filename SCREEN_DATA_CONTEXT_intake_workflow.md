# SCREEN DATA CONTEXT: intake_workflow

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `121`
* **App ID**: `1`
* **Role ID**: `7`
* **Screen Code**: `intake_workflow`
* **Screen Name**: `IntakeWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/intake_workflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakeworkflowscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeWorkflowScreen`
* **Acceptance Criteria**:
- The IntakeWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `intake_workflow-content` (Type: layout, Required: 1)
* **intakeworkflow_btn_2** -> `intakeworkflow-btn-2` (Type: button, Required: 0)
* **intakeworkflow_content** -> `intakeworkflow-content` (Type: layout, Required: 0)
* **intakeworkflow_title** -> `intakeworkflow-title` (Type: header, Required: 0)
* **intakeworkflow_screen** -> `intakeworkflow-screen` (Type: layout, Required: 0)
* **intakeworkflow_btn_1** -> `intakeworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `129` (Required: 1)
* Component ID: `663` (Required: 1)
* Component ID: `1197` (Required: 1)
* Component ID: `2633` (Required: 1)
* Component ID: `2634` (Required: 1)
* Component ID: `2635` (Required: 1)
* Component ID: `2636` (Required: 1)
* Component ID: `2637` (Required: 1)
* Component ID: `2638` (Required: 1)
* Component ID: `2639` (Required: 1)
* Component ID: `2640` (Required: 1)
* Component ID: `2641` (Required: 1)
* Component ID: `2642` (Required: 1)

## 7. API / Data Mapping
* API ID: `4402` (Required: 1)
* API ID: `4403` (Required: 1)
* API ID: `4404` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_workflow_runtime`
* **Test Name**: `IntakeWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/workflow`)
3. **should_be_visible** (Selector: `intake_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
