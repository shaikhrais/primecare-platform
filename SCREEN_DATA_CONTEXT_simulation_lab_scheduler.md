# SCREEN DATA CONTEXT: simulation_lab_scheduler

Below are the database records from `governance.db` used to configure and build the **Guest - SimulationLabSchedulerScreen** screen.

---

## 1. Screen Record
* **ID**: `959`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `simulation_lab_scheduler`
* **Screen Name**: `SimulationLabSchedulerScreen`
* **Route Path**: `/generated/simulation-lab-scheduler`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/education/simulation_lab_scheduler.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to simulation lab scheduler.`
* **User Story**: `As a Guest, I want to access the Simulation Lab Scheduler within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Simulation Lab Scheduler`
* **Acceptance Criteria**:
- The Simulation Lab Scheduler route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `simulation_lab_scheduler-screen` (Type: layout, Required: 1)
* **page_title** -> `simulation_lab_scheduler-title` (Type: header, Required: 1)
* **primary_content** -> `simulation_lab_scheduler-content` (Type: layout, Required: 1)
* **simulation_lab_scheduler_outlinedbutton_button_1** -> `simulation_lab_scheduler_outlinedbutton_button_1` (Type: button, Required: 0)
* **simulation_lab_scheduler_iconbutton_button_1** -> `simulation_lab_scheduler_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8229` (Required: 1)
* Component ID: `8230` (Required: 1)
* Component ID: `8231` (Required: 1)
* Component ID: `8232` (Required: 1)
* Component ID: `8233` (Required: 1)

## 7. API / Data Mapping
* API ID: `5397` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `simulation_lab_scheduler_runtime`
* **Test Name**: `Simulation Lab Scheduler Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Simulation Lab Scheduler`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/simulation-lab-scheduler`)
3. **should_be_visible** (Selector: `simulation_lab_scheduler-screen`, Value: `None`)
4. **should_be_visible** (Selector: `simulation_lab_scheduler-title`, Value: `None`)
5. **should_be_visible** (Selector: `simulation_lab_scheduler-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
