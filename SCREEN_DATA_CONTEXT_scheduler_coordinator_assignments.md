# SCREEN DATA CONTEXT: scheduler_coordinator_assignments

Below are the database records from `governance.db` used to configure and build the **Guest - SchedulerCoordinatorAssignmentsScreen** screen.

---

## 1. Screen Record
* **ID**: `812`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `scheduler_coordinator_assignments`
* **Screen Name**: `SchedulerCoordinatorAssignmentsScreen`
* **Route Path**: `/offices/franchise/roles/scheduler_coordinator/assignments`
* **Actual File Path**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_assignments_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to scheduler coordinator assignments.`
* **User Story**: `As a Guest, I want to access the Scheduler Coordinator Assignments within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Scheduler Coordinator Assignments`
* **Acceptance Criteria**:
- The Scheduler Coordinator Assignments route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_coordinator_assignments-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_coordinator_assignments-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_coordinator_assignments-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7456` (Required: 1)
* Component ID: `7457` (Required: 1)
* Component ID: `7458` (Required: 1)
* Component ID: `7459` (Required: 1)
* Component ID: `7460` (Required: 1)
* Component ID: `7461` (Required: 1)

## 7. API / Data Mapping
* API ID: `5200` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_coordinator_assignments_runtime`
* **Test Name**: `Scheduler Coordinator Assignments Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Coordinator Assignments`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/scheduler_coordinator/assignments`)
3. **should_be_visible** (Selector: `scheduler_coordinator_assignments-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_coordinator_assignments-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_coordinator_assignments-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
