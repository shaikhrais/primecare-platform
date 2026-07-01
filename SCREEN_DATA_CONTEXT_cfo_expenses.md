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
* **Test Name**: `CfoExpensesScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CFO Expenses`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CFO Expenses`)
4. **click_sidebar_link** (Selector: `None`, Value: `CFO Expenses`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cfo/expenses`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
