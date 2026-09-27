# SCREEN DATA CONTEXT: risk_management

Below are the database records from `governance.db` used to configure and build the **Chief Executive Officer (CEO) - RiskManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `468`
* **App ID**: `7`
* **Role ID**: `20`
* **Screen Code**: `risk_management`
* **Screen Name**: `RiskManagementScreen`
* **Route Path**: `/executive/risk-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/risk_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `20`
* **Role Code**: `ceo`
* **Role Name**: `Chief Executive Officer (CEO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Executive Officer (CEO) personnel to oversee, audit, and coordinate operations related to riskmanagementscreen.`
* **User Story**: `As a Chief Executive Officer (CEO), I want to access the RiskManagementScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RiskManagementScreen`
* **Acceptance Criteria**:
- The RiskManagementScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Executive Officer (CEO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `risk_management-screen` (Type: layout, Required: 1)
* **page_title** -> `risk_management-title` (Type: header, Required: 1)
* **primary_content** -> `risk_management-content` (Type: layout, Required: 1)
* **riskmanagement_btn_2** -> `riskmanagement-btn-2` (Type: button, Required: 0)
* **riskmanagement_screen** -> `riskmanagement-screen` (Type: layout, Required: 0)
* **riskmanagement_btn_3** -> `riskmanagement-btn-3` (Type: button, Required: 0)
* **riskmanagement_content** -> `riskmanagement-content` (Type: layout, Required: 0)
* **riskmanagement_btn_1** -> `riskmanagement-btn-1` (Type: button, Required: 0)
* **riskmanagement_loading** -> `riskmanagement-loading` (Type: loading, Required: 0)
* **riskmanagement_title** -> `riskmanagement-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `397` (Required: 1)
* Component ID: `931` (Required: 1)
* Component ID: `1465` (Required: 1)
* Component ID: `5063` (Required: 1)
* Component ID: `5064` (Required: 1)
* Component ID: `5065` (Required: 1)
* Component ID: `5066` (Required: 1)
* Component ID: `5067` (Required: 1)
* Component ID: `5068` (Required: 1)
* Component ID: `5069` (Required: 1)
* Component ID: `5070` (Required: 1)
* Component ID: `5071` (Required: 1)
* Component ID: `5072` (Required: 1)

## 7. API / Data Mapping
* API ID: `4784` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `risk_management_runtime`
* **Test Name**: `RiskManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RiskManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `ceo`)
2. **visit** (Selector: `None`, Value: `/executive/risk-management`)
3. **should_be_visible** (Selector: `risk_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `risk_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `risk_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
