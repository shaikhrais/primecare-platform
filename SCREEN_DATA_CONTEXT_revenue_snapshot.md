# SCREEN DATA CONTEXT: revenue_snapshot

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - RevenueSnapshotScreen** screen.

---

## 1. Screen Record
* **ID**: `504`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `revenue_snapshot`
* **Screen Name**: `RevenueSnapshotScreen`
* **Route Path**: `/executive/revenue-snapshot`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/revenue_snapshot_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to revenuesnapshotscreen.`
* **User Story**: `As a Franchise Owner, I want to access the RevenueSnapshotScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RevenueSnapshotScreen`
* **Acceptance Criteria**:
- The RevenueSnapshotScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `revenue_snapshot-screen` (Type: layout, Required: 1)
* **page_title** -> `revenue_snapshot-title` (Type: header, Required: 1)
* **primary_content** -> `revenue_snapshot-content` (Type: layout, Required: 1)
* **revenuesnapshot_loading** -> `revenuesnapshot-loading` (Type: loading, Required: 0)
* **revenuesnapshot_btn_3** -> `revenuesnapshot-btn-3` (Type: button, Required: 0)
* **revenuesnapshot_btn_2** -> `revenuesnapshot-btn-2` (Type: button, Required: 0)
* **revenuesnapshot_content** -> `revenuesnapshot-content` (Type: layout, Required: 0)
* **revenuesnapshot_title** -> `revenuesnapshot-title` (Type: header, Required: 0)
* **revenuesnapshot_screen** -> `revenuesnapshot-screen` (Type: layout, Required: 0)
* **revenuesnapshot_btn_1** -> `revenuesnapshot-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `433` (Required: 1)
* Component ID: `967` (Required: 1)
* Component ID: `1501` (Required: 1)
* Component ID: `5421` (Required: 1)
* Component ID: `5422` (Required: 1)
* Component ID: `5423` (Required: 1)
* Component ID: `5424` (Required: 1)
* Component ID: `5425` (Required: 1)
* Component ID: `5426` (Required: 1)
* Component ID: `5427` (Required: 1)
* Component ID: `5428` (Required: 1)
* Component ID: `5429` (Required: 1)
* Component ID: `5430` (Required: 1)

## 7. API / Data Mapping
* API ID: `4821` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `revenue_snapshot_runtime`
* **Test Name**: `RevenueSnapshotScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Revenue Snapshot`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Revenue Snapshot`)
4. **click_sidebar_link** (Selector: `None`, Value: `Revenue Snapshot`)
5. **check_url** (Selector: `None`, Value: `/executive/revenue-snapshot`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
