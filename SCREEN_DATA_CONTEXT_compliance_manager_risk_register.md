# SCREEN DATA CONTEXT: compliance_manager_risk_register

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceManagerRiskRegisterScreen** screen.

---

## 1. Screen Record
* **ID**: `744`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_manager_risk_register`
* **Screen Name**: `ComplianceManagerRiskRegisterScreen`
* **Route Path**: `/generated/compliance-manager-risk-register`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/compliance_manager_risk_register_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance manager risk register.`
* **User Story**: `As a Guest, I want to access the Compliance Manager Risk Register within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Manager Risk Register`
* **Acceptance Criteria**:
- The Compliance Manager Risk Register route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_risk_register-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_risk_register-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_risk_register-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7085` (Required: 1)
* Component ID: `7086` (Required: 1)
* Component ID: `7087` (Required: 1)
* Component ID: `7088` (Required: 1)
* Component ID: `7089` (Required: 1)

## 7. API / Data Mapping
* API ID: `5128` (Required: 1)
* API ID: `5129` (Required: 1)
* API ID: `5130` (Required: 1)
* API ID: `5131` (Required: 1)
* API ID: `5132` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_risk_register_runtime`
* **Test Name**: `Compliance Manager Risk Register Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Risk Register`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/generated/compliance-manager-risk-register`)
2. **should_be_visible** (Selector: `compliance_manager_risk_register-screen`, Value: `None`)
3. **should_be_visible** (Selector: `compliance_manager_risk_register-title`, Value: `None`)
4. **should_be_visible** (Selector: `compliance_manager_risk_register-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
