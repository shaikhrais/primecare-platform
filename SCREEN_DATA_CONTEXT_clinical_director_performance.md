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
* **Stage/Status**: `wired`

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
* **Test Name**: `ClinicalDirectorPerformanceScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Performance`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Director Performance`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Director Performance`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/performance`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
