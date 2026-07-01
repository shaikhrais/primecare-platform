# SCREEN DATA CONTEXT: cto_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - CtoDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `36`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `cto_dashboard`
* **Screen Name**: `CtoDashboardScreen`
* **Route Path**: `/offices/corporate/roles/cto/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/cto_dashboard.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to ctodashboardscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the CtoDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CtoDashboardScreen`
* **Acceptance Criteria**:
- The CtoDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `cto_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `44` (Required: 1)
* Component ID: `578` (Required: 1)
* Component ID: `1112` (Required: 1)
* Component ID: `1894` (Required: 1)
* Component ID: `1895` (Required: 1)
* Component ID: `1896` (Required: 1)
* Component ID: `1897` (Required: 1)
* Component ID: `1898` (Required: 1)
* Component ID: `1899` (Required: 1)
* Component ID: `1900` (Required: 1)
* Component ID: `1901` (Required: 1)
* Component ID: `1902` (Required: 1)
* Component ID: `1903` (Required: 1)

## 7. API / Data Mapping
* API ID: `4291` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_dashboard_runtime`
* **Test Name**: `CtoDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CTO Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CTO Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `CTO Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cto/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
