# SCREEN DATA CONTEXT: cns_workflow

Below are the database records from `governance.db` used to configure and build the **Clinical Nurse Specialist - ClinicalNurseSpecialistComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `602`
* **App ID**: `1`
* **Role ID**: `10`
* **Screen Code**: `cns_workflow`
* **Screen Name**: `ClinicalNurseSpecialistComplianceWorkflowScreen`
* **Route Path**: `/rn/cns-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/cns_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `10`
* **Role Code**: `cns`
* **Role Name**: `Clinical Nurse Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Nurse Specialist personnel to oversee, audit, and coordinate operations related to clinical nurse specialist compliance workflow.`
* **User Story**: `As a Clinical Nurse Specialist, I want to access the Clinical Nurse Specialist Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Nurse Specialist Compliance Workflow`
* **Acceptance Criteria**:
- The Clinical Nurse Specialist Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Nurse Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cns_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `cns_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `cns_workflow-content` (Type: layout, Required: 1)
* **clinical nurse specialist compliance workflow_title** -> `clinical nurse specialist compliance workflow-title` (Type: header, Required: 0)
* **clinical nurse specialist compliance workflow_screen** -> `clinical nurse specialist compliance workflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `526` (Required: 1)
* Component ID: `1060` (Required: 1)
* Component ID: `1594` (Required: 1)
* Component ID: `6267` (Required: 1)
* Component ID: `6268` (Required: 1)
* Component ID: `6269` (Required: 1)
* Component ID: `6270` (Required: 1)
* Component ID: `6271` (Required: 1)
* Component ID: `6272` (Required: 1)
* Component ID: `6273` (Required: 1)
* Component ID: `6274` (Required: 1)

## 7. API / Data Mapping
* API ID: `4951` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cns_workflow_runtime`
* **Test Name**: `Clinical Nurse Specialist Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Nurse Specialist Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cns`)
2. **visit** (Selector: `None`, Value: `/rn/cns-workflow`)
3. **should_be_visible** (Selector: `cns_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cns_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `cns_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
