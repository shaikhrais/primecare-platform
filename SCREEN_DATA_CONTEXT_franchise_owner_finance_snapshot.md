# SCREEN DATA CONTEXT: franchise_owner_finance_snapshot

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerFinanceSnapshotScreen** screen.

---

## 1. Screen Record
* **ID**: `325`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_finance_snapshot`
* **Screen Name**: `FranchiseOwnerFinanceSnapshotScreen`
* **Route Path**: `/executive/franchise-owner-finance-snapshot`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_finance_snapshot_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerfinancesnapshotscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerFinanceSnapshotScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerFinanceSnapshotScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerFinanceSnapshotScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_finance_snapshot-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_finance_snapshot-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_finance_snapshot-content` (Type: layout, Required: 1)
* **franchiseownerfinancesnapshot_screen** -> `franchiseownerfinancesnapshot-screen` (Type: layout, Required: 0)
* **franchiseownerfinancesnapshot_btn_3** -> `franchiseownerfinancesnapshot-btn-3` (Type: button, Required: 0)
* **franchiseownerfinancesnapshot_btn_2** -> `franchiseownerfinancesnapshot-btn-2` (Type: button, Required: 0)
* **franchiseownerfinancesnapshot_title** -> `franchiseownerfinancesnapshot-title` (Type: header, Required: 0)
* **franchiseownerfinancesnapshot_content** -> `franchiseownerfinancesnapshot-content` (Type: layout, Required: 0)
* **franchiseownerfinancesnapshot_btn_1** -> `franchiseownerfinancesnapshot-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `333` (Required: 1)
* Component ID: `867` (Required: 1)
* Component ID: `1401` (Required: 1)
* Component ID: `4500` (Required: 1)
* Component ID: `4501` (Required: 1)
* Component ID: `4502` (Required: 1)
* Component ID: `4503` (Required: 1)
* Component ID: `4504` (Required: 1)
* Component ID: `4505` (Required: 1)
* Component ID: `4506` (Required: 1)

## 7. API / Data Mapping
* API ID: `4654` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_finance_snapshot_runtime`
* **Test Name**: `FranchiseOwnerFinanceSnapshotScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Finance Snapshot`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Owner Finance Snapshot`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Owner Finance Snapshot`)
5. **check_url** (Selector: `None`, Value: `/executive/franchise-owner-finance-snapshot`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
