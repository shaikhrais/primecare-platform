# SCREEN DATA CONTEXT: rpn_tasks

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnTasksScreen** screen.

---

## 1. Screen Record
* **ID**: `374`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_tasks`
* **Screen Name**: `RpnTasksScreen`
* **Route Path**: `/offices/clinical/roles/rpn/rpn-tasks`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_tasks_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpntasksscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnTasksScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnTasksScreen`
* **Acceptance Criteria**:
- The RpnTasksScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_tasks-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_tasks-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_tasks-content` (Type: layout, Required: 1)
* **rpntasks_content** -> `rpntasks-content` (Type: layout, Required: 0)
* **rpntasks_title** -> `rpntasks-title` (Type: header, Required: 0)
* **rpntasks_loading** -> `rpntasks-loading` (Type: loading, Required: 0)
* **rpntasks_screen** -> `rpntasks-screen` (Type: layout, Required: 0)
* **rpntasks_btn_3** -> `rpntasks-btn-3` (Type: button, Required: 0)
* **rpntasks_btn_2** -> `rpntasks-btn-2` (Type: button, Required: 0)
* **rpntasks_btn_1** -> `rpntasks-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `380` (Required: 1)
* Component ID: `914` (Required: 1)
* Component ID: `1448` (Required: 1)
* Component ID: `4914` (Required: 1)
* Component ID: `4915` (Required: 1)
* Component ID: `4916` (Required: 1)
* Component ID: `4917` (Required: 1)
* Component ID: `4918` (Required: 1)
* Component ID: `4919` (Required: 1)
* Component ID: `4920` (Required: 1)
* Component ID: `4921` (Required: 1)
* Component ID: `4922` (Required: 1)
* Component ID: `4923` (Required: 1)

## 7. API / Data Mapping
* API ID: `4749` (Required: 1)
* API ID: `4750` (Required: 1)
* API ID: `4751` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_tasks_runtime`
* **Test Name**: `RpnTasksScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Tasks`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Tasks`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Tasks`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/rpn-tasks`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
