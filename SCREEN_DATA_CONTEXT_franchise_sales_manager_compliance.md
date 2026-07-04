# SCREEN DATA CONTEXT: franchise_sales_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseSalesManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `193`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_sales_manager_compliance`
* **Screen Name**: `FranchiseSalesManagerComplianceScreen`
* **Route Path**: `/management/franchise-sales-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/franchise_sales_manager_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisesalesmanagercompliancescreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseSalesManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseSalesManagerComplianceScreen`
* **Acceptance Criteria**:
- The FranchiseSalesManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_sales_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_sales_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_sales_manager_compliance-content` (Type: layout, Required: 1)
* **franchisesalesmanagercompliance_btn_1** -> `franchisesalesmanagercompliance-btn-1` (Type: button, Required: 0)
* **franchisesalesmanagercompliance_screen** -> `franchisesalesmanagercompliance-screen` (Type: layout, Required: 0)
* **franchisesalesmanagercompliance_content** -> `franchisesalesmanagercompliance-content` (Type: layout, Required: 0)
* **franchisesalesmanagercompliance_btn_2** -> `franchisesalesmanagercompliance-btn-2` (Type: button, Required: 0)
* **franchisesalesmanagercompliance_title** -> `franchisesalesmanagercompliance-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `201` (Required: 1)
* Component ID: `735` (Required: 1)
* Component ID: `1269` (Required: 1)
* Component ID: `3283` (Required: 1)
* Component ID: `3284` (Required: 1)
* Component ID: `3285` (Required: 1)
* Component ID: `3286` (Required: 1)
* Component ID: `3287` (Required: 1)
* Component ID: `3288` (Required: 1)
* Component ID: `3289` (Required: 1)
* Component ID: `3290` (Required: 1)
* Component ID: `3291` (Required: 1)
* Component ID: `3292` (Required: 1)

## 7. API / Data Mapping
* API ID: `4482` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_sales_manager_compliance_runtime`
* **Test Name**: `FranchiseSalesManagerComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FranchiseSalesManagerComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/management/franchise-sales-manager-compliance`)
3. **should_be_visible** (Selector: `franchise_sales_manager_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `franchise_sales_manager_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `franchise_sales_manager_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
