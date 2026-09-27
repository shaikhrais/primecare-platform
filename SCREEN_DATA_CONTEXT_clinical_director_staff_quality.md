# SCREEN DATA CONTEXT: clinical_director_staff_quality

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorStaffQualityScreen** screen.

---

## 1. Screen Record
* **ID**: `298`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_staff_quality`
* **Screen Name**: `ClinicalDirectorStaffQualityScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/staff-quality`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_staff_quality_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorstaffqualityscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorStaffQualityScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorStaffQualityScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorStaffQualityScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_staff_quality-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_staff_quality-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_staff_quality-content` (Type: layout, Required: 1)
* **clinicaldirectorstaffquality_content** -> `clinicaldirectorstaffquality-content` (Type: layout, Required: 0)
* **clinicaldirectorstaffquality_title** -> `clinicaldirectorstaffquality-title` (Type: header, Required: 0)
* **clinicaldirectorstaffquality_btn_2** -> `clinicaldirectorstaffquality-btn-2` (Type: button, Required: 0)
* **clinicaldirectorstaffquality_btn_1** -> `clinicaldirectorstaffquality-btn-1` (Type: button, Required: 0)
* **clinicaldirectorstaffquality_btn_3** -> `clinicaldirectorstaffquality-btn-3` (Type: button, Required: 0)
* **clinicaldirectorstaffquality_screen** -> `clinicaldirectorstaffquality-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `306` (Required: 1)
* Component ID: `840` (Required: 1)
* Component ID: `1374` (Required: 1)
* Component ID: `4249` (Required: 1)
* Component ID: `4250` (Required: 1)
* Component ID: `4251` (Required: 1)
* Component ID: `4252` (Required: 1)
* Component ID: `4253` (Required: 1)
* Component ID: `4254` (Required: 1)
* Component ID: `4255` (Required: 1)
* Component ID: `4256` (Required: 1)
* Component ID: `4257` (Required: 1)
* Component ID: `4258` (Required: 1)

## 7. API / Data Mapping
* API ID: `4625` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_staff_quality_runtime`
* **Test Name**: `ClinicalDirectorStaffQualityScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDirectorStaffQualityScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/staff-quality`)
3. **should_be_visible** (Selector: `clinical_director_staff_quality-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_staff_quality-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_staff_quality-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
