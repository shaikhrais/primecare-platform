# SCREEN DATA CONTEXT: rn_reports

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `367`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_reports`
* **Screen Name**: `RnReportsScreen`
* **Route Path**: `/offices/clinical/roles/rn/rn-reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_reports_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `8`
* **Role Code**: `rn`
* **Role Name**: `Registered Nurse (RN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnreportsscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnReportsScreen`
* **Acceptance Criteria**:
- The RnReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_reports-title` (Type: header, Required: 1)
* **primary_content** -> `rn_reports-content` (Type: layout, Required: 1)
* **rnreports_content** -> `rnreports-content` (Type: layout, Required: 0)
* **rnreports_btn_2** -> `rnreports-btn-2` (Type: button, Required: 0)
* **rnreports_btn_3** -> `rnreports-btn-3` (Type: button, Required: 0)
* **rnreports_loading** -> `rnreports-loading` (Type: loading, Required: 0)
* **rnreports_title** -> `rnreports-title` (Type: header, Required: 0)
* **rnreports_screen** -> `rnreports-screen` (Type: layout, Required: 0)
* **rnreports_btn_1** -> `rnreports-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `373` (Required: 1)
* Component ID: `907` (Required: 1)
* Component ID: `1441` (Required: 1)
* Component ID: `4844` (Required: 1)
* Component ID: `4845` (Required: 1)
* Component ID: `4846` (Required: 1)
* Component ID: `4847` (Required: 1)
* Component ID: `4848` (Required: 1)
* Component ID: `4849` (Required: 1)
* Component ID: `4850` (Required: 1)
* Component ID: `4851` (Required: 1)
* Component ID: `4852` (Required: 1)
* Component ID: `4853` (Required: 1)

## 7. API / Data Mapping
* API ID: `4728` (Required: 1)
* API ID: `4729` (Required: 1)
* API ID: `4730` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_reports_runtime`
* **Test Name**: `RnReportsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnReportsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/rn-reports`)
3. **should_be_visible** (Selector: `rn_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
