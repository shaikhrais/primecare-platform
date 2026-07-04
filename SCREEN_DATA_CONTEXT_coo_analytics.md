# SCREEN DATA CONTEXT: coo_analytics

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `159`
* **App ID**: `1`
* **Role ID**: `23`
* **Screen Code**: `coo_analytics`
* **Screen Name**: `CooAnalyticsScreen`
* **Route Path**: `/executive/coo-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to cooanalyticsscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooAnalyticsScreen`
* **Acceptance Criteria**:
- The CooAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `coo_analytics-content` (Type: layout, Required: 1)
* **cooanalytics_title** -> `cooanalytics-title` (Type: header, Required: 0)
* **cooanalytics_btn_1** -> `cooanalytics-btn-1` (Type: button, Required: 0)
* **cooanalytics_btn_2** -> `cooanalytics-btn-2` (Type: button, Required: 0)
* **cooanalytics_screen** -> `cooanalytics-screen` (Type: layout, Required: 0)
* **cooanalytics_content** -> `cooanalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `167` (Required: 1)
* Component ID: `701` (Required: 1)
* Component ID: `1235` (Required: 1)
* Component ID: `2970` (Required: 1)
* Component ID: `2971` (Required: 1)
* Component ID: `2972` (Required: 1)
* Component ID: `2973` (Required: 1)
* Component ID: `2974` (Required: 1)
* Component ID: `2975` (Required: 1)
* Component ID: `2976` (Required: 1)
* Component ID: `2977` (Required: 1)
* Component ID: `2978` (Required: 1)
* Component ID: `2979` (Required: 1)

## 7. API / Data Mapping
* API ID: `4448` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_analytics_runtime`
* **Test Name**: `CooAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/coo-analytics`)
3. **should_be_visible** (Selector: `coo_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
