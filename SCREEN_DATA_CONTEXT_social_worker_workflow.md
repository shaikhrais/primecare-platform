# SCREEN DATA CONTEXT: social_worker_workflow

Below are the database records from `governance.db` used to configure and build the **Social Worker - SocialWorkerWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `140`
* **App ID**: `1`
* **Role ID**: `4`
* **Screen Code**: `social_worker_workflow`
* **Screen Name**: `SocialWorkerWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/social_worker/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/social_worker_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `4`
* **Role Code**: `social_worker`
* **Role Name**: `Social Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Social Worker personnel to oversee, audit, and coordinate operations related to socialworkerworkflowscreen.`
* **User Story**: `As a Social Worker, I want to access the SocialWorkerWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SocialWorkerWorkflowScreen`
* **Acceptance Criteria**:
- The SocialWorkerWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Social Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `social_worker_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `social_worker_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `social_worker_workflow-content` (Type: layout, Required: 1)
* **socialworkerworkflow_btn_1** -> `socialworkerworkflow-btn-1` (Type: button, Required: 0)
* **socialworkerworkflow_screen** -> `socialworkerworkflow-screen` (Type: layout, Required: 0)
* **socialworkerworkflow_btn_2** -> `socialworkerworkflow-btn-2` (Type: button, Required: 0)
* **socialworkerworkflow_content** -> `socialworkerworkflow-content` (Type: layout, Required: 0)
* **socialworkerworkflow_title** -> `socialworkerworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `148` (Required: 1)
* Component ID: `682` (Required: 1)
* Component ID: `1216` (Required: 1)
* Component ID: `2796` (Required: 1)
* Component ID: `2797` (Required: 1)
* Component ID: `2798` (Required: 1)
* Component ID: `2799` (Required: 1)
* Component ID: `2800` (Required: 1)
* Component ID: `2801` (Required: 1)
* Component ID: `2802` (Required: 1)
* Component ID: `2803` (Required: 1)
* Component ID: `2804` (Required: 1)
* Component ID: `2805` (Required: 1)
* Component ID: `2806` (Required: 1)

## 7. API / Data Mapping
* API ID: `4423` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `social_worker_workflow_runtime`
* **Test Name**: `SocialWorkerWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Social Worker Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `social_worker`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Social Worker Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Social Worker Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/social_worker/workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
