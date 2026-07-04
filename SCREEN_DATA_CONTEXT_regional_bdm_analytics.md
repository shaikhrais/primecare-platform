# SCREEN DATA CONTEXT: regional_bdm_analytics

Below are the database records from `governance.db` used to configure and build the **Regional BDM - RegionalBdmAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `216`
* **App ID**: `1`
* **Role ID**: `42`
* **Screen Code**: `regional_bdm_analytics`
* **Screen Name**: `RegionalBdmAnalyticsScreen`
* **Route Path**: `/management/regional-bdm-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_bdm_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `42`
* **Role Code**: `regional_bdm`
* **Role Name**: `Regional BDM`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Regional BDM personnel to oversee, audit, and coordinate operations related to regionalbdmanalyticsscreen.`
* **User Story**: `As a Regional BDM, I want to access the RegionalBdmAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalBdmAnalyticsScreen`
* **Acceptance Criteria**:
- The RegionalBdmAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional BDM access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_analytics-content` (Type: layout, Required: 1)
* **regionalbdmanalytics_btn_2** -> `regionalbdmanalytics-btn-2` (Type: button, Required: 0)
* **regionalbdmanalytics_btn_1** -> `regionalbdmanalytics-btn-1` (Type: button, Required: 0)
* **regionalbdmanalytics_title** -> `regionalbdmanalytics-title` (Type: header, Required: 0)
* **regionalbdmanalytics_content** -> `regionalbdmanalytics-content` (Type: layout, Required: 0)
* **regionalbdmanalytics_screen** -> `regionalbdmanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `224` (Required: 1)
* Component ID: `758` (Required: 1)
* Component ID: `1292` (Required: 1)
* Component ID: `3507` (Required: 1)
* Component ID: `3508` (Required: 1)
* Component ID: `3509` (Required: 1)
* Component ID: `3510` (Required: 1)
* Component ID: `3511` (Required: 1)
* Component ID: `3512` (Required: 1)
* Component ID: `3513` (Required: 1)
* Component ID: `3514` (Required: 1)
* Component ID: `3515` (Required: 1)
* Component ID: `3516` (Required: 1)

## 7. API / Data Mapping
* API ID: `4505` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_analytics_runtime`
* **Test Name**: `RegionalBdmAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RegionalBdmAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_bdm`)
2. **visit** (Selector: `None`, Value: `/management/regional-bdm-analytics`)
3. **should_be_visible** (Selector: `regional_bdm_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_bdm_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_bdm_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
