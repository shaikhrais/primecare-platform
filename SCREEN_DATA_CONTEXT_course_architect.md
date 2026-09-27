# SCREEN DATA CONTEXT: course_architect

Below are the database records from `governance.db` used to configure and build the **Guest - CourseArchitectScreen** screen.

---

## 1. Screen Record
* **ID**: `776`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `course_architect`
* **Screen Name**: `CourseArchitectScreen`
* **Route Path**: `/generated/course-architect`
* **Actual File Path**: `apps/primecare_corporate/lib/features/training/screens/course_architect_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to course architect.`
* **User Story**: `As a Guest, I want to access the Course Architect within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Course Architect`
* **Acceptance Criteria**:
- The Course Architect route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `course_architect-screen` (Type: layout, Required: 1)
* **page_title** -> `course_architect-title` (Type: header, Required: 1)
* **primary_content** -> `course_architect-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7257` (Required: 1)
* Component ID: `7258` (Required: 1)
* Component ID: `7259` (Required: 1)
* Component ID: `7260` (Required: 1)

## 7. API / Data Mapping
* API ID: `4264` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `course_architect_runtime`
* **Test Name**: `Course Architect Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Course Architect`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/course-architect`)
3. **should_be_visible** (Selector: `course_architect-screen`, Value: `None`)
4. **should_be_visible** (Selector: `course_architect-title`, Value: `None`)
5. **should_be_visible** (Selector: `course_architect-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
