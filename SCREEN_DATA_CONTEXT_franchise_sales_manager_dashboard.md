# SCREEN DATA CONTEXT: franchise_sales_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Franchise Sales Manager - FranchiseSalesManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `46`
* **App ID**: `9`
* **Role ID**: `34`
* **Screen Code**: `franchise_sales_manager_dashboard`
* **Screen Name**: `FranchiseSalesManagerDashboardScreen`
* **Route Path**: `/offices/business_development/roles/franchise_sales_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `34`
* **Role Code**: `franchise_sales`
* **Role Name**: `Franchise Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Sales Manager personnel to oversee, audit, and coordinate operations related to franchisesalesmanagerdashboardscreen.`
* **User Story**: `As a Franchise Sales Manager, I want to access the FranchiseSalesManagerDashboardScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseSalesManagerDashboardScreen`
* **Acceptance Criteria**:
- The FranchiseSalesManagerDashboardScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_dashboard-content` (Type: layout, Required: 1)
* **franchisesalesmanagerdashboard_content** -> `franchisesalesmanagerdashboard-content` (Type: layout, Required: 0)
* **franchisesalesmanagerdashboard_btn_1** -> `franchisesalesmanagerdashboard-btn-1` (Type: button, Required: 0)
* **franchisesalesmanagerdashboard_btn_2** -> `franchisesalesmanagerdashboard-btn-2` (Type: button, Required: 0)
* **franchisesalesmanagerdashboard_title** -> `franchisesalesmanagerdashboard-title` (Type: header, Required: 0)
* **franchisesalesmanagerdashboard_screen** -> `franchisesalesmanagerdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `54` (Required: 1)
* Component ID: `588` (Required: 1)
* Component ID: `1122` (Required: 1)
* Component ID: `1985` (Required: 1)
* Component ID: `1986` (Required: 1)
* Component ID: `1987` (Required: 1)
* Component ID: `1988` (Required: 1)
* Component ID: `1989` (Required: 1)
* Component ID: `1990` (Required: 1)
* Component ID: `1991` (Required: 1)
* Component ID: `1992` (Required: 1)
* Component ID: `1993` (Required: 1)
* Component ID: `1994` (Required: 1)

## 7. API / Data Mapping
* API ID: `4301` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_dashboard_runtime`
* **Test Name**: `FranchiseSalesManagerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Sales Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `franchise_sales`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Sales Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Sales Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/business_development/roles/franchise_sales_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
