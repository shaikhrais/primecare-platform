# SCREEN DATA CONTEXT: training_hub_dashboard

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingHubDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `32`
* **App ID**: `5`
* **Role ID**: `19`
* **Screen Code**: `training_hub_dashboard`
* **Screen Name**: `TrainingHubDashboardScreen`
* **Route Path**: `/common/training-hub-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `19`
* **Role Code**: `training`
* **Role Name**: `Training Candidate`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to traininghubdashboardscreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingHubDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingHubDashboardScreen`
* **Acceptance Criteria**:
- The TrainingHubDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_hub_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `training_hub_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `training_hub_dashboard-content` (Type: layout, Required: 1)
* **traininghubdashboard_content** -> `traininghubdashboard-content` (Type: layout, Required: 0)
* **traininghubdashboard_screen** -> `traininghubdashboard-screen` (Type: layout, Required: 0)
* **traininghubdashboard_btn_1** -> `traininghubdashboard-btn-1` (Type: button, Required: 0)
* **traininghubdashboard_btn_2** -> `traininghubdashboard-btn-2` (Type: button, Required: 0)
* **traininghubdashboard_btn_3** -> `traininghubdashboard-btn-3` (Type: button, Required: 0)
* **traininghubdashboard_title** -> `traininghubdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `40` (Required: 1)
* Component ID: `574` (Required: 1)
* Component ID: `1108` (Required: 1)
* Component ID: `1858` (Required: 1)
* Component ID: `1859` (Required: 1)
* Component ID: `1860` (Required: 1)
* Component ID: `1861` (Required: 1)
* Component ID: `1862` (Required: 1)
* Component ID: `1863` (Required: 1)

## 7. API / Data Mapping
* API ID: `4285` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_hub_dashboard_runtime`
* **Test Name**: `TrainingHubDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingHubDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **visit** (Selector: `None`, Value: `/common/training-hub-dashboard`)
3. **should_be_visible** (Selector: `training_hub_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_hub_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_hub_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
