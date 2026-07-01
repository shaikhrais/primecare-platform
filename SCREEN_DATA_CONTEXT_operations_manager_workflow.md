# SCREEN DATA CONTEXT: operations_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Operations Manager - OperationsManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `212`
* **App ID**: `1`
* **Role ID**: `40`
* **Screen Code**: `operations_manager_workflow`
* **Screen Name**: `OperationsManagerWorkflowScreen`
* **Route Path**: `/management/operations-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/operations_manager_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to operationsmanagerworkflowscreen.`
* **User Story**: `As a Operations Manager, I want to access the OperationsManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OperationsManagerWorkflowScreen`
* **Acceptance Criteria**:
- The OperationsManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `operations_manager_workflow-content` (Type: layout, Required: 1)
* **operationsmanagerworkflow_content** -> `operationsmanagerworkflow-content` (Type: layout, Required: 0)
* **operationsmanagerworkflow_screen** -> `operationsmanagerworkflow-screen` (Type: layout, Required: 0)
* **operationsmanagerworkflow_title** -> `operationsmanagerworkflow-title` (Type: header, Required: 0)
* **operationsmanagerworkflow_btn_2** -> `operationsmanagerworkflow-btn-2` (Type: button, Required: 0)
* **operationsmanagerworkflow_btn_1** -> `operationsmanagerworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `220` (Required: 1)
* Component ID: `754` (Required: 1)
* Component ID: `1288` (Required: 1)
* Component ID: `3471` (Required: 1)
* Component ID: `3472` (Required: 1)
* Component ID: `3473` (Required: 1)
* Component ID: `3474` (Required: 1)
* Component ID: `3475` (Required: 1)
* Component ID: `3476` (Required: 1)
* Component ID: `3477` (Required: 1)
* Component ID: `3478` (Required: 1)
* Component ID: `3479` (Required: 1)
* Component ID: `3480` (Required: 1)

## 7. API / Data Mapping
* API ID: `4501` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_manager_workflow_runtime`
* **Test Name**: `OperationsManagerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Manager Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Manager Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Manager Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/operations-manager-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
