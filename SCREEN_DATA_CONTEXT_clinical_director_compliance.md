# SCREEN DATA CONTEXT: clinical_director_compliance

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorComplianceScreen** screen.

---

## 1. Screen Record
* **ID**: `300`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_compliance`
* **Screen Name**: `ClinicalDirectorComplianceScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/compliance-director`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_compliance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorcompliancescreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorComplianceScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorComplianceScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorComplianceScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_compliance-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_compliance-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_compliance-content` (Type: layout, Required: 1)
* **clinicaldirectorcompliance_btn_2** -> `clinicaldirectorcompliance-btn-2` (Type: button, Required: 0)
* **clinicaldirectorcompliance_screen** -> `clinicaldirectorcompliance-screen` (Type: layout, Required: 0)
* **clinicaldirectorcompliance_btn_1** -> `clinicaldirectorcompliance-btn-1` (Type: button, Required: 0)
* **clinicaldirectorcompliance_title** -> `clinicaldirectorcompliance-title` (Type: header, Required: 0)
* **clinicaldirectorcompliance_btn_3** -> `clinicaldirectorcompliance-btn-3` (Type: button, Required: 0)
* **clinicaldirectorcompliance_content** -> `clinicaldirectorcompliance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `308` (Required: 1)
* Component ID: `842` (Required: 1)
* Component ID: `1376` (Required: 1)
* Component ID: `4269` (Required: 1)
* Component ID: `4270` (Required: 1)
* Component ID: `4271` (Required: 1)
* Component ID: `4272` (Required: 1)
* Component ID: `4273` (Required: 1)
* Component ID: `4274` (Required: 1)
* Component ID: `4275` (Required: 1)
* Component ID: `4276` (Required: 1)
* Component ID: `4277` (Required: 1)
* Component ID: `4278` (Required: 1)

## 7. API / Data Mapping
* API ID: `4627` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_compliance_runtime`
* **Test Name**: `ClinicalDirectorComplianceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDirectorComplianceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/compliance-director`)
3. **should_be_visible** (Selector: `clinical_director_compliance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_compliance-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_compliance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
