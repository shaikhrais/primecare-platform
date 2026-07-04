# SCREEN DATA CONTEXT: clinic_incident_report

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicIncidentReportScreen** screen.

---

## 1. Screen Record
* **ID**: `702`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinic_incident_report`
* **Screen Name**: `ClinicIncidentReportScreen`
* **Route Path**: `/generated/clinic-incident-report`
* **Actual File Path**: `apps/primecare_clinic/lib/features/shared/screens/clinic_incident_report_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinic incident report.`
* **User Story**: `As a Guest, I want to access the Clinic Incident Report within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinic Incident Report`
* **Acceptance Criteria**:
- The Clinic Incident Report route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinic_incident_report-screen` (Type: layout, Required: 1)
* **page_title** -> `clinic_incident_report-title` (Type: header, Required: 1)
* **primary_content** -> `clinic_incident_report-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6852` (Required: 1)
* Component ID: `6853` (Required: 1)
* Component ID: `6854` (Required: 1)
* Component ID: `6855` (Required: 1)
* Component ID: `6856` (Required: 1)

## 7. API / Data Mapping
* API ID: `5078` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinic_incident_report_runtime`
* **Test Name**: `Clinic Incident Report Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinic Incident Report`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/clinic-incident-report`)
3. **should_be_visible** (Selector: `clinic_incident_report-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinic_incident_report-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinic_incident_report-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
