# SCREEN DATA CONTEXT: scheduler_conflicts

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerConflictsScreen** screen.

---

## 1. Screen Record
* **ID**: `379`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_conflicts`
* **Screen Name**: `SchedulerConflictsScreen`
* **Route Path**: `/staff/scheduler-conflicts`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_conflicts_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulerconflictsscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerConflictsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerConflictsScreen`
* **Acceptance Criteria**:
- The SchedulerConflictsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_conflicts-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_conflicts-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_conflicts-content` (Type: layout, Required: 1)
* **schedulerconflicts_screen** -> `schedulerconflicts-screen` (Type: layout, Required: 0)
* **schedulerconflicts_title** -> `schedulerconflicts-title` (Type: header, Required: 0)
* **schedulerconflicts_btn_5** -> `schedulerconflicts-btn-5` (Type: button, Required: 0)
* **schedulerconflicts_btn_2** -> `schedulerconflicts-btn-2` (Type: button, Required: 0)
* **schedulerconflicts_btn_3** -> `schedulerconflicts-btn-3` (Type: button, Required: 0)
* **schedulerconflicts_btn_1** -> `schedulerconflicts-btn-1` (Type: button, Required: 0)
* **schedulerconflicts_content** -> `schedulerconflicts-content` (Type: layout, Required: 0)
* **schedulerconflicts_btn_4** -> `schedulerconflicts-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `385` (Required: 1)
* Component ID: `919` (Required: 1)
* Component ID: `1453` (Required: 1)
* Component ID: `4964` (Required: 1)
* Component ID: `4965` (Required: 1)
* Component ID: `4966` (Required: 1)
* Component ID: `4967` (Required: 1)
* Component ID: `4968` (Required: 1)
* Component ID: `4969` (Required: 1)
* Component ID: `4970` (Required: 1)
* Component ID: `4971` (Required: 1)
* Component ID: `4972` (Required: 1)
* Component ID: `4973` (Required: 1)

## 7. API / Data Mapping
* API ID: `4760` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_conflicts_runtime`
* **Test Name**: `SchedulerConflictsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerConflictsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-conflicts`)
3. **should_be_visible** (Selector: `scheduler_conflicts-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_conflicts-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_conflicts-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
