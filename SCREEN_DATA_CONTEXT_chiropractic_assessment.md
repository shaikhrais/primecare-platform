# SCREEN DATA CONTEXT: chiropractic_assessment

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropracticAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `545`
* **App ID**: `5`
* **Role ID**: `1`
* **Screen Code**: `chiropractic_assessment`
* **Screen Name**: `ChiropracticAssessmentScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/chiropractic-assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractic_assessment_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropracticassessmentscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropracticAssessmentScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropracticAssessmentScreen`
* **Acceptance Criteria**:
- The ChiropracticAssessmentScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractic_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractic_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractic_assessment-content` (Type: layout, Required: 1)
* **chiropracticassessment_title** -> `chiropracticassessment-title` (Type: header, Required: 0)
* **chiropracticassessment_btn_2** -> `chiropracticassessment-btn-2` (Type: button, Required: 0)
* **chiropracticassessment_screen** -> `chiropracticassessment-screen` (Type: layout, Required: 0)
* **chiropracticassessment_content** -> `chiropracticassessment-content` (Type: layout, Required: 0)
* **chiropracticassessment_btn_1** -> `chiropracticassessment-btn-1` (Type: button, Required: 0)
* **chiropracticassessment_btn_3** -> `chiropracticassessment-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `469` (Required: 1)
* Component ID: `1003` (Required: 1)
* Component ID: `1537` (Required: 1)
* Component ID: `5767` (Required: 1)
* Component ID: `5768` (Required: 1)
* Component ID: `5769` (Required: 1)
* Component ID: `5770` (Required: 1)
* Component ID: `5771` (Required: 1)
* Component ID: `5772` (Required: 1)
* Component ID: `5773` (Required: 1)
* Component ID: `5774` (Required: 1)
* Component ID: `5775` (Required: 1)

## 7. API / Data Mapping
* API ID: `4880` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractic_assessment_runtime`
* **Test Name**: `ChiropracticAssessmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractic Assessment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractic Assessment`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractic Assessment`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/chiropractic-assessment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
