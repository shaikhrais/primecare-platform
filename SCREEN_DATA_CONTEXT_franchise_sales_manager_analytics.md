# SCREEN DATA CONTEXT: franchise_sales_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseSalesManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `192`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_sales_manager_analytics`
* **Screen Name**: `FranchiseSalesManagerAnalyticsScreen`
* **Route Path**: `/management/franchise-sales-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_analytics_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisesalesmanageranalyticsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseSalesManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseSalesManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The FranchiseSalesManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_analytics-content` (Type: layout, Required: 1)
* **franchisesalesmanageranalytics_title** -> `franchisesalesmanageranalytics-title` (Type: header, Required: 0)
* **franchisesalesmanageranalytics_content** -> `franchisesalesmanageranalytics-content` (Type: layout, Required: 0)
* **franchisesalesmanageranalytics_screen** -> `franchisesalesmanageranalytics-screen` (Type: layout, Required: 0)
* **franchisesalesmanageranalytics_btn_1** -> `franchisesalesmanageranalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `200` (Required: 1)
* Component ID: `734` (Required: 1)
* Component ID: `1268` (Required: 1)
* Component ID: `3273` (Required: 1)
* Component ID: `3274` (Required: 1)
* Component ID: `3275` (Required: 1)
* Component ID: `3276` (Required: 1)
* Component ID: `3277` (Required: 1)
* Component ID: `3278` (Required: 1)
* Component ID: `3279` (Required: 1)
* Component ID: `3280` (Required: 1)
* Component ID: `3281` (Required: 1)
* Component ID: `3282` (Required: 1)

## 7. API / Data Mapping
* API ID: `4481` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_analytics_runtime`
* **Test Name**: `FranchiseSalesManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseSalesManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/management/franchise-sales-manager-analytics`)
3. **should_be_visible** (Selector: `franchise_sales_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_sales_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_sales_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
