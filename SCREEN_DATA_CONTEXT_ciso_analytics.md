# SCREEN DATA CONTEXT: ciso_analytics

Below are the database records from `governance.db` used to configure and build the **Chief Information Security Officer (CISO) - CisoAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `156`
* **App ID**: `1`
* **Role ID**: `22`
* **Screen Code**: `ciso_analytics`
* **Screen Name**: `CisoAnalyticsScreen`
* **Route Path**: `/executive/ciso-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/ciso_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `22`
* **Role Code**: `ciso`
* **Role Name**: `Chief Information Security Officer (CISO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Information Security Officer (CISO) personnel to oversee, audit, and coordinate operations related to cisoanalyticsscreen.`
* **User Story**: `As a Chief Information Security Officer (CISO), I want to access the CisoAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CisoAnalyticsScreen`
* **Acceptance Criteria**:
- The CisoAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Information Security Officer (CISO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ciso_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `ciso_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `ciso_analytics-content` (Type: layout, Required: 1)
* **cisoanalytics_title** -> `cisoanalytics-title` (Type: header, Required: 0)
* **cisoanalytics_loading** -> `cisoanalytics-loading` (Type: loading, Required: 0)
* **cisoanalytics_content** -> `cisoanalytics-content` (Type: layout, Required: 0)
* **cisoanalytics_btn_2** -> `cisoanalytics-btn-2` (Type: button, Required: 0)
* **cisoanalytics_btn_1** -> `cisoanalytics-btn-1` (Type: button, Required: 0)
* **cisoanalytics_btn_3** -> `cisoanalytics-btn-3` (Type: button, Required: 0)
* **cisoanalytics_screen** -> `cisoanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `164` (Required: 1)
* Component ID: `698` (Required: 1)
* Component ID: `1232` (Required: 1)
* Component ID: `2940` (Required: 1)
* Component ID: `2941` (Required: 1)
* Component ID: `2942` (Required: 1)
* Component ID: `2943` (Required: 1)
* Component ID: `2944` (Required: 1)
* Component ID: `2945` (Required: 1)
* Component ID: `2946` (Required: 1)
* Component ID: `2947` (Required: 1)
* Component ID: `2948` (Required: 1)
* Component ID: `2949` (Required: 1)

## 7. API / Data Mapping
* API ID: `4439` (Required: 1)
* API ID: `4440` (Required: 1)
* API ID: `4441` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ciso_analytics_runtime`
* **Test Name**: `CisoAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ciso Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ciso`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Ciso Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Ciso Analytics`)
5. **check_url** (Selector: `None`, Value: `/executive/ciso-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
