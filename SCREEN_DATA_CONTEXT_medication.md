# SCREEN DATA CONTEXT: medication

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - MedicationScreen** screen.

---

## 1. Screen Record
* **ID**: `531`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `medication`
* **Screen Name**: `MedicationScreen`
* **Route Path**: `/offices/clinical/roles/rpn/medication`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/medication_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to medicationscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the MedicationScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `MedicationScreen`
* **Acceptance Criteria**:
- The MedicationScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `medication-screen` (Type: layout, Required: 1)
* **page_title** -> `medication-title` (Type: header, Required: 1)
* **primary_content** -> `medication-content` (Type: layout, Required: 1)
* **medication_btn_1** -> `medication-btn-1` (Type: button, Required: 0)
* **medication_loading** -> `medication-loading` (Type: loading, Required: 0)
* **medication_btn_2** -> `medication-btn-2` (Type: button, Required: 0)
* **medication_btn_3** -> `medication-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `459` (Required: 1)
* Component ID: `993` (Required: 1)
* Component ID: `1527` (Required: 1)
* Component ID: `5672` (Required: 1)
* Component ID: `5673` (Required: 1)
* Component ID: `5674` (Required: 1)
* Component ID: `5675` (Required: 1)
* Component ID: `5676` (Required: 1)
* Component ID: `5677` (Required: 1)
* Component ID: `5678` (Required: 1)
* Component ID: `5679` (Required: 1)
* Component ID: `5680` (Required: 1)
* Component ID: `5681` (Required: 1)

## 7. API / Data Mapping
* API ID: `4858` (Required: 1)
* API ID: `4859` (Required: 1)
* API ID: `4860` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `medication_runtime`
* **Test Name**: `MedicationScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `MedicationScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/rpn/medication`)
3. **should_be_visible** (Selector: `medication-screen`, Value: `None`)
4. **should_be_visible** (Selector: `medication-title`, Value: `None`)
5. **should_be_visible** (Selector: `medication-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
