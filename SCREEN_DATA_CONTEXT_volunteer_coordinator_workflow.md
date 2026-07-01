# SCREEN DATA CONTEXT: volunteer_coordinator_workflow

Below are the database records from `governance.db` used to configure and build the **Volunteer - VolunteerCoordinatorWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `277`
* **App ID**: `1`
* **Role ID**: `58`
* **Screen Code**: `volunteer_coordinator_workflow`
* **Screen Name**: `VolunteerCoordinatorWorkflowScreen`
* **Route Path**: `/staff/volunteer-coordinator-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_workflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Volunteer personnel to oversee, audit, and coordinate operations related to volunteercoordinatorworkflowscreen.`
* **User Story**: `As a Volunteer, I want to access the VolunteerCoordinatorWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VolunteerCoordinatorWorkflowScreen`
* **Acceptance Criteria**:
- The VolunteerCoordinatorWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `volunteer_coordinator_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `volunteer_coordinator_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `volunteer_coordinator_workflow-content` (Type: layout, Required: 1)
* **volunteercoordinatorworkflow_btn_3** -> `volunteercoordinatorworkflow-btn-3` (Type: button, Required: 0)
* **volunteercoordinatorworkflow_btn_1** -> `volunteercoordinatorworkflow-btn-1` (Type: button, Required: 0)
* **volunteercoordinatorworkflow_screen** -> `volunteercoordinatorworkflow-screen` (Type: layout, Required: 0)
* **volunteercoordinatorworkflow_btn_2** -> `volunteercoordinatorworkflow-btn-2` (Type: button, Required: 0)
* **volunteercoordinatorworkflow_title** -> `volunteercoordinatorworkflow-title` (Type: header, Required: 0)
* **volunteercoordinatorworkflow_content** -> `volunteercoordinatorworkflow-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `285` (Required: 1)
* Component ID: `819` (Required: 1)
* Component ID: `1353` (Required: 1)
* Component ID: `4062` (Required: 1)
* Component ID: `4063` (Required: 1)
* Component ID: `4064` (Required: 1)
* Component ID: `4065` (Required: 1)
* Component ID: `4066` (Required: 1)

## 7. API / Data Mapping
* API ID: `4598` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `volunteer_coordinator_workflow_runtime`
* **Test Name**: `VolunteerCoordinatorWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Volunteer Coordinator Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Volunteer Coordinator Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Volunteer Coordinator Workflow`)
5. **check_url** (Selector: `None`, Value: `/staff/volunteer-coordinator-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
