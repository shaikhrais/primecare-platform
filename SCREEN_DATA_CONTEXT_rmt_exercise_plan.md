# SCREEN DATA CONTEXT: rmt_exercise_plan

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtExercisePlanScreen** screen.

---

## 1. Screen Record
* **ID**: `357`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_exercise_plan`
* **Screen Name**: `RmtExercisePlanScreen`
* **Route Path**: `/offices/clinical/roles/rmt/exercise-plan`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_exercise_plan_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtexerciseplanscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtExercisePlanScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtExercisePlanScreen`
* **Acceptance Criteria**:
- The RmtExercisePlanScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_exercise_plan-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_exercise_plan-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_exercise_plan-content` (Type: layout, Required: 1)
* **rmtexerciseplan_btn_3** -> `rmtexerciseplan-btn-3` (Type: button, Required: 0)
* **rmtexerciseplan_title** -> `rmtexerciseplan-title` (Type: header, Required: 0)
* **rmtexerciseplan_content** -> `rmtexerciseplan-content` (Type: layout, Required: 0)
* **rmtexerciseplan_screen** -> `rmtexerciseplan-screen` (Type: layout, Required: 0)
* **rmtexerciseplan_loading** -> `rmtexerciseplan-loading` (Type: loading, Required: 0)
* **rmtexerciseplan_btn_2** -> `rmtexerciseplan-btn-2` (Type: button, Required: 0)
* **rmtexerciseplan_btn_1** -> `rmtexerciseplan-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `363` (Required: 1)
* Component ID: `897` (Required: 1)
* Component ID: `1431` (Required: 1)
* Component ID: `4748` (Required: 1)
* Component ID: `4749` (Required: 1)
* Component ID: `4750` (Required: 1)
* Component ID: `4751` (Required: 1)
* Component ID: `4752` (Required: 1)
* Component ID: `4753` (Required: 1)
* Component ID: `4754` (Required: 1)
* Component ID: `4755` (Required: 1)
* Component ID: `4756` (Required: 1)
* Component ID: `4757` (Required: 1)

## 7. API / Data Mapping
* API ID: `4698` (Required: 1)
* API ID: `4699` (Required: 1)
* API ID: `4700` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_exercise_plan_runtime`
* **Test Name**: `RmtExercisePlanScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Exercise Plan`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Exercise Plan`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Exercise Plan`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/exercise-plan`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
