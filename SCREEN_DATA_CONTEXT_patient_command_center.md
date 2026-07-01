# SCREEN DATA CONTEXT: patient_command_center

Below are the database records from `governance.db` used to configure and build the **Patient - PatientCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `328`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_command_center`
* **Screen Name**: `PatientCommandCenterScreen`
* **Route Path**: `/common/patient-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_command_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientcommandcenterscreen.`
* **User Story**: `As a Patient, I want to access the PatientCommandCenterScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientCommandCenterScreen`
* **Acceptance Criteria**:
- The PatientCommandCenterScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `patient_command_center-content` (Type: layout, Required: 1)
* **patientcommandcenter_screen** -> `patientcommandcenter-screen` (Type: layout, Required: 0)
* **patientcommandcenter_btn_1** -> `patientcommandcenter-btn-1` (Type: button, Required: 0)
* **patientcommandcenter_title** -> `patientcommandcenter-title` (Type: header, Required: 0)
* **patientcommandcenter_content** -> `patientcommandcenter-content` (Type: layout, Required: 0)
* **patientcommandcenter_btn_2** -> `patientcommandcenter-btn-2` (Type: button, Required: 0)
* **patientcommandcenter_btn_3** -> `patientcommandcenter-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `336` (Required: 1)
* Component ID: `870` (Required: 1)
* Component ID: `1404` (Required: 1)
* Component ID: `4519` (Required: 1)
* Component ID: `4520` (Required: 1)
* Component ID: `4521` (Required: 1)
* Component ID: `4522` (Required: 1)
* Component ID: `4523` (Required: 1)
* Component ID: `4524` (Required: 1)
* Component ID: `4525` (Required: 1)
* Component ID: `4526` (Required: 1)
* Component ID: `4527` (Required: 1)
* Component ID: `4528` (Required: 1)
* Component ID: `4529` (Required: 1)

## 7. API / Data Mapping
* API ID: `4657` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_command_center_runtime`
* **Test Name**: `PatientCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Command Center`)
5. **check_url** (Selector: `None`, Value: `/common/patient-command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
