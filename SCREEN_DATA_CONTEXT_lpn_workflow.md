# SCREEN DATA CONTEXT: lpn_workflow

Below are the database records from `governance.db` used to configure and build the **Licensed Practical Nurse (LPN) - LicensedPracticalNurseLPNComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `616`
* **App ID**: `1`
* **Role ID**: `56`
* **Screen Code**: `lpn_workflow`
* **Screen Name**: `LicensedPracticalNurseLPNComplianceWorkflowScreen`
* **Route Path**: `/rpn/lpn-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/lpn_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `56`
* **Role Code**: `lpn`
* **Role Name**: `Licensed Practical Nurse (LPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Licensed Practical Nurse (LPN) personnel to oversee, audit, and coordinate operations related to licensed practical nurse (lpn) compliance workflow.`
* **User Story**: `As a Licensed Practical Nurse (LPN), I want to access the Licensed Practical Nurse (LPN) Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Licensed Practical Nurse (LPN) Compliance Workflow`
* **Acceptance Criteria**:
- The Licensed Practical Nurse (LPN) Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Licensed Practical Nurse (LPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `lpn_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `lpn_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `lpn_workflow-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `540` (Required: 1)
* Component ID: `1074` (Required: 1)
* Component ID: `1608` (Required: 1)
* Component ID: `6381` (Required: 1)
* Component ID: `6382` (Required: 1)
* Component ID: `6383` (Required: 1)
* Component ID: `6384` (Required: 1)
* Component ID: `6385` (Required: 1)
* Component ID: `6386` (Required: 1)
* Component ID: `6387` (Required: 1)
* Component ID: `6388` (Required: 1)
* Component ID: `6389` (Required: 1)
* Component ID: `6390` (Required: 1)

## 7. API / Data Mapping
* API ID: `4969` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `lpn_workflow_runtime`
* **Test Name**: `Licensed Practical Nurse (LPN) Compliance Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Licensed Practical Nurse (LPN) Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `lpn`)
2. **visit** (Selector: `None`, Value: `/rpn/lpn-workflow`)
3. **should_be_visible** (Selector: `lpn_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `lpn_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `lpn_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
