# SCREEN DATA CONTEXT: scheduler_coordinator_conflicts

Below are the database records from `governance.db` used to configure and build the **Guest - SchedulerCoordinatorConflictsScreen** screen.

---

## 1. Screen Record
* **ID**: `814`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `scheduler_coordinator_conflicts`
* **Screen Name**: `SchedulerCoordinatorConflictsScreen`
* **Route Path**: `/offices/franchise/roles/scheduler_coordinator/conflicts`
* **Actual File Path**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_conflicts_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to scheduler coordinator conflicts.`
* **User Story**: `As a Guest, I want to access the Scheduler Coordinator Conflicts within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Scheduler Coordinator Conflicts`
* **Acceptance Criteria**:
- The Scheduler Coordinator Conflicts route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_coordinator_conflicts-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_coordinator_conflicts-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_coordinator_conflicts-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7469` (Required: 1)
* Component ID: `7470` (Required: 1)
* Component ID: `7471` (Required: 1)
* Component ID: `7472` (Required: 1)
* Component ID: `7473` (Required: 1)

## 7. API / Data Mapping
* API ID: `5204` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_coordinator_conflicts_runtime`
* **Test Name**: `Scheduler Coordinator Conflicts Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Coordinator Conflicts`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/scheduler_coordinator/conflicts`)
3. **should_be_visible** (Selector: `scheduler_coordinator_conflicts-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_coordinator_conflicts-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_coordinator_conflicts-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
