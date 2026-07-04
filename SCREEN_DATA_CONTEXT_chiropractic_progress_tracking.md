# SCREEN DATA CONTEXT: chiropractic_progress_tracking

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropracticProgressTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `548`
* **App ID**: `5`
* **Role ID**: `1`
* **Screen Code**: `chiropractic_progress_tracking`
* **Screen Name**: `ChiropracticProgressTrackingScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/chiropractic-progress-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractic_progress_tracking_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropracticprogresstrackingscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropracticProgressTrackingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropracticProgressTrackingScreen`
* **Acceptance Criteria**:
- The ChiropracticProgressTrackingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractic_progress_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractic_progress_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractic_progress_tracking-content` (Type: layout, Required: 1)
* **chiropracticprogresstracking_btn_3** -> `chiropracticprogresstracking-btn-3` (Type: button, Required: 0)
* **chiropracticprogresstracking_content** -> `chiropracticprogresstracking-content` (Type: layout, Required: 0)
* **chiropracticprogresstracking_screen** -> `chiropracticprogresstracking-screen` (Type: layout, Required: 0)
* **chiropracticprogresstracking_btn_1** -> `chiropracticprogresstracking-btn-1` (Type: button, Required: 0)
* **chiropracticprogresstracking_title** -> `chiropracticprogresstracking-title` (Type: header, Required: 0)
* **chiropracticprogresstracking_btn_2** -> `chiropracticprogresstracking-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `472` (Required: 1)
* Component ID: `1006` (Required: 1)
* Component ID: `1540` (Required: 1)
* Component ID: `5792` (Required: 1)
* Component ID: `5793` (Required: 1)
* Component ID: `5794` (Required: 1)
* Component ID: `5795` (Required: 1)
* Component ID: `5796` (Required: 1)
* Component ID: `5797` (Required: 1)
* Component ID: `5798` (Required: 1)
* Component ID: `5799` (Required: 1)

## 7. API / Data Mapping
* API ID: `4885` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractic_progress_tracking_runtime`
* **Test Name**: `ChiropracticProgressTrackingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropracticProgressTrackingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/chiropractic-progress-tracking`)
3. **should_be_visible** (Selector: `chiropractic_progress_tracking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractic_progress_tracking-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractic_progress_tracking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
