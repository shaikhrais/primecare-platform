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
* **Stage/Status**: `wired`

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
* **Test Name**: `IntakeWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
