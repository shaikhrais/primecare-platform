# SCREEN DATA CONTEXT: rn_medications

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - RnMedicationsScreen** screen.

---

## 1. Screen Record
* **ID**: `362`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `rn_medications`
* **Screen Name**: `RnMedicationsScreen`
* **Route Path**: `/offices/clinical/roles/rn/medications`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/rn_medications_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to rnmedicationsscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the RnMedicationsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RnMedicationsScreen`
* **Acceptance Criteria**:
- The RnMedicationsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_medications-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_medications-title` (Type: header, Required: 1)
* **primary_content** -> `rn_medications-content` (Type: layout, Required: 1)
* **rnmedications_title** -> `rnmedications-title` (Type: header, Required: 0)
* **rnmedications_loading** -> `rnmedications-loading` (Type: loading, Required: 0)
* **rnmedications_btn_3** -> `rnmedications-btn-3` (Type: button, Required: 0)
* **rnmedications_btn_1** -> `rnmedications-btn-1` (Type: button, Required: 0)
* **rnmedications_btn_2** -> `rnmedications-btn-2` (Type: button, Required: 0)
* **rnmedications_content** -> `rnmedications-content` (Type: layout, Required: 0)
* **rnmedications_screen** -> `rnmedications-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `368` (Required: 1)
* Component ID: `902` (Required: 1)
* Component ID: `1436` (Required: 1)
* Component ID: `4798` (Required: 1)
* Component ID: `4799` (Required: 1)
* Component ID: `4800` (Required: 1)
* Component ID: `4801` (Required: 1)
* Component ID: `4802` (Required: 1)
* Component ID: `4803` (Required: 1)
* Component ID: `4804` (Required: 1)
* Component ID: `4805` (Required: 1)
* Component ID: `4806` (Required: 1)
* Component ID: `4807` (Required: 1)

## 7. API / Data Mapping
* API ID: `4713` (Required: 1)
* API ID: `4714` (Required: 1)
* API ID: `4715` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_medications_runtime`
* **Test Name**: `RnMedicationsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RnMedicationsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rn/medications`)
3. **should_be_visible** (Selector: `rn_medications-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_medications-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_medications-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
