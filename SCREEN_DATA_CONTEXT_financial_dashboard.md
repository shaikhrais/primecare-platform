# SCREEN DATA CONTEXT: financial_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - FinancialDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `475`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `financial_dashboard`
* **Screen Name**: `FinancialDashboardScreen`
* **Route Path**: `/executive/financial-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `21`
* **Role Code**: `cfo`
* **Role Name**: `Chief Financial Officer (CFO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to financialdashboardscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the FinancialDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinancialDashboardScreen`
* **Acceptance Criteria**:
- The FinancialDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `financial_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `financial_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `financial_dashboard-content` (Type: layout, Required: 1)
* **financialdashboard_btn_1** -> `financialdashboard-btn-1` (Type: button, Required: 0)
* **financialdashboard_screen** -> `financialdashboard-screen` (Type: layout, Required: 0)
* **financialdashboard_content** -> `financialdashboard-content` (Type: layout, Required: 0)
* **financialdashboard_btn_3** -> `financialdashboard-btn-3` (Type: button, Required: 0)
* **financialdashboard_btn_2** -> `financialdashboard-btn-2` (Type: button, Required: 0)
* **financialdashboard_title** -> `financialdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `404` (Required: 1)
* Component ID: `938` (Required: 1)
* Component ID: `1472` (Required: 1)
* Component ID: `5133` (Required: 1)
* Component ID: `5134` (Required: 1)
* Component ID: `5135` (Required: 1)
* Component ID: `5136` (Required: 1)
* Component ID: `5137` (Required: 1)
* Component ID: `5138` (Required: 1)
* Component ID: `5139` (Required: 1)
* Component ID: `5140` (Required: 1)
* Component ID: `5141` (Required: 1)
* Component ID: `5142` (Required: 1)

## 7. API / Data Mapping
* API ID: `4792` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `financial_dashboard_runtime`
* **Test Name**: `FinancialDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Financial Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Financial Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Financial Dashboard`)
5. **check_url** (Selector: `None`, Value: `/executive/financial-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
