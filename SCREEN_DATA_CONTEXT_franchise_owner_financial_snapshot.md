# SCREEN DATA CONTEXT: franchise_owner_financial_snapshot

Below are the database records from `governance.db` used to configure and build the **Guest - FranchiseOwnerFinancialSnapshotScreen** screen.

---

## 1. Screen Record
* **ID**: `794`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `franchise_owner_financial_snapshot`
* **Screen Name**: `FranchiseOwnerFinancialSnapshotScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/financial-snapshot`
* **Actual File Path**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_financial_snapshot_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to franchise owner financial snapshot.`
* **User Story**: `As a Guest, I want to access the Franchise Owner Financial Snapshot within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Owner Financial Snapshot`
* **Acceptance Criteria**:
- The Franchise Owner Financial Snapshot route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_financial_snapshot-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_financial_snapshot-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_financial_snapshot-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7349` (Required: 1)
* Component ID: `7350` (Required: 1)
* Component ID: `7351` (Required: 1)
* Component ID: `7352` (Required: 1)
* Component ID: `7353` (Required: 1)

## 7. API / Data Mapping
* API ID: `5182` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_financial_snapshot_runtime`
* **Test Name**: `Franchise Owner Financial Snapshot Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Financial Snapshot`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/financial-snapshot`)
3. **should_be_visible** (Selector: `franchise_owner_financial_snapshot-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_financial_snapshot-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_financial_snapshot-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
