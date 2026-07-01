# SCREEN DATA CONTEXT: dynamic_analytics

Below are the database records from `governance.db` used to configure and build the **Dynamic Screen Viewer - DynamicScreenAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `104`
* **App ID**: `1`
* **Role ID**: `16`
* **Screen Code**: `dynamic_analytics`
* **Screen Name**: `DynamicScreenAnalyticsScreen`
* **Route Path**: `/common/dynamic-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `16`
* **Role Code**: `dynamic`
* **Role Name**: `Dynamic Screen Viewer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Dynamic Screen Viewer personnel to oversee, audit, and coordinate operations related to dynamicscreenanalyticsscreen.`
* **User Story**: `As a Dynamic Screen Viewer, I want to access the DynamicScreenAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DynamicScreenAnalyticsScreen`
* **Acceptance Criteria**:
- The DynamicScreenAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Dynamic Screen Viewer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `dynamic_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `dynamic_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `dynamic_analytics-content` (Type: layout, Required: 1)
* **dynamicanalytics_content** -> `dynamicanalytics-content` (Type: layout, Required: 0)
* **dynamicanalytics_title** -> `dynamicanalytics-title` (Type: header, Required: 0)
* **dynamicanalytics_screen** -> `dynamicanalytics-screen` (Type: layout, Required: 0)
* **dynamicanalytics_btn_2** -> `dynamicanalytics-btn-2` (Type: button, Required: 0)
* **dynamicanalytics_btn_1** -> `dynamicanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `112` (Required: 1)
* Component ID: `646` (Required: 1)
* Component ID: `1180` (Required: 1)
* Component ID: `2511` (Required: 1)
* Component ID: `2512` (Required: 1)
* Component ID: `2513` (Required: 1)
* Component ID: `2514` (Required: 1)
* Component ID: `2515` (Required: 1)

## 7. API / Data Mapping
* API ID: `4381` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `dynamic_analytics_runtime`
* **Test Name**: `DynamicScreenAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Dynamic Screen Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `dynamic`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Dynamic Screen Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Dynamic Screen Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/dynamic-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
