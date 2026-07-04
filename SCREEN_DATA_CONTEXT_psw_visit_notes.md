# SCREEN DATA CONTEXT: psw_visit_notes

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - VisitNotesScreen** screen.

---

## 1. Screen Record
* **ID**: `237`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_visit_notes`
* **Screen Name**: `VisitNotesScreen`
* **Route Path**: `/offices/clinical/roles/psw/visit-notes`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswvisitnotesscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswVisitNotesScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswVisitNotesScreen`
* **Acceptance Criteria**:
- The PswVisitNotesScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_visit_notes-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_visit_notes-title` (Type: header, Required: 1)
* **primary_content** -> `psw_visit_notes-content` (Type: layout, Required: 1)
* **pswvisitnotes_screen** -> `pswvisitnotes-screen` (Type: layout, Required: 0)
* **pswvisitnotes_title** -> `pswvisitnotes-title` (Type: header, Required: 0)
* **pswvisitnotes_loading** -> `pswvisitnotes-loading` (Type: loading, Required: 0)
* **pswvisitnotes_btn_3** -> `pswvisitnotes-btn-3` (Type: button, Required: 0)
* **pswvisitnotes_btn_1** -> `pswvisitnotes-btn-1` (Type: button, Required: 0)
* **pswvisitnotes_content** -> `pswvisitnotes-content` (Type: layout, Required: 0)
* **pswvisitnotes_btn_2** -> `pswvisitnotes-btn-2` (Type: button, Required: 0)
* **pswvisitnotes_btn_4** -> `pswvisitnotes-btn-4` (Type: button, Required: 0)
* **visit_notes_textarea** -> `visit-notes-textarea` (Type: textarea, Required: 1)
* **save_button** -> `save-button` (Type: button, Required: 1)

## 6. Component Mapping
* Component ID: `245` (Required: 1)
* Component ID: `779` (Required: 1)
* Component ID: `1313` (Required: 1)
* Component ID: `3696` (Required: 1)
* Component ID: `3697` (Required: 1)
* Component ID: `3698` (Required: 1)
* Component ID: `3699` (Required: 1)
* Component ID: `3700` (Required: 1)
* Component ID: `3701` (Required: 1)
* Component ID: `3702` (Required: 1)
* Component ID: `3703` (Required: 1)
* Component ID: `4654` (Required: 1)
* Component ID: `4655` (Required: 1)
* Component ID: `4656` (Required: 1)
* Component ID: `4657` (Required: 1)

## 7. API / Data Mapping
* API ID: `4530` (Required: 1)
* API ID: `4531` (Required: 1)
* API ID: `4532` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_visit_notes_runtime`
* **Test Name**: `Visit Notes Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Visit Notes`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/visit-notes`)
3. **should_be_visible** (Selector: `psw_visit_notes-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_visit_notes-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_visit_notes-content`, Value: `None`)
6. **should_be_visible** (Selector: `visit-notes-textarea`, Value: `None`)
7. **should_be_visible** (Selector: `save-button`, Value: `None`)
8. **check_no_console_error** (Selector: `None`, Value: `None`)
9. **screenshot** (Selector: `None`, Value: `None`)
