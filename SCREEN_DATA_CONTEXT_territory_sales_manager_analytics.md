# SCREEN DATA CONTEXT: territory_sales_manager_analytics

Below are the database records from `governance.db` used to configure and build the **Territory Sales Manager - TerritorySalesManagerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `228`
* **App ID**: `1`
* **Role ID**: `47`
* **Screen Code**: `territory_sales_manager_analytics`
* **Screen Name**: `TerritorySalesManagerAnalyticsScreen`
* **Route Path**: `/management/territory-sales-manager-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_sales_manager_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `47`
* **Role Code**: `territory_sales`
* **Role Name**: `Territory Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Territory Sales Manager personnel to oversee, audit, and coordinate operations related to territorysalesmanageranalyticsscreen.`
* **User Story**: `As a Territory Sales Manager, I want to access the TerritorySalesManagerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritorySalesManagerAnalyticsScreen`
* **Acceptance Criteria**:
- The TerritorySalesManagerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_analytics-content` (Type: layout, Required: 1)
* **territorysalesmanageranalytics_content** -> `territorysalesmanageranalytics-content` (Type: layout, Required: 0)
* **territorysalesmanageranalytics_title** -> `territorysalesmanageranalytics-title` (Type: header, Required: 0)
* **territorysalesmanageranalytics_btn_1** -> `territorysalesmanageranalytics-btn-1` (Type: button, Required: 0)
* **territorysalesmanageranalytics_screen** -> `territorysalesmanageranalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `236` (Required: 1)
* Component ID: `770` (Required: 1)
* Component ID: `1304` (Required: 1)
* Component ID: `3617` (Required: 1)
* Component ID: `3618` (Required: 1)
* Component ID: `3619` (Required: 1)
* Component ID: `3620` (Required: 1)
* Component ID: `3621` (Required: 1)
* Component ID: `3622` (Required: 1)
* Component ID: `3623` (Required: 1)
* Component ID: `3624` (Required: 1)
* Component ID: `3625` (Required: 1)

## 7. API / Data Mapping
* API ID: `4517` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_analytics_runtime`
* **Test Name**: `TerritorySalesManagerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TerritorySalesManagerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_sales`)
2. **visit** (Selector: `None`, Value: `/management/territory-sales-manager-analytics`)
3. **should_be_visible** (Selector: `territory_sales_manager_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_sales_manager_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_sales_manager_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
