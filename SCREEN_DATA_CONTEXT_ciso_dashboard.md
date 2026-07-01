# SCREEN DATA CONTEXT: ciso_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Information Security Officer (CISO) - CisoDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `34`
* **App ID**: `7`
* **Role ID**: `22`
* **Screen Code**: `ciso_dashboard`
* **Screen Name**: `CisoDashboardScreen`
* **Route Path**: `/offices/corporate/roles/ciso/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/ciso_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `22`
* **Role Code**: `ciso`
* **Role Name**: `Chief Information Security Officer (CISO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Information Security Officer (CISO) personnel to oversee, audit, and coordinate operations related to cisodashboardscreen.`
* **User Story**: `As a Chief Information Security Officer (CISO), I want to access the CisoDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CisoDashboardScreen`
* **Acceptance Criteria**:
- The CisoDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Information Security Officer (CISO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ciso_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `ciso_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `ciso_dashboard-content` (Type: layout, Required: 1)
* **cisodashboard_content** -> `cisodashboard-content` (Type: layout, Required: 0)
* **cisodashboard_loading** -> `cisodashboard-loading` (Type: loading, Required: 0)
* **cisodashboard_btn_2** -> `cisodashboard-btn-2` (Type: button, Required: 0)
* **cisodashboard_btn_3** -> `cisodashboard-btn-3` (Type: button, Required: 0)
* **cisodashboard_btn_1** -> `cisodashboard-btn-1` (Type: button, Required: 0)
* **cisodashboard_title** -> `cisodashboard-title` (Type: header, Required: 0)
* **cisodashboard_screen** -> `cisodashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `42` (Required: 1)
* Component ID: `576` (Required: 1)
* Component ID: `1110` (Required: 1)
* Component ID: `1874` (Required: 1)
* Component ID: `1875` (Required: 1)
* Component ID: `1876` (Required: 1)
* Component ID: `1877` (Required: 1)
* Component ID: `1878` (Required: 1)
* Component ID: `1879` (Required: 1)
* Component ID: `1880` (Required: 1)
* Component ID: `1881` (Required: 1)
* Component ID: `1882` (Required: 1)
* Component ID: `1883` (Required: 1)

## 7. API / Data Mapping
* API ID: `4287` (Required: 1)
* API ID: `4288` (Required: 1)
* API ID: `4289` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ciso_dashboard_runtime`
* **Test Name**: `CisoDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ciso Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ciso`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Ciso Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Ciso Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/ciso/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
