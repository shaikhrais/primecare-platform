# SCREEN DATA CONTEXT: clinic_dashboard

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `14`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinic_dashboard`
* **Screen Name**: `ClinicDashboardScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/clinic-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/clinic_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicdashboardscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicDashboardScreen`
* **Acceptance Criteria**:
- The ClinicDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinic_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `clinic_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `clinic_dashboard-content` (Type: layout, Required: 1)
* **clinicdashboard_loading** -> `clinicdashboard-loading` (Type: loading, Required: 0)
* **clinicdashboard_btn_1** -> `clinicdashboard-btn-1` (Type: button, Required: 0)
* **clinicdashboard_screen** -> `clinicdashboard-screen` (Type: layout, Required: 0)
* **clinicdashboard_title** -> `clinicdashboard-title` (Type: header, Required: 0)
* **clinicdashboard_content** -> `clinicdashboard-content` (Type: layout, Required: 0)
* **clinicdashboard_btn_3** -> `clinicdashboard-btn-3` (Type: button, Required: 0)
* **clinicdashboard_btn_2** -> `clinicdashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `22` (Required: 1)
* Component ID: `556` (Required: 1)
* Component ID: `1090` (Required: 1)
* Component ID: `1714` (Required: 1)
* Component ID: `1715` (Required: 1)
* Component ID: `1716` (Required: 1)
* Component ID: `1717` (Required: 1)
* Component ID: `1718` (Required: 1)
* Component ID: `1719` (Required: 1)
* Component ID: `1720` (Required: 1)
* Component ID: `1721` (Required: 1)
* Component ID: `1722` (Required: 1)
* Component ID: `1723` (Required: 1)

## 7. API / Data Mapping
* API ID: `4263` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinic_dashboard_runtime`
* **Test Name**: `ClinicDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinic Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinic Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinic Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/clinic-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
