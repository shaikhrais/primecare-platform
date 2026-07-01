# SCREEN DATA CONTEXT: qa_workflow

Below are the database records from `governance.db` used to configure and build the **QA Specialist - QaWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `136`
* **App ID**: `1`
* **Role ID**: `63`
* **Screen Code**: `qa_workflow`
* **Screen Name**: `QaWorkflowScreen`
* **Route Path**: `/common/qa-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/qa_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `63`
* **Role Code**: `qa_specialist`
* **Role Name**: `QA Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable QA Specialist personnel to oversee, audit, and coordinate operations related to qaworkflowscreen.`
* **User Story**: `As a QA Specialist, I want to access the QaWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `QaWorkflowScreen`
* **Acceptance Criteria**:
- The QaWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only QA Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `qa_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `qa_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `qa_workflow-content` (Type: layout, Required: 1)
* **qaworkflow_btn_1** -> `qaworkflow-btn-1` (Type: button, Required: 0)
* **qaworkflow_btn_2** -> `qaworkflow-btn-2` (Type: button, Required: 0)
* **qaworkflow_content** -> `qaworkflow-content` (Type: layout, Required: 0)
* **qaworkflow_title** -> `qaworkflow-title` (Type: header, Required: 0)
* **qaworkflow_screen** -> `qaworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `144` (Required: 1)
* Component ID: `678` (Required: 1)
* Component ID: `1212` (Required: 1)
* Component ID: `2764` (Required: 1)
* Component ID: `2765` (Required: 1)
* Component ID: `2766` (Required: 1)
* Component ID: `2767` (Required: 1)
* Component ID: `2768` (Required: 1)
* Component ID: `2769` (Required: 1)
* Component ID: `2770` (Required: 1)
* Component ID: `2771` (Required: 1)
* Component ID: `2772` (Required: 1)

## 7. API / Data Mapping
* API ID: `4419` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `qa_workflow_runtime`
* **Test Name**: `QaWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `QA Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `qa_specialist`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `QA Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `QA Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/qa-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
