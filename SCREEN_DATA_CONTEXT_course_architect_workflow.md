# SCREEN DATA CONTEXT: course_architect_workflow

Below are the database records from `governance.db` used to configure and build the **Training Director - CourseArchitectWorkflowScreen** screen.

---

## 1. Screen Record
* **ID**: `100`
* **App ID**: `1`
* **Role ID**: `31`
* **Screen Code**: `course_architect_workflow`
* **Screen Name**: `CourseArchitectWorkflowScreen`
* **Route Path**: `/common/course-architect-workflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/course_architect_workflow_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `31`
* **Role Code**: `training_director`
* **Role Name**: `Training Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Training Director personnel to oversee, audit, and coordinate operations related to coursearchitectworkflowscreen.`
* **User Story**: `As a Training Director, I want to access the CourseArchitectWorkflowScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CourseArchitectWorkflowScreen`
* **Acceptance Criteria**:
- The CourseArchitectWorkflowScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Training Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_architect_workflow-screen` (Type: layout, Required: 1)
* **page_title** -> `course_architect_workflow-title` (Type: header, Required: 1)
* **primary_content** -> `course_architect_workflow-content` (Type: layout, Required: 1)
* **coursearchitectworkflow_title** -> `coursearchitectworkflow-title` (Type: header, Required: 0)
* **coursearchitectworkflow_content** -> `coursearchitectworkflow-content` (Type: layout, Required: 0)
* **coursearchitectworkflow_btn_1** -> `coursearchitectworkflow-btn-1` (Type: button, Required: 0)
* **coursearchitectworkflow_btn_2** -> `coursearchitectworkflow-btn-2` (Type: button, Required: 0)
* **coursearchitectworkflow_screen** -> `coursearchitectworkflow-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `108` (Required: 1)
* Component ID: `642` (Required: 1)
* Component ID: `1176` (Required: 1)
* Component ID: `2473` (Required: 1)
* Component ID: `2474` (Required: 1)
* Component ID: `2475` (Required: 1)
* Component ID: `2476` (Required: 1)
* Component ID: `2477` (Required: 1)
* Component ID: `2478` (Required: 1)
* Component ID: `2479` (Required: 1)
* Component ID: `2480` (Required: 1)
* Component ID: `2481` (Required: 1)
* Component ID: `2482` (Required: 1)

## 7. API / Data Mapping
* API ID: `4377` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_architect_workflow_runtime`
* **Test Name**: `CourseArchitectWorkflowScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Course Architect Workflow`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `training_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Course Architect Workflow`)
4. **click_sidebar_link** (Selector: `None`, Value: `Course Architect Workflow`)
5. **check_url** (Selector: `None`, Value: `/common/course-architect-workflow`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
