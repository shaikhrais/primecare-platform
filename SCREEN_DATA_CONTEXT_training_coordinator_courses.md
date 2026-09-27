# SCREEN DATA CONTEXT: training_coordinator_courses

Below are the database records from `governance.db` used to configure and build the **Guest - TrainingCoordinatorCoursesScreen** screen.

---

## 1. Screen Record
* **ID**: `889`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `training_coordinator_courses`
* **Screen Name**: `TrainingCoordinatorCoursesScreen`
* **Route Path**: `/generated/training-coordinator-courses`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/training_coordinator_courses_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to training coordinator courses.`
* **User Story**: `As a Guest, I want to access the Training Coordinator Courses within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Training Coordinator Courses`
* **Acceptance Criteria**:
- The Training Coordinator Courses route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `training_coordinator_courses-screen` (Type: layout, Required: 1)
* **page_title** -> `training_coordinator_courses-title` (Type: header, Required: 1)
* **primary_content** -> `training_coordinator_courses-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7892` (Required: 1)
* Component ID: `7893` (Required: 1)
* Component ID: `7894` (Required: 1)
* Component ID: `7895` (Required: 1)
* Component ID: `7896` (Required: 1)

## 7. API / Data Mapping
* API ID: `5303` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `training_coordinator_courses_runtime`
* **Test Name**: `Training Coordinator Courses Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Training Coordinator Courses`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/training-coordinator-courses`)
3. **should_be_visible** (Selector: `training_coordinator_courses-screen`, Value: `None`)
4. **should_be_visible** (Selector: `training_coordinator_courses-title`, Value: `None`)
5. **should_be_visible** (Selector: `training_coordinator_courses-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
