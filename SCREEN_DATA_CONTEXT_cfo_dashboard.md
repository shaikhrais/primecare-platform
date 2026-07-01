# SCREEN DATA CONTEXT: cfo_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `33`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_dashboard`
* **Screen Name**: `CfoDashboardScreen`
* **Route Path**: `/offices/corporate/roles/cfo/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/cfo_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfodashboardscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoDashboardScreen`
* **Acceptance Criteria**:
- The CfoDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `41` (Required: 1)
* Component ID: `575` (Required: 1)
* Component ID: `1109` (Required: 1)
* Component ID: `1864` (Required: 1)
* Component ID: `1865` (Required: 1)
* Component ID: `1866` (Required: 1)
* Component ID: `1867` (Required: 1)
* Component ID: `1868` (Required: 1)
* Component ID: `1869` (Required: 1)
* Component ID: `1870` (Required: 1)
* Component ID: `1871` (Required: 1)
* Component ID: `1872` (Required: 1)
* Component ID: `1873` (Required: 1)

## 7. API / Data Mapping
* API ID: `4286` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_dashboard_runtime`
* **Test Name**: `CfoDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cfo/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
