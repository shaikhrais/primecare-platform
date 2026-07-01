# SCREEN DATA CONTEXT: support_analytics

Below are the database records from `governance.db` used to configure and build the **Customer Support - SupportAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `141`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `support_analytics`
* **Screen Name**: `SupportAnalyticsScreen`
* **Route Path**: `/common/support-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/support_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to supportanalyticsscreen.`
* **User Story**: `As a Customer Support, I want to access the SupportAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SupportAnalyticsScreen`
* **Acceptance Criteria**:
- The SupportAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `support_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `support_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `support_analytics-content` (Type: layout, Required: 1)
* **supportanalytics_screen** -> `supportanalytics-screen` (Type: layout, Required: 0)
* **supportanalytics_title** -> `supportanalytics-title` (Type: header, Required: 0)
* **supportanalytics_btn_2** -> `supportanalytics-btn-2` (Type: button, Required: 0)
* **supportanalytics_btn_1** -> `supportanalytics-btn-1` (Type: button, Required: 0)
* **supportanalytics_content** -> `supportanalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `149` (Required: 1)
* Component ID: `683` (Required: 1)
* Component ID: `1217` (Required: 1)
* Component ID: `2807` (Required: 1)
* Component ID: `2808` (Required: 1)
* Component ID: `2809` (Required: 1)
* Component ID: `2810` (Required: 1)
* Component ID: `2811` (Required: 1)
* Component ID: `2812` (Required: 1)
* Component ID: `2813` (Required: 1)

## 7. API / Data Mapping
* API ID: `4424` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `support_analytics_runtime`
* **Test Name**: `SupportAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Support Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Support Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Support Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/support-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
