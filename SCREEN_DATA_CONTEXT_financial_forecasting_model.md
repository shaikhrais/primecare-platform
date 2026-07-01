# SCREEN DATA CONTEXT: financial_forecasting_model

Below are the database records from `governance.db` used to configure and build the **Guest - FinancialForecastingModelScreen** screen.

---

## 1. Screen Record
* **ID**: `939`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `financial_forecasting_model`
* **Screen Name**: `FinancialForecastingModelScreen`
* **Route Path**: `/generated/financial-forecasting-model`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/analytics/financial_forecasting_model.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to financial forecasting model.`
* **User Story**: `As a Guest, I want to access the Financial Forecasting Model within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Financial Forecasting Model`
* **Acceptance Criteria**:
- The Financial Forecasting Model route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `financial_forecasting_model-screen` (Type: layout, Required: 1)
* **page_title** -> `financial_forecasting_model-title` (Type: header, Required: 1)
* **primary_content** -> `financial_forecasting_model-content` (Type: layout, Required: 1)
* **financial_forecasting_model_iconbutton_button_1** -> `financial_forecasting_model_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8140` (Required: 1)
* Component ID: `8141` (Required: 1)
* Component ID: `8142` (Required: 1)
* Component ID: `8143` (Required: 1)

## 7. API / Data Mapping
* API ID: `5375` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `financial_forecasting_model_runtime`
* **Test Name**: `Financial Forecasting Model Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Financial Forecasting Model`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Financial Forecasting Model`)
4. **click_sidebar_link** (Selector: `None`, Value: `Financial Forecasting Model`)
5. **check_url** (Selector: `None`, Value: `/generated/financial-forecasting-model`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
