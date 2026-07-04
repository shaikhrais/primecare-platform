# SCREEN DATA CONTEXT: patient_appointments

Below are the database records from `governance.db` used to configure and build the **Patient - PatientAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `329`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_appointments`
* **Screen Name**: `PatientAppointmentsScreen`
* **Route Path**: `/common/patient-appointments`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_appointments_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientappointmentsscreen.`
* **User Story**: `As a Patient, I want to access the PatientAppointmentsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientAppointmentsScreen`
* **Acceptance Criteria**:
- The PatientAppointmentsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `patient_appointments-content` (Type: layout, Required: 1)
* **patientappointments_screen** -> `patientappointments-screen` (Type: layout, Required: 0)
* **patientappointments_title** -> `patientappointments-title` (Type: header, Required: 0)
* **patientappointments_btn_2** -> `patientappointments-btn-2` (Type: button, Required: 0)
* **patientappointments_btn_1** -> `patientappointments-btn-1` (Type: button, Required: 0)
* **patientappointments_btn_3** -> `patientappointments-btn-3` (Type: button, Required: 0)
* **patientappointments_content** -> `patientappointments-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `337` (Required: 1)
* Component ID: `871` (Required: 1)
* Component ID: `1405` (Required: 1)
* Component ID: `4530` (Required: 1)
* Component ID: `4531` (Required: 1)
* Component ID: `4532` (Required: 1)
* Component ID: `4533` (Required: 1)
* Component ID: `4534` (Required: 1)

## 7. API / Data Mapping
* API ID: `4658` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_appointments_runtime`
* **Test Name**: `PatientAppointmentsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientAppointmentsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/patient-appointments`)
3. **should_be_visible** (Selector: `patient_appointments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_appointments-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_appointments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
