# SCREEN DATA CONTEXT: cfo_payroll

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoPayrollScreen** screen.

---

## 1. Screen Record
* **ID**: `285`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_payroll`
* **Screen Name**: `CfoPayrollScreen`
* **Route Path**: `/offices/corporate/roles/cfo/payroll`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_payroll_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfopayrollscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoPayrollScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoPayrollScreen`
* **Acceptance Criteria**:
- The CfoPayrollScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_payroll-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_payroll-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_payroll-content` (Type: layout, Required: 1)
* **cfopayroll_btn_1** -> `cfopayroll-btn-1` (Type: button, Required: 0)
* **cfopayroll_title** -> `cfopayroll-title` (Type: header, Required: 0)
* **cfopayroll_btn_3** -> `cfopayroll-btn-3` (Type: button, Required: 0)
* **cfopayroll_btn_2** -> `cfopayroll-btn-2` (Type: button, Required: 0)
* **cfopayroll_screen** -> `cfopayroll-screen` (Type: layout, Required: 0)
* **cfopayroll_loading** -> `cfopayroll-loading` (Type: loading, Required: 0)
* **cfopayroll_content** -> `cfopayroll-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `293` (Required: 1)
* Component ID: `827` (Required: 1)
* Component ID: `1361` (Required: 1)
* Component ID: `4119` (Required: 1)
* Component ID: `4120` (Required: 1)
* Component ID: `4121` (Required: 1)
* Component ID: `4122` (Required: 1)
* Component ID: `4123` (Required: 1)
* Component ID: `4124` (Required: 1)
* Component ID: `4125` (Required: 1)
* Component ID: `4126` (Required: 1)
* Component ID: `4127` (Required: 1)
* Component ID: `4128` (Required: 1)

## 7. API / Data Mapping
* API ID: `4608` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_payroll_runtime`
* **Test Name**: `CfoPayrollScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoPayrollScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/payroll`)
3. **should_be_visible** (Selector: `cfo_payroll-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_payroll-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_payroll-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
