# SCREEN DATA CONTEXT: physiotherapist_treatment_notes

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistTreatmentNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `339`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_treatment_notes`
* **Screen Name**: `PhysiotherapistTreatmentNotesScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/treatment-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_treatment_notes_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapisttreatmentnotesscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistTreatmentNotesScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistTreatmentNotesScreen`
* **Acceptance Criteria**:
- The PhysiotherapistTreatmentNotesScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_treatment_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_treatment_notes-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_treatment_notes-content` (Type: layout, Required: 1)
* **physiotherapisttreatmentnotes_content** -> `physiotherapisttreatmentnotes-content` (Type: layout, Required: 0)
* **physiotherapisttreatmentnotes_title** -> `physiotherapisttreatmentnotes-title` (Type: header, Required: 0)
* **physiotherapisttreatmentnotes_screen** -> `physiotherapisttreatmentnotes-screen` (Type: layout, Required: 0)
* **physiotherapisttreatmentnotes_btn_3** -> `physiotherapisttreatmentnotes-btn-3` (Type: button, Required: 0)
* **physiotherapisttreatmentnotes_btn_1** -> `physiotherapisttreatmentnotes-btn-1` (Type: button, Required: 0)
* **physiotherapisttreatmentnotes_btn_2** -> `physiotherapisttreatmentnotes-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `347` (Required: 1)
* Component ID: `881` (Required: 1)
* Component ID: `1415` (Required: 1)
* Component ID: `4594` (Required: 1)
* Component ID: `4595` (Required: 1)
* Component ID: `4596` (Required: 1)
* Component ID: `4597` (Required: 1)
* Component ID: `4598` (Required: 1)
* Component ID: `4599` (Required: 1)
* Component ID: `4600` (Required: 1)
* Component ID: `4601` (Required: 1)

## 7. API / Data Mapping
* API ID: `4670` (Required: 1)
* API ID: `4671` (Required: 1)
* API ID: `4672` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_treatment_notes_runtime`
* **Test Name**: `PhysiotherapistTreatmentNotesScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysiotherapistTreatmentNotesScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/treatment-notes`)
3. **should_be_visible** (Selector: `physiotherapist_treatment_notes-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physiotherapist_treatment_notes-title`, Value: `None`)
5. **should_be_visible** (Selector: `physiotherapist_treatment_notes-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
