# SCREEN DATA CONTEXT: volunteer_coordinator_analytics

Below are the database records from `governance.db` used to configure and build the **Volunteer - VolunteerCoordinatorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `275`
* **App ID**: `1`
* **Role ID**: `58`
* **Screen Code**: `volunteer_coordinator_analytics`
* **Screen Name**: `VolunteerCoordinatorAnalyticsScreen`
* **Route Path**: `/staff/volunteer-coordinator-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `58`
* **Role Code**: `volunteer`
* **Role Name**: `Volunteer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Volunteer personnel to oversee, audit, and coordinate operations related to volunteercoordinatoranalyticsscreen.`
* **User Story**: `As a Volunteer, I want to access the VolunteerCoordinatorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VolunteerCoordinatorAnalyticsScreen`
* **Acceptance Criteria**:
- The VolunteerCoordinatorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `volunteer_coordinator_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `volunteer_coordinator_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `volunteer_coordinator_analytics-content` (Type: layout, Required: 1)
* **volunteercoordinatoranalytics_title** -> `volunteercoordinatoranalytics-title` (Type: header, Required: 0)
* **volunteercoordinatoranalytics_screen** -> `volunteercoordinatoranalytics-screen` (Type: layout, Required: 0)
* **volunteercoordinatoranalytics_btn_2** -> `volunteercoordinatoranalytics-btn-2` (Type: button, Required: 0)
* **volunteercoordinatoranalytics_content** -> `volunteercoordinatoranalytics-content` (Type: layout, Required: 0)
* **volunteercoordinatoranalytics_btn_3** -> `volunteercoordinatoranalytics-btn-3` (Type: button, Required: 0)
* **volunteercoordinatoranalytics_btn_1** -> `volunteercoordinatoranalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `283` (Required: 1)
* Component ID: `817` (Required: 1)
* Component ID: `1351` (Required: 1)
* Component ID: `4049` (Required: 1)
* Component ID: `4050` (Required: 1)
* Component ID: `4051` (Required: 1)
* Component ID: `4052` (Required: 1)
* Component ID: `4053` (Required: 1)
* Component ID: `4054` (Required: 1)
* Component ID: `4055` (Required: 1)

## 7. API / Data Mapping
* API ID: `4596` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `volunteer_coordinator_analytics_runtime`
* **Test Name**: `VolunteerCoordinatorAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Volunteer Coordinator Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Volunteer Coordinator Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Volunteer Coordinator Analytics`)
5. **check_url** (Selector: `None`, Value: `/staff/volunteer-coordinator-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
