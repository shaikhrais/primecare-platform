# SCREEN DATA CONTEXT: head_of_bus_dev_analytics

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - HeadOfBusDevAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `201`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `head_of_bus_dev_analytics`
* **Screen Name**: `HeadOfBusDevAnalyticsScreen`
* **Route Path**: `/management/head-of-bus-dev-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/head_of_bus_dev_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to headofbusdevanalyticsscreen.`
* **User Story**: `As a Head of Business Development, I want to access the HeadOfBusDevAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HeadOfBusDevAnalyticsScreen`
* **Acceptance Criteria**:
- The HeadOfBusDevAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `head_of_bus_dev_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `head_of_bus_dev_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `head_of_bus_dev_analytics-content` (Type: layout, Required: 1)
* **headofbusdevanalytics_title** -> `headofbusdevanalytics-title` (Type: header, Required: 0)
* **headofbusdevanalytics_content** -> `headofbusdevanalytics-content` (Type: layout, Required: 0)
* **headofbusdevanalytics_btn_1** -> `headofbusdevanalytics-btn-1` (Type: button, Required: 0)
* **headofbusdevanalytics_btn_2** -> `headofbusdevanalytics-btn-2` (Type: button, Required: 0)
* **headofbusdevanalytics_screen** -> `headofbusdevanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `209` (Required: 1)
* Component ID: `743` (Required: 1)
* Component ID: `1277` (Required: 1)
* Component ID: `3363` (Required: 1)
* Component ID: `3364` (Required: 1)
* Component ID: `3365` (Required: 1)
* Component ID: `3366` (Required: 1)
* Component ID: `3367` (Required: 1)
* Component ID: `3368` (Required: 1)
* Component ID: `3369` (Required: 1)
* Component ID: `3370` (Required: 1)
* Component ID: `3371` (Required: 1)
* Component ID: `3372` (Required: 1)

## 7. API / Data Mapping
* API ID: `4490` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `head_of_bus_dev_analytics_runtime`
* **Test Name**: `HeadOfBusDevAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HeadOfBusDevAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/management/head-of-bus-dev-analytics`)
3. **should_be_visible** (Selector: `head_of_bus_dev_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `head_of_bus_dev_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `head_of_bus_dev_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
