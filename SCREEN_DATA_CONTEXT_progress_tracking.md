# SCREEN DATA CONTEXT: progress_tracking

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - ProgressTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `540`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `progress_tracking`
* **Screen Name**: `ProgressTrackingScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/progress-tracking`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/progress_tracking_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to progresstrackingscreen.`
* **User Story**: `As a Physiotherapist, I want to access the ProgressTrackingScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ProgressTrackingScreen`
* **Acceptance Criteria**:
- The ProgressTrackingScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `progress_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `progress_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `progress_tracking-content` (Type: layout, Required: 1)
* **progresstracking_loading** -> `progresstracking-loading` (Type: loading, Required: 0)
* **progresstracking_btn_3** -> `progresstracking-btn-3` (Type: button, Required: 0)
* **progresstracking_content** -> `progresstracking-content` (Type: layout, Required: 0)
* **progresstracking_screen** -> `progresstracking-screen` (Type: layout, Required: 0)
* **progresstracking_title** -> `progresstracking-title` (Type: header, Required: 0)
* **progresstracking_btn_2** -> `progresstracking-btn-2` (Type: button, Required: 0)
* **progresstracking_btn_1** -> `progresstracking-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `465` (Required: 1)
* Component ID: `999` (Required: 1)
* Component ID: `1533` (Required: 1)
* Component ID: `5727` (Required: 1)
* Component ID: `5728` (Required: 1)
* Component ID: `5729` (Required: 1)
* Component ID: `5730` (Required: 1)
* Component ID: `5731` (Required: 1)
* Component ID: `5732` (Required: 1)
* Component ID: `5733` (Required: 1)
* Component ID: `5734` (Required: 1)

## 7. API / Data Mapping
* API ID: `4870` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `progress_tracking_runtime`
* **Test Name**: `ProgressTrackingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ProgressTrackingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/progress-tracking`)
3. **should_be_visible** (Selector: `progress_tracking-screen`, Value: `None`)
4. **should_be_visible** (Selector: `progress_tracking-title`, Value: `None`)
5. **should_be_visible** (Selector: `progress_tracking-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
