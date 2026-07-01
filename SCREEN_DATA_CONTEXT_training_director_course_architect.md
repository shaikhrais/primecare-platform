# SCREEN DATA CONTEXT: training_director_course_architect

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingDirectorCourseArchitectScreen** screen.

---

## 1. Screen Record
* **ID**: `765`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_director_course_architect`
* **Screen Name**: `TrainingDirectorCourseArchitectScreen`
* **Route Path**: `/offices/corporate/roles/training_director/course-architect`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/training_director_course_architect_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training director course architect.`
* **User Story**: `As a Guest, I want to access the Training Director Course Architect within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Director Course Architect`
* **Acceptance Criteria**:
- The Training Director Course Architect route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_director_course_architect-screen` (Type: layout, Required: 1)
* **page_title** -> `training_director_course_architect-title` (Type: header, Required: 1)
* **primary_content** -> `training_director_course_architect-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7203` (Required: 1)
* Component ID: `7204` (Required: 1)
* Component ID: `7205` (Required: 1)
* Component ID: `7206` (Required: 1)
* Component ID: `7207` (Required: 1)
* Component ID: `7208` (Required: 1)

## 7. API / Data Mapping
* API ID: `5155` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_director_course_architect_runtime`
* **Test Name**: `Training Director Course Architect Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Director Course Architect`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Training Director Course Architect`)
4. **click_sidebar_link** (Selector: `None`, Value: `Training Director Course Architect`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/training_director/course-architect`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
