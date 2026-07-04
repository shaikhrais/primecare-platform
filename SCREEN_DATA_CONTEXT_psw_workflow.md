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
* **Stage/Status**: `template_created`

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
* **Test Name**: `Psw Workflow Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/psw-workflow`)
3. **should_be_visible** (Selector: `psw_workflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_workflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_workflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
