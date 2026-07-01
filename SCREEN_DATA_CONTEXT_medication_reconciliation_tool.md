# SCREEN DATA CONTEXT: medication_reconciliation_tool

Below are the database records from `governance.db` used to configure and build the **Guest - MedicationReconciliationToolScreen** screen.

---

## 1. Screen Record
* **ID**: `993`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `medication_reconciliation_tool`
* **Screen Name**: `MedicationReconciliationToolScreen`
* **Route Path**: `/generated/medication-reconciliation-tool`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/pharmacy/medication_reconciliation_tool.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to medication reconciliation tool.`
* **User Story**: `As a Guest, I want to access the Medication Reconciliation Tool within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Medication Reconciliation Tool`
* **Acceptance Criteria**:
- The Medication Reconciliation Tool route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `medication_reconciliation_tool-screen` (Type: layout, Required: 1)
* **page_title** -> `medication_reconciliation_tool-title` (Type: header, Required: 1)
* **primary_content** -> `medication_reconciliation_tool-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8419` (Required: 1)
* Component ID: `8420` (Required: 1)
* Component ID: `8421` (Required: 1)
* Component ID: `8422` (Required: 1)
* Component ID: `8423` (Required: 1)
* Component ID: `8424` (Required: 1)

## 7. API / Data Mapping
* API ID: `5451` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `medication_reconciliation_tool_runtime`
* **Test Name**: `Medication Reconciliation Tool Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Medication Reconciliation Tool`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Medication Reconciliation Tool`)
4. **click_sidebar_link** (Selector: `None`, Value: `Medication Reconciliation Tool`)
5. **check_url** (Selector: `None`, Value: `/generated/medication-reconciliation-tool`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
