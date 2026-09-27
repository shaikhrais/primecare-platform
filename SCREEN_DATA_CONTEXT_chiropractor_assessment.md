# SCREEN DATA CONTEXT: chiropractor_assessment

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorAssessmentScreen** screen.

---

## 1. Screen Record
* **ID**: `293`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_assessment`
* **Screen Name**: `ChiropractorAssessmentScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/assessment`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_assessment_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorassessmentscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorAssessmentScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorAssessmentScreen`
* **Acceptance Criteria**:
- The ChiropractorAssessmentScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_assessment-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_assessment-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_assessment-content` (Type: layout, Required: 1)
* **chiropractorassessment_screen** -> `chiropractorassessment-screen` (Type: layout, Required: 0)
* **chiropractorassessment_content** -> `chiropractorassessment-content` (Type: layout, Required: 0)
* **chiropractorassessment_btn_2** -> `chiropractorassessment-btn-2` (Type: button, Required: 0)
* **chiropractorassessment_btn_1** -> `chiropractorassessment-btn-1` (Type: button, Required: 0)
* **chiropractorassessment_btn_3** -> `chiropractorassessment-btn-3` (Type: button, Required: 0)
* **chiropractorassessment_title** -> `chiropractorassessment-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `301` (Required: 1)
* Component ID: `835` (Required: 1)
* Component ID: `1369` (Required: 1)
* Component ID: `4202` (Required: 1)
* Component ID: `4203` (Required: 1)
* Component ID: `4204` (Required: 1)
* Component ID: `4205` (Required: 1)
* Component ID: `4206` (Required: 1)
* Component ID: `4207` (Required: 1)
* Component ID: `4208` (Required: 1)
* Component ID: `4209` (Required: 1)

## 7. API / Data Mapping
* API ID: `4618` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_assessment_runtime`
* **Test Name**: `ChiropractorAssessmentScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ChiropractorAssessmentScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/assessment`)
3. **should_be_visible** (Selector: `chiropractor_assessment-screen`, Value: `None`)
4. **should_be_visible** (Selector: `chiropractor_assessment-title`, Value: `None`)
5. **should_be_visible** (Selector: `chiropractor_assessment-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
