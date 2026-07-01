# SCREEN DATA CONTEXT: workflow_execution

Below are the database records from `governance.db` used to configure and build the **Governance Officer - WorkflowExecutionScreen** screen.

---

## 1. Screen Record
* **ID**: `590`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `workflow_execution`
* **Screen Name**: `WorkflowExecutionScreen`
* **Route Path**: `/common/workflow-execution`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/workflow_execution_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to workflowexecutionscreen.`
* **User Story**: `As a Governance Officer, I want to access the WorkflowExecutionScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `WorkflowExecutionScreen`
* **Acceptance Criteria**:
- The WorkflowExecutionScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `workflow_execution-screen` (Type: layout, Required: 1)
* **page_title** -> `workflow_execution-title` (Type: header, Required: 1)
* **primary_content** -> `workflow_execution-content` (Type: layout, Required: 1)
* **workflowexecution_loading** -> `workflowexecution-loading` (Type: loading, Required: 0)
* **workflowexecution_title** -> `workflowexecution-title` (Type: header, Required: 0)
* **workflowexecution_btn_2** -> `workflowexecution-btn-2` (Type: button, Required: 0)
* **workflowexecution_btn_1** -> `workflowexecution-btn-1` (Type: button, Required: 0)
* **workflowexecution_screen** -> `workflowexecution-screen` (Type: layout, Required: 0)
* **workflowexecution_content** -> `workflowexecution-content` (Type: layout, Required: 0)
* **workflowexecution_btn_3** -> `workflowexecution-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `514` (Required: 1)
* Component ID: `1048` (Required: 1)
* Component ID: `1582` (Required: 1)
* Component ID: `6153` (Required: 1)
* Component ID: `6154` (Required: 1)
* Component ID: `6155` (Required: 1)
* Component ID: `6156` (Required: 1)
* Component ID: `6157` (Required: 1)
* Component ID: `6158` (Required: 1)
* Component ID: `6159` (Required: 1)
* Component ID: `6160` (Required: 1)
* Component ID: `6161` (Required: 1)
* Component ID: `6162` (Required: 1)

## 7. API / Data Mapping
* API ID: `4939` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `workflow_execution_runtime`
* **Test Name**: `WorkflowExecutionScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Workflow Execution`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Workflow Execution`)
4. **click_sidebar_link** (Selector: `None`, Value: `Workflow Execution`)
5. **check_url** (Selector: `None`, Value: `/common/workflow-execution`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
