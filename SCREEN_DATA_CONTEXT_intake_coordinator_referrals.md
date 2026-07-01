# SCREEN DATA CONTEXT: intake_coordinator_referrals

Below are the database records from `governance.db` used to configure and build the **Volunteer Coordinator - IntakeCoordinatorReferralsScreen** screen.

---

## 1. Screen Record
* **ID**: `382`
* **App ID**: `5`
* **Role ID**: `48`
* **Screen Code**: `intake_coordinator_referrals`
* **Screen Name**: `IntakeCoordinatorReferralsScreen`
* **Route Path**: `/executive/intake-coordinator-referrals`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_referrals_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Volunteer Coordinator personnel to oversee, audit, and coordinate operations related to intakecoordinatorreferralsscreen.`
* **User Story**: `As a Volunteer Coordinator, I want to access the IntakeCoordinatorReferralsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeCoordinatorReferralsScreen`
* **Acceptance Criteria**:
- The IntakeCoordinatorReferralsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Volunteer Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_referrals-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_referrals-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_referrals-content` (Type: layout, Required: 1)
* **intakecoordinatorreferrals_title** -> `intakecoordinatorreferrals-title` (Type: header, Required: 0)
* **intakecoordinatorreferrals_btn_1** -> `intakecoordinatorreferrals-btn-1` (Type: button, Required: 0)
* **intakecoordinatorreferrals_screen** -> `intakecoordinatorreferrals-screen` (Type: layout, Required: 0)
* **intakecoordinatorreferrals_content** -> `intakecoordinatorreferrals-content` (Type: layout, Required: 0)
* **intakecoordinatorreferrals_btn_3** -> `intakecoordinatorreferrals-btn-3` (Type: button, Required: 0)
* **intakecoordinatorreferrals_btn_2** -> `intakecoordinatorreferrals-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `388` (Required: 1)
* Component ID: `922` (Required: 1)
* Component ID: `1456` (Required: 1)
* Component ID: `4990` (Required: 1)
* Component ID: `4991` (Required: 1)
* Component ID: `4992` (Required: 1)
* Component ID: `4993` (Required: 1)
* Component ID: `4994` (Required: 1)
* Component ID: `4995` (Required: 1)
* Component ID: `4996` (Required: 1)
* Component ID: `4997` (Required: 1)
* Component ID: `4998` (Required: 1)
* Component ID: `4999` (Required: 1)

## 7. API / Data Mapping
* API ID: `4763` (Required: 1)
* API ID: `4764` (Required: 1)
* API ID: `4765` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_referrals_runtime`
* **Test Name**: `IntakeCoordinatorReferralsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Coordinator Referrals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `volunteer_coordinator`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Intake Coordinator Referrals`)
4. **click_sidebar_link** (Selector: `None`, Value: `Intake Coordinator Referrals`)
5. **check_url** (Selector: `None`, Value: `/executive/intake-coordinator-referrals`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
