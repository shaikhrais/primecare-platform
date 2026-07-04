# SCREEN DATA CONTEXT: owner_analytics

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - OwnerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `177`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `owner_analytics`
* **Screen Name**: `OwnerAnalyticsScreen`
* **Route Path**: `/executive/owner-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/owner_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to owneranalyticsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the OwnerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OwnerAnalyticsScreen`
* **Acceptance Criteria**:
- The OwnerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `owner_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `owner_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `owner_analytics-content` (Type: layout, Required: 1)
* **owneranalytics_btn_1** -> `owneranalytics-btn-1` (Type: button, Required: 0)
* **owneranalytics_screen** -> `owneranalytics-screen` (Type: layout, Required: 0)
* **owneranalytics_title** -> `owneranalytics-title` (Type: header, Required: 0)
* **owneranalytics_content** -> `owneranalytics-content` (Type: layout, Required: 0)
* **owneranalytics_btn_2** -> `owneranalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `185` (Required: 1)
* Component ID: `719` (Required: 1)
* Component ID: `1253` (Required: 1)
* Component ID: `3149` (Required: 1)
* Component ID: `3150` (Required: 1)
* Component ID: `3151` (Required: 1)
* Component ID: `3152` (Required: 1)
* Component ID: `3153` (Required: 1)
* Component ID: `3154` (Required: 1)
* Component ID: `3155` (Required: 1)
* Component ID: `3156` (Required: 1)
* Component ID: `3157` (Required: 1)
* Component ID: `3158` (Required: 1)

## 7. API / Data Mapping
* API ID: `4466` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `owner_analytics_runtime`
* **Test Name**: `OwnerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OwnerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/executive/owner-analytics`)
3. **should_be_visible** (Selector: `owner_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `owner_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `owner_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
