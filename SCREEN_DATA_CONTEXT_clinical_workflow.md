# SCREEN DATA CONTEXT: clinical_workflow

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `81`
* **App ID**: `1`
* **Role ID**: `6`
* **Screen Code**: `clinical_workflow`
* **Screen Name**: `ClinicalWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicalworkflowscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalWorkflowScreen`
* **Acceptance Criteria**:
- The ClinicalWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_workflow-content` (Type: layout, Required: 1)
* **clinicalworkflow_btn_2** -> `clinicalworkflow-btn-2` (Type: button, Required: 0)
* **clinicalworkflow_btn_1** -> `clinicalworkflow-btn-1` (Type: button, Required: 0)
* **clinicalworkflow_content** -> `clinicalworkflow-content` (Type: layout, Required: 0)
* **clinicalworkflow_screen** -> `clinicalworkflow-screen` (Type: layout, Required: 0)
* **clinicalworkflow_title** -> `clinicalworkflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `89` (Required: 1)
* Component ID: `623` (Required: 1)
* Component ID: `1157` (Required: 1)
* Component ID: `2305` (Required: 1)
* Component ID: `2306` (Required: 1)
* Component ID: `2307` (Required: 1)
* Component ID: `2308` (Required: 1)
* Component ID: `2309` (Required: 1)
* Component ID: `2310` (Required: 1)
* Component ID: `2311` (Required: 1)
* Component ID: `2312` (Required: 1)
* Component ID: `2313` (Required: 1)
* Component ID: `2314` (Required: 1)

## 7. API / Data Mapping
* API ID: `4352` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_workflow_runtime`
* **Test Name**: `ClinicalWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
