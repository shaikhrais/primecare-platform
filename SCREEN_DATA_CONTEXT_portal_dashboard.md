# SCREEN DATA CONTEXT: portal_dashboard

Below are the database records from `governance.db` used to configure and build the **Portal User - PortalDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `26`
* **App ID**: `5`
* **Role ID**: `14`
* **Screen Code**: `portal_dashboard`
* **Screen Name**: `PortalDashboardScreen`
* **Route Path**: `/common/portal-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `14`
* **Role Code**: `portal`
* **Role Name**: `Portal User`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Portal User personnel to oversee, audit, and coordinate operations related to portaldashboardscreen.`
* **User Story**: `As a Portal User, I want to access the PortalDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PortalDashboardScreen`
* **Acceptance Criteria**:
- The PortalDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Portal User access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `portal_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `portal_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `portal_dashboard-content` (Type: layout, Required: 1)
* **portaldashboard_btn_2** -> `portaldashboard-btn-2` (Type: button, Required: 0)
* **portaldashboard_screen** -> `portaldashboard-screen` (Type: layout, Required: 0)
* **portaldashboard_btn_4** -> `portaldashboard-btn-4` (Type: button, Required: 0)
* **portaldashboard_loading** -> `portaldashboard-loading` (Type: loading, Required: 0)
* **portaldashboard_title** -> `portaldashboard-title` (Type: header, Required: 0)
* **portaldashboard_content** -> `portaldashboard-content` (Type: layout, Required: 0)
* **portaldashboard_btn_3** -> `portaldashboard-btn-3` (Type: button, Required: 0)
* **portaldashboard_btn_1** -> `portaldashboard-btn-1` (Type: button, Required: 0)
* **portaldashboard_btn_5** -> `portaldashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `34` (Required: 1)
* Component ID: `568` (Required: 1)
* Component ID: `1102` (Required: 1)
* Component ID: `1810` (Required: 1)
* Component ID: `1811` (Required: 1)
* Component ID: `1812` (Required: 1)
* Component ID: `1813` (Required: 1)
* Component ID: `1814` (Required: 1)
* Component ID: `1815` (Required: 1)

## 7. API / Data Mapping
* API ID: `4279` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `portal_dashboard_runtime`
* **Test Name**: `PortalDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Portal Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `portal`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Portal Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Portal Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/portal-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
