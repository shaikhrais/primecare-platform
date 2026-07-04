# SCREEN DATA CONTEXT: pediatric_workflow

Below are the database records from `governance.db` used to configure and build the **Pediatric Specialist - PediatricSpecialistComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `604`
* **App ID**: `1`
* **Role ID**: `11`
* **Screen Code**: `pediatric_workflow`
* **Screen Name**: `PediatricSpecialistComplianceWorkflowScreen`
* **Route Path**: `/clinical/pediatric-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/pediatric_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `11`
* **Role Code**: `pediatric`
* **Role Name**: `Pediatric Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Pediatric Specialist personnel to oversee, audit, and coordinate operations related to pediatric specialist compliance workflow.`
* **User Story**: `As a Pediatric Specialist, I want to access the Pediatric Specialist Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Pediatric Specialist Compliance Workflow`
* **Acceptance Criteria**:
- The Pediatric Specialist Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Pediatric Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `pediatric_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `pediatric_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `pediatric_workflow-content` (Type: layout, Required: 1)
* **pediatric specialist compliance workflow_content** -> `pediatric specialist compliance workflow-content` (Type: layout, Required: 0)
* **pediatric specialist compliance workflow_title** -> `pediatric specialist compliance workflow-title` (Type: header, Required: 0)
* **pediatric specialist compliance workflow_screen** -> `pediatric specialist compliance workflow-screen` (Type: layout, Required: 0)
* **pediatric specialist compliance workflow_btn_1** -> `pediatric specialist compliance workflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `528` (Required: 1)
* Component ID: `1062` (Required: 1)
* Component ID: `1596` (Required: 1)
* Component ID: `6282` (Required: 1)
* Component ID: `6283` (Required: 1)
* Component ID: `6284` (Required: 1)
* Component ID: `6285` (Required: 1)
* Component ID: `6286` (Required: 1)
* Component ID: `6287` (Required: 1)
* Component ID: `6288` (Required: 1)

## 7. API / Data Mapping
* API ID: `4953` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `pediatric_workflow_runtime`
* **Test Name**: `Pediatric Specialist Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Pediatric Specialist Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `pediatric`)
2. **visit** (Selector: `None`, Value: `/clinical/pediatric-workflow`)
3. **should_be_visible** (Selector: `pediatric_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `pediatric_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `pediatric_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
