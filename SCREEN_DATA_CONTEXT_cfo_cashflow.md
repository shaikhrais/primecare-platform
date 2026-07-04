# SCREEN DATA CONTEXT: cfo_cashflow

Below are the database records from `governance.db` used to configure and build the **Chief Financial Officer (CFO) - CfoCashflowScreen** screen.

---

## 1. Screen Record
* **ID**: `289`
* **App ID**: `7`
* **Role ID**: `21`
* **Screen Code**: `cfo_cashflow`
* **Screen Name**: `CfoCashflowScreen`
* **Route Path**: `/executive/cfo-cashflow`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/cfo_cashflow_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Financial Officer (CFO) personnel to oversee, audit, and coordinate operations related to cfocashflowscreen.`
* **User Story**: `As a Chief Financial Officer (CFO), I want to access the CfoCashflowScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CfoCashflowScreen`
* **Acceptance Criteria**:
- The CfoCashflowScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Financial Officer (CFO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cfo_cashflow-screen` (Type: layout, Required: 1)
* **page_title** -> `cfo_cashflow-title` (Type: header, Required: 1)
* **primary_content** -> `cfo_cashflow-content` (Type: layout, Required: 1)
* **cfocashflow_btn_3** -> `cfocashflow-btn-3` (Type: button, Required: 0)
* **cfocashflow_btn_2** -> `cfocashflow-btn-2` (Type: button, Required: 0)
* **cfocashflow_content** -> `cfocashflow-content` (Type: layout, Required: 0)
* **cfocashflow_loading** -> `cfocashflow-loading` (Type: loading, Required: 0)
* **cfocashflow_screen** -> `cfocashflow-screen` (Type: layout, Required: 0)
* **cfocashflow_btn_1** -> `cfocashflow-btn-1` (Type: button, Required: 0)
* **cfocashflow_title** -> `cfocashflow-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `297` (Required: 1)
* Component ID: `831` (Required: 1)
* Component ID: `1365` (Required: 1)
* Component ID: `4159` (Required: 1)
* Component ID: `4160` (Required: 1)
* Component ID: `4161` (Required: 1)
* Component ID: `4162` (Required: 1)
* Component ID: `4163` (Required: 1)
* Component ID: `4164` (Required: 1)
* Component ID: `4165` (Required: 1)
* Component ID: `4166` (Required: 1)
* Component ID: `4167` (Required: 1)
* Component ID: `4168` (Required: 1)

## 7. API / Data Mapping
* API ID: `4612` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cfo_cashflow_runtime`
* **Test Name**: `CfoCashflowScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CfoCashflowScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cfo`)
2. **visit** (Selector: `None`, Value: `/executive/cfo-cashflow`)
3. **should_be_visible** (Selector: `cfo_cashflow-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cfo_cashflow-title`, Value: `None`)
5. **should_be_visible** (Selector: `cfo_cashflow-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
