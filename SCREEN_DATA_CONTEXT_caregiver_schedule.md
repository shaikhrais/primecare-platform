# SCREEN DATA CONTEXT: caregiver_schedule

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `281`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_schedule`
* **Screen Name**: `CaregiverScheduleScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/schedule`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/caregiver_schedule_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregiverschedulescreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverScheduleScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverScheduleScreen`
* **Acceptance Criteria**:
- The CaregiverScheduleScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_schedule-screen` (Type: layout, Required: 0)
* **page_title** -> `caregiver_schedule-title` (Type: header, Required: 0)
* **primary_content** -> `caregiver_schedule-content` (Type: layout, Required: 0)
* **caregiverschedule_btn_2** -> `caregiverschedule-btn-2` (Type: button, Required: 0)
* **caregiverschedule_content** -> `caregiverschedule-content` (Type: layout, Required: 1)
* **caregiverschedule_title** -> `caregiverschedule-title` (Type: header, Required: 1)
* **caregiverschedule_loading** -> `caregiverschedule-loading` (Type: loading, Required: 0)
* **caregiverschedule_btn_3** -> `caregiverschedule-btn-3` (Type: button, Required: 0)
* **caregiverschedule_screen** -> `caregiverschedule-screen` (Type: layout, Required: 1)
* **caregiverschedule_btn_1** -> `caregiverschedule-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `289` (Required: 1)
* Component ID: `823` (Required: 1)
* Component ID: `1357` (Required: 1)
* Component ID: `4084` (Required: 1)
* Component ID: `4085` (Required: 1)
* Component ID: `4086` (Required: 1)
* Component ID: `4087` (Required: 1)
* Component ID: `4088` (Required: 1)
* Component ID: `4089` (Required: 1)
* Component ID: `4090` (Required: 1)
* Component ID: `4091` (Required: 1)

## 7. API / Data Mapping
* API ID: `4604` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_schedule_runtime`
* **Test Name**: `CaregiverScheduleScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CaregiverScheduleScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/schedule`)
3. **should_be_visible** (Selector: `caregiverschedule-content`, Value: `None`)
4. **should_be_visible** (Selector: `caregiverschedule-title`, Value: `None`)
5. **should_be_visible** (Selector: `caregiverschedule-screen`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
