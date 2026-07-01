# SCREEN DATA CONTEXT: tax_compliance

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - TaxComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `479`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `tax_compliance`
* **Screen Name**: `TaxComplianceScreen`
* **Route Path**: `/executive/tax-compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/tax_compliance_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `21`
* **Role Code**: `cfo`
* **Role Name**: `Chief Financial Officer (CFO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to taxcompliancescreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the TaxComplianceScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TaxComplianceScreen`
* **Acceptance Criteria**:
- The TaxComplianceScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `tax_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `tax_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `tax_compliance-content` (Type: layout, Required: 1)
* **taxcompliance_title** -> `taxcompliance-title` (Type: header, Required: 0)
* **taxcompliance_btn_1** -> `taxcompliance-btn-1` (Type: button, Required: 0)
* **taxcompliance_screen** -> `taxcompliance-screen` (Type: layout, Required: 0)
* **taxcompliance_btn_3** -> `taxcompliance-btn-3` (Type: button, Required: 0)
* **taxcompliance_loading** -> `taxcompliance-loading` (Type: loading, Required: 0)
* **taxcompliance_content** -> `taxcompliance-content` (Type: layout, Required: 0)
* **taxcompliance_btn_2** -> `taxcompliance-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `408` (Required: 1)
* Component ID: `942` (Required: 1)
* Component ID: `1476` (Required: 1)
* Component ID: `5174` (Required: 1)
* Component ID: `5175` (Required: 1)
* Component ID: `5176` (Required: 1)
* Component ID: `5177` (Required: 1)
* Component ID: `5178` (Required: 1)
* Component ID: `5179` (Required: 1)
* Component ID: `5180` (Required: 1)
* Component ID: `5181` (Required: 1)
* Component ID: `5182` (Required: 1)
* Component ID: `5183` (Required: 1)

## 7. API / Data Mapping
* API ID: `4796` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `tax_compliance_runtime`
* **Test Name**: `TaxComplianceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Tax Compliance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Tax Compliance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Tax Compliance`)
5. **check_url** (Selector: `None`, Value: `/executive/tax-compliance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
