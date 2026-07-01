# SCREEN DATA CONTEXT: rmt_treatment_notes

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtTreatmentNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `356`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_treatment_notes`
* **Screen Name**: `RmtTreatmentNotesScreen`
* **Route Path**: `/offices/clinical/roles/rmt/treatment-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_treatment_notes_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmttreatmentnotesscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtTreatmentNotesScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtTreatmentNotesScreen`
* **Acceptance Criteria**:
- The RmtTreatmentNotesScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_treatment_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_treatment_notes-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_treatment_notes-content` (Type: layout, Required: 1)
* **rmttreatmentnotes_btn_3** -> `rmttreatmentnotes-btn-3` (Type: button, Required: 0)
* **rmttreatmentnotes_screen** -> `rmttreatmentnotes-screen` (Type: layout, Required: 0)
* **rmttreatmentnotes_title** -> `rmttreatmentnotes-title` (Type: header, Required: 0)
* **rmttreatmentnotes_content** -> `rmttreatmentnotes-content` (Type: layout, Required: 0)
* **rmttreatmentnotes_btn_2** -> `rmttreatmentnotes-btn-2` (Type: button, Required: 0)
* **rmttreatmentnotes_btn_1** -> `rmttreatmentnotes-btn-1` (Type: button, Required: 0)
* **rmttreatmentnotes_loading** -> `rmttreatmentnotes-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `362` (Required: 1)
* Component ID: `896` (Required: 1)
* Component ID: `1430` (Required: 1)
* Component ID: `4738` (Required: 1)
* Component ID: `4739` (Required: 1)
* Component ID: `4740` (Required: 1)
* Component ID: `4741` (Required: 1)
* Component ID: `4742` (Required: 1)
* Component ID: `4743` (Required: 1)
* Component ID: `4744` (Required: 1)
* Component ID: `4745` (Required: 1)
* Component ID: `4746` (Required: 1)
* Component ID: `4747` (Required: 1)

## 7. API / Data Mapping
* API ID: `4695` (Required: 1)
* API ID: `4696` (Required: 1)
* API ID: `4697` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_treatment_notes_runtime`
* **Test Name**: `RmtTreatmentNotesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Treatment Notes`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Treatment Notes`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Treatment Notes`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/treatment-notes`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
