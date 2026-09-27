# SCREEN DATA CONTEXT: scheduler_analytics

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `269`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `scheduler_analytics`
* **Screen Name**: `SchedulerAnalyticsScreen`
* **Route Path**: `/staff/scheduler-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_analytics_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to scheduleranalyticsscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerAnalyticsScreen`
* **Acceptance Criteria**:
- The SchedulerAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_analytics-content` (Type: layout, Required: 1)
* **scheduleranalytics_btn_3** -> `scheduleranalytics-btn-3` (Type: button, Required: 0)
* **scheduleranalytics_btn_2** -> `scheduleranalytics-btn-2` (Type: button, Required: 0)
* **scheduleranalytics_content** -> `scheduleranalytics-content` (Type: layout, Required: 0)
* **scheduleranalytics_screen** -> `scheduleranalytics-screen` (Type: layout, Required: 0)
* **scheduleranalytics_title** -> `scheduleranalytics-title` (Type: header, Required: 0)
* **scheduleranalytics_btn_1** -> `scheduleranalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `277` (Required: 1)
* Component ID: `811` (Required: 1)
* Component ID: `1345` (Required: 1)
* Component ID: `4000` (Required: 1)
* Component ID: `4001` (Required: 1)
* Component ID: `4002` (Required: 1)
* Component ID: `4003` (Required: 1)
* Component ID: `4004` (Required: 1)
* Component ID: `4005` (Required: 1)
* Component ID: `4006` (Required: 1)
* Component ID: `4007` (Required: 1)
* Component ID: `4008` (Required: 1)
* Component ID: `4009` (Required: 1)

## 7. API / Data Mapping
* API ID: `4590` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_analytics_runtime`
* **Test Name**: `SchedulerAnalyticsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `SchedulerAnalyticsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/scheduler-analytics`)
3. **should_be_visible** (Selector: `scheduler_analytics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `scheduler_analytics-title`, Value: `None`)
5. **should_be_visible** (Selector: `scheduler_analytics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
