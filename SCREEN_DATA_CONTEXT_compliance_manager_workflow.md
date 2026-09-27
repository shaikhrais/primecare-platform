# SCREEN DATA CONTEXT: compliance_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `191`
* **App ID**: `1`
* **Role ID**: `33`
* **Screen Code**: `compliance_manager_workflow`
* **Screen Name**: `ComplianceManagerWorkflowScreen`
* **Route Path**: `/management/compliance-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancemanagerworkflowscreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceManagerWorkflowScreen`
* **Acceptance Criteria**:
- The ComplianceManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_workflow-content` (Type: layout, Required: 1)
* **compliancemanagerworkflow_title** -> `compliancemanagerworkflow-title` (Type: header, Required: 0)
* **compliancemanagerworkflow_btn_1** -> `compliancemanagerworkflow-btn-1` (Type: button, Required: 0)
* **compliancemanagerworkflow_btn_2** -> `compliancemanagerworkflow-btn-2` (Type: button, Required: 0)
* **compliancemanagerworkflow_screen** -> `compliancemanagerworkflow-screen` (Type: layout, Required: 0)
* **compliancemanagerworkflow_content** -> `compliancemanagerworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `199` (Required: 1)
* Component ID: `733` (Required: 1)
* Component ID: `1267` (Required: 1)
* Component ID: `3263` (Required: 1)
* Component ID: `3264` (Required: 1)
* Component ID: `3265` (Required: 1)
* Component ID: `3266` (Required: 1)
* Component ID: `3267` (Required: 1)
* Component ID: `3268` (Required: 1)
* Component ID: `3269` (Required: 1)
* Component ID: `3270` (Required: 1)
* Component ID: `3271` (Required: 1)
* Component ID: `3272` (Required: 1)

## 7. API / Data Mapping
* API ID: `4480` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_workflow_runtime`
* **Test Name**: `ComplianceManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ComplianceManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **visit** (Selector: `None`, Value: `/management/compliance-manager-workflow`)
3. **should_be_visible** (Selector: `compliance_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `compliance_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
