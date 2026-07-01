# SCREEN DATA CONTEXT: cfo_workflow

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `155`
* **App ID**: `1`
* **Role ID**: `21`
* **Screen Code**: `cfo_workflow`
* **Screen Name**: `CfoWorkflowScreen`
* **Route Path**: `/executive/cfo-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `21`
* **Role Code**: `cfo`
* **Role Name**: `Chief Financial Officer (CFO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfoworkflowscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoWorkflowScreen`
* **Acceptance Criteria**:
- The CfoWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_workflow-content` (Type: layout, Required: 1)
* **cfoworkflow_screen** -> `cfoworkflow-screen` (Type: layout, Required: 0)
* **cfoworkflow_btn_2** -> `cfoworkflow-btn-2` (Type: button, Required: 0)
* **cfoworkflow_title** -> `cfoworkflow-title` (Type: header, Required: 0)
* **cfoworkflow_btn_1** -> `cfoworkflow-btn-1` (Type: button, Required: 0)
* **cfoworkflow_content** -> `cfoworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `163` (Required: 1)
* Component ID: `697` (Required: 1)
* Component ID: `1231` (Required: 1)
* Component ID: `2930` (Required: 1)
* Component ID: `2931` (Required: 1)
* Component ID: `2932` (Required: 1)
* Component ID: `2933` (Required: 1)
* Component ID: `2934` (Required: 1)
* Component ID: `2935` (Required: 1)
* Component ID: `2936` (Required: 1)
* Component ID: `2937` (Required: 1)
* Component ID: `2938` (Required: 1)
* Component ID: `2939` (Required: 1)

## 7. API / Data Mapping
* API ID: `4438` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_workflow_runtime`
* **Test Name**: `CfoWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/cfo-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
