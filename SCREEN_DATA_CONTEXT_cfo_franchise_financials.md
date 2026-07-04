# SCREEN DATA CONTEXT: cfo_franchise_financials

Below are the database records from `governance.db` used to configure and build the **Guest - CfoFranchiseFinancialsScreen** screen.

---

## 1. Screen Record
* **ID**: `718`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_franchise_financials`
* **Screen Name**: `CfoFranchiseFinancialsScreen`
* **Route Path**: `/offices/corporate/roles/cfo/franchise-financials`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_franchise_financials_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo franchise financials.`
* **User Story**: `As a Guest, I want to access the Cfo Franchise Financials within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Franchise Financials`
* **Acceptance Criteria**:
- The Cfo Franchise Financials route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_franchise_financials-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_franchise_financials-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_franchise_financials-content` (Type: layout, Required: 1)
* **cfofranchisefinancialsscreen_screen** -> `cfofranchisefinancialsscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6940` (Required: 1)
* Component ID: `6941` (Required: 1)
* Component ID: `6942` (Required: 1)
* Component ID: `6943` (Required: 1)
* Component ID: `6944` (Required: 1)
* Component ID: `6945` (Required: 1)

## 7. API / Data Mapping
* API ID: `5096` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_franchise_financials_runtime`
* **Test Name**: `Cfo Franchise Financials Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cfo Franchise Financials`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/franchise-financials`)
3. **should_be_visible** (Selector: `cfo_franchise_financials-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_franchise_financials-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_franchise_financials-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
