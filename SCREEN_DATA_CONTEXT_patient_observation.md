# SCREEN DATA CONTEXT: patient_observation

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - PatientObservationScreen** screen.

---

## 1. Screen Record
* **ID**: `532`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `patient_observation`
* **Screen Name**: `PatientObservationScreen`
* **Route Path**: `/offices/clinical/roles/rpn/patient-observation`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/patient_observation_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to patientobservationscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the PatientObservationScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientObservationScreen`
* **Acceptance Criteria**:
- The PatientObservationScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_observation-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_observation-title` (Type: header, Required: 1)
* **primary_content** -> `patient_observation-content` (Type: layout, Required: 1)
* **patientobservation_screen** -> `patientobservation-screen` (Type: layout, Required: 0)
* **patientobservation_btn_3** -> `patientobservation-btn-3` (Type: button, Required: 0)
* **patientobservation_title** -> `patientobservation-title` (Type: header, Required: 0)
* **patientobservation_content** -> `patientobservation-content` (Type: layout, Required: 0)
* **patientobservation_btn_1** -> `patientobservation-btn-1` (Type: button, Required: 0)
* **patientobservation_btn_2** -> `patientobservation-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `460` (Required: 1)
* Component ID: `994` (Required: 1)
* Component ID: `1528` (Required: 1)
* Component ID: `5682` (Required: 1)
* Component ID: `5683` (Required: 1)
* Component ID: `5684` (Required: 1)
* Component ID: `5685` (Required: 1)
* Component ID: `5686` (Required: 1)
* Component ID: `5687` (Required: 1)
* Component ID: `5688` (Required: 1)
* Component ID: `5689` (Required: 1)
* Component ID: `5690` (Required: 1)
* Component ID: `5691` (Required: 1)

## 7. API / Data Mapping
* API ID: `4861` (Required: 1)
* API ID: `4862` (Required: 1)
* API ID: `4863` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_observation_runtime`
* **Test Name**: `PatientObservationScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientObservationScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rpn/patient-observation`)
3. **should_be_visible** (Selector: `patient_observation-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_observation-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_observation-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
