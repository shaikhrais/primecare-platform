# SCREEN DATA CONTEXT: intake_coordinator_follow_up

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorFollowUpScreen** screen.

---

## 1. Screen Record
* **ID**: `387`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_follow_up`
* **Screen Name**: `IntakeCoordinatorFollowUpScreen`
* **Route Path**: `/executive/intake-coordinator-follow-up`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_follow_up_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorfollowupscreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorFollowUpScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorFollowUpScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorFollowUpScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_follow_up-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_follow_up-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_follow_up-content` (Type: layout, Required: 1)
* **intakecoordinatorfollowup_content** -> `intakecoordinatorfollowup-content` (Type: layout, Required: 0)
* **intakecoordinatorfollowup_btn_3** -> `intakecoordinatorfollowup-btn-3` (Type: button, Required: 0)
* **intakecoordinatorfollowup_btn_2** -> `intakecoordinatorfollowup-btn-2` (Type: button, Required: 0)
* **intakecoordinatorfollowup_btn_1** -> `intakecoordinatorfollowup-btn-1` (Type: button, Required: 0)
* **intakecoordinatorfollowup_title** -> `intakecoordinatorfollowup-title` (Type: header, Required: 0)
* **intakecoordinatorfollowup_screen** -> `intakecoordinatorfollowup-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `393` (Required: 1)
* Component ID: `927` (Required: 1)
* Component ID: `1461` (Required: 1)
* Component ID: `5030` (Required: 1)
* Component ID: `5031` (Required: 1)
* Component ID: `5032` (Required: 1)
* Component ID: `5033` (Required: 1)
* Component ID: `5034` (Required: 1)
* Component ID: `5035` (Required: 1)
* Component ID: `5036` (Required: 1)
* Component ID: `5037` (Required: 1)

## 7. API / Data Mapping
* API ID: `4778` (Required: 1)
* API ID: `4779` (Required: 1)
* API ID: `4780` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_follow_up_runtime`
* **Test Name**: `IntakeCoordinatorFollowUpScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeCoordinatorFollowUpScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **visit** (Selector: `None`, Value: `/executive/intake-coordinator-follow-up`)
3. **should_be_visible** (Selector: `intake_coordinator_follow_up-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_follow_up-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_follow_up-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
