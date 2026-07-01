# SCREEN DATA CONTEXT: patient_treatment_history

Below are the database records from `governance.db` used to configure and build the **Guest - PatientTreatmentHistoryScreen** screen.

---

## 1. Screen Record
* **ID**: `677`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_treatment_history`
* **Screen Name**: `PatientTreatmentHistoryScreen`
* **Route Path**: `/offices/client/roles/client/treatment-history`
* **Actual File Path**: `apps/primecare_client/lib/features/patient/screens/patient_treatment_history_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient treatment history.`
* **User Story**: `As a Guest, I want to access the Patient Treatment History within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient Treatment History`
* **Acceptance Criteria**:
- The Patient Treatment History route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_treatment_history-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_treatment_history-title` (Type: header, Required: 1)
* **primary_content** -> `patient_treatment_history-content` (Type: layout, Required: 1)
* **patienttreatmenthistoryscreen_screen** -> `patienttreatmenthistoryscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6715` (Required: 1)
* Component ID: `6716` (Required: 1)
* Component ID: `6717` (Required: 1)
* Component ID: `6718` (Required: 1)
* Component ID: `6719` (Required: 1)

## 7. API / Data Mapping
* API ID: `5039` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_treatment_history_runtime`
* **Test Name**: `Patient Treatment History Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Treatment History`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Treatment History`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Treatment History`)
5. **check_url** (Selector: `None`, Value: `/offices/client/roles/client/treatment-history`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
