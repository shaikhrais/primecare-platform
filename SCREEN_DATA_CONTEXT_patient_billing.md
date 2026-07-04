# SCREEN DATA CONTEXT: patient_billing

Below are the database records from `governance.db` used to configure and build the **Patient - PatientBillingScreen** screen.

---

## 1. Screen Record
* **ID**: `333`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_billing`
* **Screen Name**: `PatientBillingScreen`
* **Route Path**: `/common/patient-billing`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_billing_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientbillingscreen.`
* **User Story**: `As a Patient, I want to access the PatientBillingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientBillingScreen`
* **Acceptance Criteria**:
- The PatientBillingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_billing-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_billing-title` (Type: header, Required: 1)
* **primary_content** -> `patient_billing-content` (Type: layout, Required: 1)
* **patientbilling_btn_2** -> `patientbilling-btn-2` (Type: button, Required: 0)
* **patientbilling_btn_1** -> `patientbilling-btn-1` (Type: button, Required: 0)
* **patientbilling_content** -> `patientbilling-content` (Type: layout, Required: 0)
* **patientbilling_btn_3** -> `patientbilling-btn-3` (Type: button, Required: 0)
* **patientbilling_screen** -> `patientbilling-screen` (Type: layout, Required: 0)
* **patientbilling_title** -> `patientbilling-title` (Type: header, Required: 0)
* **patientbilling_loading** -> `patientbilling-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `341` (Required: 1)
* Component ID: `875` (Required: 1)
* Component ID: `1409` (Required: 1)
* Component ID: `4552` (Required: 1)
* Component ID: `4553` (Required: 1)
* Component ID: `4554` (Required: 1)
* Component ID: `4555` (Required: 1)
* Component ID: `4556` (Required: 1)

## 7. API / Data Mapping
* API ID: `4662` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_billing_runtime`
* **Test Name**: `PatientBillingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientBillingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/patient-billing`)
3. **should_be_visible** (Selector: `patient_billing-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_billing-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_billing-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
