# SCREEN DATA CONTEXT: adjustment_notes

Below are the database records from `governance.db` used to configure and build the **Chiropractor - AdjustmentNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `546`
* **App ID**: `5`
* **Role ID**: `1`
* **Screen Code**: `adjustment_notes`
* **Screen Name**: `AdjustmentNotesScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/adjustment-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/adjustment_notes_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to adjustmentnotesscreen.`
* **User Story**: `As a Chiropractor, I want to access the AdjustmentNotesScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AdjustmentNotesScreen`
* **Acceptance Criteria**:
- The AdjustmentNotesScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `adjustment_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `adjustment_notes-title` (Type: header, Required: 1)
* **primary_content** -> `adjustment_notes-content` (Type: layout, Required: 1)
* **adjustmentnotes_btn_1** -> `adjustmentnotes-btn-1` (Type: button, Required: 0)
* **adjustmentnotes_screen** -> `adjustmentnotes-screen` (Type: layout, Required: 0)
* **adjustmentnotes_content** -> `adjustmentnotes-content` (Type: layout, Required: 0)
* **adjustmentnotes_btn_2** -> `adjustmentnotes-btn-2` (Type: button, Required: 0)
* **adjustmentnotes_loading** -> `adjustmentnotes-loading` (Type: loading, Required: 0)
* **adjustmentnotes_btn_3** -> `adjustmentnotes-btn-3` (Type: button, Required: 0)
* **adjustmentnotes_title** -> `adjustmentnotes-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `470` (Required: 1)
* Component ID: `1004` (Required: 1)
* Component ID: `1538` (Required: 1)
* Component ID: `5776` (Required: 1)
* Component ID: `5777` (Required: 1)
* Component ID: `5778` (Required: 1)
* Component ID: `5779` (Required: 1)
* Component ID: `5780` (Required: 1)
* Component ID: `5781` (Required: 1)
* Component ID: `5782` (Required: 1)
* Component ID: `5783` (Required: 1)

## 7. API / Data Mapping
* API ID: `4881` (Required: 1)
* API ID: `4882` (Required: 1)
* API ID: `4883` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `adjustment_notes_runtime`
* **Test Name**: `AdjustmentNotesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Adjustment Notes`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Adjustment Notes`)
4. **click_sidebar_link** (Selector: `None`, Value: `Adjustment Notes`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/adjustment-notes`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
