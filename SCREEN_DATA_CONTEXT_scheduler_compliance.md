# SCREEN DATA CONTEXT: scheduler_compliance

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `270`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `scheduler_compliance`
* **Screen Name**: `SchedulerComplianceScreen`
* **Route Path**: `/staff/scheduler-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduler_compliance_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulercompliancescreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulerComplianceScreen`
* **Acceptance Criteria**:
- The SchedulerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduler_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduler_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `scheduler_compliance-content` (Type: layout, Required: 1)
* **schedulercompliance_screen** -> `schedulercompliance-screen` (Type: layout, Required: 0)
* **schedulercompliance_title** -> `schedulercompliance-title` (Type: header, Required: 0)
* **schedulercompliance_content** -> `schedulercompliance-content` (Type: layout, Required: 0)
* **schedulercompliance_btn_5** -> `schedulercompliance-btn-5` (Type: button, Required: 0)
* **schedulercompliance_btn_3** -> `schedulercompliance-btn-3` (Type: button, Required: 0)
* **schedulercompliance_btn_2** -> `schedulercompliance-btn-2` (Type: button, Required: 0)
* **schedulercompliance_btn_4** -> `schedulercompliance-btn-4` (Type: button, Required: 0)
* **schedulercompliance_btn_1** -> `schedulercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `278` (Required: 1)
* Component ID: `812` (Required: 1)
* Component ID: `1346` (Required: 1)
* Component ID: `4010` (Required: 1)
* Component ID: `4011` (Required: 1)
* Component ID: `4012` (Required: 1)
* Component ID: `4013` (Required: 1)
* Component ID: `4014` (Required: 1)
* Component ID: `4015` (Required: 1)
* Component ID: `4016` (Required: 1)
* Component ID: `4017` (Required: 1)

## 7. API / Data Mapping
* API ID: `4591` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduler_compliance_runtime`
* **Test Name**: `SchedulerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduler Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduler Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduler Compliance`)
5. **check_url** (Selector: `None`, Value: `/staff/scheduler-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
