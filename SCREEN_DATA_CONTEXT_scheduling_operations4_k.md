# SCREEN DATA CONTEXT: scheduling_operations4_k

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - SchedulingOperations4KScreen** screen.

---

## 1. Screen Record
* **ID**: `595`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `scheduling_operations4_k`
* **Screen Name**: `SchedulingOperations4KScreen`
* **Route Path**: `/staff/scheduling-operations4-k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/scheduling_operations4_k_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to schedulingoperations4kscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the SchedulingOperations4KScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SchedulingOperations4KScreen`
* **Acceptance Criteria**:
- The SchedulingOperations4KScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `scheduling_operations4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `scheduling_operations4_k-title` (Type: header, Required: 1)
* **primary_content** -> `scheduling_operations4_k-content` (Type: layout, Required: 1)
* **schedulingoperations4k_btn_2** -> `schedulingoperations4k-btn-2` (Type: button, Required: 0)
* **schedulingoperations4k_btn_3** -> `schedulingoperations4k-btn-3` (Type: button, Required: 0)
* **schedulingoperations4k_btn_4** -> `schedulingoperations4k-btn-4` (Type: button, Required: 0)
* **schedulingoperations4k_btn_5** -> `schedulingoperations4k-btn-5` (Type: button, Required: 0)
* **schedulingoperations4k_screen** -> `schedulingoperations4k-screen` (Type: layout, Required: 0)
* **schedulingoperations4k_btn_1** -> `schedulingoperations4k-btn-1` (Type: button, Required: 0)
* **schedulingoperations4k_title** -> `schedulingoperations4k-title` (Type: header, Required: 0)
* **schedulingoperations4k_content** -> `schedulingoperations4k-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `519` (Required: 1)
* Component ID: `1053` (Required: 1)
* Component ID: `1587` (Required: 1)
* Component ID: `6203` (Required: 1)
* Component ID: `6204` (Required: 1)
* Component ID: `6205` (Required: 1)
* Component ID: `6206` (Required: 1)
* Component ID: `6207` (Required: 1)
* Component ID: `6208` (Required: 1)
* Component ID: `6209` (Required: 1)
* Component ID: `6210` (Required: 1)
* Component ID: `6211` (Required: 1)
* Component ID: `6212` (Required: 1)

## 7. API / Data Mapping
* API ID: `4944` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `scheduling_operations4_k_runtime`
* **Test Name**: `SchedulingOperations4KScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Scheduling Operations4 K`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Scheduling Operations4 K`)
4. **click_sidebar_link** (Selector: `None`, Value: `Scheduling Operations4 K`)
5. **check_url** (Selector: `None`, Value: `/staff/scheduling-operations4-k`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
