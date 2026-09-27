# SCREEN DATA CONTEXT: franchise_owner_compliance

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseOwnerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `326`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_owner_compliance`
* **Screen Name**: `FranchiseOwnerComplianceScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseownercompliancescreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseOwnerComplianceScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseOwnerComplianceScreen`
* **Acceptance Criteria**:
- The FranchiseOwnerComplianceScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_compliance-content` (Type: layout, Required: 1)
* **franchiseownercompliance_btn_2** -> `franchiseownercompliance-btn-2` (Type: button, Required: 0)
* **franchiseownercompliance_btn_3** -> `franchiseownercompliance-btn-3` (Type: button, Required: 0)
* **franchiseownercompliance_screen** -> `franchiseownercompliance-screen` (Type: layout, Required: 0)
* **franchiseownercompliance_btn_1** -> `franchiseownercompliance-btn-1` (Type: button, Required: 0)
* **franchiseownercompliance_content** -> `franchiseownercompliance-content` (Type: layout, Required: 0)
* **franchiseownercompliance_title** -> `franchiseownercompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `334` (Required: 1)
* Component ID: `868` (Required: 1)
* Component ID: `1402` (Required: 1)
* Component ID: `4507` (Required: 1)
* Component ID: `4508` (Required: 1)
* Component ID: `4509` (Required: 1)
* Component ID: `4510` (Required: 1)
* Component ID: `4511` (Required: 1)
* Component ID: `4512` (Required: 1)

## 7. API / Data Mapping
* API ID: `4655` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_compliance_runtime`
* **Test Name**: `FranchiseOwnerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseOwnerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/compliance`)
3. **should_be_visible** (Selector: `franchise_owner_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_owner_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_owner_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
