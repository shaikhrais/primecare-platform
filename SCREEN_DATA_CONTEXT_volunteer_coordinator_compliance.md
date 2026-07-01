# SCREEN DATA CONTEXT: volunteer_coordinator_compliance

Below are the database records from `governance.db` used to configure and build the **Volunteer - VolunteerCoordinatorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `276`
* **App ID**: `1`
* **Role ID**: `58`
* **Screen Code**: `volunteer_coordinator_compliance`
* **Screen Name**: `VolunteerCoordinatorComplianceScreen`
* **Route Path**: `/staff/volunteer-coordinator-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Volunteer personnel to oversee, audit, and coordinate operations related to volunteercoordinatorcompliancescreen.`
* **User Story**: `As a Volunteer, I want to access the VolunteerCoordinatorComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VolunteerCoordinatorComplianceScreen`
* **Acceptance Criteria**:
- The VolunteerCoordinatorComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `volunteer_coordinator_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `volunteer_coordinator_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `volunteer_coordinator_compliance-content` (Type: layout, Required: 1)
* **volunteercoordinatorcompliance_title** -> `volunteercoordinatorcompliance-title` (Type: header, Required: 0)
* **volunteercoordinatorcompliance_content** -> `volunteercoordinatorcompliance-content` (Type: layout, Required: 0)
* **volunteercoordinatorcompliance_btn_1** -> `volunteercoordinatorcompliance-btn-1` (Type: button, Required: 0)
* **volunteercoordinatorcompliance_btn_2** -> `volunteercoordinatorcompliance-btn-2` (Type: button, Required: 0)
* **volunteercoordinatorcompliance_btn_3** -> `volunteercoordinatorcompliance-btn-3` (Type: button, Required: 0)
* **volunteercoordinatorcompliance_screen** -> `volunteercoordinatorcompliance-screen` (Type: layout, Required: 0)
* **volunteercoordinatorcompliance_btn_4** -> `volunteercoordinatorcompliance-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `284` (Required: 1)
* Component ID: `818` (Required: 1)
* Component ID: `1352` (Required: 1)
* Component ID: `4056` (Required: 1)
* Component ID: `4057` (Required: 1)
* Component ID: `4058` (Required: 1)
* Component ID: `4059` (Required: 1)
* Component ID: `4060` (Required: 1)
* Component ID: `4061` (Required: 1)

## 7. API / Data Mapping
* API ID: `4597` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `volunteer_coordinator_compliance_runtime`
* **Test Name**: `VolunteerCoordinatorComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Volunteer Coordinator Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Volunteer Coordinator Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Volunteer Coordinator Compliance`)
5. **check_url** (Selector: `None`, Value: `/staff/volunteer-coordinator-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
