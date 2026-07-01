# SCREEN DATA CONTEXT: incident_response_hub

Below are the database records from `governance.db` used to configure and build the **Guest - IncidentResponseHubScreen** screen.

---

## 1. Screen Record
* **ID**: `914`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `incident_response_hub`
* **Screen Name**: `IncidentResponseHubScreen`
* **Route Path**: `/generated/incident-response-hub`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/incident_response_hub.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to incident response hub.`
* **User Story**: `As a Guest, I want to access the Incident Response Hub within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Incident Response Hub`
* **Acceptance Criteria**:
- The Incident Response Hub route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `incident_response_hub-screen` (Type: layout, Required: 1)
* **page_title** -> `incident_response_hub-title` (Type: header, Required: 1)
* **primary_content** -> `incident_response_hub-content` (Type: layout, Required: 1)
* **incident_response_hub_iconbutton_button_1** -> `incident_response_hub_iconbutton_button_1` (Type: button, Required: 0)
* **incident_response_hub_outlinedbutton_button_1** -> `incident_response_hub_outlinedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8019` (Required: 1)
* Component ID: `8020` (Required: 1)
* Component ID: `8021` (Required: 1)
* Component ID: `8022` (Required: 1)

## 7. API / Data Mapping
* API ID: `5334` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `incident_response_hub_runtime`
* **Test Name**: `Incident Response Hub Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Incident Response Hub`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Incident Response Hub`)
4. **click_sidebar_link** (Selector: `None`, Value: `Incident Response Hub`)
5. **check_url** (Selector: `None`, Value: `/generated/incident-response-hub`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
