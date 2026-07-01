# SCREEN DATA CONTEXT: training_director_dashboard

Below are the database records from `governance.db` used to configure and build the **Training Director - TrainingDirectorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `43`
* **App ID**: `5`
* **Role ID**: `31`
* **Screen Code**: `training_director_dashboard`
* **Screen Name**: `TrainingDirectorDashboardScreen`
* **Route Path**: `/offices/corporate/roles/training_director/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/training_director_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `31`
* **Role Code**: `training_director`
* **Role Name**: `Training Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Director personnel to oversee, audit, and coordinate operations related to trainingdirectordashboardscreen.`
* **User Story**: `As a Training Director, I want to access the TrainingDirectorDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingDirectorDashboardScreen`
* **Acceptance Criteria**:
- The TrainingDirectorDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_dashboard-content` (Type: layout, Required: 1)
* **trainingdirectordashboard_btn_1** -> `trainingdirectordashboard-btn-1` (Type: button, Required: 0)
* **trainingdirectordashboard_btn_3** -> `trainingdirectordashboard-btn-3` (Type: button, Required: 0)
* **trainingdirectordashboard_btn_5** -> `trainingdirectordashboard-btn-5` (Type: button, Required: 0)
* **trainingdirectordashboard_btn_4** -> `trainingdirectordashboard-btn-4` (Type: button, Required: 0)
* **trainingdirectordashboard_content** -> `trainingdirectordashboard-content` (Type: layout, Required: 0)
* **trainingdirectordashboard_screen** -> `trainingdirectordashboard-screen` (Type: layout, Required: 0)
* **trainingdirectordashboard_btn_2** -> `trainingdirectordashboard-btn-2` (Type: button, Required: 0)
* **trainingdirectordashboard_title** -> `trainingdirectordashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `51` (Required: 1)
* Component ID: `585` (Required: 1)
* Component ID: `1119` (Required: 1)
* Component ID: `1961` (Required: 1)
* Component ID: `1962` (Required: 1)
* Component ID: `1963` (Required: 1)
* Component ID: `1964` (Required: 1)
* Component ID: `1965` (Required: 1)
* Component ID: `1966` (Required: 1)
* Component ID: `1967` (Required: 1)
* Component ID: `1968` (Required: 1)
* Component ID: `1969` (Required: 1)
* Component ID: `1970` (Required: 1)

## 7. API / Data Mapping
* API ID: `4298` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_dashboard_runtime`
* **Test Name**: `TrainingDirectorDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Director Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Director Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Director Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/training_director/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
