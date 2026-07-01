# SCREEN DATA CONTEXT: cfo_accounts_payable

Below are the database records from `governance.db` used to configure and build the **Guest - CfoAccountsPayableScreen** screen.

---

## 1. Screen Record
* **ID**: `715`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_accounts_payable`
* **Screen Name**: `CfoAccountsPayableScreen`
* **Route Path**: `/offices/corporate/roles/cfo/accounts-payable`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_payable_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo accounts payable.`
* **User Story**: `As a Guest, I want to access the Cfo Accounts Payable within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Accounts Payable`
* **Acceptance Criteria**:
- The Cfo Accounts Payable route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_accounts_payable-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_accounts_payable-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_accounts_payable-content` (Type: layout, Required: 1)
* **cfoaccountspayablescreen_screen** -> `cfoaccountspayablescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6922` (Required: 1)
* Component ID: `6923` (Required: 1)
* Component ID: `6924` (Required: 1)
* Component ID: `6925` (Required: 1)
* Component ID: `6926` (Required: 1)
* Component ID: `6927` (Required: 1)
* Component ID: `6928` (Required: 1)

## 7. API / Data Mapping
* API ID: `5093` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_accounts_payable_runtime`
* **Test Name**: `Cfo Accounts Payable Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Accounts Payable`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Accounts Payable`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Accounts Payable`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cfo/accounts-payable`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
