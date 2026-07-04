# SCREEN DATA CONTEXT: invoice_management

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - InvoiceManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `516`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `invoice_management`
* **Screen Name**: `InvoiceManagementScreen`
* **Route Path**: `/staff/invoice-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/invoice_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to invoicemanagementscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the InvoiceManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InvoiceManagementScreen`
* **Acceptance Criteria**:
- The InvoiceManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `invoice_management-screen` (Type: layout, Required: 1)
* **page_title** -> `invoice_management-title` (Type: header, Required: 1)
* **primary_content** -> `invoice_management-content` (Type: layout, Required: 1)
* **invoicemanagement_btn_5** -> `invoicemanagement-btn-5` (Type: button, Required: 0)
* **invoicemanagement_screen** -> `invoicemanagement-screen` (Type: layout, Required: 0)
* **invoicemanagement_loading** -> `invoicemanagement-loading` (Type: loading, Required: 0)
* **invoicemanagement_btn_2** -> `invoicemanagement-btn-2` (Type: button, Required: 0)
* **invoicemanagement_content** -> `invoicemanagement-content` (Type: layout, Required: 0)
* **invoicemanagement_btn_4** -> `invoicemanagement-btn-4` (Type: button, Required: 0)
* **invoicemanagement_btn_1** -> `invoicemanagement-btn-1` (Type: button, Required: 0)
* **invoicemanagement_btn_3** -> `invoicemanagement-btn-3` (Type: button, Required: 0)
* **invoicemanagement_title** -> `invoicemanagement-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `445` (Required: 1)
* Component ID: `979` (Required: 1)
* Component ID: `1513` (Required: 1)
* Component ID: `5536` (Required: 1)
* Component ID: `5537` (Required: 1)
* Component ID: `5538` (Required: 1)
* Component ID: `5539` (Required: 1)
* Component ID: `5540` (Required: 1)
* Component ID: `5541` (Required: 1)
* Component ID: `5542` (Required: 1)
* Component ID: `5543` (Required: 1)
* Component ID: `5544` (Required: 1)
* Component ID: `5545` (Required: 1)

## 7. API / Data Mapping
* API ID: `4832` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `invoice_management_runtime`
* **Test Name**: `InvoiceManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InvoiceManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/invoice-management`)
3. **should_be_visible** (Selector: `invoice_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `invoice_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `invoice_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
