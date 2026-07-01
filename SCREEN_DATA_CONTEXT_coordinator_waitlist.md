# SCREEN DATA CONTEXT: coordinator_waitlist

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - CoordinatorWaitlistScreen** screen.

---

## 1. Screen Record
* **ID**: `253`
* **App ID**: `1`
* **Role ID**: `60`
* **Screen Code**: `coordinator_waitlist`
* **Screen Name**: `CoordinatorWaitlistScreen`
* **Route Path**: `/staff/coordinator-waitlist`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/coordinator_waitlist_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to coordinatorwaitlistscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the CoordinatorWaitlistScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CoordinatorWaitlistScreen`
* **Acceptance Criteria**:
- The CoordinatorWaitlistScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coordinator_waitlist-screen` (Type: layout, Required: 1)
* **page_title** -> `coordinator_waitlist-title` (Type: header, Required: 1)
* **primary_content** -> `coordinator_waitlist-content` (Type: layout, Required: 1)
* **coordinatorwaitlist_screen** -> `coordinatorwaitlist-screen` (Type: layout, Required: 0)
* **coordinatorwaitlist_btn_4** -> `coordinatorwaitlist-btn-4` (Type: button, Required: 0)
* **coordinatorwaitlist_btn_1** -> `coordinatorwaitlist-btn-1` (Type: button, Required: 0)
* **coordinatorwaitlist_btn_5** -> `coordinatorwaitlist-btn-5` (Type: button, Required: 0)
* **coordinatorwaitlist_title** -> `coordinatorwaitlist-title` (Type: header, Required: 0)
* **coordinatorwaitlist_btn_2** -> `coordinatorwaitlist-btn-2` (Type: button, Required: 0)
* **coordinatorwaitlist_btn_3** -> `coordinatorwaitlist-btn-3` (Type: button, Required: 0)
* **coordinatorwaitlist_content** -> `coordinatorwaitlist-content` (Type: layout, Required: 0)
* **coordinatorwaitlist_loading** -> `coordinatorwaitlist-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `261` (Required: 1)
* Component ID: `795` (Required: 1)
* Component ID: `1329` (Required: 1)
* Component ID: `3850` (Required: 1)
* Component ID: `3851` (Required: 1)
* Component ID: `3852` (Required: 1)
* Component ID: `3853` (Required: 1)
* Component ID: `3854` (Required: 1)
* Component ID: `3855` (Required: 1)
* Component ID: `3856` (Required: 1)
* Component ID: `3857` (Required: 1)
* Component ID: `3858` (Required: 1)
* Component ID: `3859` (Required: 1)

## 7. API / Data Mapping
* API ID: `4568` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coordinator_waitlist_runtime`
* **Test Name**: `CoordinatorWaitlistScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Coordinator Waitlist`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Coordinator Waitlist`)
4. **click_sidebar_link** (Selector: `None`, Value: `Coordinator Waitlist`)
5. **check_url** (Selector: `None`, Value: `/staff/coordinator-waitlist`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
