# SCREEN DATA CONTEXT: rn_vitals

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnVitalsScreen** screen.

---

## 1. Screen Record
* **ID**: `363`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_vitals`
* **Screen Name**: `RnVitalsScreen`
* **Route Path**: `/offices/clinical/roles/rn/vitals`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_vitals_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnvitalsscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnVitalsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnVitalsScreen`
* **Acceptance Criteria**:
- The RnVitalsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_vitals-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_vitals-title` (Type: header, Required: 1)
* **primary_content** -> `rn_vitals-content` (Type: layout, Required: 1)
* **rnvitals_title** -> `rnvitals-title` (Type: header, Required: 0)
* **rnvitals_loading** -> `rnvitals-loading` (Type: loading, Required: 0)
* **rnvitals_screen** -> `rnvitals-screen` (Type: layout, Required: 0)
* **rnvitals_btn_2** -> `rnvitals-btn-2` (Type: button, Required: 0)
* **rnvitals_btn_3** -> `rnvitals-btn-3` (Type: button, Required: 0)
* **rnvitals_content** -> `rnvitals-content` (Type: layout, Required: 0)
* **rnvitals_btn_1** -> `rnvitals-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `369` (Required: 1)
* Component ID: `903` (Required: 1)
* Component ID: `1437` (Required: 1)
* Component ID: `4808` (Required: 1)
* Component ID: `4809` (Required: 1)
* Component ID: `4810` (Required: 1)
* Component ID: `4811` (Required: 1)
* Component ID: `4812` (Required: 1)
* Component ID: `4813` (Required: 1)

## 7. API / Data Mapping
* API ID: `4716` (Required: 1)
* API ID: `4717` (Required: 1)
* API ID: `4718` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_vitals_runtime`
* **Test Name**: `RnVitalsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Vitals`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Vitals`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Vitals`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/vitals`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
