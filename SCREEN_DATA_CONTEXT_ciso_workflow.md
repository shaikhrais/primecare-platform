# SCREEN DATA CONTEXT: ciso_workflow

Below are the database records from `governance.db` used to configure and build the **Chief Information Security Officer (CISO) - CisoWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `158`
* **App ID**: `1`
* **Role ID**: `22`
* **Screen Code**: `ciso_workflow`
* **Screen Name**: `CisoWorkflowScreen`
* **Route Path**: `/executive/ciso-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/ciso_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `22`
* **Role Code**: `ciso`
* **Role Name**: `Chief Information Security Officer (CISO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Information Security Officer (CISO) personnel to oversee, audit, and coordinate operations related to cisoworkflowscreen.`
* **User Story**: `As a Chief Information Security Officer (CISO), I want to access the CisoWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CisoWorkflowScreen`
* **Acceptance Criteria**:
- The CisoWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Information Security Officer (CISO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ciso_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `ciso_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `ciso_workflow-content` (Type: layout, Required: 1)
* **cisoworkflow_btn_3** -> `cisoworkflow-btn-3` (Type: button, Required: 0)
* **cisoworkflow_screen** -> `cisoworkflow-screen` (Type: layout, Required: 0)
* **cisoworkflow_content** -> `cisoworkflow-content` (Type: layout, Required: 0)
* **cisoworkflow_btn_2** -> `cisoworkflow-btn-2` (Type: button, Required: 0)
* **cisoworkflow_loading** -> `cisoworkflow-loading` (Type: loading, Required: 0)
* **cisoworkflow_btn_1** -> `cisoworkflow-btn-1` (Type: button, Required: 0)
* **cisoworkflow_title** -> `cisoworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `166` (Required: 1)
* Component ID: `700` (Required: 1)
* Component ID: `1234` (Required: 1)
* Component ID: `2960` (Required: 1)
* Component ID: `2961` (Required: 1)
* Component ID: `2962` (Required: 1)
* Component ID: `2963` (Required: 1)
* Component ID: `2964` (Required: 1)
* Component ID: `2965` (Required: 1)
* Component ID: `2966` (Required: 1)
* Component ID: `2967` (Required: 1)
* Component ID: `2968` (Required: 1)
* Component ID: `2969` (Required: 1)

## 7. API / Data Mapping
* API ID: `4445` (Required: 1)
* API ID: `4446` (Required: 1)
* API ID: `4447` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ciso_workflow_runtime`
* **Test Name**: `CisoWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ciso Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ciso`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Ciso Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Ciso Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/ciso-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
