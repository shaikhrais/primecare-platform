# SCREEN DATA CONTEXT: rmt_workflow

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `78`
* **App ID**: `1`
* **Role ID**: `3`
* **Screen Code**: `rmt_workflow`
* **Screen Name**: `RmtWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/rmt/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtworkflowscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtWorkflowScreen`
* **Acceptance Criteria**:
- The RmtWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_workflow-content` (Type: layout, Required: 1)
* **rmtworkflow_btn_1** -> `rmtworkflow-btn-1` (Type: button, Required: 0)
* **rmtworkflow_btn_2** -> `rmtworkflow-btn-2` (Type: button, Required: 0)
* **rmtworkflow_title** -> `rmtworkflow-title` (Type: header, Required: 0)
* **rmtworkflow_content** -> `rmtworkflow-content` (Type: layout, Required: 0)
* **rmtworkflow_screen** -> `rmtworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `86` (Required: 1)
* Component ID: `620` (Required: 1)
* Component ID: `1154` (Required: 1)
* Component ID: `2275` (Required: 1)
* Component ID: `2276` (Required: 1)
* Component ID: `2277` (Required: 1)
* Component ID: `2278` (Required: 1)
* Component ID: `2279` (Required: 1)
* Component ID: `2280` (Required: 1)
* Component ID: `2281` (Required: 1)
* Component ID: `2282` (Required: 1)
* Component ID: `2283` (Required: 1)
* Component ID: `2284` (Required: 1)

## 7. API / Data Mapping
* API ID: `4347` (Required: 1)
* API ID: `4348` (Required: 1)
* API ID: `4349` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_workflow_runtime`
* **Test Name**: `RmtWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
