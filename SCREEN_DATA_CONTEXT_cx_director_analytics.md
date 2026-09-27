# SCREEN DATA CONTEXT: cx_director_analytics

Below are the database records from `governance.db` used to configure and build the **CX Director - CxDirectorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `165`
* **App ID**: `1`
* **Role ID**: `25`
* **Screen Code**: `cx_director_analytics`
* **Screen Name**: `CxDirectorAnalyticsScreen`
* **Route Path**: `/executive/cx-director-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cx_director_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `25`
* **Role Code**: `cx_director`
* **Role Name**: `CX Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable CX Director personnel to oversee, audit, and coordinate operations related to cxdirectoranalyticsscreen.`
* **User Story**: `As a CX Director, I want to access the CxDirectorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CxDirectorAnalyticsScreen`
* **Acceptance Criteria**:
- The CxDirectorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only CX Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cx_director_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `cx_director_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `cx_director_analytics-content` (Type: layout, Required: 1)
* **cxdirectoranalytics_title** -> `cxdirectoranalytics-title` (Type: header, Required: 0)
* **cxdirectoranalytics_btn_3** -> `cxdirectoranalytics-btn-3` (Type: button, Required: 0)
* **cxdirectoranalytics_btn_1** -> `cxdirectoranalytics-btn-1` (Type: button, Required: 0)
* **cxdirectoranalytics_screen** -> `cxdirectoranalytics-screen` (Type: layout, Required: 0)
* **cxdirectoranalytics_content** -> `cxdirectoranalytics-content` (Type: layout, Required: 0)
* **cxdirectoranalytics_btn_2** -> `cxdirectoranalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `173` (Required: 1)
* Component ID: `707` (Required: 1)
* Component ID: `1241` (Required: 1)
* Component ID: `3030` (Required: 1)
* Component ID: `3031` (Required: 1)
* Component ID: `3032` (Required: 1)
* Component ID: `3033` (Required: 1)
* Component ID: `3034` (Required: 1)
* Component ID: `3035` (Required: 1)
* Component ID: `3036` (Required: 1)
* Component ID: `3037` (Required: 1)
* Component ID: `3038` (Required: 1)
* Component ID: `3039` (Required: 1)

## 7. API / Data Mapping
* API ID: `4454` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cx_director_analytics_runtime`
* **Test Name**: `CxDirectorAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CxDirectorAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cx_director`)
2. **visit** (Selector: `None`, Value: `/executive/cx-director-analytics`)
3. **should_be_visible** (Selector: `cx_director_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cx_director_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `cx_director_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
