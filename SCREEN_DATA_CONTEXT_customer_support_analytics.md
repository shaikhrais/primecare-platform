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
* **Stage/Status**: `template_created`

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
* **Test Name**: `CustomerSupportAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CustomerSupportAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **visit** (Selector: `None`, Value: `/common/customer-support-analytics`)
3. **should_be_visible** (Selector: `customer_support_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `customer_support_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `customer_support_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
