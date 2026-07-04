# SCREEN DATA CONTEXT: patient_dashboard

Below are the database records from `governance.db` used to configure and build the **Patient - PatientDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `24`
* **App ID**: `5`
* **Role ID**: `15`
* **Screen Code**: `patient_dashboard`
* **Screen Name**: `PatientDashboardScreen`
* **Route Path**: `/offices/client/roles/client/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/patient_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Patient personnel to oversee, audit, and coordinate operations related to patientdashboardscreen.`
* **User Story**: `As a Patient, I want to access the PatientDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PatientDashboardScreen`
* **Acceptance Criteria**:
- The PatientDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Patient access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `patient_dashboard-content` (Type: layout, Required: 1)
* **patientdashboard_btn_1** -> `patientdashboard-btn-1` (Type: button, Required: 0)
* **patientdashboard_btn_3** -> `patientdashboard-btn-3` (Type: button, Required: 0)
* **patientdashboard_screen** -> `patientdashboard-screen` (Type: layout, Required: 0)
* **patientdashboard_loading** -> `patientdashboard-loading` (Type: loading, Required: 0)
* **patientdashboard_content** -> `patientdashboard-content` (Type: layout, Required: 0)
* **patientdashboard_title** -> `patientdashboard-title` (Type: header, Required: 0)
* **patientdashboard_btn_2** -> `patientdashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `32` (Required: 1)
* Component ID: `566` (Required: 1)
* Component ID: `1100` (Required: 1)
* Component ID: `1794` (Required: 1)
* Component ID: `1795` (Required: 1)
* Component ID: `1796` (Required: 1)
* Component ID: `1797` (Required: 1)
* Component ID: `1798` (Required: 1)
* Component ID: `1799` (Required: 1)
* Component ID: `1800` (Required: 1)
* Component ID: `1801` (Required: 1)

## 7. API / Data Mapping
* API ID: `4277` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_dashboard_runtime`
* **Test Name**: `PatientDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PatientDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `patient`)
2. **visit** (Selector: `None`, Value: `/offices/client/roles/client/dashboard`)
3. **should_be_visible** (Selector: `patient_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `patient_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `patient_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
