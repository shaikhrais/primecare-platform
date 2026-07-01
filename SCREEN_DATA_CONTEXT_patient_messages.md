# SCREEN DATA CONTEXT: patient_messages

Below are the database records from `governance.db` used to configure and build the **Patient - PatientMessagesScreen** screen.

---

## 1. Screen Record
* **ID**: `331`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_messages`
* **Screen Name**: `PatientMessagesScreen`
* **Route Path**: `/common/patient-messages`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_messages_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientmessagesscreen.`
* **User Story**: `As a Patient, I want to access the PatientMessagesScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientMessagesScreen`
* **Acceptance Criteria**:
- The PatientMessagesScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_messages-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_messages-title` (Type: header, Required: 1)
* **primary_content** -> `patient_messages-content` (Type: layout, Required: 1)
* **patientmessages_loading** -> `patientmessages-loading` (Type: loading, Required: 0)
* **patientmessages_btn_2** -> `patientmessages-btn-2` (Type: button, Required: 0)
* **patientmessages_title** -> `patientmessages-title` (Type: header, Required: 0)
* **patientmessages_content** -> `patientmessages-content` (Type: layout, Required: 0)
* **patientmessages_screen** -> `patientmessages-screen` (Type: layout, Required: 0)
* **patientmessages_btn_1** -> `patientmessages-btn-1` (Type: button, Required: 0)
* **patientmessages_btn_3** -> `patientmessages-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `339` (Required: 1)
* Component ID: `873` (Required: 1)
* Component ID: `1407` (Required: 1)
* Component ID: `4540` (Required: 1)
* Component ID: `4541` (Required: 1)
* Component ID: `4542` (Required: 1)
* Component ID: `4543` (Required: 1)
* Component ID: `4544` (Required: 1)
* Component ID: `4545` (Required: 1)
* Component ID: `4546` (Required: 1)

## 7. API / Data Mapping
* API ID: `4660` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_messages_runtime`
* **Test Name**: `PatientMessagesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Messages`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Messages`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Messages`)
5. **check_url** (Selector: `None`, Value: `/common/patient-messages`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
