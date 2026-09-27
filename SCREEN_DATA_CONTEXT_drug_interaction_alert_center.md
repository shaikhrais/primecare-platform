# SCREEN DATA CONTEXT: drug_interaction_alert_center

Below are the database records from `governance.db` used to configure and build the **Guest - DrugInteractionAlertCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `990`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `drug_interaction_alert_center`
* **Screen Name**: `DrugInteractionAlertCenterScreen`
* **Route Path**: `/generated/drug-interaction-alert-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/pharmacy/drug_interaction_alert_center.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to drug interaction alert center.`
* **User Story**: `As a Guest, I want to access the Drug Interaction Alert Center within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Drug Interaction Alert Center`
* **Acceptance Criteria**:
- The Drug Interaction Alert Center route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `drug_interaction_alert_center-screen` (Type: layout, Required: 1)
* **page_title** -> `drug_interaction_alert_center-title` (Type: header, Required: 1)
* **primary_content** -> `drug_interaction_alert_center-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8399` (Required: 1)
* Component ID: `8400` (Required: 1)
* Component ID: `8401` (Required: 1)
* Component ID: `8402` (Required: 1)
* Component ID: `8403` (Required: 1)
* Component ID: `8404` (Required: 1)
* Component ID: `8405` (Required: 1)

## 7. API / Data Mapping
* API ID: `5446` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `drug_interaction_alert_center_runtime`
* **Test Name**: `Drug Interaction Alert Center Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Drug Interaction Alert Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/drug-interaction-alert-center`)
3. **should_be_visible** (Selector: `drug_interaction_alert_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `drug_interaction_alert_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `drug_interaction_alert_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
