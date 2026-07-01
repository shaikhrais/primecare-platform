# SCREEN DATA CONTEXT: incident_oversight

Below are the database records from `governance.db` used to configure and build the **Clinical Director - IncidentOversightScreen** screen.

---

## 1. Screen Record
* **ID**: `556`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `incident_oversight`
* **Screen Name**: `IncidentOversightScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/incident-oversight`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/incident_oversight_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to incidentoversightscreen.`
* **User Story**: `As a Clinical Director, I want to access the IncidentOversightScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IncidentOversightScreen`
* **Acceptance Criteria**:
- The IncidentOversightScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `incident_oversight-screen` (Type: layout, Required: 1)
* **page_title** -> `incident_oversight-title` (Type: header, Required: 1)
* **primary_content** -> `incident_oversight-content` (Type: layout, Required: 1)
* **incidentoversight_content** -> `incidentoversight-content` (Type: layout, Required: 0)
* **incidentoversight_btn_1** -> `incidentoversight-btn-1` (Type: button, Required: 0)
* **incidentoversight_btn_3** -> `incidentoversight-btn-3` (Type: button, Required: 0)
* **incidentoversight_loading** -> `incidentoversight-loading` (Type: loading, Required: 0)
* **incidentoversight_title** -> `incidentoversight-title` (Type: header, Required: 0)
* **incidentoversight_btn_2** -> `incidentoversight-btn-2` (Type: button, Required: 0)
* **incidentoversight_screen** -> `incidentoversight-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `480` (Required: 1)
* Component ID: `1014` (Required: 1)
* Component ID: `1548` (Required: 1)
* Component ID: `5862` (Required: 1)
* Component ID: `5863` (Required: 1)
* Component ID: `5864` (Required: 1)
* Component ID: `5865` (Required: 1)
* Component ID: `5866` (Required: 1)
* Component ID: `5867` (Required: 1)
* Component ID: `5868` (Required: 1)
* Component ID: `5869` (Required: 1)
* Component ID: `5870` (Required: 1)
* Component ID: `5871` (Required: 1)

## 7. API / Data Mapping
* API ID: `4903` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `incident_oversight_runtime`
* **Test Name**: `IncidentOversightScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Incident Oversight`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Incident Oversight`)
4. **click_sidebar_link** (Selector: `None`, Value: `Incident Oversight`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/incident-oversight`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
