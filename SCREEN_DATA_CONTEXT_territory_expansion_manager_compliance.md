# SCREEN DATA CONTEXT: territory_expansion_manager_compliance

Below are the database records from `governance.db` used to configure and build the **Territory Expansion Manager - TerritoryExpansionManagerComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `226`
* **App ID**: `1`
* **Role ID**: `46`
* **Screen Code**: `territory_expansion_manager_compliance`
* **Screen Name**: `TerritoryExpansionManagerComplianceScreen`
* **Route Path**: `/management/territory-expansion-manager-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/territory_expansion_manager_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `46`
* **Role Code**: `territory_expansion`
* **Role Name**: `Territory Expansion Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Territory Expansion Manager personnel to oversee, audit, and coordinate operations related to territoryexpansionmanagercompliancescreen.`
* **User Story**: `As a Territory Expansion Manager, I want to access the TerritoryExpansionManagerComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TerritoryExpansionManagerComplianceScreen`
* **Acceptance Criteria**:
- The TerritoryExpansionManagerComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Territory Expansion Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `territory_expansion_manager_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `territory_expansion_manager_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `territory_expansion_manager_compliance-content` (Type: layout, Required: 1)
* **territoryexpansionmanagercompliance_title** -> `territoryexpansionmanagercompliance-title` (Type: header, Required: 0)
* **territoryexpansionmanagercompliance_btn_2** -> `territoryexpansionmanagercompliance-btn-2` (Type: button, Required: 0)
* **territoryexpansionmanagercompliance_screen** -> `territoryexpansionmanagercompliance-screen` (Type: layout, Required: 0)
* **territoryexpansionmanagercompliance_content** -> `territoryexpansionmanagercompliance-content` (Type: layout, Required: 0)
* **territoryexpansionmanagercompliance_btn_1** -> `territoryexpansionmanagercompliance-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `234` (Required: 1)
* Component ID: `768` (Required: 1)
* Component ID: `1302` (Required: 1)
* Component ID: `3602` (Required: 1)
* Component ID: `3603` (Required: 1)
* Component ID: `3604` (Required: 1)
* Component ID: `3605` (Required: 1)
* Component ID: `3606` (Required: 1)
* Component ID: `3607` (Required: 1)
* Component ID: `3608` (Required: 1)

## 7. API / Data Mapping
* API ID: `4515` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `territory_expansion_manager_compliance_runtime`
* **Test Name**: `TerritoryExpansionManagerComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Territory Expansion Manager Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `territory_expansion`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Territory Expansion Manager Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Territory Expansion Manager Compliance`)
5. **check_url** (Selector: `None`, Value: `/management/territory-expansion-manager-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
