# SCREEN DATA CONTEXT: cfo_tax

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoTaxScreen** screen.

---

## 1. Screen Record
* **ID**: `287`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_tax`
* **Screen Name**: `CfoTaxScreen`
* **Route Path**: `/executive/cfo-tax`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_tax_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfotaxscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoTaxScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoTaxScreen`
* **Acceptance Criteria**:
- The CfoTaxScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_tax-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_tax-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_tax-content` (Type: layout, Required: 1)
* **cfotax_loading** -> `cfotax-loading` (Type: loading, Required: 0)
* **cfotax_title** -> `cfotax-title` (Type: header, Required: 0)
* **cfotax_btn_1** -> `cfotax-btn-1` (Type: button, Required: 0)
* **cfotax_btn_3** -> `cfotax-btn-3` (Type: button, Required: 0)
* **cfotax_btn_2** -> `cfotax-btn-2` (Type: button, Required: 0)
* **cfotax_screen** -> `cfotax-screen` (Type: layout, Required: 0)
* **cfotax_content** -> `cfotax-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `295` (Required: 1)
* Component ID: `829` (Required: 1)
* Component ID: `1363` (Required: 1)
* Component ID: `4139` (Required: 1)
* Component ID: `4140` (Required: 1)
* Component ID: `4141` (Required: 1)
* Component ID: `4142` (Required: 1)
* Component ID: `4143` (Required: 1)
* Component ID: `4144` (Required: 1)
* Component ID: `4145` (Required: 1)
* Component ID: `4146` (Required: 1)
* Component ID: `4147` (Required: 1)
* Component ID: `4148` (Required: 1)

## 7. API / Data Mapping
* API ID: `4610` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_tax_runtime`
* **Test Name**: `CfoTaxScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoTaxScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/executive/cfo-tax`)
3. **should_be_visible** (Selector: `cfo_tax-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_tax-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_tax-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
