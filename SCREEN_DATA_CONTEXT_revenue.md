# SCREEN DATA CONTEXT: revenue

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - RevenueScreen** screen.

---

## 1. Screen Record
* **ID**: `476`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `revenue`
* **Screen Name**: `RevenueScreen`
* **Route Path**: `/executive/revenue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/revenue_screen.dart`
* **Stage/Status**: `production_ready`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to revenuescreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the RevenueScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RevenueScreen`
* **Acceptance Criteria**:
- The RevenueScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `revenue-screen` (Type: layout, Required: 1)
* **page_title** -> `revenue-title` (Type: header, Required: 1)
* **primary_content** -> `revenue-content` (Type: layout, Required: 1)
* **revenue_btn_2** -> `revenue-btn-2` (Type: button, Required: 0)
* **revenue_btn_3** -> `revenue-btn-3` (Type: button, Required: 0)
* **revenue_loading** -> `revenue-loading` (Type: loading, Required: 0)
* **revenue_btn_1** -> `revenue-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `405` (Required: 1)
* Component ID: `939` (Required: 1)
* Component ID: `1473` (Required: 1)
* Component ID: `5143` (Required: 1)
* Component ID: `5144` (Required: 1)
* Component ID: `5145` (Required: 1)
* Component ID: `5146` (Required: 1)
* Component ID: `5147` (Required: 1)
* Component ID: `5148` (Required: 1)
* Component ID: `5149` (Required: 1)
* Component ID: `5150` (Required: 1)
* Component ID: `5151` (Required: 1)
* Component ID: `5152` (Required: 1)

## 7. API / Data Mapping
* API ID: `4793` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `revenue_runtime`
* **Test Name**: `RevenueScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Revenue`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Revenue`)
4. **click_sidebar_link** (Selector: `None`, Value: `Revenue`)
5. **check_url** (Selector: `None`, Value: `/executive/revenue`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
