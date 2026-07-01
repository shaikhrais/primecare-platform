# SCREEN DATA CONTEXT: staffing_overview

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - StaffingOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `471`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `staffing_overview`
* **Screen Name**: `StaffingOverviewScreen`
* **Route Path**: `/executive/staffing-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/staffing_overview_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `23`
* **Role Code**: `coo`
* **Role Name**: `Chief Operating Officer (COO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to staffingoverviewscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the StaffingOverviewScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `StaffingOverviewScreen`
* **Acceptance Criteria**:
- The StaffingOverviewScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `staffing_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `staffing_overview-title` (Type: header, Required: 1)
* **primary_content** -> `staffing_overview-content` (Type: layout, Required: 1)
* **staffingoverview_content** -> `staffingoverview-content` (Type: layout, Required: 0)
* **staffingoverview_title** -> `staffingoverview-title` (Type: header, Required: 0)
* **staffingoverview_loading** -> `staffingoverview-loading` (Type: loading, Required: 0)
* **staffingoverview_btn_3** -> `staffingoverview-btn-3` (Type: button, Required: 0)
* **staffingoverview_btn_2** -> `staffingoverview-btn-2` (Type: button, Required: 0)
* **staffingoverview_btn_1** -> `staffingoverview-btn-1` (Type: button, Required: 0)
* **staffingoverview_screen** -> `staffingoverview-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `400` (Required: 1)
* Component ID: `934` (Required: 1)
* Component ID: `1468` (Required: 1)
* Component ID: `5093` (Required: 1)
* Component ID: `5094` (Required: 1)
* Component ID: `5095` (Required: 1)
* Component ID: `5096` (Required: 1)
* Component ID: `5097` (Required: 1)
* Component ID: `5098` (Required: 1)
* Component ID: `5099` (Required: 1)
* Component ID: `5100` (Required: 1)
* Component ID: `5101` (Required: 1)
* Component ID: `5102` (Required: 1)

## 7. API / Data Mapping
* API ID: `4786` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `staffing_overview_runtime`
* **Test Name**: `StaffingOverviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Staffing Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Staffing Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Staffing Overview`)
5. **check_url** (Selector: `None`, Value: `/executive/staffing-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
