# SCREEN DATA CONTEXT: patient_trial_outcomeser

Below are the database records from `governance.db` used to configure and build the **Guest - PatientTrialOutcomeserScreen** screen.

---

## 1. Screen Record
* **ID**: `1014`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `patient_trial_outcomeser`
* **Screen Name**: `PatientTrialOutcomeserScreen`
* **Route Path**: `/generated/patient-trial-outcomeser`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/patient_trial_outcomes_viewer.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to patient trial outcomeser.`
* **User Story**: `As a Guest, I want to access the Patient Trial Outcomeser within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Patient Trial Outcomeser`
* **Acceptance Criteria**:
- The Patient Trial Outcomeser route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `patient_trial_outcomeser-screen` (Type: layout, Required: 1)
* **page_title** -> `patient_trial_outcomeser-title` (Type: header, Required: 1)
* **primary_content** -> `patient_trial_outcomeser-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8560` (Required: 1)
* Component ID: `8561` (Required: 1)
* Component ID: `8562` (Required: 1)
* Component ID: `8563` (Required: 1)
* Component ID: `8564` (Required: 1)
* Component ID: `8565` (Required: 1)
* Component ID: `8566` (Required: 1)
* Component ID: `8567` (Required: 1)
* Component ID: `8568` (Required: 1)

## 7. API / Data Mapping
* API ID: `5480` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `patient_trial_outcomeser_runtime`
* **Test Name**: `Patient Trial Outcomeser Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Patient Trial Outcomeser`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Patient Trial Outcomeser`)
4. **click_sidebar_link** (Selector: `None`, Value: `Patient Trial Outcomeser`)
5. **check_url** (Selector: `None`, Value: `/generated/patient-trial-outcomeser`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
