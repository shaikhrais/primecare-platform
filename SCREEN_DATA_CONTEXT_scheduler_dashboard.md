# SCREEN DATA CONTEXT: scheduler_dashboard

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `72`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_dashboard`
* **Screen Name**: `SchedulerDashboardScreen`
* **Route Path**: `/offices/franchise/roles/scheduler/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulerdashboardscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerDashboardScreen`
* **Acceptance Criteria**:
- The SchedulerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_dashboard-content` (Type: layout, Required: 1)
* **schedulerdashboard_screen** -> `schedulerdashboard-screen` (Type: layout, Required: 0)
* **schedulerdashboard_btn_5** -> `schedulerdashboard-btn-5` (Type: button, Required: 0)
* **schedulerdashboard_btn_1** -> `schedulerdashboard-btn-1` (Type: button, Required: 0)
* **schedulerdashboard_title** -> `schedulerdashboard-title` (Type: header, Required: 0)
* **schedulerdashboard_content** -> `schedulerdashboard-content` (Type: layout, Required: 0)
* **schedulerdashboard_btn_4** -> `schedulerdashboard-btn-4` (Type: button, Required: 0)
* **schedulerdashboard_btn_2** -> `schedulerdashboard-btn-2` (Type: button, Required: 0)
* **schedulerdashboard_btn_3** -> `schedulerdashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `80` (Required: 1)
* Component ID: `614` (Required: 1)
* Component ID: `1148` (Required: 1)
* Component ID: `2221` (Required: 1)
* Component ID: `2222` (Required: 1)
* Component ID: `2223` (Required: 1)
* Component ID: `2224` (Required: 1)
* Component ID: `2225` (Required: 1)
* Component ID: `2226` (Required: 1)
* Component ID: `2227` (Required: 1)
* Component ID: `2228` (Required: 1)
* Component ID: `2229` (Required: 1)
* Component ID: `2230` (Required: 1)

## 7. API / Data Mapping
* API ID: `4337` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_dashboard_runtime`
* **Test Name**: `SchedulerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduler Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduler Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/scheduler/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
