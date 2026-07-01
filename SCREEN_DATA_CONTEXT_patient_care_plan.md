# SCREEN DATA CONTEXT: patient_care_plan

Below are the database records from `governance.db` used to configure and build the **Patient - PatientCarePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `330`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_care_plan`
* **Screen Name**: `PatientCarePlanScreen`
* **Route Path**: `/common/patient-care-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_care_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientcareplanscreen.`
* **User Story**: `As a Patient, I want to access the PatientCarePlanScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientCarePlanScreen`
* **Acceptance Criteria**:
- The PatientCarePlanScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_care_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_care_plan-title` (Type: header, Required: 1)
* **primary_content** -> `patient_care_plan-content` (Type: layout, Required: 1)
* **patientcareplan_btn_2** -> `patientcareplan-btn-2` (Type: button, Required: 0)
* **patientcareplan_loading** -> `patientcareplan-loading` (Type: loading, Required: 0)
* **patientcareplan_btn_3** -> `patientcareplan-btn-3` (Type: button, Required: 0)
* **patientcareplan_title** -> `patientcareplan-title` (Type: header, Required: 0)
* **patientcareplan_content** -> `patientcareplan-content` (Type: layout, Required: 0)
* **patientcareplan_btn_1** -> `patientcareplan-btn-1` (Type: button, Required: 0)
* **patientcareplan_screen** -> `patientcareplan-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `338` (Required: 1)
* Component ID: `872` (Required: 1)
* Component ID: `1406` (Required: 1)
* Component ID: `4535` (Required: 1)
* Component ID: `4536` (Required: 1)
* Component ID: `4537` (Required: 1)
* Component ID: `4538` (Required: 1)
* Component ID: `4539` (Required: 1)

## 7. API / Data Mapping
* API ID: `4659` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_care_plan_runtime`
* **Test Name**: `PatientCarePlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Care Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Care Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Care Plan`)
5. **check_url** (Selector: `None`, Value: `/common/patient-care-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
