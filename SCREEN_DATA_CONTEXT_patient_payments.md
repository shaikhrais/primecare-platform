# SCREEN DATA CONTEXT: patient_payments

Below are the database records from `governance.db` used to configure and build the **Guest - PatientPaymentsScreen** screen.

---

## 1. Screen Record
* **ID**: `676`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_payments`
* **Screen Name**: `PatientPaymentsScreen`
* **Route Path**: `/offices/client/roles/client/payments`
* **Actual File Path**: `apps/primecare_client/lib/features/patient/screens/patient_payments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient payments.`
* **User Story**: `As a Guest, I want to access the Patient Payments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient Payments`
* **Acceptance Criteria**:
- The Patient Payments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_payments-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_payments-title` (Type: header, Required: 1)
* **primary_content** -> `patient_payments-content` (Type: layout, Required: 1)
* **patientpaymentsscreen_screen** -> `patientpaymentsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6710` (Required: 1)
* Component ID: `6711` (Required: 1)
* Component ID: `6712` (Required: 1)
* Component ID: `6713` (Required: 1)
* Component ID: `6714` (Required: 1)

## 7. API / Data Mapping
* API ID: `5038` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_payments_runtime`
* **Test Name**: `Patient Payments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Payments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/client/payments`)
3. **should_be_visible** (Selector: `patient_payments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_payments-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_payments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
