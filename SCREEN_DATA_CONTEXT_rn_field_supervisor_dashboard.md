# SCREEN DATA CONTEXT: rn_field_supervisor_dashboard

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) Field Supervisor - RnFieldSupervisorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `63`
* **App ID**: `6`
* **Role ID**: `53`
* **Screen Code**: `rn_field_supervisor_dashboard`
* **Screen Name**: `RnFieldSupervisorDashboardScreen`
* **Route Path**: `/rn/rn-field-supervisor-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_field_supervisor_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `53`
* **Role Code**: `rn_field_supervisor`
* **Role Name**: `Registered Nurse (RN) Field Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) Field Supervisor personnel to oversee, audit, and coordinate operations related to rnfieldsupervisordashboardscreen.`
* **User Story**: `As a Registered Nurse (RN) Field Supervisor, I want to access the RnFieldSupervisorDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnFieldSupervisorDashboardScreen`
* **Acceptance Criteria**:
- The RnFieldSupervisorDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) Field Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_field_supervisor_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_field_supervisor_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `rn_field_supervisor_dashboard-content` (Type: layout, Required: 1)
* **rnfieldsupervisordashboard_btn_5** -> `rnfieldsupervisordashboard-btn-5` (Type: button, Required: 0)
* **rnfieldsupervisordashboard_btn_3** -> `rnfieldsupervisordashboard-btn-3` (Type: button, Required: 0)
* **rnfieldsupervisordashboard_title** -> `rnfieldsupervisordashboard-title` (Type: field, Required: 0)
* **rnfieldsupervisordashboard_screen** -> `rnfieldsupervisordashboard-screen` (Type: field, Required: 0)
* **rnfieldsupervisordashboard_content** -> `rnfieldsupervisordashboard-content` (Type: field, Required: 0)
* **rnfieldsupervisordashboard_btn_4** -> `rnfieldsupervisordashboard-btn-4` (Type: button, Required: 0)
* **rnfieldsupervisordashboard_btn_2** -> `rnfieldsupervisordashboard-btn-2` (Type: button, Required: 0)
* **rnfieldsupervisordashboard_btn_1** -> `rnfieldsupervisordashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `71` (Required: 1)
* Component ID: `605` (Required: 1)
* Component ID: `1139` (Required: 1)
* Component ID: `2140` (Required: 1)
* Component ID: `2141` (Required: 1)
* Component ID: `2142` (Required: 1)
* Component ID: `2143` (Required: 1)
* Component ID: `2144` (Required: 1)
* Component ID: `2145` (Required: 1)
* Component ID: `2146` (Required: 1)
* Component ID: `2147` (Required: 1)
* Component ID: `2148` (Required: 1)
* Component ID: `2149` (Required: 1)

## 7. API / Data Mapping
* API ID: `4320` (Required: 1)
* API ID: `4321` (Required: 1)
* API ID: `4322` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_field_supervisor_dashboard_runtime`
* **Test Name**: `RnFieldSupervisorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Field Supervisor Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn_field_supervisor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Field Supervisor Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Field Supervisor Dashboard`)
5. **check_url** (Selector: `None`, Value: `/rn/rn-field-supervisor-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
