# SCREEN DATA CONTEXT: psw_incident_report

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - ReportIncidentScreen** screen.

---

## 1. Screen Record
* **ID**: `348`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_incident_report`
* **Screen Name**: `ReportIncidentScreen`
* **Route Path**: `/offices/clinical/roles/psw/incident-report`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswincidentreportscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswIncidentReportScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswIncidentReportScreen`
* **Acceptance Criteria**:
- The PswIncidentReportScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_incident_report-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_incident_report-title` (Type: header, Required: 1)
* **primary_content** -> `psw_incident_report-content` (Type: layout, Required: 1)
* **pswincidentreport_screen** -> `pswincidentreport-screen` (Type: layout, Required: 0)
* **pswincidentreport_loading** -> `pswincidentreport-loading` (Type: loading, Required: 0)
* **pswincidentreport_btn_3** -> `pswincidentreport-btn-3` (Type: button, Required: 0)
* **pswincidentreport_btn_1** -> `pswincidentreport-btn-1` (Type: button, Required: 0)
* **pswincidentreport_title** -> `pswincidentreport-title` (Type: header, Required: 0)
* **pswincidentreport_content** -> `pswincidentreport-content` (Type: layout, Required: 0)
* **pswincidentreport_btn_2** -> `pswincidentreport-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `355` (Required: 1)
* Component ID: `889` (Required: 1)
* Component ID: `1423` (Required: 1)
* Component ID: `4668` (Required: 1)
* Component ID: `4669` (Required: 1)
* Component ID: `4670` (Required: 1)
* Component ID: `4671` (Required: 1)
* Component ID: `4672` (Required: 1)
* Component ID: `4673` (Required: 1)
* Component ID: `4674` (Required: 1)
* Component ID: `4675` (Required: 1)
* Component ID: `4676` (Required: 1)
* Component ID: `4677` (Required: 1)

## 7. API / Data Mapping
* API ID: `4680` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_incident_report_runtime`
* **Test Name**: `Report Incident Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Report Incident`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/incident-report`)
3. **should_be_visible** (Selector: `psw_incident_report-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_incident_report-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_incident_report-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
