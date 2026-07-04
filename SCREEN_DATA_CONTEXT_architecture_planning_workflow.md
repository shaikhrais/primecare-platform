# SCREEN DATA CONTEXT: architecture_planning_workflow

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - ArchitecturePlanningWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `88`
* **App ID**: `1`
* **Role ID**: `17`
* **Screen Code**: `architecture_planning_workflow`
* **Screen Name**: `ArchitecturePlanningWorkflowScreen`
* **Route Path**: `/common/architecture-planning-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `17`
* **Role Code**: `infrastructure`
* **Role Name**: `Infrastructure Auditor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to architectureplanningworkflowscreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the ArchitecturePlanningWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ArchitecturePlanningWorkflowScreen`
* **Acceptance Criteria**:
- The ArchitecturePlanningWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `architecture_planning_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `architecture_planning_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `architecture_planning_workflow-content` (Type: layout, Required: 1)
* **architectureplanningworkflow_title** -> `architectureplanningworkflow-title` (Type: header, Required: 0)
* **architectureplanningworkflow_btn_1** -> `architectureplanningworkflow-btn-1` (Type: button, Required: 0)
* **architectureplanningworkflow_screen** -> `architectureplanningworkflow-screen` (Type: layout, Required: 0)
* **architectureplanningworkflow_btn_2** -> `architectureplanningworkflow-btn-2` (Type: button, Required: 0)
* **architectureplanningworkflow_content** -> `architectureplanningworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `96` (Required: 1)
* Component ID: `630` (Required: 1)
* Component ID: `1164` (Required: 1)
* Component ID: `2361` (Required: 1)
* Component ID: `2362` (Required: 1)
* Component ID: `2363` (Required: 1)
* Component ID: `2364` (Required: 1)
* Component ID: `2365` (Required: 1)
* Component ID: `2366` (Required: 1)
* Component ID: `2367` (Required: 1)
* Component ID: `2368` (Required: 1)
* Component ID: `2369` (Required: 1)
* Component ID: `2370` (Required: 1)

## 7. API / Data Mapping
* API ID: `4365` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `architecture_planning_workflow_runtime`
* **Test Name**: `ArchitecturePlanningWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ArchitecturePlanningWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/architecture-planning-workflow`)
3. **should_be_visible** (Selector: `architecture_planning_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `architecture_planning_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `architecture_planning_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
