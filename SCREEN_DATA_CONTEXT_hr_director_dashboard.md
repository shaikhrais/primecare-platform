# SCREEN DATA CONTEXT: hr_director_dashboard

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `39`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_dashboard`
* **Screen Name**: `HrDirectorDashboardScreen`
* **Route Path**: `/offices/corporate/roles/hr_director/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectordashboardscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorDashboardScreen`
* **Acceptance Criteria**:
- The HrDirectorDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_dashboard-content` (Type: layout, Required: 1)
* **hrdirectordashboard_content** -> `hrdirectordashboard-content` (Type: layout, Required: 0)
* **hrdirectordashboard_screen** -> `hrdirectordashboard-screen` (Type: layout, Required: 0)
* **hrdirectordashboard_btn_1** -> `hrdirectordashboard-btn-1` (Type: button, Required: 0)
* **hrdirectordashboard_title** -> `hrdirectordashboard-title` (Type: header, Required: 0)
* **hrdirectordashboard_btn_3** -> `hrdirectordashboard-btn-3` (Type: button, Required: 0)
* **hrdirectordashboard_btn_2** -> `hrdirectordashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `47` (Required: 1)
* Component ID: `581` (Required: 1)
* Component ID: `1115` (Required: 1)
* Component ID: `1924` (Required: 1)
* Component ID: `1925` (Required: 1)
* Component ID: `1926` (Required: 1)
* Component ID: `1927` (Required: 1)
* Component ID: `1928` (Required: 1)
* Component ID: `1929` (Required: 1)
* Component ID: `1930` (Required: 1)
* Component ID: `1931` (Required: 1)
* Component ID: `1932` (Required: 1)

## 7. API / Data Mapping
* API ID: `4294` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_dashboard_runtime`
* **Test Name**: `HrDirectorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Director Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Director Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Director Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/hr_director/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
