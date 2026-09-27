# SCREEN DATA CONTEXT: hr_manager_workflow

Below are the database records from `governance.db` used to configure and build the **HR Director - HrManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `259`
* **App ID**: `1`
* **Role ID**: `27`
* **Screen Code**: `hr_manager_workflow`
* **Screen Name**: `HrManagerWorkflowScreen`
* **Route Path**: `/staff/hr-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrmanagerworkflowscreen.`
* **User Story**: `As a HR Director, I want to access the HrManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrManagerWorkflowScreen`
* **Acceptance Criteria**:
- The HrManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `hr_manager_workflow-content` (Type: layout, Required: 1)
* **hrmanagerworkflow_btn_2** -> `hrmanagerworkflow-btn-2` (Type: button, Required: 0)
* **hrmanagerworkflow_content** -> `hrmanagerworkflow-content` (Type: layout, Required: 0)
* **hrmanagerworkflow_screen** -> `hrmanagerworkflow-screen` (Type: layout, Required: 0)
* **hrmanagerworkflow_title** -> `hrmanagerworkflow-title` (Type: header, Required: 0)
* **hrmanagerworkflow_btn_3** -> `hrmanagerworkflow-btn-3` (Type: button, Required: 0)
* **hrmanagerworkflow_btn_1** -> `hrmanagerworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `267` (Required: 1)
* Component ID: `801` (Required: 1)
* Component ID: `1335` (Required: 1)
* Component ID: `3906` (Required: 1)
* Component ID: `3907` (Required: 1)
* Component ID: `3908` (Required: 1)
* Component ID: `3909` (Required: 1)
* Component ID: `3910` (Required: 1)
* Component ID: `3911` (Required: 1)
* Component ID: `3912` (Required: 1)
* Component ID: `3913` (Required: 1)
* Component ID: `3914` (Required: 1)
* Component ID: `3915` (Required: 1)

## 7. API / Data Mapping
* API ID: `4574` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_manager_workflow_runtime`
* **Test Name**: `HrManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/staff/hr-manager-workflow`)
3. **should_be_visible** (Selector: `hr_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
