# SCREEN DATA CONTEXT: general_manager_analytics

Below are the database records from `governance.db` used to configure and build the **General Manager - GeneralManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `195`
* **App ID**: `1`
* **Role ID**: `35`
* **Screen Code**: `general_manager_analytics`
* **Screen Name**: `GeneralManagerAnalyticsScreen`
* **Route Path**: `/management/general-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/general_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `35`
* **Role Code**: `gm`
* **Role Name**: `General Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable General Manager personnel to oversee, audit, and coordinate operations related to generalmanageranalyticsscreen.`
* **User Story**: `As a General Manager, I want to access the GeneralManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GeneralManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The GeneralManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only General Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `general_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `general_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `general_manager_analytics-content` (Type: layout, Required: 1)
* **generalmanageranalytics_btn_2** -> `generalmanageranalytics-btn-2` (Type: button, Required: 0)
* **generalmanageranalytics_btn_3** -> `generalmanageranalytics-btn-3` (Type: button, Required: 0)
* **generalmanageranalytics_title** -> `generalmanageranalytics-title` (Type: header, Required: 0)
* **generalmanageranalytics_screen** -> `generalmanageranalytics-screen` (Type: layout, Required: 0)
* **generalmanageranalytics_content** -> `generalmanageranalytics-content` (Type: layout, Required: 0)
* **generalmanageranalytics_btn_1** -> `generalmanageranalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `203` (Required: 1)
* Component ID: `737` (Required: 1)
* Component ID: `1271` (Required: 1)
* Component ID: `3303` (Required: 1)
* Component ID: `3304` (Required: 1)
* Component ID: `3305` (Required: 1)
* Component ID: `3306` (Required: 1)
* Component ID: `3307` (Required: 1)
* Component ID: `3308` (Required: 1)
* Component ID: `3309` (Required: 1)
* Component ID: `3310` (Required: 1)
* Component ID: `3311` (Required: 1)
* Component ID: `3312` (Required: 1)

## 7. API / Data Mapping
* API ID: `4484` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `general_manager_analytics_runtime`
* **Test Name**: `GeneralManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GeneralManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `gm`)
2. **visit** (Selector: `None`, Value: `/management/general-manager-analytics`)
3. **should_be_visible** (Selector: `general_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `general_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `general_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
