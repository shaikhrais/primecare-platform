# SCREEN DATA CONTEXT: psw_schedule

Below are the database records from `governance.db` used to configure and build the **Guest - PswScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `691`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_schedule`
* **Screen Name**: `PswScheduleScreen`
* **Route Path**: `/generated/psw-schedule`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/psw_schedule_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw schedule.`
* **User Story**: `As a Guest, I want to access the Psw Schedule within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Schedule`
* **Acceptance Criteria**:
- The Psw Schedule route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_schedule-title` (Type: header, Required: 1)
* **primary_content** -> `psw_schedule-content` (Type: layout, Required: 1)
* **pswschedulescreen_screen** -> `pswschedulescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6795` (Required: 1)
* Component ID: `6796` (Required: 1)
* Component ID: `6797` (Required: 1)
* Component ID: `6798` (Required: 1)
* Component ID: `6799` (Required: 1)

## 7. API / Data Mapping
* API ID: `5059` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_schedule_runtime`
* **Test Name**: `Psw Schedule Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-schedule`)
3. **should_be_visible** (Selector: `psw_schedule-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_schedule-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_schedule-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
