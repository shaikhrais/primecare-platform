# SCREEN DATA CONTEXT: payroll

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - PayrollScreen** screen.

---

## 1. Screen Record
* **ID**: `478`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `payroll`
* **Screen Name**: `PayrollScreen`
* **Route Path**: `/executive/payroll`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/payroll_screen.dart`
* **Stage/Status**: `production_ready`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to payrollscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the PayrollScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PayrollScreen`
* **Acceptance Criteria**:
- The PayrollScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `payroll-screen` (Type: layout, Required: 1)
* **page_title** -> `payroll-title` (Type: header, Required: 1)
* **primary_content** -> `payroll-content` (Type: layout, Required: 1)
* **payroll_btn_1** -> `payroll-btn-1` (Type: button, Required: 0)
* **payroll_loading** -> `payroll-loading` (Type: loading, Required: 0)
* **payroll_btn_2** -> `payroll-btn-2` (Type: button, Required: 0)
* **payroll_btn_3** -> `payroll-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `407` (Required: 1)
* Component ID: `941` (Required: 1)
* Component ID: `1475` (Required: 1)
* Component ID: `5164` (Required: 1)
* Component ID: `5165` (Required: 1)
* Component ID: `5166` (Required: 1)
* Component ID: `5167` (Required: 1)
* Component ID: `5168` (Required: 1)
* Component ID: `5169` (Required: 1)
* Component ID: `5170` (Required: 1)
* Component ID: `5171` (Required: 1)
* Component ID: `5172` (Required: 1)
* Component ID: `5173` (Required: 1)

## 7. API / Data Mapping
* API ID: `4795` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `payroll_runtime`
* **Test Name**: `PayrollScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Payroll`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Payroll`)
4. **click_sidebar_link** (Selector: `None`, Value: `Payroll`)
5. **check_url** (Selector: `None`, Value: `/executive/payroll`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
