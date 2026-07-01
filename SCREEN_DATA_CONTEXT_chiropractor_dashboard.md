# SCREEN DATA CONTEXT: chiropractor_dashboard

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `13`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_dashboard`
* **Screen Name**: `ChiropractorDashboardScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/chiropractor_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractordashboardscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorDashboardScreen`
* **Acceptance Criteria**:
- The ChiropractorDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_dashboard-content` (Type: layout, Required: 1)
* **chiropractordashboard_btn_1** -> `chiropractordashboard-btn-1` (Type: button, Required: 0)
* **chiropractordashboard_screen** -> `chiropractordashboard-screen` (Type: layout, Required: 0)
* **chiropractordashboard_loading** -> `chiropractordashboard-loading` (Type: loading, Required: 0)
* **chiropractordashboard_title** -> `chiropractordashboard-title` (Type: header, Required: 0)
* **chiropractordashboard_btn_3** -> `chiropractordashboard-btn-3` (Type: button, Required: 0)
* **chiropractordashboard_btn_2** -> `chiropractordashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `21` (Required: 1)
* Component ID: `555` (Required: 1)
* Component ID: `1089` (Required: 1)
* Component ID: `1709` (Required: 1)
* Component ID: `1710` (Required: 1)
* Component ID: `1711` (Required: 1)
* Component ID: `1712` (Required: 1)
* Component ID: `1713` (Required: 1)

## 7. API / Data Mapping
* API ID: `4262` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_dashboard_runtime`
* **Test Name**: `ChiropractorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
