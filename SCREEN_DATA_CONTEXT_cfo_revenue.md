# SCREEN DATA CONTEXT: cfo_revenue

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoRevenueScreen** screen.

---

## 1. Screen Record
* **ID**: `283`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_revenue`
* **Screen Name**: `CfoRevenueScreen`
* **Route Path**: `/offices/corporate/roles/cfo/revenue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_revenue_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cforevenuescreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoRevenueScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoRevenueScreen`
* **Acceptance Criteria**:
- The CfoRevenueScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_revenue-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_revenue-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_revenue-content` (Type: layout, Required: 1)
* **cforevenue_screen** -> `cforevenue-screen` (Type: layout, Required: 0)
* **cforevenue_btn_3** -> `cforevenue-btn-3` (Type: button, Required: 0)
* **cforevenue_btn_2** -> `cforevenue-btn-2` (Type: button, Required: 0)
* **cforevenue_btn_1** -> `cforevenue-btn-1` (Type: button, Required: 0)
* **cforevenue_loading** -> `cforevenue-loading` (Type: loading, Required: 0)
* **cforevenue_content** -> `cforevenue-content` (Type: layout, Required: 0)
* **cforevenue_title** -> `cforevenue-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `291` (Required: 1)
* Component ID: `825` (Required: 1)
* Component ID: `1359` (Required: 1)
* Component ID: `4099` (Required: 1)
* Component ID: `4100` (Required: 1)
* Component ID: `4101` (Required: 1)
* Component ID: `4102` (Required: 1)
* Component ID: `4103` (Required: 1)
* Component ID: `4104` (Required: 1)
* Component ID: `4105` (Required: 1)
* Component ID: `4106` (Required: 1)
* Component ID: `4107` (Required: 1)
* Component ID: `4108` (Required: 1)

## 7. API / Data Mapping
* API ID: `4606` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_revenue_runtime`
* **Test Name**: `CfoRevenueScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Revenue`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Revenue`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Revenue`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cfo/revenue`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
