# SCREEN DATA CONTEXT: controlled_substance_log

Below are the database records from `governance.db` used to configure and build the **Guest - ControlledSubstanceLogScreen** screen.

---

## 1. Screen Record
* **ID**: `989`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `controlled_substance_log`
* **Screen Name**: `ControlledSubstanceLogScreen`
* **Route Path**: `/generated/controlled-substance-log`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/pharmacy/controlled_substance_log.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to controlled substance log.`
* **User Story**: `As a Guest, I want to access the Controlled Substance Log within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Controlled Substance Log`
* **Acceptance Criteria**:
- The Controlled Substance Log route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `controlled_substance_log-screen` (Type: layout, Required: 1)
* **page_title** -> `controlled_substance_log-title` (Type: header, Required: 1)
* **primary_content** -> `controlled_substance_log-content` (Type: layout, Required: 1)
* **substance_btn_add** -> `substance-btn-add` (Type: button, Required: 0)
* **substance_btn_sign** -> `substance-btn-sign` (Type: button, Required: 0)
* **substance_search** -> `substance-search` (Type: custom, Required: 0)
* **substance_witness_field** -> `substance-witness-field` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8391` (Required: 1)
* Component ID: `8392` (Required: 1)
* Component ID: `8393` (Required: 1)
* Component ID: `8394` (Required: 1)
* Component ID: `8395` (Required: 1)
* Component ID: `8396` (Required: 1)
* Component ID: `8397` (Required: 1)
* Component ID: `8398` (Required: 1)

## 7. API / Data Mapping
* API ID: `5443` (Required: 1)
* API ID: `5444` (Required: 1)
* API ID: `5445` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `controlled_substance_log_runtime`
* **Test Name**: `Controlled Substance Log Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Controlled Substance Log`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Controlled Substance Log`)
4. **click_sidebar_link** (Selector: `None`, Value: `Controlled Substance Log`)
5. **check_url** (Selector: `None`, Value: `/generated/controlled-substance-log`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
