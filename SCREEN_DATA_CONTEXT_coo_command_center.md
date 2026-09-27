# SCREEN DATA CONTEXT: coo_command_center

Below are the database records from `governance.db` used to configure and build the **Chief Operating Officer (COO) - CooCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `304`
* **App ID**: `7`
* **Role ID**: `23`
* **Screen Code**: `coo_command_center`
* **Screen Name**: `CooCommandCenterScreen`
* **Route Path**: `/executive/coo-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/coo_command_center_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Operating Officer (COO) personnel to oversee, audit, and coordinate operations related to coocommandcenterscreen.`
* **User Story**: `As a Chief Operating Officer (COO), I want to access the CooCommandCenterScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CooCommandCenterScreen`
* **Acceptance Criteria**:
- The CooCommandCenterScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Operating Officer (COO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `coo_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `coo_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `coo_command_center-content` (Type: layout, Required: 1)
* **coocommandcenter_btn_1** -> `coocommandcenter-btn-1` (Type: button, Required: 0)
* **coocommandcenter_content** -> `coocommandcenter-content` (Type: layout, Required: 0)
* **coocommandcenter_screen** -> `coocommandcenter-screen` (Type: layout, Required: 0)
* **coocommandcenter_loading** -> `coocommandcenter-loading` (Type: loading, Required: 0)
* **coocommandcenter_title** -> `coocommandcenter-title` (Type: header, Required: 0)
* **coocommandcenter_btn_3** -> `coocommandcenter-btn-3` (Type: button, Required: 0)
* **coocommandcenter_btn_2** -> `coocommandcenter-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `312` (Required: 1)
* Component ID: `846` (Required: 1)
* Component ID: `1380` (Required: 1)
* Component ID: `4305` (Required: 1)
* Component ID: `4306` (Required: 1)
* Component ID: `4307` (Required: 1)
* Component ID: `4308` (Required: 1)
* Component ID: `4309` (Required: 1)
* Component ID: `4310` (Required: 1)
* Component ID: `4311` (Required: 1)
* Component ID: `4312` (Required: 1)
* Component ID: `4313` (Required: 1)
* Component ID: `4314` (Required: 1)

## 7. API / Data Mapping
* API ID: `4633` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `coo_command_center_runtime`
* **Test Name**: `CooCommandCenterScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CooCommandCenterScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `coo`)
2. **visit** (Selector: `None`, Value: `/executive/coo-command-center`)
3. **should_be_visible** (Selector: `coo_command_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `coo_command_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `coo_command_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
