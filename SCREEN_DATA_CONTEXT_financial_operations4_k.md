# SCREEN DATA CONTEXT: financial_operations4_k

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - FinancialOperations4KScreen** screen.

---

## 1. Screen Record
* **ID**: `596`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `financial_operations4_k`
* **Screen Name**: `FinancialOperations4KScreen`
* **Route Path**: `/executive/financial-operations4-k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/financial_operations4_k_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to financialoperations4kscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the FinancialOperations4KScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FinancialOperations4KScreen`
* **Acceptance Criteria**:
- The FinancialOperations4KScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `financial_operations4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `financial_operations4_k-title` (Type: header, Required: 1)
* **primary_content** -> `financial_operations4_k-content` (Type: layout, Required: 1)
* **financialoperations4k_btn_2** -> `financialoperations4k-btn-2` (Type: button, Required: 0)
* **financialoperations4k_btn_1** -> `financialoperations4k-btn-1` (Type: button, Required: 0)
* **financialoperations4k_content** -> `financialoperations4k-content` (Type: layout, Required: 0)
* **financialoperations4k_screen** -> `financialoperations4k-screen` (Type: layout, Required: 0)
* **financialoperations4k_title** -> `financialoperations4k-title` (Type: header, Required: 0)
* **financialoperations4k_btn_3** -> `financialoperations4k-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `520` (Required: 1)
* Component ID: `1054` (Required: 1)
* Component ID: `1588` (Required: 1)
* Component ID: `6213` (Required: 1)
* Component ID: `6214` (Required: 1)
* Component ID: `6215` (Required: 1)
* Component ID: `6216` (Required: 1)
* Component ID: `6217` (Required: 1)
* Component ID: `6218` (Required: 1)
* Component ID: `6219` (Required: 1)
* Component ID: `6220` (Required: 1)
* Component ID: `6221` (Required: 1)
* Component ID: `6222` (Required: 1)

## 7. API / Data Mapping
* API ID: `4945` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `financial_operations4_k_runtime`
* **Test Name**: `FinancialOperations4KScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `FinancialOperations4KScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/executive/financial-operations4-k`)
3. **should_be_visible** (Selector: `financial_operations4_k-screen`, Value: `None`)
4. **should_be_visible** (Selector: `financial_operations4_k-title`, Value: `None`)
5. **should_be_visible** (Selector: `financial_operations4_k-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
