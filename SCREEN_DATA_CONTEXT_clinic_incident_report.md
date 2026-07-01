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
* **Stage/Status**: `wired`

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
* **Test Name**: `Clinic Incident Report Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinic Incident Report`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinic Incident Report`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinic Incident Report`)
5. **check_url** (Selector: `None`, Value: `/generated/clinic-incident-report`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
