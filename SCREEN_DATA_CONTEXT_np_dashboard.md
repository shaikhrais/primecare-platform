# SCREEN DATA CONTEXT: np_dashboard

Below are the database records from `governance.db` used to configure and build the **Nurse Practitioner (NP) - NpDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `7`
* **App ID**: `6`
* **Role ID**: `54`
* **Screen Code**: `np_dashboard`
* **Screen Name**: `NpDashboardScreen`
* **Route Path**: `/clinical/np-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/np_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `54`
* **Role Code**: `np`
* **Role Name**: `Nurse Practitioner (NP)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Nurse Practitioner (NP) personnel to oversee, audit, and coordinate operations related to npdashboardscreen.`
* **User Story**: `As a Nurse Practitioner (NP), I want to access the NpDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `NpDashboardScreen`
* **Acceptance Criteria**:
- The NpDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Nurse Practitioner (NP) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `np_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `np_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `np_dashboard-content` (Type: layout, Required: 1)
* **npdashboard_screen** -> `npdashboard-screen` (Type: layout, Required: 0)
* **npdashboard_btn_2** -> `npdashboard-btn-2` (Type: button, Required: 0)
* **npdashboard_btn_3** -> `npdashboard-btn-3` (Type: button, Required: 0)
* **npdashboard_loading** -> `npdashboard-loading` (Type: loading, Required: 0)
* **npdashboard_btn_1** -> `npdashboard-btn-1` (Type: button, Required: 0)
* **npdashboard_title** -> `npdashboard-title` (Type: header, Required: 0)
* **npdashboard_content** -> `npdashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `15` (Required: 1)
* Component ID: `549` (Required: 1)
* Component ID: `1083` (Required: 1)
* Component ID: `1657` (Required: 1)
* Component ID: `1658` (Required: 1)
* Component ID: `1659` (Required: 1)
* Component ID: `1660` (Required: 1)
* Component ID: `1661` (Required: 1)
* Component ID: `1662` (Required: 1)
* Component ID: `1663` (Required: 1)
* Component ID: `1664` (Required: 1)
* Component ID: `1665` (Required: 1)
* Component ID: `1666` (Required: 1)

## 7. API / Data Mapping
* API ID: `4256` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `np_dashboard_runtime`
* **Test Name**: `NpDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `NpDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `np`)
2. **visit** (Selector: `None`, Value: `/clinical/np-dashboard`)
3. **should_be_visible** (Selector: `np_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `np_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `np_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
