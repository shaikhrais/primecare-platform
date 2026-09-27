# SCREEN DATA CONTEXT: franchise_owner_command_center

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `320`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_command_center`
* **Screen Name**: `FranchiseOwnerCommandCenterScreen`
* **Route Path**: `/executive/franchise-owner-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_command_center_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownercommandcenterscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerCommandCenterScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerCommandCenterScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerCommandCenterScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_command_center-content` (Type: layout, Required: 1)
* **franchiseownercommandcenter_btn_1** -> `franchiseownercommandcenter-btn-1` (Type: button, Required: 0)
* **franchiseownercommandcenter_btn_3** -> `franchiseownercommandcenter-btn-3` (Type: button, Required: 0)
* **franchiseownercommandcenter_btn_2** -> `franchiseownercommandcenter-btn-2` (Type: button, Required: 0)
* **franchiseownercommandcenter_title** -> `franchiseownercommandcenter-title` (Type: header, Required: 0)
* **franchiseownercommandcenter_screen** -> `franchiseownercommandcenter-screen` (Type: layout, Required: 0)
* **franchiseownercommandcenter_content** -> `franchiseownercommandcenter-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `328` (Required: 1)
* Component ID: `862` (Required: 1)
* Component ID: `1396` (Required: 1)
* Component ID: `4458` (Required: 1)
* Component ID: `4459` (Required: 1)
* Component ID: `4460` (Required: 1)
* Component ID: `4461` (Required: 1)
* Component ID: `4462` (Required: 1)
* Component ID: `4463` (Required: 1)

## 7. API / Data Mapping
* API ID: `4649` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_command_center_runtime`
* **Test Name**: `FranchiseOwnerCommandCenterScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseOwnerCommandCenterScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/executive/franchise-owner-command-center`)
3. **should_be_visible** (Selector: `franchise_owner_command_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_command_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_command_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
