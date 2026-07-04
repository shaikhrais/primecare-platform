# SCREEN DATA CONTEXT: rn_analytics

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `239`
* **App ID**: `1`
* **Role ID**: `8`
* **Screen Code**: `rn_analytics`
* **Screen Name**: `RnAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnanalyticsscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnAnalyticsScreen`
* **Acceptance Criteria**:
- The RnAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `rn_analytics-content` (Type: layout, Required: 1)
* **rnanalytics_btn_1** -> `rnanalytics-btn-1` (Type: button, Required: 0)
* **rnanalytics_screen** -> `rnanalytics-screen` (Type: layout, Required: 0)
* **rnanalytics_btn_4** -> `rnanalytics-btn-4` (Type: button, Required: 0)
* **rnanalytics_btn_2** -> `rnanalytics-btn-2` (Type: button, Required: 0)
* **rnanalytics_content** -> `rnanalytics-content` (Type: layout, Required: 0)
* **rnanalytics_btn_3** -> `rnanalytics-btn-3` (Type: button, Required: 0)
* **rnanalytics_title** -> `rnanalytics-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `247` (Required: 1)
* Component ID: `781` (Required: 1)
* Component ID: `1315` (Required: 1)
* Component ID: `3712` (Required: 1)
* Component ID: `3713` (Required: 1)
* Component ID: `3714` (Required: 1)
* Component ID: `3715` (Required: 1)
* Component ID: `3716` (Required: 1)
* Component ID: `3717` (Required: 1)
* Component ID: `3718` (Required: 1)
* Component ID: `3719` (Required: 1)
* Component ID: `3720` (Required: 1)
* Component ID: `3721` (Required: 1)

## 7. API / Data Mapping
* API ID: `4536` (Required: 1)
* API ID: `4537` (Required: 1)
* API ID: `4538` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_analytics_runtime`
* **Test Name**: `RnAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-analytics`)
3. **should_be_visible** (Selector: `rn_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
