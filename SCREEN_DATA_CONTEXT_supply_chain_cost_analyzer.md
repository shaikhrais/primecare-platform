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
* **Stage/Status**: `wired`

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
* **Test Name**: `Supply Chain Cost Analyzer Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Supply Chain Cost Analyzer`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Supply Chain Cost Analyzer`)
4. **click_sidebar_link** (Selector: `None`, Value: `Supply Chain Cost Analyzer`)
5. **check_url** (Selector: `None`, Value: `/generated/supply-chain-cost-analyzer`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
