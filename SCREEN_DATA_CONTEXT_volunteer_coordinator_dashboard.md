# SCREEN DATA CONTEXT: volunteer_coordinator_dashboard

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - VolunteerCoordinatorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `74`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `volunteer_coordinator_dashboard`
* **Screen Name**: `VolunteerCoordinatorDashboardScreen`
* **Route Path**: `/offices/corporate/roles/volunteer_coordinator/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `48`
* **Role Code**: `volunteer_coordinator`
* **Role Name**: `Volunteer Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to volunteercoordinatordashboardscreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the VolunteerCoordinatorDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VolunteerCoordinatorDashboardScreen`
* **Acceptance Criteria**:
- The VolunteerCoordinatorDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `volunteer_coordinator_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `volunteer_coordinator_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `volunteer_coordinator_dashboard-content` (Type: layout, Required: 1)
* **volunteercoordinatordashboard_content** -> `volunteercoordinatordashboard-content` (Type: layout, Required: 0)
* **volunteercoordinatordashboard_screen** -> `volunteercoordinatordashboard-screen` (Type: layout, Required: 0)
* **volunteercoordinatordashboard_btn_4** -> `volunteercoordinatordashboard-btn-4` (Type: button, Required: 0)
* **volunteercoordinatordashboard_btn_5** -> `volunteercoordinatordashboard-btn-5` (Type: button, Required: 0)
* **volunteercoordinatordashboard_title** -> `volunteercoordinatordashboard-title` (Type: header, Required: 0)
* **volunteercoordinatordashboard_btn_1** -> `volunteercoordinatordashboard-btn-1` (Type: button, Required: 0)
* **volunteercoordinatordashboard_btn_2** -> `volunteercoordinatordashboard-btn-2` (Type: button, Required: 0)
* **volunteercoordinatordashboard_btn_3** -> `volunteercoordinatordashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `82` (Required: 1)
* Component ID: `616` (Required: 1)
* Component ID: `1150` (Required: 1)
* Component ID: `2238` (Required: 1)
* Component ID: `2239` (Required: 1)
* Component ID: `2240` (Required: 1)
* Component ID: `2241` (Required: 1)
* Component ID: `2242` (Required: 1)
* Component ID: `2243` (Required: 1)
* Component ID: `2244` (Required: 1)
* Component ID: `2245` (Required: 1)
* Component ID: `2246` (Required: 1)
* Component ID: `2247` (Required: 1)

## 7. API / Data Mapping
* API ID: `4339` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `volunteer_coordinator_dashboard_runtime`
* **Test Name**: `VolunteerCoordinatorDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VolunteerCoordinatorDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/volunteer_coordinator/dashboard`)
3. **should_be_visible** (Selector: `volunteer_coordinator_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `volunteer_coordinator_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `volunteer_coordinator_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
