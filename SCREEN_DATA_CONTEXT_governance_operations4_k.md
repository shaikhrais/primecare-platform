# SCREEN DATA CONTEXT: governance_operations4_k

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceOperations4KScreen** screen.

---

## 1. Screen Record
* **ID**: `594`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `governance_operations4_k`
* **Screen Name**: `GovernanceOperations4KScreen`
* **Route Path**: `/common/governance-operations4-k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/governance_operations4_k_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governanceoperations4kscreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceOperations4KScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceOperations4KScreen`
* **Acceptance Criteria**:
- The GovernanceOperations4KScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_operations4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_operations4_k-title` (Type: header, Required: 1)
* **primary_content** -> `governance_operations4_k-content` (Type: layout, Required: 1)
* **governanceoperations4k_btn_3** -> `governanceoperations4k-btn-3` (Type: button, Required: 0)
* **governanceoperations4k_content** -> `governanceoperations4k-content` (Type: layout, Required: 0)
* **governanceoperations4k_screen** -> `governanceoperations4k-screen` (Type: layout, Required: 0)
* **governanceoperations4k_title** -> `governanceoperations4k-title` (Type: header, Required: 0)
* **governanceoperations4k_btn_1** -> `governanceoperations4k-btn-1` (Type: button, Required: 0)
* **governanceoperations4k_btn_2** -> `governanceoperations4k-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `518` (Required: 1)
* Component ID: `1052` (Required: 1)
* Component ID: `1586` (Required: 1)
* Component ID: `6193` (Required: 1)
* Component ID: `6194` (Required: 1)
* Component ID: `6195` (Required: 1)
* Component ID: `6196` (Required: 1)
* Component ID: `6197` (Required: 1)
* Component ID: `6198` (Required: 1)
* Component ID: `6199` (Required: 1)
* Component ID: `6200` (Required: 1)
* Component ID: `6201` (Required: 1)
* Component ID: `6202` (Required: 1)

## 7. API / Data Mapping
* API ID: `4943` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_operations4_k_runtime`
* **Test Name**: `GovernanceOperations4KScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Governance Operations4 K`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Governance Operations4 K`)
4. **click_sidebar_link** (Selector: `None`, Value: `Governance Operations4 K`)
5. **check_url** (Selector: `None`, Value: `/common/governance-operations4-k`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
