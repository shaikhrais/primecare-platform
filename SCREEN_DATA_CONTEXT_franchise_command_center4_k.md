# SCREEN DATA CONTEXT: franchise_command_center4_k

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseCommandCenter4KScreen** screen.

---

## 1. Screen Record
* **ID**: `592`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_command_center4_k`
* **Screen Name**: `FranchiseCommandCenter4KScreen`
* **Route Path**: `/executive/franchise-command-center4-k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_command_center4_k_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisecommandcenter4kscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseCommandCenter4KScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseCommandCenter4KScreen`
* **Acceptance Criteria**:
- The FranchiseCommandCenter4KScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_command_center4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_command_center4_k-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_command_center4_k-content` (Type: layout, Required: 1)
* **franchisecommandcenter4k_btn_1** -> `franchisecommandcenter4k-btn-1` (Type: button, Required: 0)
* **franchisecommandcenter4k_title** -> `franchisecommandcenter4k-title` (Type: header, Required: 0)
* **franchisecommandcenter4k_btn_3** -> `franchisecommandcenter4k-btn-3` (Type: button, Required: 0)
* **franchisecommandcenter4k_content** -> `franchisecommandcenter4k-content` (Type: layout, Required: 0)
* **franchisecommandcenter4k_screen** -> `franchisecommandcenter4k-screen` (Type: layout, Required: 0)
* **franchisecommandcenter4k_btn_2** -> `franchisecommandcenter4k-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `516` (Required: 1)
* Component ID: `1050` (Required: 1)
* Component ID: `1584` (Required: 1)
* Component ID: `6173` (Required: 1)
* Component ID: `6174` (Required: 1)
* Component ID: `6175` (Required: 1)
* Component ID: `6176` (Required: 1)
* Component ID: `6177` (Required: 1)
* Component ID: `6178` (Required: 1)
* Component ID: `6179` (Required: 1)
* Component ID: `6180` (Required: 1)
* Component ID: `6181` (Required: 1)
* Component ID: `6182` (Required: 1)

## 7. API / Data Mapping
* API ID: `4941` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_command_center4_k_runtime`
* **Test Name**: `FranchiseCommandCenter4KScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Command Center4 K`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Command Center4 K`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Command Center4 K`)
5. **check_url** (Selector: `None`, Value: `/executive/franchise-command-center4-k`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
