# SCREEN DATA CONTEXT: cfo_accounts_receivable

Below are the database records from `governance.db` used to configure and build the **Guest - CfoAccountsReceivableScreen** screen.

---

## 1. Screen Record
* **ID**: `716`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cfo_accounts_receivable`
* **Screen Name**: `CfoAccountsReceivableScreen`
* **Route Path**: `/offices/corporate/roles/cfo/accounts-receivable`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_receivable_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cfo accounts receivable.`
* **User Story**: `As a Guest, I want to access the Cfo Accounts Receivable within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cfo Accounts Receivable`
* **Acceptance Criteria**:
- The Cfo Accounts Receivable route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_accounts_receivable-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_accounts_receivable-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_accounts_receivable-content` (Type: layout, Required: 1)
* **cfoaccountsreceivablescreen_screen** -> `cfoaccountsreceivablescreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6929` (Required: 1)
* Component ID: `6930` (Required: 1)
* Component ID: `6931` (Required: 1)
* Component ID: `6932` (Required: 1)
* Component ID: `6933` (Required: 1)
* Component ID: `6934` (Required: 1)

## 7. API / Data Mapping
* API ID: `5094` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_accounts_receivable_runtime`
* **Test Name**: `Cfo Accounts Receivable Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cfo Accounts Receivable`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/accounts-receivable`)
3. **should_be_visible** (Selector: `cfo_accounts_receivable-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_accounts_receivable-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_accounts_receivable-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
