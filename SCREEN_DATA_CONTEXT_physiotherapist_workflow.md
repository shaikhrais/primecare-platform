# SCREEN DATA CONTEXT: physiotherapist_workflow

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `130`
* **App ID**: `1`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_workflow`
* **Screen Name**: `PhysiotherapistWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistworkflowscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistWorkflowScreen`
* **Acceptance Criteria**:
- The PhysiotherapistWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_workflow-content` (Type: layout, Required: 1)
* **physiotherapistworkflow_screen** -> `physiotherapistworkflow-screen` (Type: layout, Required: 0)
* **physiotherapistworkflow_content** -> `physiotherapistworkflow-content` (Type: layout, Required: 0)
* **physiotherapistworkflow_title** -> `physiotherapistworkflow-title` (Type: header, Required: 0)
* **physiotherapistworkflow_btn_2** -> `physiotherapistworkflow-btn-2` (Type: button, Required: 0)
* **physiotherapistworkflow_btn_1** -> `physiotherapistworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `138` (Required: 1)
* Component ID: `672` (Required: 1)
* Component ID: `1206` (Required: 1)
* Component ID: `2705` (Required: 1)
* Component ID: `2706` (Required: 1)
* Component ID: `2707` (Required: 1)
* Component ID: `2708` (Required: 1)
* Component ID: `2709` (Required: 1)
* Component ID: `2710` (Required: 1)
* Component ID: `2711` (Required: 1)
* Component ID: `2712` (Required: 1)

## 7. API / Data Mapping
* API ID: `4413` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_workflow_runtime`
* **Test Name**: `PhysiotherapistWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysiotherapistWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/workflow`)
3. **should_be_visible** (Selector: `physiotherapist_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physiotherapist_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `physiotherapist_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
