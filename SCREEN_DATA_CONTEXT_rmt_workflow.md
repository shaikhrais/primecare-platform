# SCREEN DATA CONTEXT: rmt_workflow

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `78`
* **App ID**: `1`
* **Role ID**: `3`
* **Screen Code**: `rmt_workflow`
* **Screen Name**: `RmtWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/rmt/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtworkflowscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtWorkflowScreen`
* **Acceptance Criteria**:
- The RmtWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_workflow-content` (Type: layout, Required: 1)
* **rmtworkflow_btn_1** -> `rmtworkflow-btn-1` (Type: button, Required: 0)
* **rmtworkflow_btn_2** -> `rmtworkflow-btn-2` (Type: button, Required: 0)
* **rmtworkflow_title** -> `rmtworkflow-title` (Type: header, Required: 0)
* **rmtworkflow_content** -> `rmtworkflow-content` (Type: layout, Required: 0)
* **rmtworkflow_screen** -> `rmtworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `86` (Required: 1)
* Component ID: `620` (Required: 1)
* Component ID: `1154` (Required: 1)
* Component ID: `2275` (Required: 1)
* Component ID: `2276` (Required: 1)
* Component ID: `2277` (Required: 1)
* Component ID: `2278` (Required: 1)
* Component ID: `2279` (Required: 1)
* Component ID: `2280` (Required: 1)
* Component ID: `2281` (Required: 1)
* Component ID: `2282` (Required: 1)
* Component ID: `2283` (Required: 1)
* Component ID: `2284` (Required: 1)

## 7. API / Data Mapping
* API ID: `4347` (Required: 1)
* API ID: `4348` (Required: 1)
* API ID: `4349` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_workflow_runtime`
* **Test Name**: `RmtWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RmtWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rmt/workflow`)
3. **should_be_visible** (Selector: `rmt_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rmt_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `rmt_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
