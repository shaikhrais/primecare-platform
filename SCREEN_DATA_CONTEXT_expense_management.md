# SCREEN DATA CONTEXT: expense_management

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - ExpenseManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `477`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `expense_management`
* **Screen Name**: `ExpenseManagementScreen`
* **Route Path**: `/executive/expense-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/expense_management_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to expensemanagementscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the ExpenseManagementScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ExpenseManagementScreen`
* **Acceptance Criteria**:
- The ExpenseManagementScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `expense_management-screen` (Type: layout, Required: 1)
* **page_title** -> `expense_management-title` (Type: header, Required: 1)
* **primary_content** -> `expense_management-content` (Type: layout, Required: 1)
* **expensemanagement_title** -> `expensemanagement-title` (Type: header, Required: 0)
* **expensemanagement_loading** -> `expensemanagement-loading` (Type: loading, Required: 0)
* **expensemanagement_screen** -> `expensemanagement-screen` (Type: layout, Required: 0)
* **expensemanagement_btn_2** -> `expensemanagement-btn-2` (Type: button, Required: 0)
* **expensemanagement_btn_3** -> `expensemanagement-btn-3` (Type: button, Required: 0)
* **expensemanagement_btn_1** -> `expensemanagement-btn-1` (Type: button, Required: 0)
* **expensemanagement_content** -> `expensemanagement-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `406` (Required: 1)
* Component ID: `940` (Required: 1)
* Component ID: `1474` (Required: 1)
* Component ID: `5153` (Required: 1)
* Component ID: `5154` (Required: 1)
* Component ID: `5155` (Required: 1)
* Component ID: `5156` (Required: 1)
* Component ID: `5157` (Required: 1)
* Component ID: `5158` (Required: 1)
* Component ID: `5159` (Required: 1)
* Component ID: `5160` (Required: 1)
* Component ID: `5161` (Required: 1)
* Component ID: `5162` (Required: 1)
* Component ID: `5163` (Required: 1)

## 7. API / Data Mapping
* API ID: `4794` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `expense_management_runtime`
* **Test Name**: `ExpenseManagementScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Expense Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Expense Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Expense Management`)
5. **check_url** (Selector: `None`, Value: `/executive/expense-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
