# SCREEN DATA CONTEXT: revenue_analytics

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - RevenueAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `467`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `revenue_analytics`
* **Screen Name**: `RevenueAnalyticsScreen`
* **Route Path**: `/executive/revenue-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/revenue_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `20`
* **Role Code**: `ceo`
* **Role Name**: `Chief Executive Officer (CEO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to revenueanalyticsscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the RevenueAnalyticsScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RevenueAnalyticsScreen`
* **Acceptance Criteria**:
- The RevenueAnalyticsScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `revenue_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `revenue_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `revenue_analytics-content` (Type: layout, Required: 1)
* **revenueanalytics_title** -> `revenueanalytics-title` (Type: header, Required: 0)
* **revenueanalytics_btn_3** -> `revenueanalytics-btn-3` (Type: button, Required: 0)
* **revenueanalytics_btn_2** -> `revenueanalytics-btn-2` (Type: button, Required: 0)
* **revenueanalytics_screen** -> `revenueanalytics-screen` (Type: layout, Required: 0)
* **revenueanalytics_content** -> `revenueanalytics-content` (Type: layout, Required: 0)
* **revenueanalytics_btn_1** -> `revenueanalytics-btn-1` (Type: button, Required: 0)
* **revenueanalytics_loading** -> `revenueanalytics-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `396` (Required: 1)
* Component ID: `930` (Required: 1)
* Component ID: `1464` (Required: 1)
* Component ID: `5056` (Required: 1)
* Component ID: `5057` (Required: 1)
* Component ID: `5058` (Required: 1)
* Component ID: `5059` (Required: 1)
* Component ID: `5060` (Required: 1)
* Component ID: `5061` (Required: 1)
* Component ID: `5062` (Required: 1)

## 7. API / Data Mapping
* API ID: `4783` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `revenue_analytics_runtime`
* **Test Name**: `RevenueAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Revenue Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Revenue Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Revenue Analytics`)
5. **check_url** (Selector: `None`, Value: `/executive/revenue-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
