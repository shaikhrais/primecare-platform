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
* **Stage/Status**: `wired`

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
* **Test Name**: `PatientAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/patient-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
