# SCREEN DATA CONTEXT: cfo_profitability

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoProfitabilityScreen** screen.

---

## 1. Screen Record
* **ID**: `288`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_profitability`
* **Screen Name**: `CfoProfitabilityScreen`
* **Route Path**: `/offices/corporate/roles/cfo/profitability`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_profitability_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfoprofitabilityscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoProfitabilityScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoProfitabilityScreen`
* **Acceptance Criteria**:
- The CfoProfitabilityScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_profitability-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_profitability-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_profitability-content` (Type: layout, Required: 1)
* **cfoprofitability_btn_2** -> `cfoprofitability-btn-2` (Type: button, Required: 0)
* **cfoprofitability_title** -> `cfoprofitability-title` (Type: header, Required: 0)
* **cfoprofitability_loading** -> `cfoprofitability-loading` (Type: loading, Required: 0)
* **cfoprofitability_content** -> `cfoprofitability-content` (Type: layout, Required: 0)
* **cfoprofitability_btn_1** -> `cfoprofitability-btn-1` (Type: button, Required: 0)
* **cfoprofitability_btn_3** -> `cfoprofitability-btn-3` (Type: button, Required: 0)
* **cfoprofitability_screen** -> `cfoprofitability-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `296` (Required: 1)
* Component ID: `830` (Required: 1)
* Component ID: `1364` (Required: 1)
* Component ID: `4149` (Required: 1)
* Component ID: `4150` (Required: 1)
* Component ID: `4151` (Required: 1)
* Component ID: `4152` (Required: 1)
* Component ID: `4153` (Required: 1)
* Component ID: `4154` (Required: 1)
* Component ID: `4155` (Required: 1)
* Component ID: `4156` (Required: 1)
* Component ID: `4157` (Required: 1)
* Component ID: `4158` (Required: 1)

## 7. API / Data Mapping
* API ID: `4611` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_profitability_runtime`
* **Test Name**: `CfoProfitabilityScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoProfitabilityScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cfo/profitability`)
3. **should_be_visible** (Selector: `cfo_profitability-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_profitability-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_profitability-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
