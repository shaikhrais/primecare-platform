# SCREEN DATA CONTEXT: customer_support_analytics

Below are the database records from `governance.db` used to configure and build the **Customer Support - CustomerSupportAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `101`
* **App ID**: `1`
* **Role ID**: `61`
* **Screen Code**: `customer_support_analytics`
* **Screen Name**: `CustomerSupportAnalyticsScreen`
* **Route Path**: `/common/customer-support-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/customer_support_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to customersupportanalyticsscreen.`
* **User Story**: `As a Customer Support, I want to access the CustomerSupportAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CustomerSupportAnalyticsScreen`
* **Acceptance Criteria**:
- The CustomerSupportAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `customer_support_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `customer_support_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `customer_support_analytics-content` (Type: layout, Required: 1)
* **customersupportanalytics_title** -> `customersupportanalytics-title` (Type: header, Required: 0)
* **customersupportanalytics_btn_1** -> `customersupportanalytics-btn-1` (Type: button, Required: 0)
* **customersupportanalytics_screen** -> `customersupportanalytics-screen` (Type: layout, Required: 0)
* **customersupportanalytics_content** -> `customersupportanalytics-content` (Type: layout, Required: 0)
* **customersupportanalytics_btn_2** -> `customersupportanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `109` (Required: 1)
* Component ID: `643` (Required: 1)
* Component ID: `1177` (Required: 1)
* Component ID: `2483` (Required: 1)
* Component ID: `2484` (Required: 1)
* Component ID: `2485` (Required: 1)
* Component ID: `2486` (Required: 1)
* Component ID: `2487` (Required: 1)
* Component ID: `2488` (Required: 1)
* Component ID: `2489` (Required: 1)
* Component ID: `2490` (Required: 1)
* Component ID: `2491` (Required: 1)
* Component ID: `2492` (Required: 1)

## 7. API / Data Mapping
* API ID: `4378` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `customer_support_analytics_runtime`
* **Test Name**: `CustomerSupportAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Customer Support Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Customer Support Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Customer Support Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/customer-support-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
