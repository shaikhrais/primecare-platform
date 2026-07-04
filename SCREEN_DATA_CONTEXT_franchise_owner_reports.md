# SCREEN DATA CONTEXT: franchise_owner_reports

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `327`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_reports`
* **Screen Name**: `FranchiseOwnerReportsScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerreportsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerReportsScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerReportsScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerReportsScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_reports-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_reports-content` (Type: layout, Required: 1)
* **franchiseownerreports_btn_2** -> `franchiseownerreports-btn-2` (Type: button, Required: 0)
* **franchiseownerreports_btn_3** -> `franchiseownerreports-btn-3` (Type: button, Required: 0)
* **franchiseownerreports_content** -> `franchiseownerreports-content` (Type: layout, Required: 0)
* **franchiseownerreports_title** -> `franchiseownerreports-title` (Type: header, Required: 0)
* **franchiseownerreports_btn_1** -> `franchiseownerreports-btn-1` (Type: button, Required: 0)
* **franchiseownerreports_screen** -> `franchiseownerreports-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `335` (Required: 1)
* Component ID: `869` (Required: 1)
* Component ID: `1403` (Required: 1)
* Component ID: `4513` (Required: 1)
* Component ID: `4514` (Required: 1)
* Component ID: `4515` (Required: 1)
* Component ID: `4516` (Required: 1)
* Component ID: `4517` (Required: 1)
* Component ID: `4518` (Required: 1)

## 7. API / Data Mapping
* API ID: `4656` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_reports_runtime`
* **Test Name**: `FranchiseOwnerReportsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseOwnerReportsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/reports`)
3. **should_be_visible** (Selector: `franchise_owner_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
