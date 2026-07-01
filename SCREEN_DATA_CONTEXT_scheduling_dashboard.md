# SCREEN DATA CONTEXT: scheduling_dashboard

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulingDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `512`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduling_dashboard`
* **Screen Name**: `SchedulingDashboardScreen`
* **Route Path**: `/staff/scheduling-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduling_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulingdashboardscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulingDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulingDashboardScreen`
* **Acceptance Criteria**:
- The SchedulingDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduling_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduling_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `scheduling_dashboard-content` (Type: layout, Required: 1)
* **schedulingdashboard_btn_5** -> `schedulingdashboard-btn-5` (Type: button, Required: 0)
* **schedulingdashboard_btn_2** -> `schedulingdashboard-btn-2` (Type: button, Required: 0)
* **schedulingdashboard_btn_1** -> `schedulingdashboard-btn-1` (Type: button, Required: 0)
* **schedulingdashboard_content** -> `schedulingdashboard-content` (Type: layout, Required: 0)
* **schedulingdashboard_btn_3** -> `schedulingdashboard-btn-3` (Type: button, Required: 0)
* **schedulingdashboard_screen** -> `schedulingdashboard-screen` (Type: layout, Required: 0)
* **schedulingdashboard_btn_4** -> `schedulingdashboard-btn-4` (Type: button, Required: 0)
* **schedulingdashboard_title** -> `schedulingdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `441` (Required: 1)
* Component ID: `975` (Required: 1)
* Component ID: `1509` (Required: 1)
* Component ID: `5498` (Required: 1)
* Component ID: `5499` (Required: 1)
* Component ID: `5500` (Required: 1)
* Component ID: `5501` (Required: 1)
* Component ID: `5502` (Required: 1)
* Component ID: `5503` (Required: 1)
* Component ID: `5504` (Required: 1)
* Component ID: `5505` (Required: 1)
* Component ID: `5506` (Required: 1)
* Component ID: `5507` (Required: 1)

## 7. API / Data Mapping
* API ID: `4828` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduling_dashboard_runtime`
* **Test Name**: `SchedulingDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduling Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduling Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduling Dashboard`)
5. **check_url** (Selector: `None`, Value: `/staff/scheduling-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
