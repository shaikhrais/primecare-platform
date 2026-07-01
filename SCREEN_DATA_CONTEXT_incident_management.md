# SCREEN DATA CONTEXT: incident_management

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - IncidentManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `487`
* **App ID**: `5`
* **Role ID**: `33`
* **Screen Code**: `incident_management`
* **Screen Name**: `IncidentManagementScreen`
* **Route Path**: `/management/incident-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/incident_management_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to incidentmanagementscreen.`
* **User Story**: `As a Compliance Manager, I want to access the IncidentManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IncidentManagementScreen`
* **Acceptance Criteria**:
- The IncidentManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `incident_management-screen` (Type: layout, Required: 1)
* **page_title** -> `incident_management-title` (Type: header, Required: 1)
* **primary_content** -> `incident_management-content` (Type: layout, Required: 1)
* **incidentmanagement_screen** -> `incidentmanagement-screen` (Type: layout, Required: 0)
* **incidentmanagement_content** -> `incidentmanagement-content` (Type: layout, Required: 0)
* **incidentmanagement_title** -> `incidentmanagement-title` (Type: header, Required: 0)
* **incidentmanagement_btn_1** -> `incidentmanagement-btn-1` (Type: button, Required: 0)
* **incidentmanagement_btn_2** -> `incidentmanagement-btn-2` (Type: button, Required: 0)
* **incidentmanagement_btn_3** -> `incidentmanagement-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `416` (Required: 1)
* Component ID: `950` (Required: 1)
* Component ID: `1484` (Required: 1)
* Component ID: `5254` (Required: 1)
* Component ID: `5255` (Required: 1)
* Component ID: `5256` (Required: 1)
* Component ID: `5257` (Required: 1)
* Component ID: `5258` (Required: 1)
* Component ID: `5259` (Required: 1)
* Component ID: `5260` (Required: 1)
* Component ID: `5261` (Required: 1)
* Component ID: `5262` (Required: 1)
* Component ID: `5263` (Required: 1)

## 7. API / Data Mapping
* API ID: `4804` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `incident_management_runtime`
* **Test Name**: `IncidentManagementScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Incident Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Incident Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Incident Management`)
5. **check_url** (Selector: `None`, Value: `/management/incident-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
