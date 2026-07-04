# SCREEN DATA CONTEXT: franchise_sales_analytics

Below are the database records from `governance.db` used to configure and build the **Franchise Sales Manager - FranchiseSalesManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `605`
* **App ID**: `1`
* **Role ID**: `34`
* **Screen Code**: `franchise_sales_analytics`
* **Screen Name**: `FranchiseSalesManagerAnalyticsScreen`
* **Route Path**: `/executive/franchise-sales-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_sales_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `34`
* **Role Code**: `franchise_sales`
* **Role Name**: `Franchise Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Sales Manager personnel to oversee, audit, and coordinate operations related to franchise sales manager analytics.`
* **User Story**: `As a Franchise Sales Manager, I want to access the Franchise Sales Manager Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Sales Manager Analytics`
* **Acceptance Criteria**:
- The Franchise Sales Manager Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_analytics-content` (Type: layout, Required: 1)
* **franchise sales manager analytics_btn_1** -> `franchise sales manager analytics-btn-1` (Type: button, Required: 0)
* **franchise sales manager analytics_screen** -> `franchise sales manager analytics-screen` (Type: layout, Required: 0)
* **franchise sales manager analytics_content** -> `franchise sales manager analytics-content` (Type: layout, Required: 0)
* **franchise sales manager analytics_title** -> `franchise sales manager analytics-title` (Type: header, Required: 0)
* **franchise sales manager analytics_btn_2** -> `franchise sales manager analytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `529` (Required: 1)
* Component ID: `1063` (Required: 1)
* Component ID: `1597` (Required: 1)
* Component ID: `6289` (Required: 1)
* Component ID: `6290` (Required: 1)
* Component ID: `6291` (Required: 1)
* Component ID: `6292` (Required: 1)
* Component ID: `6293` (Required: 1)
* Component ID: `6294` (Required: 1)
* Component ID: `6295` (Required: 1)
* Component ID: `6296` (Required: 1)
* Component ID: `6297` (Required: 1)
* Component ID: `6298` (Required: 1)

## 7. API / Data Mapping
* API ID: `4954` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_analytics_runtime`
* **Test Name**: `Franchise Sales Manager Analytics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Sales Manager Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `franchise_sales`)
2. **visit** (Selector: `None`, Value: `/executive/franchise-sales-analytics`)
3. **should_be_visible** (Selector: `franchise_sales_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_sales_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_sales_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
