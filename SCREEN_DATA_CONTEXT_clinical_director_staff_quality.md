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
* **Test Name**: `ClinicalDirectorStaffQualityScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Staff Quality`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Director Staff Quality`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Director Staff Quality`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/staff-quality`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
