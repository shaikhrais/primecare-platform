# SCREEN DATA CONTEXT: operational_efficiency_metrics

Below are the database records from `governance.db` used to configure and build the **Guest - OperationalEfficiencyMetricsScreen** screen.

---

## 1. Screen Record
* **ID**: `941`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `operational_efficiency_metrics`
* **Screen Name**: `OperationalEfficiencyMetricsScreen`
* **Route Path**: `/generated/operational-efficiency-metrics`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/operational_efficiency_metrics.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to operational efficiency metrics.`
* **User Story**: `As a Guest, I want to access the Operational Efficiency Metrics within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Operational Efficiency Metrics`
* **Acceptance Criteria**:
- The Operational Efficiency Metrics route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `operational_efficiency_metrics-screen` (Type: layout, Required: 1)
* **page_title** -> `operational_efficiency_metrics-title` (Type: header, Required: 1)
* **primary_content** -> `operational_efficiency_metrics-content` (Type: layout, Required: 1)
* **operational_efficiency_metrics_iconbutton_button_1** -> `operational_efficiency_metrics_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8147` (Required: 1)
* Component ID: `8148` (Required: 1)
* Component ID: `8149` (Required: 1)

## 7. API / Data Mapping
* API ID: `5377` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `operational_efficiency_metrics_runtime`
* **Test Name**: `Operational Efficiency Metrics Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Operational Efficiency Metrics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/operational-efficiency-metrics`)
3. **should_be_visible** (Selector: `operational_efficiency_metrics-screen`, Value: `None`)
4. **should_be_visible** (Selector: `operational_efficiency_metrics-title`, Value: `None`)
5. **should_be_visible** (Selector: `operational_efficiency_metrics-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
