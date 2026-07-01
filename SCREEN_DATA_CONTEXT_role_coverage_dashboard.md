# SCREEN DATA CONTEXT: role_coverage_dashboard

Below are the database records from `governance.db` used to configure and build the **Governance Officer - RoleCoverageDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `588`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `role_coverage_dashboard`
* **Screen Name**: `RoleCoverageDashboardScreen`
* **Route Path**: `/common/role-coverage-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/role_coverage_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to rolecoveragedashboardscreen.`
* **User Story**: `As a Governance Officer, I want to access the RoleCoverageDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RoleCoverageDashboardScreen`
* **Acceptance Criteria**:
- The RoleCoverageDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `role_coverage_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `role_coverage_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `role_coverage_dashboard-content` (Type: layout, Required: 1)
* **rolecoveragedashboard_title** -> `rolecoveragedashboard-title` (Type: header, Required: 0)
* **rolecoveragedashboard_btn_1** -> `rolecoveragedashboard-btn-1` (Type: button, Required: 0)
* **rolecoveragedashboard_content** -> `rolecoveragedashboard-content` (Type: layout, Required: 0)
* **rolecoveragedashboard_btn_2** -> `rolecoveragedashboard-btn-2` (Type: button, Required: 0)
* **rolecoveragedashboard_btn_3** -> `rolecoveragedashboard-btn-3` (Type: button, Required: 0)
* **rolecoveragedashboard_screen** -> `rolecoveragedashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `512` (Required: 1)
* Component ID: `1046` (Required: 1)
* Component ID: `1580` (Required: 1)
* Component ID: `6133` (Required: 1)
* Component ID: `6134` (Required: 1)
* Component ID: `6135` (Required: 1)
* Component ID: `6136` (Required: 1)
* Component ID: `6137` (Required: 1)
* Component ID: `6138` (Required: 1)
* Component ID: `6139` (Required: 1)
* Component ID: `6140` (Required: 1)
* Component ID: `6141` (Required: 1)
* Component ID: `6142` (Required: 1)

## 7. API / Data Mapping
* API ID: `4937` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `role_coverage_dashboard_runtime`
* **Test Name**: `RoleCoverageDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Role Coverage Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Role Coverage Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Role Coverage Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/role-coverage-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
