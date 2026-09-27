# SCREEN DATA CONTEXT: intake_coordinator_dashboard

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeCoordinatorDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `69`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `intake_coordinator_dashboard`
* **Screen Name**: `IntakeCoordinatorDashboardScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatordashboardscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeCoordinatorDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorDashboardScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_dashboard-content` (Type: layout, Required: 1)
* **intakecoordinatordashboard_btn_3** -> `intakecoordinatordashboard-btn-3` (Type: button, Required: 0)
* **intakecoordinatordashboard_screen** -> `intakecoordinatordashboard-screen` (Type: layout, Required: 0)
* **intakecoordinatordashboard_btn_1** -> `intakecoordinatordashboard-btn-1` (Type: button, Required: 0)
* **intakecoordinatordashboard_btn_2** -> `intakecoordinatordashboard-btn-2` (Type: button, Required: 0)
* **intakecoordinatordashboard_title** -> `intakecoordinatordashboard-title` (Type: header, Required: 0)
* **intakecoordinatordashboard_loading** -> `intakecoordinatordashboard-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `77` (Required: 1)
* Component ID: `611` (Required: 1)
* Component ID: `1145` (Required: 1)
* Component ID: `2194` (Required: 1)
* Component ID: `2195` (Required: 1)
* Component ID: `2196` (Required: 1)
* Component ID: `2197` (Required: 1)
* Component ID: `2198` (Required: 1)
* Component ID: `2199` (Required: 1)
* Component ID: `2200` (Required: 1)
* Component ID: `2201` (Required: 1)

## 7. API / Data Mapping
* API ID: `4332` (Required: 1)
* API ID: `4333` (Required: 1)
* API ID: `4334` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_dashboard_runtime`
* **Test Name**: `IntakeCoordinatorDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeCoordinatorDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/dashboard`)
3. **should_be_visible** (Selector: `intake_coordinator_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
