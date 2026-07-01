# SCREEN DATA CONTEXT: cfo_tax_and_remittance

Below are the database records from `governance.db` used to configure and build the **Guest - CfoTaxAndRemittanceScreen** screen.

---

## 1. Screen Record
* **ID**: `720`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_tax_and_remittance`
* **Screen Name**: `CfoTaxAndRemittanceScreen`
* **Route Path**: `/offices/corporate/roles/cfo/tax-and-remittance`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_tax_and_remittance_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo tax and remittance.`
* **User Story**: `As a Guest, I want to access the Cfo Tax And Remittance within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Tax And Remittance`
* **Acceptance Criteria**:
- The Cfo Tax And Remittance route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_tax_and_remittance-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_tax_and_remittance-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_tax_and_remittance-content` (Type: layout, Required: 1)
* **cfotaxandremittancescreen_screen** -> `cfotaxandremittancescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6951` (Required: 1)
* Component ID: `6952` (Required: 1)
* Component ID: `6953` (Required: 1)
* Component ID: `6954` (Required: 1)
* Component ID: `6955` (Required: 1)
* Component ID: `6956` (Required: 1)
* Component ID: `6957` (Required: 1)

## 7. API / Data Mapping
* API ID: `5098` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_tax_and_remittance_runtime`
* **Test Name**: `Cfo Tax And Remittance Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Tax And Remittance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Tax And Remittance`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Tax And Remittance`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cfo/tax-and-remittance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
