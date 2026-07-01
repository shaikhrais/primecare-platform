# SCREEN DATA CONTEXT: exercise_prescription

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - ExercisePrescriptionScreen** screen.

---

## 1. Screen Record
* **ID**: `539`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `exercise_prescription`
* **Screen Name**: `ExercisePrescriptionScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/exercise-prescription`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/exercise_prescription_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to exerciseprescriptionscreen.`
* **User Story**: `As a Physiotherapist, I want to access the ExercisePrescriptionScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ExercisePrescriptionScreen`
* **Acceptance Criteria**:
- The ExercisePrescriptionScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `exercise_prescription-screen` (Type: layout, Required: 1)
* **page_title** -> `exercise_prescription-title` (Type: header, Required: 1)
* **primary_content** -> `exercise_prescription-content` (Type: layout, Required: 1)
* **exerciseprescription_title** -> `exerciseprescription-title` (Type: header, Required: 0)
* **exerciseprescription_btn_1** -> `exerciseprescription-btn-1` (Type: button, Required: 0)
* **exerciseprescription_content** -> `exerciseprescription-content` (Type: layout, Required: 0)
* **exerciseprescription_screen** -> `exerciseprescription-screen` (Type: layout, Required: 0)
* **exerciseprescription_btn_3** -> `exerciseprescription-btn-3` (Type: button, Required: 0)
* **exerciseprescription_btn_2** -> `exerciseprescription-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `464` (Required: 1)
* Component ID: `998` (Required: 1)
* Component ID: `1532` (Required: 1)
* Component ID: `5717` (Required: 1)
* Component ID: `5718` (Required: 1)
* Component ID: `5719` (Required: 1)
* Component ID: `5720` (Required: 1)
* Component ID: `5721` (Required: 1)
* Component ID: `5722` (Required: 1)
* Component ID: `5723` (Required: 1)
* Component ID: `5724` (Required: 1)
* Component ID: `5725` (Required: 1)
* Component ID: `5726` (Required: 1)

## 7. API / Data Mapping
* API ID: `4869` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `exercise_prescription_runtime`
* **Test Name**: `ExercisePrescriptionScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Exercise Prescription`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Exercise Prescription`)
4. **click_sidebar_link** (Selector: `None`, Value: `Exercise Prescription`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/exercise-prescription`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
