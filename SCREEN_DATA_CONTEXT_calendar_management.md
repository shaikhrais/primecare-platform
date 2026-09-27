# SCREEN DATA CONTEXT: calendar_management

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - CalendarManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `513`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `calendar_management`
* **Screen Name**: `CalendarManagementScreen`
* **Route Path**: `/staff/calendar-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/calendar_management_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to calendarmanagementscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the CalendarManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CalendarManagementScreen`
* **Acceptance Criteria**:
- The CalendarManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `calendar_management-screen` (Type: layout, Required: 1)
* **page_title** -> `calendar_management-title` (Type: header, Required: 1)
* **primary_content** -> `calendar_management-content` (Type: layout, Required: 1)
* **calendarmanagement_btn_2** -> `calendarmanagement-btn-2` (Type: button, Required: 0)
* **calendarmanagement_content** -> `calendarmanagement-content` (Type: layout, Required: 0)
* **calendarmanagement_btn_4** -> `calendarmanagement-btn-4` (Type: button, Required: 0)
* **calendarmanagement_btn_1** -> `calendarmanagement-btn-1` (Type: button, Required: 0)
* **calendarmanagement_btn_5** -> `calendarmanagement-btn-5` (Type: button, Required: 0)
* **calendarmanagement_screen** -> `calendarmanagement-screen` (Type: layout, Required: 0)
* **calendarmanagement_btn_3** -> `calendarmanagement-btn-3` (Type: button, Required: 0)
* **calendarmanagement_title** -> `calendarmanagement-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `442` (Required: 1)
* Component ID: `976` (Required: 1)
* Component ID: `1510` (Required: 1)
* Component ID: `5508` (Required: 1)
* Component ID: `5509` (Required: 1)
* Component ID: `5510` (Required: 1)
* Component ID: `5511` (Required: 1)
* Component ID: `5512` (Required: 1)
* Component ID: `5513` (Required: 1)
* Component ID: `5514` (Required: 1)
* Component ID: `5515` (Required: 1)
* Component ID: `5516` (Required: 1)
* Component ID: `5517` (Required: 1)

## 7. API / Data Mapping
* API ID: `4829` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `calendar_management_runtime`
* **Test Name**: `CalendarManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CalendarManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/calendar-management`)
3. **should_be_visible** (Selector: `calendar_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `calendar_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `calendar_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
