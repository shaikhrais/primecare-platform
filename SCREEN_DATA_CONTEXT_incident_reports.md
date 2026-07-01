# SCREEN DATA CONTEXT: incident_reports

Below are the database records from `governance.db` used to configure and build the **Guest - IncidentReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `835`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `incident_reports`
* **Screen Name**: `IncidentReportsScreen`
* **Route Path**: `/generated/incident-reports`
* **Actual File Path**: `apps/primecare_governance/lib/features/qa/screens/incident_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to incident reports.`
* **User Story**: `As a Guest, I want to access the Incident Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Incident Reports`
* **Acceptance Criteria**:
- The Incident Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `incident_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `incident_reports-title` (Type: header, Required: 1)
* **primary_content** -> `incident_reports-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7587` (Required: 1)
* Component ID: `7588` (Required: 1)
* Component ID: `7589` (Required: 1)
* Component ID: `7590` (Required: 1)
* Component ID: `7591` (Required: 1)

## 7. API / Data Mapping
* API ID: `5233` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `incident_reports_runtime`
* **Test Name**: `Incident Reports Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Incident Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Incident Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `Incident Reports`)
5. **check_url** (Selector: `None`, Value: `/generated/incident-reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
