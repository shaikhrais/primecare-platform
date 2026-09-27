# SCREEN DATA CONTEXT: intake_coordinator_intake_forms

Below are the database records from `governance.db` used to configure and build the **Guest - IntakeCoordinatorIntakeFormsScreen** screen.

---

## 1. Screen Record
* **ID**: `876`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `intake_coordinator_intake_forms`
* **Screen Name**: `IntakeCoordinatorIntakeFormsScreen`
* **Route Path**: `/generated/intake-coordinator-intake-forms`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_intake_forms_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to intake coordinator intake forms.`
* **User Story**: `As a Guest, I want to access the Intake Coordinator Intake Forms within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Intake Coordinator Intake Forms`
* **Acceptance Criteria**:
- The Intake Coordinator Intake Forms route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_coordinator_intake_forms-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_coordinator_intake_forms-title` (Type: header, Required: 1)
* **primary_content** -> `intake_coordinator_intake_forms-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7817` (Required: 1)
* Component ID: `7818` (Required: 1)
* Component ID: `7819` (Required: 1)
* Component ID: `7820` (Required: 1)
* Component ID: `7821` (Required: 1)
* Component ID: `7822` (Required: 1)

## 7. API / Data Mapping
* API ID: `5282` (Required: 1)
* API ID: `5283` (Required: 1)
* API ID: `5284` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_coordinator_intake_forms_runtime`
* **Test Name**: `Intake Coordinator Intake Forms Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Intake Coordinator Intake Forms`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/intake-coordinator-intake-forms`)
3. **should_be_visible** (Selector: `intake_coordinator_intake_forms-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_coordinator_intake_forms-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_coordinator_intake_forms-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
