# SCREEN DATA CONTEXT: clinical_director_incident_review

Below are the database records from `governance.db` used to configure and build the **Clinical Director - ClinicalDirectorIncidentReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `299`
* **App ID**: `6`
* **Role ID**: `6`
* **Screen Code**: `clinical_director_incident_review`
* **Screen Name**: `ClinicalDirectorIncidentReviewScreen`
* **Route Path**: `/offices/clinical/roles/clinical_director/incident-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_incident_review_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Director personnel to oversee, audit, and coordinate operations related to clinicaldirectorincidentreviewscreen.`
* **User Story**: `As a Clinical Director, I want to access the ClinicalDirectorIncidentReviewScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ClinicalDirectorIncidentReviewScreen`
* **Acceptance Criteria**:
- The ClinicalDirectorIncidentReviewScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_director_incident_review-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_director_incident_review-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_director_incident_review-content` (Type: layout, Required: 1)
* **clinicaldirectorincidentreview_title** -> `clinicaldirectorincidentreview-title` (Type: header, Required: 0)
* **clinicaldirectorincidentreview_content** -> `clinicaldirectorincidentreview-content` (Type: layout, Required: 0)
* **clinicaldirectorincidentreview_btn_1** -> `clinicaldirectorincidentreview-btn-1` (Type: button, Required: 0)
* **clinicaldirectorincidentreview_btn_2** -> `clinicaldirectorincidentreview-btn-2` (Type: button, Required: 0)
* **clinicaldirectorincidentreview_screen** -> `clinicaldirectorincidentreview-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `307` (Required: 1)
* Component ID: `841` (Required: 1)
* Component ID: `1375` (Required: 1)
* Component ID: `4259` (Required: 1)
* Component ID: `4260` (Required: 1)
* Component ID: `4261` (Required: 1)
* Component ID: `4262` (Required: 1)
* Component ID: `4263` (Required: 1)
* Component ID: `4264` (Required: 1)
* Component ID: `4265` (Required: 1)
* Component ID: `4266` (Required: 1)
* Component ID: `4267` (Required: 1)
* Component ID: `4268` (Required: 1)

## 7. API / Data Mapping
* API ID: `4626` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_director_incident_review_runtime`
* **Test Name**: `ClinicalDirectorIncidentReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Director Incident Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `clinical_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Clinical Director Incident Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Clinical Director Incident Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/clinical_director/incident-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
