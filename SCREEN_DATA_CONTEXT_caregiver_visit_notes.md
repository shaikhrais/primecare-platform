# SCREEN DATA CONTEXT: caregiver_visit_notes

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverVisitNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `280`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_visit_notes`
* **Screen Name**: `CaregiverVisitNotesScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/visit-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/caregiver_visit_notes_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregivervisitnotesscreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverVisitNotesScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverVisitNotesScreen`
* **Acceptance Criteria**:
- The CaregiverVisitNotesScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_visit_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `caregiver_visit_notes-title` (Type: header, Required: 1)
* **primary_content** -> `caregiver_visit_notes-content` (Type: layout, Required: 1)
* **caregivervisitnotes_btn_3** -> `caregivervisitnotes-btn-3` (Type: button, Required: 0)
* **caregivervisitnotes_btn_1** -> `caregivervisitnotes-btn-1` (Type: button, Required: 0)
* **caregivervisitnotes_btn_2** -> `caregivervisitnotes-btn-2` (Type: button, Required: 0)
* **caregivervisitnotes_title** -> `caregivervisitnotes-title` (Type: header, Required: 0)
* **caregivervisitnotes_content** -> `caregivervisitnotes-content` (Type: layout, Required: 0)
* **caregivervisitnotes_screen** -> `caregivervisitnotes-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `288` (Required: 1)
* Component ID: `822` (Required: 1)
* Component ID: `1356` (Required: 1)
* Component ID: `4077` (Required: 1)
* Component ID: `4078` (Required: 1)
* Component ID: `4079` (Required: 1)
* Component ID: `4080` (Required: 1)
* Component ID: `4081` (Required: 1)
* Component ID: `4082` (Required: 1)
* Component ID: `4083` (Required: 1)

## 7. API / Data Mapping
* API ID: `4601` (Required: 1)
* API ID: `4602` (Required: 1)
* API ID: `4603` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_visit_notes_runtime`
* **Test Name**: `CaregiverVisitNotesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Caregiver Visit Notes`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Caregiver Visit Notes`)
4. **click_sidebar_link** (Selector: `None`, Value: `Caregiver Visit Notes`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/visit-notes`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
