# SCREEN DATA CONTEXT: scheduler_calendar

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerCalendarScreen** screen.

---

## 1. Screen Record
* **ID**: `377`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_calendar`
* **Screen Name**: `SchedulerCalendarScreen`
* **Route Path**: `/staff/scheduler-calendar`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_calendar_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulercalendarscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerCalendarScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerCalendarScreen`
* **Acceptance Criteria**:
- The SchedulerCalendarScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_calendar-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_calendar-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_calendar-content` (Type: layout, Required: 1)
* **schedulercalendar_loading** -> `schedulercalendar-loading` (Type: loading, Required: 0)
* **schedulercalendar_btn_1** -> `schedulercalendar-btn-1` (Type: button, Required: 0)
* **schedulercalendar_title** -> `schedulercalendar-title` (Type: header, Required: 0)
* **schedulercalendar_btn_4** -> `schedulercalendar-btn-4` (Type: button, Required: 0)
* **schedulercalendar_btn_3** -> `schedulercalendar-btn-3` (Type: button, Required: 0)
* **schedulercalendar_btn_2** -> `schedulercalendar-btn-2` (Type: button, Required: 0)
* **schedulercalendar_content** -> `schedulercalendar-content` (Type: layout, Required: 0)
* **schedulercalendar_screen** -> `schedulercalendar-screen` (Type: layout, Required: 0)
* **schedulercalendar_btn_5** -> `schedulercalendar-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `383` (Required: 1)
* Component ID: `917` (Required: 1)
* Component ID: `1451` (Required: 1)
* Component ID: `4944` (Required: 1)
* Component ID: `4945` (Required: 1)
* Component ID: `4946` (Required: 1)
* Component ID: `4947` (Required: 1)
* Component ID: `4948` (Required: 1)
* Component ID: `4949` (Required: 1)
* Component ID: `4950` (Required: 1)
* Component ID: `4951` (Required: 1)
* Component ID: `4952` (Required: 1)
* Component ID: `4953` (Required: 1)

## 7. API / Data Mapping
* API ID: `4756` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_calendar_runtime`
* **Test Name**: `SchedulerCalendarScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerCalendarScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-calendar`)
3. **should_be_visible** (Selector: `scheduler_calendar-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_calendar-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_calendar-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
