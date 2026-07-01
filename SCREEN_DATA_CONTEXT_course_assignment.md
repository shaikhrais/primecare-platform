# SCREEN DATA CONTEXT: course_assignment

Below are the database records from `governance.db` used to configure and build the **Training Coordinator - CourseAssignmentScreen** screen.

---

## 1. Screen Record
* **ID**: `562`
* **App ID**: `5`
* **Role ID**: `62`
* **Screen Code**: `course_assignment`
* **Screen Name**: `CourseAssignmentScreen`
* **Route Path**: `/staff/course-assignment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/course_assignment_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `62`
* **Role Code**: `training_coordinator`
* **Role Name**: `Training Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Training Coordinator personnel to oversee, audit, and coordinate operations related to courseassignmentscreen.`
* **User Story**: `As a Training Coordinator, I want to access the CourseAssignmentScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CourseAssignmentScreen`
* **Acceptance Criteria**:
- The CourseAssignmentScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_assignment-screen` (Type: layout, Required: 1)
* **page_title** -> `course_assignment-title` (Type: header, Required: 1)
* **primary_content** -> `course_assignment-content` (Type: layout, Required: 1)
* **courseassignment_btn_4** -> `courseassignment-btn-4` (Type: button, Required: 0)
* **courseassignment_btn_2** -> `courseassignment-btn-2` (Type: button, Required: 0)
* **courseassignment_btn_5** -> `courseassignment-btn-5` (Type: button, Required: 0)
* **courseassignment_title** -> `courseassignment-title` (Type: header, Required: 0)
* **courseassignment_screen** -> `courseassignment-screen` (Type: layout, Required: 0)
* **courseassignment_loading** -> `courseassignment-loading` (Type: loading, Required: 0)
* **courseassignment_content** -> `courseassignment-content` (Type: layout, Required: 0)
* **courseassignment_btn_1** -> `courseassignment-btn-1` (Type: button, Required: 0)
* **courseassignment_btn_3** -> `courseassignment-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `486` (Required: 1)
* Component ID: `1020` (Required: 1)
* Component ID: `1554` (Required: 1)
* Component ID: `5918` (Required: 1)
* Component ID: `5919` (Required: 1)
* Component ID: `5920` (Required: 1)
* Component ID: `5921` (Required: 1)
* Component ID: `5922` (Required: 1)
* Component ID: `5923` (Required: 1)
* Component ID: `5924` (Required: 1)
* Component ID: `5925` (Required: 1)

## 7. API / Data Mapping
* API ID: `4909` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_assignment_runtime`
* **Test Name**: `CourseAssignmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Course Assignment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Course Assignment`)
4. **click_sidebar_link** (Selector: `None`, Value: `Course Assignment`)
5. **check_url** (Selector: `None`, Value: `/staff/course-assignment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
