# SCREEN DATA CONTEXT: patient_my_appointments

Below are the database records from `governance.db` used to configure and build the **Guest - PatientMyAppointmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `675`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_my_appointments`
* **Screen Name**: `PatientMyAppointmentsScreen`
* **Route Path**: `/offices/client/roles/client/my-appointments`
* **Actual File Path**: `apps/primecare_client/lib/features/patient/screens/patient_my_appointments_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient my appointments.`
* **User Story**: `As a Guest, I want to access the Patient My Appointments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient My Appointments`
* **Acceptance Criteria**:
- The Patient My Appointments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_my_appointments-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_my_appointments-title` (Type: header, Required: 1)
* **primary_content** -> `patient_my_appointments-content` (Type: layout, Required: 1)
* **patientmyappointmentsscreen_screen** -> `patientmyappointmentsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6705` (Required: 1)
* Component ID: `6706` (Required: 1)
* Component ID: `6707` (Required: 1)
* Component ID: `6708` (Required: 1)
* Component ID: `6709` (Required: 1)

## 7. API / Data Mapping
* API ID: `5037` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_my_appointments_runtime`
* **Test Name**: `Patient My Appointments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient My Appointments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/client/my-appointments`)
3. **should_be_visible** (Selector: `patient_my_appointments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_my_appointments-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_my_appointments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
