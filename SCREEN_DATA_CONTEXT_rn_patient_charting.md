# SCREEN DATA CONTEXT: rn_patient_charting

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnPatientChartingScreen** screen.

---

## 1. Screen Record
* **ID**: `361`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_patient_charting`
* **Screen Name**: `RnPatientChartingScreen`
* **Route Path**: `/offices/clinical/roles/rn/patient-charting`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_patient_charting_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnpatientchartingscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnPatientChartingScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnPatientChartingScreen`
* **Acceptance Criteria**:
- The RnPatientChartingScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_patient_charting-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_patient_charting-title` (Type: header, Required: 1)
* **primary_content** -> `rn_patient_charting-content` (Type: layout, Required: 1)
* **rnpatientcharting_title** -> `rnpatientcharting-title` (Type: header, Required: 0)
* **rnpatientcharting_content** -> `rnpatientcharting-content` (Type: layout, Required: 0)
* **rnpatientcharting_btn_3** -> `rnpatientcharting-btn-3` (Type: button, Required: 0)
* **rnpatientcharting_loading** -> `rnpatientcharting-loading` (Type: loading, Required: 0)
* **rnpatientcharting_btn_1** -> `rnpatientcharting-btn-1` (Type: button, Required: 0)
* **rnpatientcharting_screen** -> `rnpatientcharting-screen` (Type: layout, Required: 0)
* **rnpatientcharting_btn_2** -> `rnpatientcharting-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `367` (Required: 1)
* Component ID: `901` (Required: 1)
* Component ID: `1435` (Required: 1)
* Component ID: `4788` (Required: 1)
* Component ID: `4789` (Required: 1)
* Component ID: `4790` (Required: 1)
* Component ID: `4791` (Required: 1)
* Component ID: `4792` (Required: 1)
* Component ID: `4793` (Required: 1)
* Component ID: `4794` (Required: 1)
* Component ID: `4795` (Required: 1)
* Component ID: `4796` (Required: 1)
* Component ID: `4797` (Required: 1)

## 7. API / Data Mapping
* API ID: `4710` (Required: 1)
* API ID: `4711` (Required: 1)
* API ID: `4712` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_patient_charting_runtime`
* **Test Name**: `RnPatientChartingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RN Patient Charting`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RN Patient Charting`)
4. **click_sidebar_link** (Selector: `None`, Value: `RN Patient Charting`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/patient-charting`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
