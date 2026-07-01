# SCREEN DATA CONTEXT: scrum_master_workflow

Below are the database records from `governance.db` used to configure and build the **Scrum Master - ScrumMasterWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `224`
* **App ID**: `1`
* **Role ID**: `44`
* **Screen Code**: `scrum_master_workflow`
* **Screen Name**: `ScrumMasterWorkflowScreen`
* **Route Path**: `/management/scrum-master-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scrum_master_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `44`
* **Role Code**: `scrum_master`
* **Role Name**: `Scrum Master`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Scrum Master personnel to oversee, audit, and coordinate operations related to scrummasterworkflowscreen.`
* **User Story**: `As a Scrum Master, I want to access the ScrumMasterWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScrumMasterWorkflowScreen`
* **Acceptance Criteria**:
- The ScrumMasterWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Scrum Master access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scrum_master_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `scrum_master_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `scrum_master_workflow-content` (Type: layout, Required: 1)
* **scrummasterworkflow_btn_2** -> `scrummasterworkflow-btn-2` (Type: button, Required: 0)
* **scrummasterworkflow_btn_1** -> `scrummasterworkflow-btn-1` (Type: button, Required: 0)
* **scrummasterworkflow_btn_3** -> `scrummasterworkflow-btn-3` (Type: button, Required: 0)
* **scrummasterworkflow_loading** -> `scrummasterworkflow-loading` (Type: loading, Required: 0)
* **scrummasterworkflow_title** -> `scrummasterworkflow-title` (Type: header, Required: 0)
* **scrummasterworkflow_content** -> `scrummasterworkflow-content` (Type: layout, Required: 0)
* **scrummasterworkflow_screen** -> `scrummasterworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `232` (Required: 1)
* Component ID: `766` (Required: 1)
* Component ID: `1300` (Required: 1)
* Component ID: `3582` (Required: 1)
* Component ID: `3583` (Required: 1)
* Component ID: `3584` (Required: 1)
* Component ID: `3585` (Required: 1)
* Component ID: `3586` (Required: 1)
* Component ID: `3587` (Required: 1)
* Component ID: `3588` (Required: 1)
* Component ID: `3589` (Required: 1)
* Component ID: `3590` (Required: 1)
* Component ID: `3591` (Required: 1)

## 7. API / Data Mapping
* API ID: `4513` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scrum_master_workflow_runtime`
* **Test Name**: `ScrumMasterWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scrum Master Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scrum_master`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scrum Master Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scrum Master Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/scrum-master-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
