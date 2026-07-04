# SCREEN DATA CONTEXT: clinical_operations4_k

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalOperations4KScreen** screen.

---

## 1. Screen Record
* **ID**: `593`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_operations4_k`
* **Screen Name**: `ClinicalOperations4KScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/operations4k`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_operations4_k_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaloperations4kscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalOperations4KScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalOperations4KScreen`
* **Acceptance Criteria**:
- The ClinicalOperations4KScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_operations4_k-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_operations4_k-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_operations4_k-content` (Type: layout, Required: 1)
* **clinicaloperations4k_btn_1** -> `clinicaloperations4k-btn-1` (Type: button, Required: 0)
* **clinicaloperations4k_content** -> `clinicaloperations4k-content` (Type: layout, Required: 0)
* **clinicaloperations4k_btn_3** -> `clinicaloperations4k-btn-3` (Type: button, Required: 0)
* **clinicaloperations4k_screen** -> `clinicaloperations4k-screen` (Type: layout, Required: 0)
* **clinicaloperations4k_title** -> `clinicaloperations4k-title` (Type: header, Required: 0)
* **clinicaloperations4k_btn_2** -> `clinicaloperations4k-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `517` (Required: 1)
* Component ID: `1051` (Required: 1)
* Component ID: `1585` (Required: 1)
* Component ID: `6183` (Required: 1)
* Component ID: `6184` (Required: 1)
* Component ID: `6185` (Required: 1)
* Component ID: `6186` (Required: 1)
* Component ID: `6187` (Required: 1)
* Component ID: `6188` (Required: 1)
* Component ID: `6189` (Required: 1)
* Component ID: `6190` (Required: 1)
* Component ID: `6191` (Required: 1)
* Component ID: `6192` (Required: 1)

## 7. API / Data Mapping
* API ID: `4942` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_operations4_k_runtime`
* **Test Name**: `ClinicalOperations4KScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalOperations4KScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/operations4k`)
3. **should_be_visible** (Selector: `clinical_operations4_k-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_operations4_k-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_operations4_k-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
