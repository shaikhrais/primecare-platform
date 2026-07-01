# SCREEN DATA CONTEXT: psw_workflow

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `238`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_workflow`
* **Screen Name**: `PswWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/psw/psw-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswworkflowscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswWorkflowScreen`
* **Acceptance Criteria**:
- The PswWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `psw_workflow-content` (Type: layout, Required: 1)
* **pswworkflow_screen** -> `pswworkflow-screen` (Type: layout, Required: 0)
* **pswworkflow_loading** -> `pswworkflow-loading` (Type: loading, Required: 0)
* **psw_workflow_screen_textfield_input_4** -> `psw_workflow_screen_textfield_input_4` (Type: field, Required: 0)
* **pswworkflow_content** -> `pswworkflow-content` (Type: layout, Required: 0)
* **pswworkflow_title** -> `pswworkflow-title` (Type: header, Required: 0)
* **psw_workflow_screen_textfield_input_2** -> `psw_workflow_screen_textfield_input_2` (Type: field, Required: 0)
* **psw_workflow_screen_textfield_input_5** -> `psw_workflow_screen_textfield_input_5` (Type: field, Required: 0)
* **pswworkflow_btn_2** -> `pswworkflow-btn-2` (Type: button, Required: 0)
* **pswworkflow_btn_1** -> `pswworkflow-btn-1` (Type: button, Required: 0)
* **psw_workflow_screen_textfield_input_1** -> `psw_workflow_screen_textfield_input_1` (Type: field, Required: 0)
* **psw_workflow_screen_textfield_input_3** -> `psw_workflow_screen_textfield_input_3` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `246` (Required: 1)
* Component ID: `780` (Required: 1)
* Component ID: `1314` (Required: 1)
* Component ID: `3704` (Required: 1)
* Component ID: `3705` (Required: 1)
* Component ID: `3706` (Required: 1)
* Component ID: `3707` (Required: 1)
* Component ID: `3708` (Required: 1)
* Component ID: `3709` (Required: 1)
* Component ID: `3710` (Required: 1)
* Component ID: `3711` (Required: 1)

## 7. API / Data Mapping
* API ID: `4533` (Required: 1)
* API ID: `4534` (Required: 1)
* API ID: `4535` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_workflow_runtime`
* **Test Name**: `PswWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/psw-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
