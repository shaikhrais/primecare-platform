# SCREEN DATA CONTEXT: risk_register

Below are the database records from `governance.db` used to configure and build the **Guest - RiskRegisterScreen** screen.

---

## 1. Screen Record
* **ID**: `728`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `risk_register`
* **Screen Name**: `RiskRegisterScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/risk-register`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/risk_register_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to risk register.`
* **User Story**: `As a Guest, I want to access the Risk Register within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Risk Register`
* **Acceptance Criteria**:
- The Risk Register route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `risk_register-screen` (Type: layout, Required: 1)
* **page_title** -> `risk_register-title` (Type: header, Required: 1)
* **primary_content** -> `risk_register-content` (Type: layout, Required: 1)
* **risk_register_btn_add** -> `risk-register-btn-add` (Type: button, Required: 0)
* **risk_register_btn_export** -> `risk-register-btn-export` (Type: button, Required: 0)
* **risk_register_search** -> `risk-register-search` (Type: custom, Required: 0)
* **riskregister_content** -> `riskregister-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6994` (Required: 1)
* Component ID: `6995` (Required: 1)
* Component ID: `6996` (Required: 1)
* Component ID: `6997` (Required: 1)
* Component ID: `6998` (Required: 1)
* Component ID: `6999` (Required: 1)

## 7. API / Data Mapping
* API ID: `5106` (Required: 1)
* API ID: `5107` (Required: 1)
* API ID: `5108` (Required: 1)
* API ID: `5109` (Required: 1)
* API ID: `5110` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `risk_register_runtime`
* **Test Name**: `Risk Register Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Risk Register`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/risk-register`)
2. **should_be_visible** (Selector: `risk_register-screen`, Value: `None`)
3. **should_be_visible** (Selector: `risk_register-title`, Value: `None`)
4. **should_be_visible** (Selector: `risk_register-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
