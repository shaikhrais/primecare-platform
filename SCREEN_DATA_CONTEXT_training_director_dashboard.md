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
* **Stage/Status**: `template_created`

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
* **Test Name**: `TrainingDirectorDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingDirectorDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/training_director/dashboard`)
3. **should_be_visible** (Selector: `training_director_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_director_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_director_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
