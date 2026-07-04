# SCREEN DATA CONTEXT: chiropractor_treatment_notes

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorTreatmentNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `294`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_treatment_notes`
* **Screen Name**: `ChiropractorTreatmentNotesScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/treatment-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_treatment_notes_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractortreatmentnotesscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorTreatmentNotesScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorTreatmentNotesScreen`
* **Acceptance Criteria**:
- The ChiropractorTreatmentNotesScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_treatment_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_treatment_notes-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_treatment_notes-content` (Type: layout, Required: 1)
* **chiropractortreatmentnotes_content** -> `chiropractortreatmentnotes-content` (Type: layout, Required: 0)
* **chiropractortreatmentnotes_title** -> `chiropractortreatmentnotes-title` (Type: header, Required: 0)
* **chiropractortreatmentnotes_btn_1** -> `chiropractortreatmentnotes-btn-1` (Type: button, Required: 0)
* **chiropractortreatmentnotes_btn_2** -> `chiropractortreatmentnotes-btn-2` (Type: button, Required: 0)
* **chiropractortreatmentnotes_btn_3** -> `chiropractortreatmentnotes-btn-3` (Type: button, Required: 0)
* **chiropractortreatmentnotes_screen** -> `chiropractortreatmentnotes-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `302` (Required: 1)
* Component ID: `836` (Required: 1)
* Component ID: `1370` (Required: 1)
* Component ID: `4210` (Required: 1)
* Component ID: `4211` (Required: 1)
* Component ID: `4212` (Required: 1)
* Component ID: `4213` (Required: 1)
* Component ID: `4214` (Required: 1)
* Component ID: `4215` (Required: 1)
* Component ID: `4216` (Required: 1)
* Component ID: `4217` (Required: 1)

## 7. API / Data Mapping
* API ID: `4619` (Required: 1)
* API ID: `4620` (Required: 1)
* API ID: `4621` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_treatment_notes_runtime`
* **Test Name**: `ChiropractorTreatmentNotesScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropractorTreatmentNotesScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/treatment-notes`)
3. **should_be_visible** (Selector: `chiropractor_treatment_notes-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractor_treatment_notes-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractor_treatment_notes-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
