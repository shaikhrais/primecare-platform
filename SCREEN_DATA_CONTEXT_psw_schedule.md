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
* **Stage/Status**: `wired`

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
* **Test Name**: `Psw Schedule Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Schedule`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Schedule`)
5. **check_url** (Selector: `None`, Value: `/generated/psw-schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
