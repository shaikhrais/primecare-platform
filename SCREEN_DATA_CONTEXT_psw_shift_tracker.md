# SCREEN DATA CONTEXT: psw_shift_tracker

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswShiftTrackerScreen** screen.

---

## 1. Screen Record
* **ID**: `235`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_shift_tracker`
* **Screen Name**: `PswShiftTrackerScreen`
* **Route Path**: `/offices/clinical/roles/psw/schedule`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswshifttrackerscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswShiftTrackerScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswShiftTrackerScreen`
* **Acceptance Criteria**:
- The PswShiftTrackerScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_shift_tracker-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_shift_tracker-title` (Type: header, Required: 1)
* **primary_content** -> `psw_shift_tracker-content` (Type: layout, Required: 1)
* **pswshifttracker_screen** -> `pswshifttracker-screen` (Type: layout, Required: 0)
* **pswshifttracker_content** -> `pswshifttracker-content` (Type: layout, Required: 0)
* **pswshifttracker_title** -> `pswshifttracker-title` (Type: header, Required: 0)
* **pswshifttracker_btn_1** -> `pswshifttracker-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `243` (Required: 1)
* Component ID: `777` (Required: 1)
* Component ID: `1311` (Required: 1)
* Component ID: `3682` (Required: 1)
* Component ID: `3683` (Required: 1)
* Component ID: `3684` (Required: 1)
* Component ID: `3685` (Required: 1)
* Component ID: `3686` (Required: 1)
* Component ID: `3687` (Required: 1)
* Component ID: `3688` (Required: 1)
* Component ID: `3689` (Required: 1)

## 7. API / Data Mapping
* API ID: `4528` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_shift_tracker_runtime`
* **Test Name**: `PswShiftTrackerScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Shift Tracker`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Shift Tracker`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Shift Tracker`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
