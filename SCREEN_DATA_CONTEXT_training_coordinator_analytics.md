# SCREEN DATA CONTEXT: training_coordinator_analytics

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingCoordinatorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `272`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_coordinator_analytics`
* **Screen Name**: `TrainingCoordinatorAnalyticsScreen`
* **Route Path**: `/staff/training-coordinator-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/training_coordinator_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `19`
* **Role Code**: `training`
* **Role Name**: `Training Candidate`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to trainingcoordinatoranalyticsscreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingCoordinatorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingCoordinatorAnalyticsScreen`
* **Acceptance Criteria**:
- The TrainingCoordinatorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_analytics-content` (Type: layout, Required: 1)
* **trainingcoordinatoranalytics_content** -> `trainingcoordinatoranalytics-content` (Type: layout, Required: 0)
* **trainingcoordinatoranalytics_screen** -> `trainingcoordinatoranalytics-screen` (Type: layout, Required: 0)
* **trainingcoordinatoranalytics_title** -> `trainingcoordinatoranalytics-title` (Type: header, Required: 0)
* **trainingcoordinatoranalytics_btn_1** -> `trainingcoordinatoranalytics-btn-1` (Type: button, Required: 0)
* **trainingcoordinatoranalytics_btn_3** -> `trainingcoordinatoranalytics-btn-3` (Type: button, Required: 0)
* **trainingcoordinatoranalytics_btn_2** -> `trainingcoordinatoranalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `280` (Required: 1)
* Component ID: `814` (Required: 1)
* Component ID: `1348` (Required: 1)
* Component ID: `4028` (Required: 1)
* Component ID: `4029` (Required: 1)
* Component ID: `4030` (Required: 1)
* Component ID: `4031` (Required: 1)
* Component ID: `4032` (Required: 1)
* Component ID: `4033` (Required: 1)
* Component ID: `4034` (Required: 1)

## 7. API / Data Mapping
* API ID: `4593` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_analytics_runtime`
* **Test Name**: `TrainingCoordinatorAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingCoordinatorAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **visit** (Selector: `None`, Value: `/staff/training-coordinator-analytics`)
3. **should_be_visible** (Selector: `training_coordinator_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_coordinator_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_coordinator_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
