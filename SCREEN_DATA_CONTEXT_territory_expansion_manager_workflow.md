# SCREEN DATA CONTEXT: territory_expansion_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Territory Expansion Manager - TerritoryExpansionManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `227`
* **App ID**: `1`
* **Role ID**: `46`
* **Screen Code**: `territory_expansion_manager_workflow`
* **Screen Name**: `TerritoryExpansionManagerWorkflowScreen`
* **Route Path**: `/management/territory-expansion-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_expansion_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `46`
* **Role Code**: `territory_expansion`
* **Role Name**: `Territory Expansion Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Territory Expansion Manager personnel to oversee, audit, and coordinate operations related to territoryexpansionmanagerworkflowscreen.`
* **User Story**: `As a Territory Expansion Manager, I want to access the TerritoryExpansionManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritoryExpansionManagerWorkflowScreen`
* **Acceptance Criteria**:
- The TerritoryExpansionManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Expansion Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_expansion_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_expansion_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `territory_expansion_manager_workflow-content` (Type: layout, Required: 1)
* **territoryexpansionmanagerworkflow_screen** -> `territoryexpansionmanagerworkflow-screen` (Type: layout, Required: 0)
* **territoryexpansionmanagerworkflow_btn_1** -> `territoryexpansionmanagerworkflow-btn-1` (Type: button, Required: 0)
* **territoryexpansionmanagerworkflow_title** -> `territoryexpansionmanagerworkflow-title` (Type: header, Required: 0)
* **territoryexpansionmanagerworkflow_content** -> `territoryexpansionmanagerworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `235` (Required: 1)
* Component ID: `769` (Required: 1)
* Component ID: `1303` (Required: 1)
* Component ID: `3609` (Required: 1)
* Component ID: `3610` (Required: 1)
* Component ID: `3611` (Required: 1)
* Component ID: `3612` (Required: 1)
* Component ID: `3613` (Required: 1)
* Component ID: `3614` (Required: 1)
* Component ID: `3615` (Required: 1)
* Component ID: `3616` (Required: 1)

## 7. API / Data Mapping
* API ID: `4516` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_expansion_manager_workflow_runtime`
* **Test Name**: `TerritoryExpansionManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TerritoryExpansionManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_expansion`)
2. **visit** (Selector: `None`, Value: `/management/territory-expansion-manager-workflow`)
3. **should_be_visible** (Selector: `territory_expansion_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_expansion_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_expansion_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
