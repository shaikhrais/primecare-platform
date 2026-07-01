# SCREEN DATA CONTEXT: operations_command_center

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - OperationsCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `470`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `operations_command_center`
* **Screen Name**: `OperationsCommandCenterScreen`
* **Route Path**: `/executive/operations-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/operations_command_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to operationscommandcenterscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the OperationsCommandCenterScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OperationsCommandCenterScreen`
* **Acceptance Criteria**:
- The OperationsCommandCenterScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operations_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `operations_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `operations_command_center-content` (Type: layout, Required: 1)
* **operationscommandcenter_screen** -> `operationscommandcenter-screen` (Type: layout, Required: 0)
* **operationscommandcenter_btn_2** -> `operationscommandcenter-btn-2` (Type: button, Required: 0)
* **operationscommandcenter_btn_1** -> `operationscommandcenter-btn-1` (Type: button, Required: 0)
* **operationscommandcenter_title** -> `operationscommandcenter-title` (Type: header, Required: 0)
* **operationscommandcenter_btn_3** -> `operationscommandcenter-btn-3` (Type: button, Required: 0)
* **operationscommandcenter_content** -> `operationscommandcenter-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `399` (Required: 1)
* Component ID: `933` (Required: 1)
* Component ID: `1467` (Required: 1)
* Component ID: `5083` (Required: 1)
* Component ID: `5084` (Required: 1)
* Component ID: `5085` (Required: 1)
* Component ID: `5086` (Required: 1)
* Component ID: `5087` (Required: 1)
* Component ID: `5088` (Required: 1)
* Component ID: `5089` (Required: 1)
* Component ID: `5090` (Required: 1)
* Component ID: `5091` (Required: 1)
* Component ID: `5092` (Required: 1)

## 7. API / Data Mapping
* API ID: `4785` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operations_command_center_runtime`
* **Test Name**: `OperationsCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operations Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Operations Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Operations Command Center`)
5. **check_url** (Selector: `None`, Value: `/executive/operations-command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
