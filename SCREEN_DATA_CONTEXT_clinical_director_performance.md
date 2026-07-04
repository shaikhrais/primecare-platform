# SCREEN DATA CONTEXT: clinical_director_performance

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorPerformanceScreen** screen.

---

## 1. Screen Record
* **ID**: `303`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_performance`
* **Screen Name**: `ClinicalDirectorPerformanceScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/performance`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_performance_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorperformancescreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorPerformanceScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorPerformanceScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorPerformanceScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_performance-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_performance-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_performance-content` (Type: layout, Required: 1)
* **clinicaldirectorperformance_screen** -> `clinicaldirectorperformance-screen` (Type: layout, Required: 0)
* **clinicaldirectorperformance_btn_2** -> `clinicaldirectorperformance-btn-2` (Type: button, Required: 0)
* **clinicaldirectorperformance_title** -> `clinicaldirectorperformance-title` (Type: header, Required: 0)
* **clinicaldirectorperformance_btn_1** -> `clinicaldirectorperformance-btn-1` (Type: button, Required: 0)
* **clinicaldirectorperformance_btn_3** -> `clinicaldirectorperformance-btn-3` (Type: button, Required: 0)
* **clinicaldirectorperformance_content** -> `clinicaldirectorperformance-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `311` (Required: 1)
* Component ID: `845` (Required: 1)
* Component ID: `1379` (Required: 1)
* Component ID: `4297` (Required: 1)
* Component ID: `4298` (Required: 1)
* Component ID: `4299` (Required: 1)
* Component ID: `4300` (Required: 1)
* Component ID: `4301` (Required: 1)
* Component ID: `4302` (Required: 1)
* Component ID: `4303` (Required: 1)
* Component ID: `4304` (Required: 1)

## 7. API / Data Mapping
* API ID: `4630` (Required: 1)
* API ID: `4631` (Required: 1)
* API ID: `4632` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_performance_runtime`
* **Test Name**: `ClinicalDirectorPerformanceScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ClinicalDirectorPerformanceScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/performance`)
3. **should_be_visible** (Selector: `clinical_director_performance-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_director_performance-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_director_performance-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
