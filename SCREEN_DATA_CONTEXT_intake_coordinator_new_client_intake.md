# SCREEN DATA CONTEXT: intake_coordinator_new_client_intake

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorNewClientIntakeScreen** screen.

---

## 1. Screen Record
* **ID**: `383`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_new_client_intake`
* **Screen Name**: `IntakeCoordinatorNewClientIntakeScreen`
* **Route Path**: `/executive/intake-coordinator-new-client-intake`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_new_client_intake_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `48`
* **Role Code**: `volunteer_coordinator`
* **Role Name**: `Volunteer Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatornewclientintakescreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorNewClientIntakeScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorNewClientIntakeScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorNewClientIntakeScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_new_client_intake-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_new_client_intake-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_new_client_intake-content` (Type: layout, Required: 1)
* **intakecoordinatornewclientintake_btn_1** -> `intakecoordinatornewclientintake-btn-1` (Type: button, Required: 0)
* **intakecoordinatornewclientintake_btn_2** -> `intakecoordinatornewclientintake-btn-2` (Type: button, Required: 0)
* **intakecoordinatornewclientintake_screen** -> `intakecoordinatornewclientintake-screen` (Type: layout, Required: 0)
* **intakecoordinatornewclientintake_title** -> `intakecoordinatornewclientintake-title` (Type: header, Required: 0)
* **intakecoordinatornewclientintake_content** -> `intakecoordinatornewclientintake-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `389` (Required: 1)
* Component ID: `923` (Required: 1)
* Component ID: `1457` (Required: 1)
* Component ID: `5000` (Required: 1)
* Component ID: `5001` (Required: 1)
* Component ID: `5002` (Required: 1)
* Component ID: `5003` (Required: 1)
* Component ID: `5004` (Required: 1)
* Component ID: `5005` (Required: 1)
* Component ID: `5006` (Required: 1)

## 7. API / Data Mapping
* API ID: `4766` (Required: 1)
* API ID: `4767` (Required: 1)
* API ID: `4768` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_new_client_intake_runtime`
* **Test Name**: `IntakeCoordinatorNewClientIntakeScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeCoordinatorNewClientIntakeScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **visit** (Selector: `None`, Value: `/executive/intake-coordinator-new-client-intake`)
3. **should_be_visible** (Selector: `intake_coordinator_new_client_intake-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_new_client_intake-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_new_client_intake-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
