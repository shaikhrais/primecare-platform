# SCREEN DATA CONTEXT: medication_administration

Below are the database records from `governance.db` used to configure and build the **Registered Nurse (RN) - MedicationAdministrationScreen** screen.

---

## 1. Screen Record
* **ID**: `525`
* **App ID**: `6`
* **Role ID**: `8`
* **Screen Code**: `medication_administration`
* **Screen Name**: `MedicationAdministrationScreen`
* **Route Path**: `/offices/clinical/roles/rn/medication-administration`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rn/medication_administration_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Nurse (RN) personnel to oversee, audit, and coordinate operations related to medicationadministrationscreen.`
* **User Story**: `As a Registered Nurse (RN), I want to access the MedicationAdministrationScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `MedicationAdministrationScreen`
* **Acceptance Criteria**:
- The MedicationAdministrationScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Nurse (RN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `medication_administration-screen` (Type: layout, Required: 1)
* **page_title** -> `medication_administration-title` (Type: header, Required: 1)
* **primary_content** -> `medication_administration-content` (Type: layout, Required: 1)
* **medicationadministration_btn_3** -> `medicationadministration-btn-3` (Type: button, Required: 0)
* **medicationadministration_btn_1** -> `medicationadministration-btn-1` (Type: button, Required: 0)
* **medicationadministration_btn_2** -> `medicationadministration-btn-2` (Type: button, Required: 0)
* **medicationadministration_screen** -> `medicationadministration-screen` (Type: layout, Required: 0)
* **medicationadministration_content** -> `medicationadministration-content` (Type: layout, Required: 0)
* **medicationadministration_title** -> `medicationadministration-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `453` (Required: 1)
* Component ID: `987` (Required: 1)
* Component ID: `1521` (Required: 1)
* Component ID: `5613` (Required: 1)
* Component ID: `5614` (Required: 1)
* Component ID: `5615` (Required: 1)
* Component ID: `5616` (Required: 1)
* Component ID: `5617` (Required: 1)
* Component ID: `5618` (Required: 1)
* Component ID: `5619` (Required: 1)
* Component ID: `5620` (Required: 1)
* Component ID: `5621` (Required: 1)

## 7. API / Data Mapping
* API ID: `4840` (Required: 1)
* API ID: `4841` (Required: 1)
* API ID: `4842` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `medication_administration_runtime`
* **Test Name**: `MedicationAdministrationScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Medication Administration`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Medication Administration`)
4. **click_sidebar_link** (Selector: `None`, Value: `Medication Administration`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rn/medication-administration`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
