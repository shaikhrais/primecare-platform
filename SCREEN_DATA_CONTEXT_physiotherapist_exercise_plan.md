# SCREEN DATA CONTEXT: physiotherapist_exercise_plan

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistExercisePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `340`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_exercise_plan`
* **Screen Name**: `PhysiotherapistExercisePlanScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/exercise-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_exercise_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistexerciseplanscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistExercisePlanScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistExercisePlanScreen`
* **Acceptance Criteria**:
- The PhysiotherapistExercisePlanScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_exercise_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_exercise_plan-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_exercise_plan-content` (Type: layout, Required: 1)
* **physiotherapistexerciseplan_screen** -> `physiotherapistexerciseplan-screen` (Type: layout, Required: 0)
* **physiotherapistexerciseplan_content** -> `physiotherapistexerciseplan-content` (Type: layout, Required: 0)
* **physiotherapistexerciseplan_btn_2** -> `physiotherapistexerciseplan-btn-2` (Type: button, Required: 0)
* **physiotherapistexerciseplan_btn_1** -> `physiotherapistexerciseplan-btn-1` (Type: button, Required: 0)
* **physiotherapistexerciseplan_btn_3** -> `physiotherapistexerciseplan-btn-3` (Type: button, Required: 0)
* **physiotherapistexerciseplan_title** -> `physiotherapistexerciseplan-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `348` (Required: 1)
* Component ID: `882` (Required: 1)
* Component ID: `1416` (Required: 1)
* Component ID: `4602` (Required: 1)
* Component ID: `4603` (Required: 1)
* Component ID: `4604` (Required: 1)
* Component ID: `4605` (Required: 1)
* Component ID: `4606` (Required: 1)
* Component ID: `4607` (Required: 1)
* Component ID: `4608` (Required: 1)

## 7. API / Data Mapping
* API ID: `4673` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_exercise_plan_runtime`
* **Test Name**: `PhysiotherapistExercisePlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Exercise Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Exercise Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Exercise Plan`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/exercise-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
