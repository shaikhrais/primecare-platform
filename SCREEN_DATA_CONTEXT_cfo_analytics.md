# SCREEN DATA CONTEXT: cfo_analytics

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `153`
* **App ID**: `1`
* **Role ID**: `21`
* **Screen Code**: `cfo_analytics`
* **Screen Name**: `CfoAnalyticsScreen`
* **Route Path**: `/executive/cfo-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `21`
* **Role Code**: `cfo`
* **Role Name**: `Chief Financial Officer (CFO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfoanalyticsscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoAnalyticsScreen`
* **Acceptance Criteria**:
- The CfoAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_analytics-content` (Type: layout, Required: 1)
* **cfoanalytics_content** -> `cfoanalytics-content` (Type: layout, Required: 0)
* **cfoanalytics_title** -> `cfoanalytics-title` (Type: header, Required: 0)
* **cfoanalytics_btn_1** -> `cfoanalytics-btn-1` (Type: button, Required: 0)
* **cfoanalytics_btn_2** -> `cfoanalytics-btn-2` (Type: button, Required: 0)
* **cfoanalytics_screen** -> `cfoanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `161` (Required: 1)
* Component ID: `695` (Required: 1)
* Component ID: `1229` (Required: 1)
* Component ID: `2910` (Required: 1)
* Component ID: `2911` (Required: 1)
* Component ID: `2912` (Required: 1)
* Component ID: `2913` (Required: 1)
* Component ID: `2914` (Required: 1)
* Component ID: `2915` (Required: 1)
* Component ID: `2916` (Required: 1)
* Component ID: `2917` (Required: 1)
* Component ID: `2918` (Required: 1)
* Component ID: `2919` (Required: 1)

## 7. API / Data Mapping
* API ID: `4436` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_analytics_runtime`
* **Test Name**: `CfoAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/executive/cfo-analytics`)
3. **should_be_visible** (Selector: `cfo_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
