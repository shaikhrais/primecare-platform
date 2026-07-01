# SCREEN DATA CONTEXT: therapist_workflow

Below are the database records from `governance.db` used to configure and build the **Therapist - TherapistComplianceWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `598`
* **App ID**: `1`
* **Role ID**: `5`
* **Screen Code**: `therapist_workflow`
* **Screen Name**: `TherapistComplianceWorkflowScreen`
* **Route Path**: `/offices/clinical/roles/therapist/workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/therapist_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `5`
* **Role Code**: `therapist`
* **Role Name**: `Therapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Therapist personnel to oversee, audit, and coordinate operations related to therapist compliance workflow.`
* **User Story**: `As a Therapist, I want to access the Therapist Compliance Workflow within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Therapist Compliance Workflow`
* **Acceptance Criteria**:
- The Therapist Compliance Workflow route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Therapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `therapist_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `therapist_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `therapist_workflow-content` (Type: layout, Required: 1)
* **therapist compliance workflow_btn_2** -> `therapist compliance workflow-btn-2` (Type: button, Required: 0)
* **therapist compliance workflow_screen** -> `therapist compliance workflow-screen` (Type: layout, Required: 0)
* **therapist compliance workflow_btn_3** -> `therapist compliance workflow-btn-3` (Type: button, Required: 0)
* **therapist compliance workflow_btn_1** -> `therapist compliance workflow-btn-1` (Type: button, Required: 0)
* **therapist compliance workflow_title** -> `therapist compliance workflow-title` (Type: header, Required: 0)
* **therapist compliance workflow_content** -> `therapist compliance workflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `522` (Required: 1)
* Component ID: `1056` (Required: 1)
* Component ID: `1590` (Required: 1)
* Component ID: `6232` (Required: 1)
* Component ID: `6233` (Required: 1)
* Component ID: `6234` (Required: 1)
* Component ID: `6235` (Required: 1)
* Component ID: `6236` (Required: 1)
* Component ID: `6237` (Required: 1)
* Component ID: `6238` (Required: 1)
* Component ID: `6239` (Required: 1)

## 7. API / Data Mapping
* API ID: `4947` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `therapist_workflow_runtime`
* **Test Name**: `Therapist Compliance Workflow Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Therapist Compliance Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `therapist`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Therapist Compliance Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Therapist Compliance Workflow`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/therapist/workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
