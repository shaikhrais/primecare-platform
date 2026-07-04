# SCREEN DATA CONTEXT: scrum_master_analytics

Below are the database records from `governance.db` used to configure and build the **Scrum Master - ScrumMasterAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `222`
* **App ID**: `1`
* **Role ID**: `44`
* **Screen Code**: `scrum_master_analytics`
* **Screen Name**: `ScrumMasterAnalyticsScreen`
* **Route Path**: `/management/scrum-master-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scrum_master_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `44`
* **Role Code**: `scrum_master`
* **Role Name**: `Scrum Master`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Scrum Master personnel to oversee, audit, and coordinate operations related to scrummasteranalyticsscreen.`
* **User Story**: `As a Scrum Master, I want to access the ScrumMasterAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScrumMasterAnalyticsScreen`
* **Acceptance Criteria**:
- The ScrumMasterAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Scrum Master access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scrum_master_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `scrum_master_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `scrum_master_analytics-content` (Type: layout, Required: 1)
* **scrummasteranalytics_screen** -> `scrummasteranalytics-screen` (Type: layout, Required: 0)
* **scrummasteranalytics_btn_2** -> `scrummasteranalytics-btn-2` (Type: button, Required: 0)
* **scrummasteranalytics_title** -> `scrummasteranalytics-title` (Type: header, Required: 0)
* **scrummasteranalytics_btn_3** -> `scrummasteranalytics-btn-3` (Type: button, Required: 0)
* **scrummasteranalytics_content** -> `scrummasteranalytics-content` (Type: layout, Required: 0)
* **scrummasteranalytics_loading** -> `scrummasteranalytics-loading` (Type: loading, Required: 0)
* **scrummasteranalytics_btn_1** -> `scrummasteranalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `230` (Required: 1)
* Component ID: `764` (Required: 1)
* Component ID: `1298` (Required: 1)
* Component ID: `3562` (Required: 1)
* Component ID: `3563` (Required: 1)
* Component ID: `3564` (Required: 1)
* Component ID: `3565` (Required: 1)
* Component ID: `3566` (Required: 1)
* Component ID: `3567` (Required: 1)
* Component ID: `3568` (Required: 1)
* Component ID: `3569` (Required: 1)
* Component ID: `3570` (Required: 1)
* Component ID: `3571` (Required: 1)

## 7. API / Data Mapping
* API ID: `4511` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scrum_master_analytics_runtime`
* **Test Name**: `ScrumMasterAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ScrumMasterAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scrum_master`)
2. **visit** (Selector: `None`, Value: `/management/scrum-master-analytics`)
3. **should_be_visible** (Selector: `scrum_master_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scrum_master_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `scrum_master_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
