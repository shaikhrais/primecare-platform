# SCREEN DATA CONTEXT: franchise_owner_staff

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerStaffScreen** screen.

---

## 1. Screen Record
* **ID**: `322`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_staff`
* **Screen Name**: `FranchiseOwnerStaffScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/staff`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_staff_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownerstaffscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerStaffScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerStaffScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerStaffScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_staff-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_staff-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_staff-content` (Type: layout, Required: 1)
* **franchiseownerstaff_btn_1** -> `franchiseownerstaff-btn-1` (Type: button, Required: 0)
* **franchiseownerstaff_screen** -> `franchiseownerstaff-screen` (Type: layout, Required: 0)
* **franchiseownerstaff_btn_3** -> `franchiseownerstaff-btn-3` (Type: button, Required: 0)
* **franchiseownerstaff_content** -> `franchiseownerstaff-content` (Type: layout, Required: 0)
* **franchiseownerstaff_btn_2** -> `franchiseownerstaff-btn-2` (Type: button, Required: 0)
* **franchiseownerstaff_title** -> `franchiseownerstaff-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `330` (Required: 1)
* Component ID: `864` (Required: 1)
* Component ID: `1398` (Required: 1)
* Component ID: `4471` (Required: 1)
* Component ID: `4472` (Required: 1)
* Component ID: `4473` (Required: 1)
* Component ID: `4474` (Required: 1)
* Component ID: `4475` (Required: 1)
* Component ID: `4476` (Required: 1)
* Component ID: `4477` (Required: 1)
* Component ID: `4478` (Required: 1)
* Component ID: `4479` (Required: 1)
* Component ID: `4480` (Required: 1)

## 7. API / Data Mapping
* API ID: `4651` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_staff_runtime`
* **Test Name**: `FranchiseOwnerStaffScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseOwnerStaffScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/staff`)
3. **should_be_visible** (Selector: `franchise_owner_staff-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_staff-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_staff-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
