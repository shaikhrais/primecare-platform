# SCREEN DATA CONTEXT: patient_book_appointment

Below are the database records from `governance.db` used to configure and build the **Guest - PatientBookAppointmentScreen** screen.

---

## 1. Screen Record
* **ID**: `673`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_book_appointment`
* **Screen Name**: `PatientBookAppointmentScreen`
* **Route Path**: `/offices/client/roles/client/book-appointment`
* **Actual File Path**: `apps/primecare_client/lib/features/patient/screens/patient_book_appointment_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient book appointment.`
* **User Story**: `As a Guest, I want to access the Patient Book Appointment within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient Book Appointment`
* **Acceptance Criteria**:
- The Patient Book Appointment route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_book_appointment-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_book_appointment-title` (Type: header, Required: 1)
* **primary_content** -> `patient_book_appointment-content` (Type: layout, Required: 1)
* **patientbookappointmentscreen_screen** -> `patientbookappointmentscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6695` (Required: 1)
* Component ID: `6696` (Required: 1)
* Component ID: `6697` (Required: 1)
* Component ID: `6698` (Required: 1)
* Component ID: `6699` (Required: 1)

## 7. API / Data Mapping
* API ID: `5035` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_book_appointment_runtime`
* **Test Name**: `Patient Book Appointment Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Book Appointment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/client/book-appointment`)
3. **should_be_visible** (Selector: `patient_book_appointment-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_book_appointment-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_book_appointment-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
