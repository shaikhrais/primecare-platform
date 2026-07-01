# SCREEN DATA CONTEXT: franchise_overview

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - FranchiseOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `469`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `franchise_overview`
* **Screen Name**: `FranchiseOverviewScreen`
* **Route Path**: `/executive/franchise-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_overview_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to franchiseoverviewscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the FranchiseOverviewScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOverviewScreen`
* **Acceptance Criteria**:
- The FranchiseOverviewScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_overview-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_overview-content` (Type: layout, Required: 1)
* **franchiseoverview_btn_3** -> `franchiseoverview-btn-3` (Type: button, Required: 0)
* **franchiseoverview_loading** -> `franchiseoverview-loading` (Type: loading, Required: 0)
* **franchiseoverview_content** -> `franchiseoverview-content` (Type: layout, Required: 0)
* **franchiseoverview_title** -> `franchiseoverview-title` (Type: header, Required: 0)
* **franchiseoverview_btn_2** -> `franchiseoverview-btn-2` (Type: button, Required: 0)
* **franchiseoverview_btn_1** -> `franchiseoverview-btn-1` (Type: button, Required: 0)
* **franchiseoverview_screen** -> `franchiseoverview-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `398` (Required: 1)
* Component ID: `932` (Required: 1)
* Component ID: `1466` (Required: 1)
* Component ID: `5073` (Required: 1)
* Component ID: `5074` (Required: 1)
* Component ID: `5075` (Required: 1)
* Component ID: `5076` (Required: 1)
* Component ID: `5077` (Required: 1)
* Component ID: `5078` (Required: 1)
* Component ID: `5079` (Required: 1)
* Component ID: `5080` (Required: 1)
* Component ID: `5081` (Required: 1)
* Component ID: `5082` (Required: 1)

## 7. API / Data Mapping
* API ID: `4270` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_overview_runtime`
* **Test Name**: `FranchiseOverviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Overview`)
5. **check_url** (Selector: `None`, Value: `/executive/franchise-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
