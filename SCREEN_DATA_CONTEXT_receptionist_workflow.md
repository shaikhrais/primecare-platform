# SCREEN DATA CONTEXT: receptionist_workflow

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - ReceptionistWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `268`
* **App ID**: `1`
* **Role ID**: `59`
* **Screen Code**: `receptionist_workflow`
* **Screen Name**: `ReceptionistWorkflowScreen`
* **Route Path**: `/staff/receptionist-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/receptionist_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to receptionistworkflowscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the ReceptionistWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReceptionistWorkflowScreen`
* **Acceptance Criteria**:
- The ReceptionistWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_workflow-content` (Type: layout, Required: 1)
* **receptionistworkflow_btn_3** -> `receptionistworkflow-btn-3` (Type: button, Required: 0)
* **receptionistworkflow_title** -> `receptionistworkflow-title` (Type: header, Required: 0)
* **receptionistworkflow_screen** -> `receptionistworkflow-screen` (Type: layout, Required: 0)
* **receptionistworkflow_content** -> `receptionistworkflow-content` (Type: layout, Required: 0)
* **receptionistworkflow_btn_2** -> `receptionistworkflow-btn-2` (Type: button, Required: 0)
* **receptionistworkflow_btn_1** -> `receptionistworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `276` (Required: 1)
* Component ID: `810` (Required: 1)
* Component ID: `1344` (Required: 1)
* Component ID: `3990` (Required: 1)
* Component ID: `3991` (Required: 1)
* Component ID: `3992` (Required: 1)
* Component ID: `3993` (Required: 1)
* Component ID: `3994` (Required: 1)
* Component ID: `3995` (Required: 1)
* Component ID: `3996` (Required: 1)
* Component ID: `3997` (Required: 1)
* Component ID: `3998` (Required: 1)
* Component ID: `3999` (Required: 1)

## 7. API / Data Mapping
* API ID: `4589` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_workflow_runtime`
* **Test Name**: `ReceptionistWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Receptionist Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Receptionist Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Receptionist Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/receptionist-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
