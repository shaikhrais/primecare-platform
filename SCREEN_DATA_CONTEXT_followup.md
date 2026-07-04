# SCREEN DATA CONTEXT: followup

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - FollowupScreen** screen.

---

## 1. Screen Record
* **ID**: `552`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `followup`
* **Screen Name**: `FollowupScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/followup`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/followup_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to followupscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the FollowupScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FollowupScreen`
* **Acceptance Criteria**:
- The FollowupScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `followup-screen` (Type: layout, Required: 1)
* **page_title** -> `followup-title` (Type: header, Required: 1)
* **primary_content** -> `followup-content` (Type: layout, Required: 1)
* **followup_btn_3** -> `followup-btn-3` (Type: button, Required: 0)
* **followup_btn_1** -> `followup-btn-1` (Type: button, Required: 0)
* **followup_loading** -> `followup-loading` (Type: loading, Required: 0)
* **followup_btn_2** -> `followup-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `476` (Required: 1)
* Component ID: `1010` (Required: 1)
* Component ID: `1544` (Required: 1)
* Component ID: `5825` (Required: 1)
* Component ID: `5826` (Required: 1)
* Component ID: `5827` (Required: 1)
* Component ID: `5828` (Required: 1)
* Component ID: `5829` (Required: 1)
* Component ID: `5830` (Required: 1)
* Component ID: `5831` (Required: 1)
* Component ID: `5832` (Required: 1)

## 7. API / Data Mapping
* API ID: `4895` (Required: 1)
* API ID: `4896` (Required: 1)
* API ID: `4897` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `followup_runtime`
* **Test Name**: `FollowupScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FollowupScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/followup`)
3. **should_be_visible** (Selector: `followup-screen`, Value: `None`)
4. **should_be_visible** (Selector: `followup-title`, Value: `None`)
5. **should_be_visible** (Selector: `followup-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
