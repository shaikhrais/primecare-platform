# SCREEN DATA CONTEXT: rmt_dashboard

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_dashboard`
* **Screen Name**: `RmtDashboardScreen`
* **Route Path**: `/offices/clinical/roles/rmt/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtdashboardscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtDashboardScreen`
* **Acceptance Criteria**:
- The RmtDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_dashboard-content` (Type: layout, Required: 1)
* **rmtdashboard_screen** -> `rmtdashboard-screen` (Type: layout, Required: 0)
* **rmtdashboard_btn_3** -> `rmtdashboard-btn-3` (Type: button, Required: 0)
* **rmtdashboard_loading** -> `rmtdashboard-loading` (Type: loading, Required: 0)
* **rmtdashboard_btn_3_${apt.id}** -> `rmtdashboard-btn-3-${apt.id}` (Type: button, Required: 0)
* **rmtdashboard_btn_4_${apt.id}** -> `rmtdashboard-btn-4-${apt.id}` (Type: button, Required: 0)
* **rmtdashboard_btn_2** -> `rmtdashboard-btn-2` (Type: button, Required: 0)
* **rmtdashboard_btn_1** -> `rmtdashboard-btn-1` (Type: button, Required: 0)
* **rmtdashboard_title** -> `rmtdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `9` (Required: 1)
* Component ID: `543` (Required: 1)
* Component ID: `1077` (Required: 1)
* Component ID: `1611` (Required: 1)
* Component ID: `1612` (Required: 1)
* Component ID: `1613` (Required: 1)
* Component ID: `1614` (Required: 1)
* Component ID: `1615` (Required: 1)
* Component ID: `1616` (Required: 1)
* Component ID: `1617` (Required: 1)
* Component ID: `1618` (Required: 1)
* Component ID: `1619` (Required: 1)
* Component ID: `1620` (Required: 1)

## 7. API / Data Mapping
* API ID: `4248` (Required: 1)
* API ID: `4249` (Required: 1)
* API ID: `4250` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_dashboard_runtime`
* **Test Name**: `RmtDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
