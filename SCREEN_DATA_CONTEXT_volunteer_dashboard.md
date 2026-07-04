# SCREEN DATA CONTEXT: volunteer_dashboard

Below are the database records from `governance.db` used to configure and build the **Volunteer - VolunteerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `75`
* **App ID**: `5`
* **Role ID**: `58`
* **Screen Code**: `volunteer_dashboard`
* **Screen Name**: `VolunteerDashboardScreen`
* **Route Path**: `/staff/volunteer-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `58`
* **Role Code**: `volunteer`
* **Role Name**: `Volunteer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer personnel to oversee, audit, and coordinate operations related to volunteerdashboardscreen.`
* **User Story**: `As a Volunteer, I want to access the VolunteerDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VolunteerDashboardScreen`
* **Acceptance Criteria**:
- The VolunteerDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `volunteer_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `volunteer_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `volunteer_dashboard-content` (Type: layout, Required: 1)
* **volunteerdashboard_btn_3** -> `volunteerdashboard-btn-3` (Type: button, Required: 0)
* **volunteerdashboard_title** -> `volunteerdashboard-title` (Type: header, Required: 0)
* **volunteerdashboard_screen** -> `volunteerdashboard-screen` (Type: layout, Required: 0)
* **volunteerdashboard_btn_1** -> `volunteerdashboard-btn-1` (Type: button, Required: 0)
* **volunteerdashboard_btn_2** -> `volunteerdashboard-btn-2` (Type: button, Required: 0)
* **volunteerdashboard_btn_5** -> `volunteerdashboard-btn-5` (Type: button, Required: 0)
* **volunteerdashboard_content** -> `volunteerdashboard-content` (Type: layout, Required: 0)
* **volunteerdashboard_btn_4** -> `volunteerdashboard-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `83` (Required: 1)
* Component ID: `617` (Required: 1)
* Component ID: `1151` (Required: 1)
* Component ID: `2248` (Required: 1)
* Component ID: `2249` (Required: 1)
* Component ID: `2250` (Required: 1)
* Component ID: `2251` (Required: 1)
* Component ID: `2252` (Required: 1)
* Component ID: `2253` (Required: 1)
* Component ID: `2254` (Required: 1)

## 7. API / Data Mapping
* API ID: `4340` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `volunteer_dashboard_runtime`
* **Test Name**: `VolunteerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VolunteerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer`)
2. **visit** (Selector: `None`, Value: `/staff/volunteer-dashboard`)
3. **should_be_visible** (Selector: `volunteer_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `volunteer_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `volunteer_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
