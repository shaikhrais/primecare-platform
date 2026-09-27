# SCREEN DATA CONTEXT: cto_analytics

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - CtoAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `162`
* **App ID**: `1`
* **Role ID**: `24`
* **Screen Code**: `cto_analytics`
* **Screen Name**: `CtoAnalyticsScreen`
* **Route Path**: `/executive/cto-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cto_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to ctoanalyticsscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the CtoAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CtoAnalyticsScreen`
* **Acceptance Criteria**:
- The CtoAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `cto_analytics-content` (Type: layout, Required: 1)
* **ctoanalytics_content** -> `ctoanalytics-content` (Type: layout, Required: 0)
* **ctoanalytics_btn_2** -> `ctoanalytics-btn-2` (Type: button, Required: 0)
* **ctoanalytics_btn_1** -> `ctoanalytics-btn-1` (Type: button, Required: 0)
* **ctoanalytics_title** -> `ctoanalytics-title` (Type: header, Required: 0)
* **ctoanalytics_screen** -> `ctoanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `170` (Required: 1)
* Component ID: `704` (Required: 1)
* Component ID: `1238` (Required: 1)
* Component ID: `3000` (Required: 1)
* Component ID: `3001` (Required: 1)
* Component ID: `3002` (Required: 1)
* Component ID: `3003` (Required: 1)
* Component ID: `3004` (Required: 1)
* Component ID: `3005` (Required: 1)
* Component ID: `3006` (Required: 1)
* Component ID: `3007` (Required: 1)
* Component ID: `3008` (Required: 1)
* Component ID: `3009` (Required: 1)

## 7. API / Data Mapping
* API ID: `4451` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_analytics_runtime`
* **Test Name**: `CtoAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CtoAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **visit** (Selector: `None`, Value: `/executive/cto-analytics`)
3. **should_be_visible** (Selector: `cto_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
