# SCREEN DATA CONTEXT: territory_sales_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Territory Sales Manager - TerritorySalesManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `230`
* **App ID**: `1`
* **Role ID**: `47`
* **Screen Code**: `territory_sales_manager_workflow`
* **Screen Name**: `TerritorySalesManagerWorkflowScreen`
* **Route Path**: `/management/territory-sales-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_sales_manager_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `47`
* **Role Code**: `territory_sales`
* **Role Name**: `Territory Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Territory Sales Manager personnel to oversee, audit, and coordinate operations related to territorysalesmanagerworkflowscreen.`
* **User Story**: `As a Territory Sales Manager, I want to access the TerritorySalesManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritorySalesManagerWorkflowScreen`
* **Acceptance Criteria**:
- The TerritorySalesManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_workflow-content` (Type: layout, Required: 1)
* **territorysalesmanagerworkflow_btn_1** -> `territorysalesmanagerworkflow-btn-1` (Type: button, Required: 0)
* **territorysalesmanagerworkflow_content** -> `territorysalesmanagerworkflow-content` (Type: layout, Required: 0)
* **territorysalesmanagerworkflow_title** -> `territorysalesmanagerworkflow-title` (Type: header, Required: 0)
* **territorysalesmanagerworkflow_screen** -> `territorysalesmanagerworkflow-screen` (Type: layout, Required: 0)
* **territorysalesmanagerworkflow_btn_2** -> `territorysalesmanagerworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `238` (Required: 1)
* Component ID: `772` (Required: 1)
* Component ID: `1306` (Required: 1)
* Component ID: `3636` (Required: 1)
* Component ID: `3637` (Required: 1)
* Component ID: `3638` (Required: 1)
* Component ID: `3639` (Required: 1)
* Component ID: `3640` (Required: 1)
* Component ID: `3641` (Required: 1)
* Component ID: `3642` (Required: 1)
* Component ID: `3643` (Required: 1)
* Component ID: `3644` (Required: 1)
* Component ID: `3645` (Required: 1)

## 7. API / Data Mapping
* API ID: `4519` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_workflow_runtime`
* **Test Name**: `TerritorySalesManagerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Sales Manager Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_sales`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Territory Sales Manager Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Territory Sales Manager Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/territory-sales-manager-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
