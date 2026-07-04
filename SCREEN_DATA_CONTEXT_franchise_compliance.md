# SCREEN DATA CONTEXT: franchise_compliance

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `111`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_compliance`
* **Screen Name**: `FranchiseComplianceScreen`
* **Route Path**: `/common/franchise-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/franchise_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisecompliancescreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseComplianceScreen`
* **Acceptance Criteria**:
- The FranchiseComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_compliance-content` (Type: layout, Required: 1)
* **franchisecompliance_screen** -> `franchisecompliance-screen` (Type: layout, Required: 0)
* **franchisecompliance_title** -> `franchisecompliance-title` (Type: header, Required: 0)
* **franchisecompliance_content** -> `franchisecompliance-content` (Type: layout, Required: 0)
* **franchisecompliance_btn_1** -> `franchisecompliance-btn-1` (Type: button, Required: 0)
* **franchisecompliance_btn_3** -> `franchisecompliance-btn-3` (Type: button, Required: 0)
* **franchisecompliance_btn_2** -> `franchisecompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `119` (Required: 1)
* Component ID: `653` (Required: 1)
* Component ID: `1187` (Required: 1)
* Component ID: `2555` (Required: 1)
* Component ID: `2556` (Required: 1)
* Component ID: `2557` (Required: 1)
* Component ID: `2558` (Required: 1)
* Component ID: `2559` (Required: 1)
* Component ID: `2560` (Required: 1)
* Component ID: `2561` (Required: 1)
* Component ID: `2562` (Required: 1)

## 7. API / Data Mapping
* API ID: `4388` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_compliance_runtime`
* **Test Name**: `FranchiseComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/common/franchise-compliance`)
3. **should_be_visible** (Selector: `franchise_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
