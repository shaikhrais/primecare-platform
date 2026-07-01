# SCREEN DATA CONTEXT: owner_workflow

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - OwnerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `179`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `owner_workflow`
* **Screen Name**: `OwnerWorkflowScreen`
* **Route Path**: `/executive/owner-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/owner_workflow_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to ownerworkflowscreen.`
* **User Story**: `As a Franchise Owner, I want to access the OwnerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OwnerWorkflowScreen`
* **Acceptance Criteria**:
- The OwnerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `owner_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `owner_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `owner_workflow-content` (Type: layout, Required: 1)
* **ownerworkflow_btn_2** -> `ownerworkflow-btn-2` (Type: button, Required: 0)
* **ownerworkflow_btn_1** -> `ownerworkflow-btn-1` (Type: button, Required: 0)
* **ownerworkflow_content** -> `ownerworkflow-content` (Type: layout, Required: 0)
* **ownerworkflow_title** -> `ownerworkflow-title` (Type: header, Required: 0)
* **ownerworkflow_screen** -> `ownerworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `187` (Required: 1)
* Component ID: `721` (Required: 1)
* Component ID: `1255` (Required: 1)
* Component ID: `3169` (Required: 1)
* Component ID: `3170` (Required: 1)
* Component ID: `3171` (Required: 1)
* Component ID: `3172` (Required: 1)
* Component ID: `3173` (Required: 1)
* Component ID: `3174` (Required: 1)
* Component ID: `3175` (Required: 1)
* Component ID: `3176` (Required: 1)
* Component ID: `3177` (Required: 1)
* Component ID: `3178` (Required: 1)

## 7. API / Data Mapping
* API ID: `4468` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `owner_workflow_runtime`
* **Test Name**: `OwnerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Owner Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Owner Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Owner Workflow`)
5. **check_url** (Selector: `None`, Value: `/executive/owner-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
