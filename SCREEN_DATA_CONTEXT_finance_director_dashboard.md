# SCREEN DATA CONTEXT: finance_director_dashboard

Below are the database records from `governance.db` used to configure and build the **Finance Director - FinanceDirectorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `38`
* **App ID**: `7`
* **Role ID**: `26`
* **Screen Code**: `finance_director_dashboard`
* **Screen Name**: `FinanceDirectorDashboardScreen`
* **Route Path**: `/offices/corporate/roles/finance_director/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/finance_director_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `26`
* **Role Code**: `finance_director`
* **Role Name**: `Finance Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Finance Director personnel to oversee, audit, and coordinate operations related to financedirectordashboardscreen.`
* **User Story**: `As a Finance Director, I want to access the FinanceDirectorDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinanceDirectorDashboardScreen`
* **Acceptance Criteria**:
- The FinanceDirectorDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Finance Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `finance_director_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `finance_director_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `finance_director_dashboard-content` (Type: layout, Required: 1)
* **financedirectordashboard_screen** -> `financedirectordashboard-screen` (Type: layout, Required: 0)
* **financedirectordashboard_title** -> `financedirectordashboard-title` (Type: header, Required: 0)
* **financedirectordashboard_content** -> `financedirectordashboard-content` (Type: layout, Required: 0)
* **financedirectordashboard_btn_1** -> `financedirectordashboard-btn-1` (Type: button, Required: 0)
* **financedirectordashboard_btn_3** -> `financedirectordashboard-btn-3` (Type: button, Required: 0)
* **financedirectordashboard_btn_5** -> `financedirectordashboard-btn-5` (Type: button, Required: 0)
* **financedirectordashboard_btn_4** -> `financedirectordashboard-btn-4` (Type: button, Required: 0)
* **financedirectordashboard_btn_2** -> `financedirectordashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `46` (Required: 1)
* Component ID: `580` (Required: 1)
* Component ID: `1114` (Required: 1)
* Component ID: `1914` (Required: 1)
* Component ID: `1915` (Required: 1)
* Component ID: `1916` (Required: 1)
* Component ID: `1917` (Required: 1)
* Component ID: `1918` (Required: 1)
* Component ID: `1919` (Required: 1)
* Component ID: `1920` (Required: 1)
* Component ID: `1921` (Required: 1)
* Component ID: `1922` (Required: 1)
* Component ID: `1923` (Required: 1)

## 7. API / Data Mapping
* API ID: `4293` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `finance_director_dashboard_runtime`
* **Test Name**: `FinanceDirectorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Finance Director Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `finance_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Finance Director Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Finance Director Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/finance_director/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
