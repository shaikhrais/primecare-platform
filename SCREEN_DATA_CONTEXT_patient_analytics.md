# SCREEN DATA CONTEXT: patient_analytics

Below are the database records from `governance.db` used to configure and build the **Patient - PatientAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `125`
* **App ID**: `1`
* **Role ID**: `15`
* **Screen Code**: `patient_analytics`
* **Screen Name**: `PatientAnalyticsScreen`
* **Route Path**: `/common/patient-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientanalyticsscreen.`
* **User Story**: `As a Patient, I want to access the PatientAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientAnalyticsScreen`
* **Acceptance Criteria**:
- The PatientAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `patient_analytics-content` (Type: layout, Required: 1)
* **patientanalytics_screen** -> `patientanalytics-screen` (Type: layout, Required: 0)
* **patientanalytics_content** -> `patientanalytics-content` (Type: layout, Required: 0)
* **patientanalytics_btn_1** -> `patientanalytics-btn-1` (Type: button, Required: 0)
* **patientanalytics_title** -> `patientanalytics-title` (Type: header, Required: 0)
* **patientanalytics_btn_2** -> `patientanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `133` (Required: 1)
* Component ID: `667` (Required: 1)
* Component ID: `1201` (Required: 1)
* Component ID: `2673` (Required: 1)
* Component ID: `2674` (Required: 1)
* Component ID: `2675` (Required: 1)
* Component ID: `2676` (Required: 1)
* Component ID: `2677` (Required: 1)

## 7. API / Data Mapping
* API ID: `4408` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_analytics_runtime`
* **Test Name**: `PatientAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/common/patient-analytics`)
3. **should_be_visible** (Selector: `patient_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
