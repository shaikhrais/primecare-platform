# SCREEN DATA CONTEXT: territory_sales_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Territory Sales Manager - TerritorySalesManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `229`
* **App ID**: `1`
* **Role ID**: `47`
* **Screen Code**: `territory_sales_manager_compliance`
* **Screen Name**: `TerritorySalesManagerComplianceScreen`
* **Route Path**: `/management/territory-sales-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_sales_manager_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `47`
* **Role Code**: `territory_sales`
* **Role Name**: `Territory Sales Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Territory Sales Manager personnel to oversee, audit, and coordinate operations related to territorysalesmanagercompliancescreen.`
* **User Story**: `As a Territory Sales Manager, I want to access the TerritorySalesManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritorySalesManagerComplianceScreen`
* **Acceptance Criteria**:
- The TerritorySalesManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Sales Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_sales_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_sales_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `territory_sales_manager_compliance-content` (Type: layout, Required: 1)
* **territorysalesmanagercompliance_title** -> `territorysalesmanagercompliance-title` (Type: header, Required: 0)
* **territorysalesmanagercompliance_btn_2** -> `territorysalesmanagercompliance-btn-2` (Type: button, Required: 0)
* **territorysalesmanagercompliance_content** -> `territorysalesmanagercompliance-content` (Type: layout, Required: 0)
* **territorysalesmanagercompliance_screen** -> `territorysalesmanagercompliance-screen` (Type: layout, Required: 0)
* **territorysalesmanagercompliance_btn_1** -> `territorysalesmanagercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `237` (Required: 1)
* Component ID: `771` (Required: 1)
* Component ID: `1305` (Required: 1)
* Component ID: `3626` (Required: 1)
* Component ID: `3627` (Required: 1)
* Component ID: `3628` (Required: 1)
* Component ID: `3629` (Required: 1)
* Component ID: `3630` (Required: 1)
* Component ID: `3631` (Required: 1)
* Component ID: `3632` (Required: 1)
* Component ID: `3633` (Required: 1)
* Component ID: `3634` (Required: 1)
* Component ID: `3635` (Required: 1)

## 7. API / Data Mapping
* API ID: `4518` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_sales_manager_compliance_runtime`
* **Test Name**: `TerritorySalesManagerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Sales Manager Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_sales`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Territory Sales Manager Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Territory Sales Manager Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/territory-sales-manager-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
