# SCREEN DATA CONTEXT: rmt_assessment

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `355`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_assessment`
* **Screen Name**: `RmtAssessmentScreen`
* **Route Path**: `/offices/clinical/roles/rmt/assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_assessment_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtassessmentscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtAssessmentScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtAssessmentScreen`
* **Acceptance Criteria**:
- The RmtAssessmentScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_assessment-content` (Type: layout, Required: 1)
* **rmtassessment_btn_3** -> `rmtassessment-btn-3` (Type: button, Required: 0)
* **rmtassessment_btn_2** -> `rmtassessment-btn-2` (Type: button, Required: 0)
* **rmtassessment_btn_1** -> `rmtassessment-btn-1` (Type: button, Required: 0)
* **rmtassessment_content** -> `rmtassessment-content` (Type: layout, Required: 0)
* **rmtassessment_loading** -> `rmtassessment-loading` (Type: loading, Required: 0)
* **rmtassessment_title** -> `rmtassessment-title` (Type: header, Required: 0)
* **rmtassessment_screen** -> `rmtassessment-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `361` (Required: 1)
* Component ID: `895` (Required: 1)
* Component ID: `1429` (Required: 1)
* Component ID: `4728` (Required: 1)
* Component ID: `4729` (Required: 1)
* Component ID: `4730` (Required: 1)
* Component ID: `4731` (Required: 1)
* Component ID: `4732` (Required: 1)
* Component ID: `4733` (Required: 1)
* Component ID: `4734` (Required: 1)
* Component ID: `4735` (Required: 1)
* Component ID: `4736` (Required: 1)
* Component ID: `4737` (Required: 1)

## 7. API / Data Mapping
* API ID: `4692` (Required: 1)
* API ID: `4693` (Required: 1)
* API ID: `4694` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_assessment_runtime`
* **Test Name**: `RmtAssessmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Assessment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Assessment`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Assessment`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/assessment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
