# SCREEN DATA CONTEXT: rn_field_supervisor_workflow

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) Field Supervisor - RegisteredNurseRNFieldSupervisorComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `612`
* **App ID**: `1`
* **Role ID**: `53`
* **Screen Code**: `rn_field_supervisor_workflow`
* **Screen Name**: `RegisteredNurseRNFieldSupervisorComplianceWorkflowScreen`
* **Route Path**: `/rn/rn-field-supervisor-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_field_supervisor_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `53`
* **Role Code**: `rn_field_supervisor`
* **Role Name**: `Registered Nurse (RN) Field Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) Field Supervisor personnel to oversee, audit, and coordinate operations related to registered nurse (rn) field supervisor compliance workflow.`
* **User Story**: `As a Registered Nurse (RN) Field Supervisor, I want to access the Registered Nurse (RN) Field Supervisor Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Registered Nurse (RN) Field Supervisor Compliance Workflow`
* **Acceptance Criteria**:
- The Registered Nurse (RN) Field Supervisor Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) Field Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_field_supervisor_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_field_supervisor_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `rn_field_supervisor_workflow-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `536` (Required: 1)
* Component ID: `1070` (Required: 1)
* Component ID: `1604` (Required: 1)
* Component ID: `6340` (Required: 1)
* Component ID: `6341` (Required: 1)
* Component ID: `6342` (Required: 1)
* Component ID: `6343` (Required: 1)
* Component ID: `6344` (Required: 1)
* Component ID: `6345` (Required: 1)
* Component ID: `6346` (Required: 1)
* Component ID: `6347` (Required: 1)
* Component ID: `6348` (Required: 1)
* Component ID: `6349` (Required: 1)

## 7. API / Data Mapping
* API ID: `4963` (Required: 1)
* API ID: `4964` (Required: 1)
* API ID: `4965` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_field_supervisor_workflow_runtime`
* **Test Name**: `Registered Nurse (RN) Field Supervisor Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Registered Nurse (RN) Field Supervisor Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn_field_supervisor`)
2. **visit** (Selector: `None`, Value: `/rn/rn-field-supervisor-workflow`)
3. **should_be_visible** (Selector: `rn_field_supervisor_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_field_supervisor_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_field_supervisor_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
