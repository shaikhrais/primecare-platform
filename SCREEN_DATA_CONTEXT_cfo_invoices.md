# SCREEN DATA CONTEXT: cfo_invoices

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoInvoicesScreen** screen.

---

## 1. Screen Record
* **ID**: `286`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_invoices`
* **Screen Name**: `CfoInvoicesScreen`
* **Route Path**: `/offices/corporate/roles/cfo/invoices`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_invoices_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfoinvoicesscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoInvoicesScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoInvoicesScreen`
* **Acceptance Criteria**:
- The CfoInvoicesScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_invoices-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_invoices-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_invoices-content` (Type: layout, Required: 1)
* **cfoinvoices_loading** -> `cfoinvoices-loading` (Type: loading, Required: 0)
* **cfoinvoices_btn_2** -> `cfoinvoices-btn-2` (Type: button, Required: 0)
* **cfoinvoices_btn_1** -> `cfoinvoices-btn-1` (Type: button, Required: 0)
* **cfoinvoices_screen** -> `cfoinvoices-screen` (Type: layout, Required: 0)
* **cfoinvoices_title** -> `cfoinvoices-title` (Type: header, Required: 0)
* **cfoinvoices_btn_3** -> `cfoinvoices-btn-3` (Type: button, Required: 0)
* **cfoinvoices_content** -> `cfoinvoices-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `294` (Required: 1)
* Component ID: `828` (Required: 1)
* Component ID: `1362` (Required: 1)
* Component ID: `4129` (Required: 1)
* Component ID: `4130` (Required: 1)
* Component ID: `4131` (Required: 1)
* Component ID: `4132` (Required: 1)
* Component ID: `4133` (Required: 1)
* Component ID: `4134` (Required: 1)
* Component ID: `4135` (Required: 1)
* Component ID: `4136` (Required: 1)
* Component ID: `4137` (Required: 1)
* Component ID: `4138` (Required: 1)

## 7. API / Data Mapping
* API ID: `4609` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_invoices_runtime`
* **Test Name**: `CfoInvoicesScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoInvoicesScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/invoices`)
3. **should_be_visible** (Selector: `cfo_invoices-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_invoices-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_invoices-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
