# SCREEN DATA CONTEXT: np_workflow

Below are the database records from `governance.db` used to configure and build the **Nurse Practitioner (NP) - NursePractitionerNPComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `614`
* **App ID**: `1`
* **Role ID**: `54`
* **Screen Code**: `np_workflow`
* **Screen Name**: `NursePractitionerNPComplianceWorkflowScreen`
* **Route Path**: `/rn/np-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/np_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `54`
* **Role Code**: `np`
* **Role Name**: `Nurse Practitioner (NP)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Nurse Practitioner (NP) personnel to oversee, audit, and coordinate operations related to nurse practitioner (np) compliance workflow.`
* **User Story**: `As a Nurse Practitioner (NP), I want to access the Nurse Practitioner (NP) Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Nurse Practitioner (NP) Compliance Workflow`
* **Acceptance Criteria**:
- The Nurse Practitioner (NP) Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Nurse Practitioner (NP) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `np_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `np_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `np_workflow-content` (Type: layout, Required: 1)
* **nurse practitioner (np) compliance workflow_title** -> `nurse practitioner (np) compliance workflow-title` (Type: header, Required: 0)
* **nurse practitioner (np) compliance workflow_btn_1** -> `nurse practitioner (np) compliance workflow-btn-1` (Type: button, Required: 0)
* **nurse practitioner (np) compliance workflow_content** -> `nurse practitioner (np) compliance workflow-content` (Type: layout, Required: 0)
* **nurse practitioner (np) compliance workflow_screen** -> `nurse practitioner (np) compliance workflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `538` (Required: 1)
* Component ID: `1072` (Required: 1)
* Component ID: `1606` (Required: 1)
* Component ID: `6360` (Required: 1)
* Component ID: `6361` (Required: 1)
* Component ID: `6362` (Required: 1)
* Component ID: `6363` (Required: 1)
* Component ID: `6364` (Required: 1)
* Component ID: `6365` (Required: 1)
* Component ID: `6366` (Required: 1)
* Component ID: `6367` (Required: 1)
* Component ID: `6368` (Required: 1)
* Component ID: `6369` (Required: 1)
* Component ID: `6370` (Required: 1)

## 7. API / Data Mapping
* API ID: `4967` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `np_workflow_runtime`
* **Test Name**: `Nurse Practitioner (NP) Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Nurse Practitioner (NP) Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `np`)
2. **visit** (Selector: `None`, Value: `/rn/np-workflow`)
3. **should_be_visible** (Selector: `np_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `np_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `np_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
