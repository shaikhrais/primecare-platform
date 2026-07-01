# SCREEN DATA CONTEXT: clinical_director_staffing

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalDirectorStaffingScreen** screen.

---

## 1. Screen Record
* **ID**: `680`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_director_staffing`
* **Screen Name**: `ClinicalDirectorStaffingScreen`
* **Route Path**: `/generated/clinical-director-staffing`
* **Actual File Path**: `apps/primecare_clinic/lib/features/generated_screens/clinical_director_staffing_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical director staffing.`
* **User Story**: `As a Guest, I want to access the Clinical Director Staffing within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Director Staffing`
* **Acceptance Criteria**:
- The Clinical Director Staffing route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_staffing-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_staffing-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_staffing-content` (Type: layout, Required: 1)
* **clinicaldirectorstaffingscreen_screen** -> `clinicaldirectorstaffingscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6735` (Required: 1)
* Component ID: `6736` (Required: 1)
* Component ID: `6737` (Required: 1)
* Component ID: `6738` (Required: 1)
* Component ID: `6739` (Required: 1)

## 7. API / Data Mapping
* API ID: `5042` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_staffing_runtime`
* **Test Name**: `Clinical Director Staffing Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Staffing`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Director Staffing`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Director Staffing`)
5. **check_url** (Selector: `None`, Value: `/generated/clinical-director-staffing`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
