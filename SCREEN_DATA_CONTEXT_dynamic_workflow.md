# SCREEN DATA CONTEXT: dynamic_workflow

Below are the database records from `governance.db` used to configure and build the **Dynamic Screen Viewer - DynamicScreenWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `106`
* **App ID**: `1`
* **Role ID**: `16`
* **Screen Code**: `dynamic_workflow`
* **Screen Name**: `DynamicScreenWorkflowScreen`
* **Route Path**: `/common/dynamic-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/dynamic_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `16`
* **Role Code**: `dynamic`
* **Role Name**: `Dynamic Screen Viewer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Dynamic Screen Viewer personnel to oversee, audit, and coordinate operations related to dynamicscreenworkflowscreen.`
* **User Story**: `As a Dynamic Screen Viewer, I want to access the DynamicScreenWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DynamicScreenWorkflowScreen`
* **Acceptance Criteria**:
- The DynamicScreenWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Dynamic Screen Viewer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `dynamic_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `dynamic_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `dynamic_workflow-content` (Type: layout, Required: 1)
* **dynamicworkflow_btn_3** -> `dynamicworkflow-btn-3` (Type: button, Required: 0)
* **dynamicworkflow_btn_1** -> `dynamicworkflow-btn-1` (Type: button, Required: 0)
* **dynamicworkflow_loading** -> `dynamicworkflow-loading` (Type: loading, Required: 0)
* **dynamicworkflow_screen** -> `dynamicworkflow-screen` (Type: layout, Required: 0)
* **dynamicworkflow_content** -> `dynamicworkflow-content` (Type: layout, Required: 0)
* **dynamicworkflow_title** -> `dynamicworkflow-title` (Type: header, Required: 0)
* **dynamicworkflow_btn_2** -> `dynamicworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `114` (Required: 1)
* Component ID: `648` (Required: 1)
* Component ID: `1182` (Required: 1)
* Component ID: `2526` (Required: 1)
* Component ID: `2527` (Required: 1)
* Component ID: `2528` (Required: 1)
* Component ID: `2529` (Required: 1)
* Component ID: `2530` (Required: 1)

## 7. API / Data Mapping
* API ID: `4383` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `dynamic_workflow_runtime`
* **Test Name**: `DynamicScreenWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Dynamic Screen Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `dynamic`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Dynamic Screen Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Dynamic Screen Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/dynamic-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
