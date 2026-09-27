# SCREEN DATA CONTEXT: clinical_quality

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalQualityScreen** screen.

---

## 1. Screen Record
* **ID**: `553`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_quality`
* **Screen Name**: `ClinicalQualityScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/quality`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_quality_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicalqualityscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalQualityScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalQualityScreen`
* **Acceptance Criteria**:
- The ClinicalQualityScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_quality-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_quality-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_quality-content` (Type: layout, Required: 1)
* **clinicalquality_title** -> `clinicalquality-title` (Type: header, Required: 0)
* **clinicalquality_btn_3** -> `clinicalquality-btn-3` (Type: button, Required: 0)
* **clinicalquality_screen** -> `clinicalquality-screen` (Type: layout, Required: 0)
* **clinicalquality_loading** -> `clinicalquality-loading` (Type: loading, Required: 0)
* **clinicalquality_btn_2** -> `clinicalquality-btn-2` (Type: button, Required: 0)
* **clinicalquality_content** -> `clinicalquality-content` (Type: layout, Required: 0)
* **clinicalquality_btn_1** -> `clinicalquality-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `477` (Required: 1)
* Component ID: `1011` (Required: 1)
* Component ID: `1545` (Required: 1)
* Component ID: `5833` (Required: 1)
* Component ID: `5834` (Required: 1)
* Component ID: `5835` (Required: 1)
* Component ID: `5836` (Required: 1)
* Component ID: `5837` (Required: 1)
* Component ID: `5838` (Required: 1)
* Component ID: `5839` (Required: 1)
* Component ID: `5840` (Required: 1)
* Component ID: `5841` (Required: 1)
* Component ID: `5842` (Required: 1)

## 7. API / Data Mapping
* API ID: `4898` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_quality_runtime`
* **Test Name**: `ClinicalQualityScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalQualityScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/quality`)
3. **should_be_visible** (Selector: `clinical_quality-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_quality-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_quality-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
