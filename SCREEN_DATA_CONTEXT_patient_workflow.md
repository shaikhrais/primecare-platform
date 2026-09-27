# SCREEN DATA CONTEXT: patient_workflow

Below are the database records from `governance.db` used to configure and build the **Patient - PatientWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `127`
* **App ID**: `1`
* **Role ID**: `15`
* **Screen Code**: `patient_workflow`
* **Screen Name**: `PatientWorkflowScreen`
* **Route Path**: `/common/patient-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientworkflowscreen.`
* **User Story**: `As a Patient, I want to access the PatientWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientWorkflowScreen`
* **Acceptance Criteria**:
- The PatientWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `patient_workflow-content` (Type: layout, Required: 1)
* **patientworkflow_btn_1** -> `patientworkflow-btn-1` (Type: button, Required: 0)
* **patientworkflow_screen** -> `patientworkflow-screen` (Type: layout, Required: 0)
* **patientworkflow_btn_2** -> `patientworkflow-btn-2` (Type: button, Required: 0)
* **patientworkflow_content** -> `patientworkflow-content` (Type: layout, Required: 0)
* **patientworkflow_title** -> `patientworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `135` (Required: 1)
* Component ID: `669` (Required: 1)
* Component ID: `1203` (Required: 1)
* Component ID: `2684` (Required: 1)
* Component ID: `2685` (Required: 1)
* Component ID: `2686` (Required: 1)
* Component ID: `2687` (Required: 1)
* Component ID: `2688` (Required: 1)
* Component ID: `2689` (Required: 1)

## 7. API / Data Mapping
* API ID: `4410` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_workflow_runtime`
* **Test Name**: `PatientWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/patient-workflow`)
3. **should_be_visible** (Selector: `patient_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
