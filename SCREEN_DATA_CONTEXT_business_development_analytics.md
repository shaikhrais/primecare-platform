# SCREEN DATA CONTEXT: business_development_analytics

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - BusinessDevelopmentAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `89`
* **App ID**: `1`
* **Role ID**: `37`
* **Screen Code**: `business_development_analytics`
* **Screen Name**: `BusinessDevelopmentAnalyticsScreen`
* **Route Path**: `/common/business-development-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/business_development_analytics_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to businessdevelopmentanalyticsscreen.`
* **User Story**: `As a Head of Business Development, I want to access the BusinessDevelopmentAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BusinessDevelopmentAnalyticsScreen`
* **Acceptance Criteria**:
- The BusinessDevelopmentAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `business_development_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `business_development_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `business_development_analytics-content` (Type: layout, Required: 1)
* **businessdevelopmentanalytics_screen** -> `businessdevelopmentanalytics-screen` (Type: layout, Required: 0)
* **businessdevelopmentanalytics_btn_1** -> `businessdevelopmentanalytics-btn-1` (Type: button, Required: 0)
* **businessdevelopmentanalytics_content** -> `businessdevelopmentanalytics-content` (Type: layout, Required: 0)
* **businessdevelopmentanalytics_title** -> `businessdevelopmentanalytics-title` (Type: header, Required: 0)
* **businessdevelopmentanalytics_btn_2** -> `businessdevelopmentanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `97` (Required: 1)
* Component ID: `631` (Required: 1)
* Component ID: `1165` (Required: 1)
* Component ID: `2371` (Required: 1)
* Component ID: `2372` (Required: 1)
* Component ID: `2373` (Required: 1)
* Component ID: `2374` (Required: 1)
* Component ID: `2375` (Required: 1)
* Component ID: `2376` (Required: 1)
* Component ID: `2377` (Required: 1)
* Component ID: `2378` (Required: 1)
* Component ID: `2379` (Required: 1)
* Component ID: `2380` (Required: 1)

## 7. API / Data Mapping
* API ID: `4366` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `business_development_analytics_runtime`
* **Test Name**: `BusinessDevelopmentAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Business Development Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Business Development Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Business Development Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/business-development-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
