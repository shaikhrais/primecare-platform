# SCREEN DATA CONTEXT: scheduler_booking_requests

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerBookingRequestsScreen** screen.

---

## 1. Screen Record
* **ID**: `378`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduler_booking_requests`
* **Screen Name**: `SchedulerBookingRequestsScreen`
* **Route Path**: `/staff/scheduler-booking-requests`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_booking_requests_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulerbookingrequestsscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerBookingRequestsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerBookingRequestsScreen`
* **Acceptance Criteria**:
- The SchedulerBookingRequestsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_booking_requests-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_booking_requests-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_booking_requests-content` (Type: layout, Required: 1)
* **schedulerbookingrequests_btn_2** -> `schedulerbookingrequests-btn-2` (Type: button, Required: 0)
* **schedulerbookingrequests_title** -> `schedulerbookingrequests-title` (Type: header, Required: 0)
* **schedulerbookingrequests_screen** -> `schedulerbookingrequests-screen` (Type: layout, Required: 0)
* **schedulerbookingrequests_btn_3** -> `schedulerbookingrequests-btn-3` (Type: button, Required: 0)
* **schedulerbookingrequests_btn_5** -> `schedulerbookingrequests-btn-5` (Type: button, Required: 0)
* **schedulerbookingrequests_btn_1** -> `schedulerbookingrequests-btn-1` (Type: button, Required: 0)
* **schedulerbookingrequests_btn_4** -> `schedulerbookingrequests-btn-4` (Type: button, Required: 0)
* **schedulerbookingrequests_content** -> `schedulerbookingrequests-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `384` (Required: 1)
* Component ID: `918` (Required: 1)
* Component ID: `1452` (Required: 1)
* Component ID: `4954` (Required: 1)
* Component ID: `4955` (Required: 1)
* Component ID: `4956` (Required: 1)
* Component ID: `4957` (Required: 1)
* Component ID: `4958` (Required: 1)
* Component ID: `4959` (Required: 1)
* Component ID: `4960` (Required: 1)
* Component ID: `4961` (Required: 1)
* Component ID: `4962` (Required: 1)
* Component ID: `4963` (Required: 1)

## 7. API / Data Mapping
* API ID: `4757` (Required: 1)
* API ID: `4758` (Required: 1)
* API ID: `4759` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_booking_requests_runtime`
* **Test Name**: `SchedulerBookingRequestsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerBookingRequestsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-booking-requests`)
3. **should_be_visible** (Selector: `scheduler_booking_requests-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_booking_requests-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_booking_requests-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
