# SCREEN DATA CONTEXT: franchise_command_center

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `503`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_command_center`
* **Screen Name**: `FranchiseCommandCenterScreen`
* **Route Path**: `/executive/franchise-command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_command_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisecommandcenterscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseCommandCenterScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseCommandCenterScreen`
* **Acceptance Criteria**:
- The FranchiseCommandCenterScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_command_center-content` (Type: layout, Required: 1)
* **franchisecommandcenter_btn_3** -> `franchisecommandcenter-btn-3` (Type: button, Required: 0)
* **franchisecommandcenter_screen** -> `franchisecommandcenter-screen` (Type: layout, Required: 0)
* **franchisecommandcenter_btn_1** -> `franchisecommandcenter-btn-1` (Type: button, Required: 0)
* **franchisecommandcenter_title** -> `franchisecommandcenter-title` (Type: header, Required: 0)
* **franchisecommandcenter_content** -> `franchisecommandcenter-content` (Type: layout, Required: 0)
* **franchisecommandcenter_btn_2** -> `franchisecommandcenter-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `432` (Required: 1)
* Component ID: `966` (Required: 1)
* Component ID: `1500` (Required: 1)
* Component ID: `5411` (Required: 1)
* Component ID: `5412` (Required: 1)
* Component ID: `5413` (Required: 1)
* Component ID: `5414` (Required: 1)
* Component ID: `5415` (Required: 1)
* Component ID: `5416` (Required: 1)
* Component ID: `5417` (Required: 1)
* Component ID: `5418` (Required: 1)
* Component ID: `5419` (Required: 1)
* Component ID: `5420` (Required: 1)

## 7. API / Data Mapping
* API ID: `4820` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_command_center_runtime`
* **Test Name**: `FranchiseCommandCenterScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseCommandCenterScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/executive/franchise-command-center`)
3. **should_be_visible** (Selector: `franchise_command_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_command_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_command_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
