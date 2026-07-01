# SCREEN DATA CONTEXT: rn_workflow

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `243`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_workflow`
* **Screen Name**: `RnWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnworkflowscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnWorkflowScreen`
* **Acceptance Criteria**:
- The RnWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `rn_workflow-content` (Type: layout, Required: 1)
* **rn_workflow_screen_textfield_input_2** -> `rn_workflow_screen_textfield_input_2` (Type: field, Required: 0)
* **rnworkflow_screen** -> `rnworkflow-screen` (Type: layout, Required: 0)
* **rnworkflow_loading** -> `rnworkflow-loading` (Type: loading, Required: 0)
* **rn_workflow_screen_textfield_input_1** -> `rn_workflow_screen_textfield_input_1` (Type: field, Required: 0)
* **rnworkflow_btn_1** -> `rnworkflow-btn-1` (Type: button, Required: 0)
* **rn_workflow_screen_textfield_input_3** -> `rn_workflow_screen_textfield_input_3` (Type: field, Required: 0)
* **rnworkflow_title** -> `rnworkflow-title` (Type: header, Required: 0)
* **rnworkflow_btn_2** -> `rnworkflow-btn-2` (Type: button, Required: 0)
* **rnworkflow_content** -> `rnworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `251` (Required: 1)
* Component ID: `785` (Required: 1)
* Component ID: `1319` (Required: 1)
* Component ID: `3750` (Required: 1)
* Component ID: `3751` (Required: 1)
* Component ID: `3752` (Required: 1)
* Component ID: `3753` (Required: 1)
* Component ID: `3754` (Required: 1)
* Component ID: `3755` (Required: 1)
* Component ID: `3756` (Required: 1)
* Component ID: `3757` (Required: 1)
* Component ID: `3758` (Required: 1)
* Component ID: `3759` (Required: 1)

## 7. API / Data Mapping
* API ID: `4548` (Required: 1)
* API ID: `4549` (Required: 1)
* API ID: `4550` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_workflow_runtime`
* **Test Name**: `RnWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
