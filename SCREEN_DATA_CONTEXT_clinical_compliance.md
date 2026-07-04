# SCREEN DATA CONTEXT: clinical_compliance

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `80`
* **App ID**: `1`
* **Role ID**: `6`
* **Screen Code**: `clinical_compliance`
* **Screen Name**: `ClinicalComplianceScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/compliance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_compliance_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `6`
* **Role Code**: `clinical_director`
* **Role Name**: `Clinical Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicalcompliancescreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalComplianceScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalComplianceScreen`
* **Acceptance Criteria**:
- The ClinicalComplianceScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_compliance-content` (Type: layout, Required: 1)
* **clinicalcompliance_title** -> `clinicalcompliance-title` (Type: header, Required: 0)
* **clinicalcompliance_btn_1** -> `clinicalcompliance-btn-1` (Type: button, Required: 0)
* **clinicalcompliance_btn_2** -> `clinicalcompliance-btn-2` (Type: button, Required: 0)
* **clinicalcompliance_btn_3** -> `clinicalcompliance-btn-3` (Type: button, Required: 0)
* **clinicalcompliance_screen** -> `clinicalcompliance-screen` (Type: layout, Required: 0)
* **clinicalcompliance_content** -> `clinicalcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `88` (Required: 1)
* Component ID: `622` (Required: 1)
* Component ID: `1156` (Required: 1)
* Component ID: `2295` (Required: 1)
* Component ID: `2296` (Required: 1)
* Component ID: `2297` (Required: 1)
* Component ID: `2298` (Required: 1)
* Component ID: `2299` (Required: 1)
* Component ID: `2300` (Required: 1)
* Component ID: `2301` (Required: 1)
* Component ID: `2302` (Required: 1)
* Component ID: `2303` (Required: 1)
* Component ID: `2304` (Required: 1)

## 7. API / Data Mapping
* API ID: `4351` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_compliance_runtime`
* **Test Name**: `ClinicalComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/compliance`)
3. **should_be_visible** (Selector: `clinical_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
