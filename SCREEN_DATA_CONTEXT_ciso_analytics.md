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
* **Stage/Status**: `template_created`

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
* **Test Name**: `CisoAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CisoAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ciso`)
2. **visit** (Selector: `None`, Value: `/executive/ciso-analytics`)
3. **should_be_visible** (Selector: `ciso_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ciso_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `ciso_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
