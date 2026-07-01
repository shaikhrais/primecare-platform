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
* **Stage/Status**: `wired`

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
* **Test Name**: `CooAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `COO Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `COO Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `COO Analytics`)
5. **check_url** (Selector: `None`, Value: `/executive/coo-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
