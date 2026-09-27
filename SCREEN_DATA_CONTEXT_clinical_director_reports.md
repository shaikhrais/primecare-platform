# SCREEN DATA CONTEXT: clinical_director_reports

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `301`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_reports`
* **Screen Name**: `ClinicalDirectorReportsScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/reports`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_reports_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorreportsscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorReportsScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorReportsScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorReportsScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_reports-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_reports-content` (Type: layout, Required: 1)
* **clinicaldirectorreports_btn_2** -> `clinicaldirectorreports-btn-2` (Type: button, Required: 0)
* **clinicaldirectorreports_content** -> `clinicaldirectorreports-content` (Type: layout, Required: 0)
* **clinicaldirectorreports_title** -> `clinicaldirectorreports-title` (Type: header, Required: 0)
* **clinicaldirectorreports_btn_1** -> `clinicaldirectorreports-btn-1` (Type: button, Required: 0)
* **clinicaldirectorreports_btn_3** -> `clinicaldirectorreports-btn-3` (Type: button, Required: 0)
* **clinicaldirectorreports_screen** -> `clinicaldirectorreports-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `309` (Required: 1)
* Component ID: `843` (Required: 1)
* Component ID: `1377` (Required: 1)
* Component ID: `4279` (Required: 1)
* Component ID: `4280` (Required: 1)
* Component ID: `4281` (Required: 1)
* Component ID: `4282` (Required: 1)
* Component ID: `4283` (Required: 1)
* Component ID: `4284` (Required: 1)
* Component ID: `4285` (Required: 1)
* Component ID: `4286` (Required: 1)
* Component ID: `4287` (Required: 1)
* Component ID: `4288` (Required: 1)

## 7. API / Data Mapping
* API ID: `4628` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_reports_runtime`
* **Test Name**: `ClinicalDirectorReportsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDirectorReportsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/reports`)
3. **should_be_visible** (Selector: `clinical_director_reports-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_reports-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_reports-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
