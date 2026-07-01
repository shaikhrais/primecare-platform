# SCREEN DATA CONTEXT: executive_command_center

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - ExecutiveCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `465`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `executive_command_center`
* **Screen Name**: `ExecutiveCommandCenterScreen`
* **Route Path**: `/executive/executive-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/executive_command_center_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `20`
* **Role Code**: `ceo`
* **Role Name**: `Chief Executive Officer (CEO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to executivecommandcenterscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the ExecutiveCommandCenterScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ExecutiveCommandCenterScreen`
* **Acceptance Criteria**:
- The ExecutiveCommandCenterScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `executive_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `executive_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `executive_command_center-content` (Type: layout, Required: 1)
* **executivecommandcenter_screen** -> `executivecommandcenter-screen` (Type: layout, Required: 0)
* **executivecommandcenter_title** -> `executivecommandcenter-title` (Type: header, Required: 0)
* **executivecommandcenter_btn_1** -> `executivecommandcenter-btn-1` (Type: button, Required: 0)
* **executivecommandcenter_btn_2** -> `executivecommandcenter-btn-2` (Type: button, Required: 0)
* **executivecommandcenter_btn_3** -> `executivecommandcenter-btn-3` (Type: button, Required: 0)
* **executivecommandcenter_content** -> `executivecommandcenter-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `394` (Required: 1)
* Component ID: `928` (Required: 1)
* Component ID: `1462` (Required: 1)
* Component ID: `5038` (Required: 1)
* Component ID: `5039` (Required: 1)
* Component ID: `5040` (Required: 1)
* Component ID: `5041` (Required: 1)
* Component ID: `5042` (Required: 1)
* Component ID: `5043` (Required: 1)
* Component ID: `5044` (Required: 1)
* Component ID: `5045` (Required: 1)

## 7. API / Data Mapping
* API ID: `4781` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `executive_command_center_runtime`
* **Test Name**: `ExecutiveCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Executive Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Executive Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Executive Command Center`)
5. **check_url** (Selector: `None`, Value: `/executive/executive-command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
