# SCREEN DATA CONTEXT: franchise_owner_branch_overview

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerBranchOverviewScreen** screen.

---

## 1. Screen Record
* **ID**: `321`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_branch_overview`
* **Screen Name**: `FranchiseOwnerBranchOverviewScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/branch-overview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_branch_overview_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerbranchoverviewscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerBranchOverviewScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerBranchOverviewScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerBranchOverviewScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_branch_overview-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_branch_overview-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_branch_overview-content` (Type: layout, Required: 1)
* **franchiseownerbranchoverview_screen** -> `franchiseownerbranchoverview-screen` (Type: layout, Required: 0)
* **franchiseownerbranchoverview_content** -> `franchiseownerbranchoverview-content` (Type: layout, Required: 0)
* **franchiseownerbranchoverview_btn_1** -> `franchiseownerbranchoverview-btn-1` (Type: button, Required: 0)
* **franchiseownerbranchoverview_btn_2** -> `franchiseownerbranchoverview-btn-2` (Type: button, Required: 0)
* **franchiseownerbranchoverview_title** -> `franchiseownerbranchoverview-title` (Type: header, Required: 0)
* **franchiseownerbranchoverview_btn_3** -> `franchiseownerbranchoverview-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `329` (Required: 1)
* Component ID: `863` (Required: 1)
* Component ID: `1397` (Required: 1)
* Component ID: `4464` (Required: 1)
* Component ID: `4465` (Required: 1)
* Component ID: `4466` (Required: 1)
* Component ID: `4467` (Required: 1)
* Component ID: `4468` (Required: 1)
* Component ID: `4469` (Required: 1)
* Component ID: `4470` (Required: 1)

## 7. API / Data Mapping
* API ID: `4650` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_branch_overview_runtime`
* **Test Name**: `FranchiseOwnerBranchOverviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Branch Overview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Owner Branch Overview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Owner Branch Overview`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/branch-overview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
