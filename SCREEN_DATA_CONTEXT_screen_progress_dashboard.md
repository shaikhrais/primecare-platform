# SCREEN DATA CONTEXT: screen_progress_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ScreenProgressDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1262`
* **App ID**: `5`
* **Role ID**: `None`
* **Screen Code**: `screen_progress_dashboard`
* **Screen Name**: `ScreenProgressDashboardScreen`
* **Route Path**: `/management/screen-progress-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/screen_progress_dashboard.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `None`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `public`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Authorized Staff personnel to oversee, audit, and coordinate operations related to screenprogressdashboardscreen.`
* **User Story**: `As a Authorized Staff, I want to access the ScreenProgressDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ScreenProgressDashboardScreen`
* **Acceptance Criteria**:
- The ScreenProgressDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Authorized Staff access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `screen_progress_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `screen_progress_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `screen_progress_dashboard-content` (Type: layout, Required: 1)
* **screenprogressdashboard_total_screens** -> `screenprogressdashboard-total-screens` (Type: layout, Required: 0)
* **screenprogressdashboard_blocked_screens** -> `screenprogressdashboard-blocked-screens` (Type: layout, Required: 0)
* **screenprogressdashboard_final_screens** -> `screenprogressdashboard-final-screens` (Type: layout, Required: 0)
* **screenprogressdashboard_screen** -> `screenprogressdashboard-screen` (Type: layout, Required: 0)
* **screenprogressdashboard_refresh** -> `screenprogressdashboard-refresh` (Type: layout, Required: 0)

## 6. Component Mapping
* No custom components mapped.

## 7. API / Data Mapping
* API ID: `5495` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `screen_progress_dashboard_runtime`
* **Test Name**: `ScreenProgressDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ScreenProgressDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/management/screen-progress-dashboard`)
3. **should_be_visible** (Selector: `screen_progress_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `screen_progress_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `screen_progress_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
