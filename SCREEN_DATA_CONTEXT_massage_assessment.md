# SCREEN DATA CONTEXT: massage_assessment

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - MassageAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `541`
* **App ID**: `5`
* **Role ID**: `3`
* **Screen Code**: `massage_assessment`
* **Screen Name**: `MassageAssessmentScreen`
* **Route Path**: `/offices/clinical/roles/rmt/massage-assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/massage_assessment_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to massageassessmentscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the MassageAssessmentScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `MassageAssessmentScreen`
* **Acceptance Criteria**:
- The MassageAssessmentScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `massage_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `massage_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `massage_assessment-content` (Type: layout, Required: 1)
* **massageassessment_content** -> `massageassessment-content` (Type: layout, Required: 0)
* **massageassessment_btn_2** -> `massageassessment-btn-2` (Type: button, Required: 0)
* **massageassessment_btn_1** -> `massageassessment-btn-1` (Type: button, Required: 0)
* **massageassessment_title** -> `massageassessment-title` (Type: header, Required: 0)
* **massageassessment_btn_3** -> `massageassessment-btn-3` (Type: button, Required: 0)
* **massageassessment_screen** -> `massageassessment-screen` (Type: layout, Required: 0)
* **massageassessment_loading** -> `massageassessment-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `466` (Required: 1)
* Component ID: `1000` (Required: 1)
* Component ID: `1534` (Required: 1)
* Component ID: `5735` (Required: 1)
* Component ID: `5736` (Required: 1)
* Component ID: `5737` (Required: 1)
* Component ID: `5738` (Required: 1)
* Component ID: `5739` (Required: 1)
* Component ID: `5740` (Required: 1)
* Component ID: `5741` (Required: 1)
* Component ID: `5742` (Required: 1)
* Component ID: `5743` (Required: 1)
* Component ID: `5744` (Required: 1)
* Component ID: `5745` (Required: 1)
* Component ID: `5746` (Required: 1)

## 7. API / Data Mapping
* API ID: `4871` (Required: 1)
* API ID: `4872` (Required: 1)
* API ID: `4873` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `massage_assessment_runtime`
* **Test Name**: `MassageAssessmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Massage Assessment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Massage Assessment`)
4. **click_sidebar_link** (Selector: `None`, Value: `Massage Assessment`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/massage-assessment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
