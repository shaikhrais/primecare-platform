# SCREEN DATA CONTEXT: shared_stubs

Below are the database records from `governance.db` used to configure and build the **Dynamic Screen Viewer - SharedScreenStubsScreen** screen.

---

## 1. Screen Record
* **ID**: `137`
* **App ID**: `1`
* **Role ID**: `16`
* **Screen Code**: `shared_stubs`
* **Screen Name**: `SharedScreenStubsScreen`
* **Route Path**: `/common/shared-stubs`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/shared_screen_stubs.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `16`
* **Role Code**: `dynamic`
* **Role Name**: `Dynamic Screen Viewer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Dynamic Screen Viewer personnel to oversee, audit, and coordinate operations related to sharedscreenstubs.`
* **User Story**: `As a Dynamic Screen Viewer, I want to access the SharedScreenStubs within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SharedScreenStubs`
* **Acceptance Criteria**:
- The SharedScreenStubs route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Dynamic Screen Viewer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `shared_stubs-screen` (Type: layout, Required: 1)
* **page_title** -> `shared_stubs-title` (Type: header, Required: 1)
* **primary_content** -> `shared_stubs-content` (Type: layout, Required: 1)
* **screennotimplemented_title** -> `screennotimplemented-title` (Type: header, Required: 0)
* **sharedstubs_btn_trigger_scan** -> `sharedstubs-btn-trigger-scan` (Type: button, Required: 0)
* **sharedstubs_btn_manual_refresh** -> `sharedstubs-btn-manual-refresh` (Type: button, Required: 0)
* **sharedstubs_content** -> `sharedstubs-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `145` (Required: 1)
* Component ID: `679` (Required: 1)
* Component ID: `1213` (Required: 1)
* Component ID: `2773` (Required: 1)
* Component ID: `2774` (Required: 1)
* Component ID: `2775` (Required: 1)

## 7. API / Data Mapping
* API ID: `4420` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `shared_stubs_runtime`
* **Test Name**: `SharedScreenStubs Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Shared Screen Stubs`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `dynamic`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Shared Screen Stubs`)
4. **click_sidebar_link** (Selector: `None`, Value: `Shared Screen Stubs`)
5. **check_url** (Selector: `None`, Value: `/common/shared-stubs`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
