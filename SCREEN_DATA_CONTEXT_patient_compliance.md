# SCREEN DATA CONTEXT: patient_compliance

Below are the database records from `governance.db` used to configure and build the **Patient - PatientComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `126`
* **App ID**: `1`
* **Role ID**: `15`
* **Screen Code**: `patient_compliance`
* **Screen Name**: `PatientComplianceScreen`
* **Route Path**: `/common/patient-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `15`
* **Role Code**: `patient`
* **Role Name**: `Patient`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientcompliancescreen.`
* **User Story**: `As a Patient, I want to access the PatientComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientComplianceScreen`
* **Acceptance Criteria**:
- The PatientComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `patient_compliance-content` (Type: layout, Required: 1)
* **patientcompliance_content** -> `patientcompliance-content` (Type: layout, Required: 0)
* **patientcompliance_loading** -> `patientcompliance-loading` (Type: loading, Required: 0)
* **patientcompliance_btn_1** -> `patientcompliance-btn-1` (Type: button, Required: 0)
* **patientcompliance_btn_3** -> `patientcompliance-btn-3` (Type: button, Required: 0)
* **patientcompliance_screen** -> `patientcompliance-screen` (Type: layout, Required: 0)
* **patientcompliance_title** -> `patientcompliance-title` (Type: header, Required: 0)
* **patientcompliance_btn_2** -> `patientcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `134` (Required: 1)
* Component ID: `668` (Required: 1)
* Component ID: `1202` (Required: 1)
* Component ID: `2678` (Required: 1)
* Component ID: `2679` (Required: 1)
* Component ID: `2680` (Required: 1)
* Component ID: `2681` (Required: 1)
* Component ID: `2682` (Required: 1)
* Component ID: `2683` (Required: 1)

## 7. API / Data Mapping
* API ID: `4409` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_compliance_runtime`
* **Test Name**: `PatientComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/patient-compliance`)
3. **should_be_visible** (Selector: `patient_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
