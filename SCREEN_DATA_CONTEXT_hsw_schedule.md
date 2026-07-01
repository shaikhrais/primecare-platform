# SCREEN DATA CONTEXT: hsw_schedule

Below are the database records from `governance.db` used to configure and build the **Home Support Worker - HswScheduleScreen** screen.

---

## 1. Screen Record
* **ID**: `85`
* **App ID**: `1`
* **Role ID**: `52`
* **Screen Code**: `hsw_schedule`
* **Screen Name**: `HswScheduleScreen`
* **Route Path**: `/clinical/hsw-schedule`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/hsw_schedule_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `52`
* **Role Code**: `hsw`
* **Role Name**: `Home Support Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Home Support Worker personnel to oversee, audit, and coordinate operations related to hswschedulescreen.`
* **User Story**: `As a Home Support Worker, I want to access the HswScheduleScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HswScheduleScreen`
* **Acceptance Criteria**:
- The HswScheduleScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Home Support Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hsw_schedule-screen` (Type: layout, Required: 1)
* **page_title** -> `hsw_schedule-title` (Type: header, Required: 1)
* **primary_content** -> `hsw_schedule-content` (Type: layout, Required: 1)
* **hswschedule_content** -> `hswschedule-content` (Type: layout, Required: 0)
* **hswschedule_btn_1** -> `hswschedule-btn-1` (Type: button, Required: 0)
* **request_schedule_swap** -> `request_schedule_swap` (Type: custom, Required: 0)
* **generate_travel_expense_report** -> `generate_travel_expense_report` (Type: custom, Required: 0)
* **data_cy_hsw_visits_calendar_view** -> `data-cy-hsw-visits-calendar-view` (Type: custom, Required: 0)
* **data_cy_hsw_client_map_locator** -> `data-cy-hsw-client-map-locator` (Type: custom, Required: 0)
* **hswschedule_screen** -> `hswschedule-screen` (Type: layout, Required: 0)
* **data_cy_hsw_mileage_tracker_widget** -> `data-cy-hsw-mileage-tracker-widget` (Type: custom, Required: 0)
* **hswschedule_title** -> `hswschedule-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `93` (Required: 1)
* Component ID: `627` (Required: 1)
* Component ID: `1161` (Required: 1)
* Component ID: `2338` (Required: 1)
* Component ID: `2339` (Required: 1)
* Component ID: `2340` (Required: 1)
* Component ID: `2341` (Required: 1)
* Component ID: `2342` (Required: 1)
* Component ID: `2343` (Required: 1)

## 7. API / Data Mapping
* API ID: `4360` (Required: 1)
* API ID: `4361` (Required: 1)
* API ID: `4362` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hsw_schedule_runtime`
* **Test Name**: `HswScheduleScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HSW Schedule`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hsw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HSW Schedule`)
4. **click_sidebar_link** (Selector: `None`, Value: `HSW Schedule`)
5. **check_url** (Selector: `None`, Value: `/clinical/hsw-schedule`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
