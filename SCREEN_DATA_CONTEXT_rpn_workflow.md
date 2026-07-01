# SCREEN DATA CONTEXT: rpn_workflow

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `246`
* **App ID**: `1`
* **Role ID**: `55`
* **Screen Code**: `rpn_workflow`
* **Screen Name**: `RpnWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpnworkflowscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnWorkflowScreen`
* **Acceptance Criteria**:
- The RpnWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_workflow-content` (Type: layout, Required: 1)
* **rpn_workflow_screen_textfield_input_1** -> `rpn_workflow_screen_textfield_input_1` (Type: field, Required: 0)
* **rpn_workflow_screen_textfield_input_2** -> `rpn_workflow_screen_textfield_input_2` (Type: field, Required: 0)
* **rpnworkflow_btn_2** -> `rpnworkflow-btn-2` (Type: button, Required: 0)
* **rpnworkflow_content** -> `rpnworkflow-content` (Type: layout, Required: 0)
* **rpnworkflow_loading** -> `rpnworkflow-loading` (Type: loading, Required: 0)
* **rpn_workflow_screen_textfield_input_5** -> `rpn_workflow_screen_textfield_input_5` (Type: field, Required: 0)
* **rpnworkflow_btn_3** -> `rpnworkflow-btn-3` (Type: button, Required: 0)
* **rpn_workflow_screen_textfield_input_4** -> `rpn_workflow_screen_textfield_input_4` (Type: field, Required: 0)
* **rpnworkflow_title** -> `rpnworkflow-title` (Type: header, Required: 0)
* **rpnworkflow_btn_1** -> `rpnworkflow-btn-1` (Type: button, Required: 0)
* **rpnworkflow_screen** -> `rpnworkflow-screen` (Type: layout, Required: 0)
* **rpn_workflow_screen_textfield_input_3** -> `rpn_workflow_screen_textfield_input_3` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `254` (Required: 1)
* Component ID: `788` (Required: 1)
* Component ID: `1322` (Required: 1)
* Component ID: `3780` (Required: 1)
* Component ID: `3781` (Required: 1)
* Component ID: `3782` (Required: 1)
* Component ID: `3783` (Required: 1)
* Component ID: `3784` (Required: 1)
* Component ID: `3785` (Required: 1)
* Component ID: `3786` (Required: 1)
* Component ID: `3787` (Required: 1)
* Component ID: `3788` (Required: 1)
* Component ID: `3789` (Required: 1)

## 7. API / Data Mapping
* API ID: `4557` (Required: 1)
* API ID: `4558` (Required: 1)
* API ID: `4559` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_workflow_runtime`
* **Test Name**: `RpnWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
