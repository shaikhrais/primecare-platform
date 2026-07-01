# SCREEN DATA CONTEXT: local_marketing_manager_workflow

Below are the database records from `governance.db` used to configure and build the **Local Marketing Manager - LocalMarketingManagerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `209`
* **App ID**: `1`
* **Role ID**: `39`
* **Screen Code**: `local_marketing_manager_workflow`
* **Screen Name**: `LocalMarketingManagerWorkflowScreen`
* **Route Path**: `/management/local-marketing-manager-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/local_marketing_manager_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `39`
* **Role Code**: `local_marketing`
* **Role Name**: `Local Marketing Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Local Marketing Manager personnel to oversee, audit, and coordinate operations related to localmarketingmanagerworkflowscreen.`
* **User Story**: `As a Local Marketing Manager, I want to access the LocalMarketingManagerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LocalMarketingManagerWorkflowScreen`
* **Acceptance Criteria**:
- The LocalMarketingManagerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Local Marketing Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `local_marketing_manager_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `local_marketing_manager_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `local_marketing_manager_workflow-content` (Type: layout, Required: 1)
* **localmarketingmanagerworkflow_title** -> `localmarketingmanagerworkflow-title` (Type: header, Required: 0)
* **localmarketingmanagerworkflow_screen** -> `localmarketingmanagerworkflow-screen` (Type: layout, Required: 0)
* **localmarketingmanagerworkflow_content** -> `localmarketingmanagerworkflow-content` (Type: layout, Required: 0)
* **localmarketingmanagerworkflow_btn_1** -> `localmarketingmanagerworkflow-btn-1` (Type: button, Required: 0)
* **localmarketingmanagerworkflow_btn_2** -> `localmarketingmanagerworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `217` (Required: 1)
* Component ID: `751` (Required: 1)
* Component ID: `1285` (Required: 1)
* Component ID: `3443` (Required: 1)
* Component ID: `3444` (Required: 1)
* Component ID: `3445` (Required: 1)
* Component ID: `3446` (Required: 1)
* Component ID: `3447` (Required: 1)
* Component ID: `3448` (Required: 1)
* Component ID: `3449` (Required: 1)
* Component ID: `3450` (Required: 1)

## 7. API / Data Mapping
* API ID: `4498` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `local_marketing_manager_workflow_runtime`
* **Test Name**: `LocalMarketingManagerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Local Marketing Manager Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `local_marketing`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Local Marketing Manager Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Local Marketing Manager Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/local-marketing-manager-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
