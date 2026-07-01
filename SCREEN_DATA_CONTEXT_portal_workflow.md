# SCREEN DATA CONTEXT: portal_workflow

Below are the database records from `governance.db` used to configure and build the **Portal User - PortalWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `133`
* **App ID**: `1`
* **Role ID**: `14`
* **Screen Code**: `portal_workflow`
* **Screen Name**: `PortalWorkflowScreen`
* **Route Path**: `/common/portal-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/portal_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `14`
* **Role Code**: `portal`
* **Role Name**: `Portal User`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Portal User personnel to oversee, audit, and coordinate operations related to portalworkflowscreen.`
* **User Story**: `As a Portal User, I want to access the PortalWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PortalWorkflowScreen`
* **Acceptance Criteria**:
- The PortalWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Portal User access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `portal_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `portal_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `portal_workflow-content` (Type: layout, Required: 1)
* **portalworkflow_title** -> `portalworkflow-title` (Type: header, Required: 0)
* **portalworkflow_btn_1** -> `portalworkflow-btn-1` (Type: button, Required: 0)
* **portalworkflow_btn_2** -> `portalworkflow-btn-2` (Type: button, Required: 0)
* **portalworkflow_btn_3** -> `portalworkflow-btn-3` (Type: button, Required: 0)
* **portalworkflow_screen** -> `portalworkflow-screen` (Type: layout, Required: 0)
* **portalworkflow_loading** -> `portalworkflow-loading` (Type: loading, Required: 0)
* **portalworkflow_content** -> `portalworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `141` (Required: 1)
* Component ID: `675` (Required: 1)
* Component ID: `1209` (Required: 1)
* Component ID: `2734` (Required: 1)
* Component ID: `2735` (Required: 1)
* Component ID: `2736` (Required: 1)
* Component ID: `2737` (Required: 1)
* Component ID: `2738` (Required: 1)
* Component ID: `2739` (Required: 1)
* Component ID: `2740` (Required: 1)
* Component ID: `2741` (Required: 1)
* Component ID: `2742` (Required: 1)
* Component ID: `2743` (Required: 1)
* Component ID: `2744` (Required: 1)

## 7. API / Data Mapping
* API ID: `4416` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `portal_workflow_runtime`
* **Test Name**: `PortalWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Portal Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `portal`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Portal Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Portal Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/portal-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
