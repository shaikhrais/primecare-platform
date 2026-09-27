# SCREEN DATA CONTEXT: regional_manager_usa_analytics

Below are the database records from `governance.db` used to configure and build the **Regional Manager USA - RegionalManagerUsaAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `219`
* **App ID**: `1`
* **Role ID**: `43`
* **Screen Code**: `regional_manager_usa_analytics`
* **Screen Name**: `RegionalManagerUsaAnalyticsScreen`
* **Route Path**: `/management/regional-manager-usa-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `43`
* **Role Code**: `regional_manager_usa`
* **Role Name**: `Regional Manager USA`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional Manager USA personnel to oversee, audit, and coordinate operations related to regionalmanagerusaanalyticsscreen.`
* **User Story**: `As a Regional Manager USA, I want to access the RegionalManagerUsaAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalManagerUsaAnalyticsScreen`
* **Acceptance Criteria**:
- The RegionalManagerUsaAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional Manager USA access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_manager_usa_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_manager_usa_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `regional_manager_usa_analytics-content` (Type: layout, Required: 1)
* **regionalmanagerusaanalytics_screen** -> `regionalmanagerusaanalytics-screen` (Type: layout, Required: 0)
* **regionalmanagerusaanalytics_btn_2** -> `regionalmanagerusaanalytics-btn-2` (Type: button, Required: 0)
* **regionalmanagerusaanalytics_content** -> `regionalmanagerusaanalytics-content` (Type: layout, Required: 0)
* **regionalmanagerusaanalytics_btn_1** -> `regionalmanagerusaanalytics-btn-1` (Type: button, Required: 0)
* **regionalmanagerusaanalytics_title** -> `regionalmanagerusaanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `227` (Required: 1)
* Component ID: `761` (Required: 1)
* Component ID: `1295` (Required: 1)
* Component ID: `3535` (Required: 1)
* Component ID: `3536` (Required: 1)
* Component ID: `3537` (Required: 1)
* Component ID: `3538` (Required: 1)
* Component ID: `3539` (Required: 1)
* Component ID: `3540` (Required: 1)
* Component ID: `3541` (Required: 1)
* Component ID: `3542` (Required: 1)
* Component ID: `3543` (Required: 1)
* Component ID: `3544` (Required: 1)

## 7. API / Data Mapping
* API ID: `4508` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_manager_usa_analytics_runtime`
* **Test Name**: `RegionalManagerUsaAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RegionalManagerUsaAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_manager_usa`)
2. **visit** (Selector: `None`, Value: `/management/regional-manager-usa-analytics`)
3. **should_be_visible** (Selector: `regional_manager_usa_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_manager_usa_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_manager_usa_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
