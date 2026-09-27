# SCREEN DATA CONTEXT: osha_incident_reporter

Below are the database records from `governance.db` used to configure and build the **Guest - OshaIncidentReporterScreen** screen.

---

## 1. Screen Record
* **ID**: `918`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `osha_incident_reporter`
* **Screen Name**: `OshaIncidentReporterScreen`
* **Route Path**: `/generated/osha-incident-reporter`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/osha_incident_reporter.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to osha incident reporter.`
* **User Story**: `As a Guest, I want to access the Osha Incident Reporter within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Osha Incident Reporter`
* **Acceptance Criteria**:
- The Osha Incident Reporter route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `osha_incident_reporter-screen` (Type: layout, Required: 1)
* **page_title** -> `osha_incident_reporter-title` (Type: header, Required: 1)
* **primary_content** -> `osha_incident_reporter-content` (Type: layout, Required: 1)
* **osha_incident_reporter_outlinedbutton_button_1** -> `osha_incident_reporter_outlinedbutton_button_1` (Type: button, Required: 0)
* **osha_incident_reporter_iconbutton_button_1** -> `osha_incident_reporter_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8037` (Required: 1)
* Component ID: `8038` (Required: 1)
* Component ID: `8039` (Required: 1)
* Component ID: `8040` (Required: 1)
* Component ID: `8041` (Required: 1)

## 7. API / Data Mapping
* API ID: `5340` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `osha_incident_reporter_runtime`
* **Test Name**: `Osha Incident Reporter Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Osha Incident Reporter`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/osha-incident-reporter`)
3. **should_be_visible** (Selector: `osha_incident_reporter-screen`, Value: `None`)
4. **should_be_visible** (Selector: `osha_incident_reporter-title`, Value: `None`)
5. **should_be_visible** (Selector: `osha_incident_reporter-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
