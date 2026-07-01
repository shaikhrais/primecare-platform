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
* **Test Name**: `Drug Interaction Alert Center Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Drug Interaction Alert Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Drug Interaction Alert Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Drug Interaction Alert Center`)
5. **check_url** (Selector: `None`, Value: `/generated/drug-interaction-alert-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
