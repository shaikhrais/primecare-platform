# SCREEN DATA CONTEXT: training_dashboard

Below are the database records from `governance.db` used to configure and build the **Training Coordinator - TrainingDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `561`
* **App ID**: `5`
* **Role ID**: `62`
* **Screen Code**: `training_dashboard`
* **Screen Name**: `TrainingDashboardScreen`
* **Route Path**: `/staff/training-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `62`
* **Role Code**: `training_coordinator`
* **Role Name**: `Training Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Coordinator personnel to oversee, audit, and coordinate operations related to trainingdashboardscreen.`
* **User Story**: `As a Training Coordinator, I want to access the TrainingDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingDashboardScreen`
* **Acceptance Criteria**:
- The TrainingDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `training_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `training_dashboard-content` (Type: layout, Required: 1)
* **trainingdashboard_screen** -> `trainingdashboard-screen` (Type: layout, Required: 0)
* **trainingdashboard_btn_2** -> `trainingdashboard-btn-2` (Type: button, Required: 0)
* **trainingdashboard_btn_4** -> `trainingdashboard-btn-4` (Type: button, Required: 0)
* **trainingdashboard_title** -> `trainingdashboard-title` (Type: header, Required: 0)
* **trainingdashboard_content** -> `trainingdashboard-content` (Type: layout, Required: 0)
* **trainingdashboard_btn_1** -> `trainingdashboard-btn-1` (Type: button, Required: 0)
* **trainingdashboard_loading** -> `trainingdashboard-loading` (Type: loading, Required: 0)
* **trainingdashboard_btn_3** -> `trainingdashboard-btn-3` (Type: button, Required: 0)
* **trainingdashboard_btn_5** -> `trainingdashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `485` (Required: 1)
* Component ID: `1019` (Required: 1)
* Component ID: `1553` (Required: 1)
* Component ID: `5908` (Required: 1)
* Component ID: `5909` (Required: 1)
* Component ID: `5910` (Required: 1)
* Component ID: `5911` (Required: 1)
* Component ID: `5912` (Required: 1)
* Component ID: `5913` (Required: 1)
* Component ID: `5914` (Required: 1)
* Component ID: `5915` (Required: 1)
* Component ID: `5916` (Required: 1)
* Component ID: `5917` (Required: 1)

## 7. API / Data Mapping
* API ID: `4908` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_dashboard_runtime`
* **Test Name**: `TrainingDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Dashboard`)
5. **check_url** (Selector: `None`, Value: `/staff/training-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
