# SCREEN DATA CONTEXT: caregiver_incident_report

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverIncidentReportScreen** screen.

---

## 1. Screen Record
* **ID**: `282`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_incident_report`
* **Screen Name**: `CaregiverIncidentReportScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/incident-report`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/caregiver_incident_report_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregiverincidentreportscreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverIncidentReportScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverIncidentReportScreen`
* **Acceptance Criteria**:
- The CaregiverIncidentReportScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_incident_report-screen` (Type: layout, Required: 1)
* **page_title** -> `caregiver_incident_report-title` (Type: header, Required: 1)
* **primary_content** -> `caregiver_incident_report-content` (Type: layout, Required: 1)
* **caregiverincidentreport_btn_3** -> `caregiverincidentreport-btn-3` (Type: button, Required: 0)
* **caregiverincidentreport_btn_2** -> `caregiverincidentreport-btn-2` (Type: button, Required: 0)
* **caregiverincidentreport_title** -> `caregiverincidentreport-title` (Type: header, Required: 0)
* **caregiverincidentreport_btn_1** -> `caregiverincidentreport-btn-1` (Type: button, Required: 0)
* **caregiverincidentreport_screen** -> `caregiverincidentreport-screen` (Type: layout, Required: 0)
* **caregiverincidentreport_content** -> `caregiverincidentreport-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `290` (Required: 1)
* Component ID: `824` (Required: 1)
* Component ID: `1358` (Required: 1)
* Component ID: `4092` (Required: 1)
* Component ID: `4093` (Required: 1)
* Component ID: `4094` (Required: 1)
* Component ID: `4095` (Required: 1)
* Component ID: `4096` (Required: 1)
* Component ID: `4097` (Required: 1)
* Component ID: `4098` (Required: 1)

## 7. API / Data Mapping
* API ID: `4605` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_incident_report_runtime`
* **Test Name**: `CaregiverIncidentReportScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Caregiver Incident Report`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Caregiver Incident Report`)
4. **click_sidebar_link** (Selector: `None`, Value: `Caregiver Incident Report`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/incident-report`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
