# SCREEN DATA CONTEXT: training_director_analytics

Below are the database records from `governance.db` used to configure and build the **Training Candidate - TrainingDirectorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `183`
* **App ID**: `1`
* **Role ID**: `19`
* **Screen Code**: `training_director_analytics`
* **Screen Name**: `TrainingDirectorAnalyticsScreen`
* **Route Path**: `/offices/corporate/roles/training_director/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/training_director_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Candidate personnel to oversee, audit, and coordinate operations related to trainingdirectoranalyticsscreen.`
* **User Story**: `As a Training Candidate, I want to access the TrainingDirectorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TrainingDirectorAnalyticsScreen`
* **Acceptance Criteria**:
- The TrainingDirectorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Candidate access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_analytics-content` (Type: layout, Required: 1)
* **trainingdirectoranalytics_content** -> `trainingdirectoranalytics-content` (Type: layout, Required: 0)
* **trainingdirectoranalytics_btn_2** -> `trainingdirectoranalytics-btn-2` (Type: button, Required: 0)
* **trainingdirectoranalytics_title** -> `trainingdirectoranalytics-title` (Type: header, Required: 0)
* **trainingdirectoranalytics_btn_1** -> `trainingdirectoranalytics-btn-1` (Type: button, Required: 0)
* **trainingdirectoranalytics_screen** -> `trainingdirectoranalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `191` (Required: 1)
* Component ID: `725` (Required: 1)
* Component ID: `1259` (Required: 1)
* Component ID: `3197` (Required: 1)
* Component ID: `3198` (Required: 1)
* Component ID: `3199` (Required: 1)
* Component ID: `3200` (Required: 1)
* Component ID: `3201` (Required: 1)
* Component ID: `3202` (Required: 1)
* Component ID: `3203` (Required: 1)

## 7. API / Data Mapping
* API ID: `4472` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_analytics_runtime`
* **Test Name**: `TrainingDirectorAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TrainingDirectorAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/training_director/analytics`)
3. **should_be_visible** (Selector: `training_director_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_director_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_director_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
