# SCREEN DATA CONTEXT: intake_coordinator_assessment_queue

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorAssessmentQueueScreen** screen.

---

## 1. Screen Record
* **ID**: `384`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_assessment_queue`
* **Screen Name**: `IntakeCoordinatorAssessmentQueueScreen`
* **Route Path**: `/executive/intake-coordinator-assessment-queue`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_assessment_queue_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorassessmentqueuescreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorAssessmentQueueScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorAssessmentQueueScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorAssessmentQueueScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_assessment_queue-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_assessment_queue-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_assessment_queue-content` (Type: layout, Required: 1)
* **intakecoordinatorassessmentqueue_screen** -> `intakecoordinatorassessmentqueue-screen` (Type: layout, Required: 0)
* **intakecoordinatorassessmentqueue_btn_2** -> `intakecoordinatorassessmentqueue-btn-2` (Type: button, Required: 0)
* **intakecoordinatorassessmentqueue_title** -> `intakecoordinatorassessmentqueue-title` (Type: header, Required: 0)
* **intakecoordinatorassessmentqueue_btn_1** -> `intakecoordinatorassessmentqueue-btn-1` (Type: button, Required: 0)
* **intakecoordinatorassessmentqueue_content** -> `intakecoordinatorassessmentqueue-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `390` (Required: 1)
* Component ID: `924` (Required: 1)
* Component ID: `1458` (Required: 1)
* Component ID: `5007` (Required: 1)
* Component ID: `5008` (Required: 1)
* Component ID: `5009` (Required: 1)
* Component ID: `5010` (Required: 1)
* Component ID: `5011` (Required: 1)
* Component ID: `5012` (Required: 1)
* Component ID: `5013` (Required: 1)
* Component ID: `5014` (Required: 1)

## 7. API / Data Mapping
* API ID: `4769` (Required: 1)
* API ID: `4770` (Required: 1)
* API ID: `4771` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_assessment_queue_runtime`
* **Test Name**: `IntakeCoordinatorAssessmentQueueScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Coordinator Assessment Queue`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Coordinator Assessment Queue`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Coordinator Assessment Queue`)
5. **check_url** (Selector: `None`, Value: `/executive/intake-coordinator-assessment-queue`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
