# SCREEN DATA CONTEXT: system_dashboard

Below are the database records from `governance.db` used to configure and build the **Governance Officer - SystemDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `30`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `system_dashboard`
* **Screen Name**: `SystemDashboardScreen`
* **Route Path**: `/common/system-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/system_dashboard.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to systemdashboardscreen.`
* **User Story**: `As a Governance Officer, I want to access the SystemDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SystemDashboardScreen`
* **Acceptance Criteria**:
- The SystemDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `system_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `system_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `system_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `38` (Required: 1)
* Component ID: `572` (Required: 1)
* Component ID: `1106` (Required: 1)
* Component ID: `1840` (Required: 1)
* Component ID: `1841` (Required: 1)
* Component ID: `1842` (Required: 1)
* Component ID: `1843` (Required: 1)
* Component ID: `1844` (Required: 1)
* Component ID: `1845` (Required: 1)
* Component ID: `1846` (Required: 1)
* Component ID: `1847` (Required: 1)
* Component ID: `1848` (Required: 1)
* Component ID: `1849` (Required: 1)

## 7. API / Data Mapping
* API ID: `4283` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `system_dashboard_runtime`
* **Test Name**: `SystemDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `System Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `System Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `System Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/system-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
