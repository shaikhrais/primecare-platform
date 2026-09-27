# SCREEN DATA CONTEXT: general_manager_workflow

Below are the database records from `governance.db` used to configure and build the **General Manager - GeneralManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `197`
* **App ID**: `1`
* **Role ID**: `35`
* **Screen Code**: `general_manager_workflow`
* **Screen Name**: `GeneralManagerWorkflowScreen`
* **Route Path**: `/management/general-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/general_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `35`
* **Role Code**: `gm`
* **Role Name**: `General Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanagerworkflowscreen.`
* **User Story**: `As a General Manager, I want to access the GeneralManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GeneralManagerWorkflowScreen`
* **Acceptance Criteria**:
- The GeneralManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only General Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `general_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `general_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `general_manager_workflow-content` (Type: layout, Required: 1)
* **generalmanagerworkflow_screen** -> `generalmanagerworkflow-screen` (Type: layout, Required: 0)
* **generalmanagerworkflow_content** -> `generalmanagerworkflow-content` (Type: layout, Required: 0)
* **generalmanagerworkflow_btn_1** -> `generalmanagerworkflow-btn-1` (Type: button, Required: 0)
* **generalmanagerworkflow_btn_2** -> `generalmanagerworkflow-btn-2` (Type: button, Required: 0)
* **generalmanagerworkflow_btn_3** -> `generalmanagerworkflow-btn-3` (Type: button, Required: 0)
* **generalmanagerworkflow_title** -> `generalmanagerworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `205` (Required: 1)
* Component ID: `739` (Required: 1)
* Component ID: `1273` (Required: 1)
* Component ID: `3323` (Required: 1)
* Component ID: `3324` (Required: 1)
* Component ID: `3325` (Required: 1)
* Component ID: `3326` (Required: 1)
* Component ID: `3327` (Required: 1)
* Component ID: `3328` (Required: 1)
* Component ID: `3329` (Required: 1)
* Component ID: `3330` (Required: 1)
* Component ID: `3331` (Required: 1)
* Component ID: `3332` (Required: 1)

## 7. API / Data Mapping
* API ID: `4486` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `general_manager_workflow_runtime`
* **Test Name**: `GeneralManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GeneralManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `gm`)
2. **visit** (Selector: `None`, Value: `/management/general-manager-workflow`)
3. **should_be_visible** (Selector: `general_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `general_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `general_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
