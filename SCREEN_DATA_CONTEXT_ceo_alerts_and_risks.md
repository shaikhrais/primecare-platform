# SCREEN DATA CONTEXT: ceo_alerts_and_risks

Below are the database records from `governance.db` used to configure and build the **Guest - CeoAlertsAndRisksScreen** screen.

---

## 1. Screen Record
* **ID**: `703`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ceo_alerts_and_risks`
* **Screen Name**: `CeoAlertsAndRisksScreen`
* **Route Path**: `/offices/corporate/roles/ceo/alerts-and-risks`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/ceo_alerts_and_risks_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ceo alerts and risks.`
* **User Story**: `As a Guest, I want to access the Ceo Alerts And Risks within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ceo Alerts And Risks`
* **Acceptance Criteria**:
- The Ceo Alerts And Risks route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ceo_alerts_and_risks-screen` (Type: layout, Required: 1)
* **page_title** -> `ceo_alerts_and_risks-title` (Type: header, Required: 1)
* **primary_content** -> `ceo_alerts_and_risks-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6857` (Required: 1)
* Component ID: `6858` (Required: 1)
* Component ID: `6859` (Required: 1)
* Component ID: `6860` (Required: 1)

## 7. API / Data Mapping
* API ID: `5079` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ceo_alerts_and_risks_runtime`
* **Test Name**: `Ceo Alerts And Risks Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ceo Alerts And Risks`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/ceo/alerts-and-risks`)
3. **should_be_visible** (Selector: `ceo_alerts_and_risks-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ceo_alerts_and_risks-title`, Value: `None`)
5. **should_be_visible** (Selector: `ceo_alerts_and_risks-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
