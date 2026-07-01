# SCREEN DATA CONTEXT: physiotherapist_assessment

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `338`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_assessment`
* **Screen Name**: `PhysiotherapistAssessmentScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_assessment_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistassessmentscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistAssessmentScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistAssessmentScreen`
* **Acceptance Criteria**:
- The PhysiotherapistAssessmentScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_assessment-content` (Type: layout, Required: 1)
* **physiotherapistassessment_btn_1** -> `physiotherapistassessment-btn-1` (Type: button, Required: 0)
* **physiotherapistassessment_screen** -> `physiotherapistassessment-screen` (Type: layout, Required: 0)
* **physiotherapistassessment_content** -> `physiotherapistassessment-content` (Type: layout, Required: 0)
* **physiotherapistassessment_title** -> `physiotherapistassessment-title` (Type: header, Required: 0)
* **physiotherapistassessment_btn_2** -> `physiotherapistassessment-btn-2` (Type: button, Required: 0)
* **physiotherapistassessment_btn_3** -> `physiotherapistassessment-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `346` (Required: 1)
* Component ID: `880` (Required: 1)
* Component ID: `1414` (Required: 1)
* Component ID: `4586` (Required: 1)
* Component ID: `4587` (Required: 1)
* Component ID: `4588` (Required: 1)
* Component ID: `4589` (Required: 1)
* Component ID: `4590` (Required: 1)
* Component ID: `4591` (Required: 1)
* Component ID: `4592` (Required: 1)
* Component ID: `4593` (Required: 1)

## 7. API / Data Mapping
* API ID: `4669` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_assessment_runtime`
* **Test Name**: `PhysiotherapistAssessmentScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Assessment`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Assessment`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Assessment`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/assessment`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
