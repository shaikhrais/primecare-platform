# SCREEN DATA CONTEXT: regional_bdm_workflow

Below are the database records from `governance.db` used to configure and build the **Regional BDM - RegionalBdmWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `218`
* **App ID**: `1`
* **Role ID**: `42`
* **Screen Code**: `regional_bdm_workflow`
* **Screen Name**: `RegionalBdmWorkflowScreen`
* **Route Path**: `/management/regional-bdm-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_bdm_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `42`
* **Role Code**: `regional_bdm`
* **Role Name**: `Regional BDM`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional BDM personnel to oversee, audit, and coordinate operations related to regionalbdmworkflowscreen.`
* **User Story**: `As a Regional BDM, I want to access the RegionalBdmWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalBdmWorkflowScreen`
* **Acceptance Criteria**:
- The RegionalBdmWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional BDM access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_workflow-content` (Type: layout, Required: 1)
* **regionalbdmworkflow_title** -> `regionalbdmworkflow-title` (Type: header, Required: 0)
* **regionalbdmworkflow_screen** -> `regionalbdmworkflow-screen` (Type: layout, Required: 0)
* **regionalbdmworkflow_btn_2** -> `regionalbdmworkflow-btn-2` (Type: button, Required: 0)
* **regionalbdmworkflow_content** -> `regionalbdmworkflow-content` (Type: layout, Required: 0)
* **regionalbdmworkflow_btn_1** -> `regionalbdmworkflow-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `226` (Required: 1)
* Component ID: `760` (Required: 1)
* Component ID: `1294` (Required: 1)
* Component ID: `3525` (Required: 1)
* Component ID: `3526` (Required: 1)
* Component ID: `3527` (Required: 1)
* Component ID: `3528` (Required: 1)
* Component ID: `3529` (Required: 1)
* Component ID: `3530` (Required: 1)
* Component ID: `3531` (Required: 1)
* Component ID: `3532` (Required: 1)
* Component ID: `3533` (Required: 1)
* Component ID: `3534` (Required: 1)

## 7. API / Data Mapping
* API ID: `4507` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_workflow_runtime`
* **Test Name**: `RegionalBdmWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Regional BDM Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_bdm`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Regional BDM Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Regional BDM Workflow`)
5. **check_url** (Selector: `None`, Value: `/management/regional-bdm-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
