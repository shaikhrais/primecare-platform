# SCREEN DATA CONTEXT: hsw_incident_reports

Below are the database records from `governance.db` used to configure and build the **Home Support Worker - HswIncidentReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `84`
* **App ID**: `1`
* **Role ID**: `52`
* **Screen Code**: `hsw_incident_reports`
* **Screen Name**: `HswIncidentReportsScreen`
* **Route Path**: `/clinical/hsw-incident-reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/hsw_incident_reports_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `52`
* **Role Code**: `hsw`
* **Role Name**: `Home Support Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Home Support Worker personnel to oversee, audit, and coordinate operations related to hswincidentreportsscreen.`
* **User Story**: `As a Home Support Worker, I want to access the HswIncidentReportsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HswIncidentReportsScreen`
* **Acceptance Criteria**:
- The HswIncidentReportsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Home Support Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hsw_incident_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `hsw_incident_reports-title` (Type: header, Required: 1)
* **primary_content** -> `hsw_incident_reports-content` (Type: layout, Required: 1)
* **data_cy_hsw_incident_form_fields** -> `data-cy-hsw-incident-form-fields` (Type: field, Required: 0)
* **hswincidentreports_content** -> `hswincidentreports-content` (Type: layout, Required: 0)
* **submit_incident_report** -> `submit_incident_report` (Type: custom, Required: 0)
* **data_cy_hsw_witness_notes_input** -> `data-cy-hsw-witness-notes-input` (Type: field, Required: 0)
* **hswincidentreports_screen** -> `hswincidentreports-screen` (Type: layout, Required: 0)
* **data_cy_hsw_incident_severity_picker** -> `data-cy-hsw-incident-severity-picker` (Type: custom, Required: 0)
* **hswincidentreports_btn_1** -> `hswincidentreports-btn-1` (Type: button, Required: 0)
* **hswincidentreports_title** -> `hswincidentreports-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `92` (Required: 1)
* Component ID: `626` (Required: 1)
* Component ID: `1160` (Required: 1)
* Component ID: `2330` (Required: 1)
* Component ID: `2331` (Required: 1)
* Component ID: `2332` (Required: 1)
* Component ID: `2333` (Required: 1)
* Component ID: `2334` (Required: 1)
* Component ID: `2335` (Required: 1)
* Component ID: `2336` (Required: 1)
* Component ID: `2337` (Required: 1)

## 7. API / Data Mapping
* API ID: `4357` (Required: 1)
* API ID: `4358` (Required: 1)
* API ID: `4359` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hsw_incident_reports_runtime`
* **Test Name**: `HswIncidentReportsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HSW Incident Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hsw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HSW Incident Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `HSW Incident Reports`)
5. **check_url** (Selector: `None`, Value: `/clinical/hsw-incident-reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
