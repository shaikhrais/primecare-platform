# SCREEN DATA CONTEXT: growth_analytics

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - GrowthAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `497`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `growth_analytics`
* **Screen Name**: `GrowthAnalyticsScreen`
* **Route Path**: `/management/growth-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/growth_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to growthanalyticsscreen.`
* **User Story**: `As a Head of Business Development, I want to access the GrowthAnalyticsScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GrowthAnalyticsScreen`
* **Acceptance Criteria**:
- The GrowthAnalyticsScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `growth_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `growth_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `growth_analytics-content` (Type: layout, Required: 1)
* **growthanalytics_loading** -> `growthanalytics-loading` (Type: loading, Required: 0)
* **growthanalytics_title** -> `growthanalytics-title` (Type: header, Required: 0)
* **growthanalytics_btn_2** -> `growthanalytics-btn-2` (Type: button, Required: 0)
* **growthanalytics_btn_3** -> `growthanalytics-btn-3` (Type: button, Required: 0)
* **growthanalytics_content** -> `growthanalytics-content` (Type: layout, Required: 0)
* **growthanalytics_screen** -> `growthanalytics-screen` (Type: layout, Required: 0)
* **growthanalytics_btn_1** -> `growthanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `426` (Required: 1)
* Component ID: `960` (Required: 1)
* Component ID: `1494` (Required: 1)
* Component ID: `5353` (Required: 1)
* Component ID: `5354` (Required: 1)
* Component ID: `5355` (Required: 1)
* Component ID: `5356` (Required: 1)
* Component ID: `5357` (Required: 1)
* Component ID: `5358` (Required: 1)
* Component ID: `5359` (Required: 1)
* Component ID: `5360` (Required: 1)
* Component ID: `5361` (Required: 1)
* Component ID: `5362` (Required: 1)

## 7. API / Data Mapping
* API ID: `4814` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `growth_analytics_runtime`
* **Test Name**: `GrowthAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GrowthAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **visit** (Selector: `None`, Value: `/management/growth-analytics`)
3. **should_be_visible** (Selector: `growth_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `growth_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `growth_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
