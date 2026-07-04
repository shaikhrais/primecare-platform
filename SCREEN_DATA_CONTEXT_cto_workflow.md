# SCREEN DATA CONTEXT: cto_workflow

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - CtoWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `164`
* **App ID**: `1`
* **Role ID**: `24`
* **Screen Code**: `cto_workflow`
* **Screen Name**: `CtoWorkflowScreen`
* **Route Path**: `/executive/cto-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cto_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to ctoworkflowscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the CtoWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CtoWorkflowScreen`
* **Acceptance Criteria**:
- The CtoWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `cto_workflow-content` (Type: layout, Required: 1)
* **ctoworkflow_content** -> `ctoworkflow-content` (Type: layout, Required: 0)
* **ctoworkflow_btn_2** -> `ctoworkflow-btn-2` (Type: button, Required: 0)
* **ctoworkflow_btn_1** -> `ctoworkflow-btn-1` (Type: button, Required: 0)
* **ctoworkflow_title** -> `ctoworkflow-title` (Type: header, Required: 0)
* **ctoworkflow_screen** -> `ctoworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `172` (Required: 1)
* Component ID: `706` (Required: 1)
* Component ID: `1240` (Required: 1)
* Component ID: `3020` (Required: 1)
* Component ID: `3021` (Required: 1)
* Component ID: `3022` (Required: 1)
* Component ID: `3023` (Required: 1)
* Component ID: `3024` (Required: 1)
* Component ID: `3025` (Required: 1)
* Component ID: `3026` (Required: 1)
* Component ID: `3027` (Required: 1)
* Component ID: `3028` (Required: 1)
* Component ID: `3029` (Required: 1)

## 7. API / Data Mapping
* API ID: `4453` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_workflow_runtime`
* **Test Name**: `CtoWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CtoWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **visit** (Selector: `None`, Value: `/executive/cto-workflow`)
3. **should_be_visible** (Selector: `cto_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
