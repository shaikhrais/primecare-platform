# SCREEN DATA CONTEXT: clinic_workflow

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `97`
* **App ID**: `1`
* **Role ID**: `6`
* **Screen Code**: `clinic_workflow`
* **Screen Name**: `ClinicWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/clinic-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/clinic_workflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicworkflowscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicWorkflowScreen`
* **Acceptance Criteria**:
- The ClinicWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinic_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `clinic_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `clinic_workflow-content` (Type: layout, Required: 1)
* **clinicworkflow_screen** -> `clinicworkflow-screen` (Type: layout, Required: 0)
* **clinicworkflow_content** -> `clinicworkflow-content` (Type: layout, Required: 0)
* **clinicworkflow_btn_1** -> `clinicworkflow-btn-1` (Type: button, Required: 0)
* **clinicworkflow_title** -> `clinicworkflow-title` (Type: header, Required: 0)
* **clinicworkflow_btn_2** -> `clinicworkflow-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `105` (Required: 1)
* Component ID: `639` (Required: 1)
* Component ID: `1173` (Required: 1)
* Component ID: `2445` (Required: 1)
* Component ID: `2446` (Required: 1)
* Component ID: `2447` (Required: 1)
* Component ID: `2448` (Required: 1)
* Component ID: `2449` (Required: 1)
* Component ID: `2450` (Required: 1)
* Component ID: `2451` (Required: 1)
* Component ID: `2452` (Required: 1)
* Component ID: `2453` (Required: 1)
* Component ID: `2454` (Required: 1)

## 7. API / Data Mapping
* API ID: `4374` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinic_workflow_runtime`
* **Test Name**: `ClinicWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinic Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinic Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinic Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/clinic-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
