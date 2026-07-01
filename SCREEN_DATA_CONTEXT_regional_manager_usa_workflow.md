# SCREEN DATA CONTEXT: regional_manager_usa_workflow

Below are the database records from `governance.db` used to configure and build the **Regional Manager USA - RegionalManagerUsaWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `221`
* **App ID**: `1`
* **Role ID**: `43`
* **Screen Code**: `regional_manager_usa_workflow`
* **Screen Name**: `RegionalManagerUsaWorkflowScreen`
* **Route Path**: `/management/regional-manager-usa-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `43`
* **Role Code**: `regional_manager_usa`
* **Role Name**: `Regional Manager USA`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional Manager USA personnel to oversee, audit, and coordinate operations related to regionalmanagerusaworkflowscreen.`
* **User Story**: `As a Regional Manager USA, I want to access the RegionalManagerUsaWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalManagerUsaWorkflowScreen`
* **Acceptance Criteria**:
- The RegionalManagerUsaWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional Manager USA access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_manager_usa_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_manager_usa_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `regional_manager_usa_workflow-content` (Type: layout, Required: 1)
* **regionalmanagerusaworkflow_btn_2** -> `regionalmanagerusaworkflow-btn-2` (Type: button, Required: 0)
* **regionalmanagerusaworkflow_screen** -> `regionalmanagerusaworkflow-screen` (Type: layout, Required: 0)
* **regionalmanagerusaworkflow_content** -> `regionalmanagerusaworkflow-content` (Type: layout, Required: 0)
* **regionalmanagerusaworkflow_title** -> `regionalmanagerusaworkflow-title` (Type: header, Required: 0)
* **regionalmanagerusaworkflow_btn_1** -> `regionalmanagerusaworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `229` (Required: 1)
* Component ID: `763` (Required: 1)
* Component ID: `1297` (Required: 1)
* Component ID: `3553` (Required: 1)
* Component ID: `3554` (Required: 1)
* Component ID: `3555` (Required: 1)
* Component ID: `3556` (Required: 1)
* Component ID: `3557` (Required: 1)
* Component ID: `3558` (Required: 1)
* Component ID: `3559` (Required: 1)
* Component ID: `3560` (Required: 1)
* Component ID: `3561` (Required: 1)

## 7. API / Data Mapping
* API ID: `4510` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_manager_usa_workflow_runtime`
* **Test Name**: `RegionalManagerUsaWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional Manager Usa Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_manager_usa`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Regional Manager Usa Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Regional Manager Usa Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/regional-manager-usa-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
