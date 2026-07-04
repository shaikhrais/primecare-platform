# SCREEN DATA CONTEXT: territory_sales_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Territory Sales Manager - TerritorySalesManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `59`
* **App ID**: `5`
* **Role ID**: `47`
* **Screen Code**: `territory_sales_manager_dashboard`
* **Screen Name**: `TerritorySalesManagerDashboardScreen`
* **Route Path**: `/offices/marketing/roles/territory_sales_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_sales_manager_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `47`
* **Role Code**: `territory_sales`
* **Role Name**: `Territory Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Territory Sales Manager personnel to oversee, audit, and coordinate operations related to territorysalesmanagerdashboardscreen.`
* **User Story**: `As a Territory Sales Manager, I want to access the TerritorySalesManagerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritorySalesManagerDashboardScreen`
* **Acceptance Criteria**:
- The TerritorySalesManagerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_dashboard-content` (Type: layout, Required: 1)
* **territorysalesmanagerdashboard_title** -> `territorysalesmanagerdashboard-title` (Type: header, Required: 0)
* **territorysalesmanagerdashboard_btn_2** -> `territorysalesmanagerdashboard-btn-2` (Type: button, Required: 0)
* **territorysalesmanagerdashboard_btn_1** -> `territorysalesmanagerdashboard-btn-1` (Type: button, Required: 0)
* **territorysalesmanagerdashboard_screen** -> `territorysalesmanagerdashboard-screen` (Type: layout, Required: 0)
* **territorysalesmanagerdashboard_content** -> `territorysalesmanagerdashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `67` (Required: 1)
* Component ID: `601` (Required: 1)
* Component ID: `1135` (Required: 1)
* Component ID: `2106` (Required: 1)
* Component ID: `2107` (Required: 1)
* Component ID: `2108` (Required: 1)
* Component ID: `2109` (Required: 1)
* Component ID: `2110` (Required: 1)
* Component ID: `2111` (Required: 1)
* Component ID: `2112` (Required: 1)
* Component ID: `2113` (Required: 1)
* Component ID: `2114` (Required: 1)
* Component ID: `2115` (Required: 1)

## 7. API / Data Mapping
* API ID: `4314` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_dashboard_runtime`
* **Test Name**: `TerritorySalesManagerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `TerritorySalesManagerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_sales`)
2. **visit** (Selector: `None`, Value: `/offices/marketing/roles/territory_sales_manager/dashboard`)
3. **should_be_visible** (Selector: `territory_sales_manager_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `territory_sales_manager_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `territory_sales_manager_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
