# SCREEN DATA CONTEXT: supply_chain_cost_analyzer

Below are the database records from `governance.db` used to configure and build the **Guest - SupplyChainCostAnalyzerScreen** screen.

---

## 1. Screen Record
* **ID**: `946`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `supply_chain_cost_analyzer`
* **Screen Name**: `SupplyChainCostAnalyzerScreen`
* **Route Path**: `/generated/supply-chain-cost-analyzer`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/supply_chain_cost_analyzer.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to supply chain cost analyzer.`
* **User Story**: `As a Guest, I want to access the Supply Chain Cost Analyzer within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Supply Chain Cost Analyzer`
* **Acceptance Criteria**:
- The Supply Chain Cost Analyzer route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `supply_chain_cost_analyzer-screen` (Type: layout, Required: 1)
* **page_title** -> `supply_chain_cost_analyzer-title` (Type: header, Required: 1)
* **primary_content** -> `supply_chain_cost_analyzer-content` (Type: layout, Required: 1)
* **supply_chain_cost_analyzer_iconbutton_button_1** -> `supply_chain_cost_analyzer_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8164` (Required: 1)
* Component ID: `8165` (Required: 1)
* Component ID: `8166` (Required: 1)

## 7. API / Data Mapping
* API ID: `5382` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `supply_chain_cost_analyzer_runtime`
* **Test Name**: `Supply Chain Cost Analyzer Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Supply Chain Cost Analyzer`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/supply-chain-cost-analyzer`)
3. **should_be_visible** (Selector: `supply_chain_cost_analyzer-screen`, Value: `None`)
4. **should_be_visible** (Selector: `supply_chain_cost_analyzer-title`, Value: `None`)
5. **should_be_visible** (Selector: `supply_chain_cost_analyzer-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
