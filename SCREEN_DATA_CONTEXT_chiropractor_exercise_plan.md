# SCREEN DATA CONTEXT: chiropractor_exercise_plan

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorExercisePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `295`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_exercise_plan`
* **Screen Name**: `ChiropractorExercisePlanScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/exercise-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_exercise_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorexerciseplanscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorExercisePlanScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorExercisePlanScreen`
* **Acceptance Criteria**:
- The ChiropractorExercisePlanScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_exercise_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_exercise_plan-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_exercise_plan-content` (Type: layout, Required: 1)
* **chiropractorexerciseplan_screen** -> `chiropractorexerciseplan-screen` (Type: layout, Required: 0)
* **chiropractorexerciseplan_content** -> `chiropractorexerciseplan-content` (Type: layout, Required: 0)
* **chiropractorexerciseplan_btn_3** -> `chiropractorexerciseplan-btn-3` (Type: button, Required: 0)
* **chiropractorexerciseplan_btn_1** -> `chiropractorexerciseplan-btn-1` (Type: button, Required: 0)
* **chiropractorexerciseplan_title** -> `chiropractorexerciseplan-title` (Type: header, Required: 0)
* **chiropractorexerciseplan_btn_2** -> `chiropractorexerciseplan-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `303` (Required: 1)
* Component ID: `837` (Required: 1)
* Component ID: `1371` (Required: 1)
* Component ID: `4218` (Required: 1)
* Component ID: `4219` (Required: 1)
* Component ID: `4220` (Required: 1)
* Component ID: `4221` (Required: 1)
* Component ID: `4222` (Required: 1)
* Component ID: `4223` (Required: 1)
* Component ID: `4224` (Required: 1)
* Component ID: `4225` (Required: 1)
* Component ID: `4226` (Required: 1)
* Component ID: `4227` (Required: 1)
* Component ID: `4228` (Required: 1)
* Component ID: `4229` (Required: 1)
* Component ID: `4230` (Required: 1)
* Component ID: `4231` (Required: 1)
* Component ID: `4232` (Required: 1)
* Component ID: `4233` (Required: 1)

## 7. API / Data Mapping
* API ID: `4622` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_exercise_plan_runtime`
* **Test Name**: `ChiropractorExercisePlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Exercise Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Exercise Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Exercise Plan`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/exercise-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
