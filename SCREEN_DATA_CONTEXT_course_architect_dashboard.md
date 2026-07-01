# SCREEN DATA CONTEXT: course_architect_dashboard

Below are the database records from `governance.db` used to configure and build the **Training Director - CourseArchitectDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `15`
* **App ID**: `5`
* **Role ID**: `31`
* **Screen Code**: `course_architect_dashboard`
* **Screen Name**: `CourseArchitectDashboardScreen`
* **Route Path**: `/common/course-architect-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `31`
* **Role Code**: `training_director`
* **Role Name**: `Training Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Director personnel to oversee, audit, and coordinate operations related to coursearchitectdashboardscreen.`
* **User Story**: `As a Training Director, I want to access the CourseArchitectDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CourseArchitectDashboardScreen`
* **Acceptance Criteria**:
- The CourseArchitectDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_architect_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `course_architect_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `course_architect_dashboard-content` (Type: layout, Required: 1)
* **coursearchitectdashboard_btn_2** -> `coursearchitectdashboard-btn-2` (Type: button, Required: 0)
* **coursearchitectdashboard_title** -> `coursearchitectdashboard-title` (Type: header, Required: 0)
* **coursearchitectdashboard_screen** -> `coursearchitectdashboard-screen` (Type: layout, Required: 0)
* **coursearchitectdashboard_btn_1** -> `coursearchitectdashboard-btn-1` (Type: button, Required: 0)
* **coursearchitectdashboard_btn_3** -> `coursearchitectdashboard-btn-3` (Type: button, Required: 0)
* **coursearchitectdashboard_content** -> `coursearchitectdashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `23` (Required: 1)
* Component ID: `557` (Required: 1)
* Component ID: `1091` (Required: 1)
* Component ID: `1724` (Required: 1)
* Component ID: `1725` (Required: 1)
* Component ID: `1726` (Required: 1)
* Component ID: `1727` (Required: 1)
* Component ID: `1728` (Required: 1)
* Component ID: `1729` (Required: 1)
* Component ID: `1730` (Required: 1)
* Component ID: `1731` (Required: 1)
* Component ID: `1732` (Required: 1)
* Component ID: `1733` (Required: 1)

## 7. API / Data Mapping
* API ID: `4264` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_architect_dashboard_runtime`
* **Test Name**: `CourseArchitectDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Course Architect Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Course Architect Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Course Architect Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/course-architect-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
