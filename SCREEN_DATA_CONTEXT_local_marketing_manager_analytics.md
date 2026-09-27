# SCREEN DATA CONTEXT: local_marketing_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Local Marketing Manager - LocalMarketingManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `207`
* **App ID**: `1`
* **Role ID**: `39`
* **Screen Code**: `local_marketing_manager_analytics`
* **Screen Name**: `LocalMarketingManagerAnalyticsScreen`
* **Route Path**: `/management/local-marketing-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/local_marketing_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `39`
* **Role Code**: `local_marketing`
* **Role Name**: `Local Marketing Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Local Marketing Manager personnel to oversee, audit, and coordinate operations related to localmarketingmanageranalyticsscreen.`
* **User Story**: `As a Local Marketing Manager, I want to access the LocalMarketingManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `LocalMarketingManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The LocalMarketingManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Local Marketing Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `local_marketing_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `local_marketing_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `local_marketing_manager_analytics-content` (Type: layout, Required: 1)
* **localmarketingmanageranalytics_btn_1** -> `localmarketingmanageranalytics-btn-1` (Type: button, Required: 0)
* **localmarketingmanageranalytics_content** -> `localmarketingmanageranalytics-content` (Type: layout, Required: 0)
* **localmarketingmanageranalytics_title** -> `localmarketingmanageranalytics-title` (Type: header, Required: 0)
* **localmarketingmanageranalytics_screen** -> `localmarketingmanageranalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `215` (Required: 1)
* Component ID: `749` (Required: 1)
* Component ID: `1283` (Required: 1)
* Component ID: `3423` (Required: 1)
* Component ID: `3424` (Required: 1)
* Component ID: `3425` (Required: 1)
* Component ID: `3426` (Required: 1)
* Component ID: `3427` (Required: 1)
* Component ID: `3428` (Required: 1)
* Component ID: `3429` (Required: 1)
* Component ID: `3430` (Required: 1)
* Component ID: `3431` (Required: 1)
* Component ID: `3432` (Required: 1)

## 7. API / Data Mapping
* API ID: `4496` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `local_marketing_manager_analytics_runtime`
* **Test Name**: `LocalMarketingManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `LocalMarketingManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `local_marketing`)
2. **visit** (Selector: `None`, Value: `/management/local-marketing-manager-analytics`)
3. **should_be_visible** (Selector: `local_marketing_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `local_marketing_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `local_marketing_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
