# SCREEN DATA CONTEXT: franchise_sales_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseSalesManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `194`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_sales_manager_workflow`
* **Screen Name**: `FranchiseSalesManagerWorkflowScreen`
* **Route Path**: `/management/franchise-sales-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_workflow_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisesalesmanagerworkflowscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseSalesManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseSalesManagerWorkflowScreen`
* **Acceptance Criteria**:
- The FranchiseSalesManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_workflow-content` (Type: layout, Required: 1)
* **franchisesalesmanagerworkflow_btn_2** -> `franchisesalesmanagerworkflow-btn-2` (Type: button, Required: 0)
* **franchisesalesmanagerworkflow_title** -> `franchisesalesmanagerworkflow-title` (Type: header, Required: 0)
* **franchisesalesmanagerworkflow_screen** -> `franchisesalesmanagerworkflow-screen` (Type: layout, Required: 0)
* **franchisesalesmanagerworkflow_content** -> `franchisesalesmanagerworkflow-content` (Type: layout, Required: 0)
* **franchisesalesmanagerworkflow_btn_1** -> `franchisesalesmanagerworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `202` (Required: 1)
* Component ID: `736` (Required: 1)
* Component ID: `1270` (Required: 1)
* Component ID: `3293` (Required: 1)
* Component ID: `3294` (Required: 1)
* Component ID: `3295` (Required: 1)
* Component ID: `3296` (Required: 1)
* Component ID: `3297` (Required: 1)
* Component ID: `3298` (Required: 1)
* Component ID: `3299` (Required: 1)
* Component ID: `3300` (Required: 1)
* Component ID: `3301` (Required: 1)
* Component ID: `3302` (Required: 1)

## 7. API / Data Mapping
* API ID: `4483` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_workflow_runtime`
* **Test Name**: `FranchiseSalesManagerWorkflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseSalesManagerWorkflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/management/franchise-sales-manager-workflow`)
3. **should_be_visible** (Selector: `franchise_sales_manager_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_sales_manager_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_sales_manager_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
