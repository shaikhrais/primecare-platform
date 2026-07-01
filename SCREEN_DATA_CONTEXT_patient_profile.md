# SCREEN DATA CONTEXT: patient_profile

Below are the database records from `governance.db` used to configure and build the **Patient - PatientProfileScreen** screen.

---

## 1. Screen Record
* **ID**: `334`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_profile`
* **Screen Name**: `PatientProfileScreen`
* **Route Path**: `/offices/client/roles/client/profile`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_profile_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientprofilescreen.`
* **User Story**: `As a Patient, I want to access the PatientProfileScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientProfileScreen`
* **Acceptance Criteria**:
- The PatientProfileScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_profile-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_profile-title` (Type: header, Required: 1)
* **primary_content** -> `patient_profile-content` (Type: layout, Required: 1)
* **patientprofile_title** -> `patientprofile-title` (Type: header, Required: 0)
* **patientprofile_screen** -> `patientprofile-screen` (Type: layout, Required: 0)
* **patientprofile_btn_1** -> `patientprofile-btn-1` (Type: button, Required: 0)
* **patientprofile_content** -> `patientprofile-content` (Type: layout, Required: 0)
* **patientprofile_btn_2** -> `patientprofile-btn-2` (Type: button, Required: 0)
* **patientprofile_loading** -> `patientprofile-loading` (Type: loading, Required: 0)
* **patientprofile_btn_3** -> `patientprofile-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `342` (Required: 1)
* Component ID: `876` (Required: 1)
* Component ID: `1410` (Required: 1)
* Component ID: `4557` (Required: 1)
* Component ID: `4558` (Required: 1)
* Component ID: `4559` (Required: 1)
* Component ID: `4560` (Required: 1)
* Component ID: `4561` (Required: 1)

## 7. API / Data Mapping
* API ID: `4663` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_profile_runtime`
* **Test Name**: `PatientProfileScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Profile`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Profile`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Profile`)
5. **check_url** (Selector: `None`, Value: `/offices/client/roles/client/profile`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
