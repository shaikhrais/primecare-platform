# SCREEN DATA CONTEXT: scheduling_health

Below are the database records from `governance.db` used to configure and build the **Operations Manager - SchedulingHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `510`
* **App ID**: `5`
* **Role ID**: `40`
* **Screen Code**: `scheduling_health`
* **Screen Name**: `SchedulingHealthScreen`
* **Route Path**: `/management/scheduling-health`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/scheduling_health_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `40`
* **Role Code**: `ops_manager`
* **Role Name**: `Operations Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Operations Manager personnel to oversee, audit, and coordinate operations related to schedulinghealthscreen.`
* **User Story**: `As a Operations Manager, I want to access the SchedulingHealthScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulingHealthScreen`
* **Acceptance Criteria**:
- The SchedulingHealthScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Operations Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduling_health-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduling_health-title` (Type: header, Required: 1)
* **primary_content** -> `scheduling_health-content` (Type: layout, Required: 1)
* **schedulinghealth_btn_2** -> `schedulinghealth-btn-2` (Type: button, Required: 0)
* **schedulinghealth_content** -> `schedulinghealth-content` (Type: layout, Required: 0)
* **schedulinghealth_screen** -> `schedulinghealth-screen` (Type: layout, Required: 0)
* **schedulinghealth_loading** -> `schedulinghealth-loading` (Type: loading, Required: 0)
* **schedulinghealth_btn_3** -> `schedulinghealth-btn-3` (Type: button, Required: 0)
* **schedulinghealth_btn_1** -> `schedulinghealth-btn-1` (Type: button, Required: 0)
* **schedulinghealth_title** -> `schedulinghealth-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `439` (Required: 1)
* Component ID: `973` (Required: 1)
* Component ID: `1507` (Required: 1)
* Component ID: `5479` (Required: 1)
* Component ID: `5480` (Required: 1)
* Component ID: `5481` (Required: 1)
* Component ID: `5482` (Required: 1)
* Component ID: `5483` (Required: 1)
* Component ID: `5484` (Required: 1)
* Component ID: `5485` (Required: 1)
* Component ID: `5486` (Required: 1)
* Component ID: `5487` (Required: 1)
* Component ID: `5488` (Required: 1)

## 7. API / Data Mapping
* API ID: `4826` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduling_health_runtime`
* **Test Name**: `SchedulingHealthScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduling Health`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ops_manager`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduling Health`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduling Health`)
5. **check_url** (Selector: `None`, Value: `/management/scheduling-health`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
