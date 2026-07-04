# SCREEN DATA CONTEXT: remote_patient_monitoring_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - RemotePatientMonitoringDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1023`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `remote_patient_monitoring_dashboard`
* **Screen Name**: `RemotePatientMonitoringDashboardScreen`
* **Route Path**: `/generated/remote-patient-monitoring-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/remote_patient_monitoring_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to remote patient monitoring dashboard.`
* **User Story**: `As a Guest, I want to access the Remote Patient Monitoring Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Remote Patient Monitoring Dashboard`
* **Acceptance Criteria**:
- The Remote Patient Monitoring Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `remote_patient_monitoring_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `remote_patient_monitoring_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `remote_patient_monitoring_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8619` (Required: 1)
* Component ID: `8620` (Required: 1)
* Component ID: `8621` (Required: 1)
* Component ID: `8622` (Required: 1)
* Component ID: `8623` (Required: 1)
* Component ID: `8624` (Required: 1)
* Component ID: `8625` (Required: 1)

## 7. API / Data Mapping
* API ID: `5489` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `remote_patient_monitoring_dashboard_runtime`
* **Test Name**: `Remote Patient Monitoring Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Remote Patient Monitoring Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/remote-patient-monitoring-dashboard`)
3. **should_be_visible** (Selector: `remote_patient_monitoring_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `remote_patient_monitoring_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `remote_patient_monitoring_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
