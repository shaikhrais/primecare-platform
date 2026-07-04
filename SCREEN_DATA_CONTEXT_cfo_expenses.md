# SCREEN DATA CONTEXT: cfo_expenses

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoExpensesScreen** screen.

---

## 1. Screen Record
* **ID**: `284`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_expenses`
* **Screen Name**: `CfoExpensesScreen`
* **Route Path**: `/offices/corporate/roles/cfo/expenses`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_expenses_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfoexpensesscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoExpensesScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoExpensesScreen`
* **Acceptance Criteria**:
- The CfoExpensesScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_expenses-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_expenses-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_expenses-content` (Type: layout, Required: 1)
* **cfoexpenses_title** -> `cfoexpenses-title` (Type: header, Required: 0)
* **cfoexpenses_loading** -> `cfoexpenses-loading` (Type: loading, Required: 0)
* **cfoexpenses_screen** -> `cfoexpenses-screen` (Type: layout, Required: 0)
* **cfoexpenses_btn_3** -> `cfoexpenses-btn-3` (Type: button, Required: 0)
* **cfoexpenses_btn_2** -> `cfoexpenses-btn-2` (Type: button, Required: 0)
* **cfoexpenses_btn_1** -> `cfoexpenses-btn-1` (Type: button, Required: 0)
* **cfoexpenses_content** -> `cfoexpenses-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `292` (Required: 1)
* Component ID: `826` (Required: 1)
* Component ID: `1360` (Required: 1)
* Component ID: `4109` (Required: 1)
* Component ID: `4110` (Required: 1)
* Component ID: `4111` (Required: 1)
* Component ID: `4112` (Required: 1)
* Component ID: `4113` (Required: 1)
* Component ID: `4114` (Required: 1)
* Component ID: `4115` (Required: 1)
* Component ID: `4116` (Required: 1)
* Component ID: `4117` (Required: 1)
* Component ID: `4118` (Required: 1)

## 7. API / Data Mapping
* API ID: `4607` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_expenses_runtime`
* **Test Name**: `CfoExpensesScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoExpensesScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/expenses`)
3. **should_be_visible** (Selector: `cfo_expenses-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_expenses-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_expenses-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
