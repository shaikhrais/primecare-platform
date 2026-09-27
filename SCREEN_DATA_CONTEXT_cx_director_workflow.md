# SCREEN DATA CONTEXT: cx_director_workflow

Below are the database records from `governance.db` used to configure and build the **CX Director - CxDirectorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `167`
* **App ID**: `1`
* **Role ID**: `25`
* **Screen Code**: `cx_director_workflow`
* **Screen Name**: `CxDirectorWorkflowScreen`
* **Route Path**: `/executive/cx-director-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cx_director_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `25`
* **Role Code**: `cx_director`
* **Role Name**: `CX Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable CX Director personnel to oversee, audit, and coordinate operations related to cxdirectorworkflowscreen.`
* **User Story**: `As a CX Director, I want to access the CxDirectorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CxDirectorWorkflowScreen`
* **Acceptance Criteria**:
- The CxDirectorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only CX Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cx_director_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `cx_director_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `cx_director_workflow-content` (Type: layout, Required: 1)
* **cxdirectorworkflow_btn_2** -> `cxdirectorworkflow-btn-2` (Type: button, Required: 0)
* **cxdirectorworkflow_title** -> `cxdirectorworkflow-title` (Type: header, Required: 0)
* **cxdirectorworkflow_btn_3** -> `cxdirectorworkflow-btn-3` (Type: button, Required: 0)
* **cxdirectorworkflow_btn_1** -> `cxdirectorworkflow-btn-1` (Type: button, Required: 0)
* **cxdirectorworkflow_screen** -> `cxdirectorworkflow-screen` (Type: layout, Required: 0)
* **cxdirectorworkflow_content** -> `cxdirectorworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `175` (Required: 1)
* Component ID: `709` (Required: 1)
* Component ID: `1243` (Required: 1)
* Component ID: `3050` (Required: 1)
* Component ID: `3051` (Required: 1)
* Component ID: `3052` (Required: 1)
* Component ID: `3053` (Required: 1)
* Component ID: `3054` (Required: 1)
* Component ID: `3055` (Required: 1)
* Component ID: `3056` (Required: 1)
* Component ID: `3057` (Required: 1)
* Component ID: `3058` (Required: 1)
* Component ID: `3059` (Required: 1)

## 7. API / Data Mapping
* API ID: `4456` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cx_director_workflow_runtime`
* **Test Name**: `CxDirectorWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CxDirectorWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cx_director`)
2. **visit** (Selector: `None`, Value: `/executive/cx-director-workflow`)
3. **should_be_visible** (Selector: `cx_director_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cx_director_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `cx_director_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
