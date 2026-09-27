# SCREEN DATA CONTEXT: hr_hiring_applicants

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringApplicantsScreen** screen.

---

## 1. Screen Record
* **ID**: `315`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_applicants`
* **Screen Name**: `HrHiringApplicantsScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/applicants`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_applicants_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `45`
* **Role Code**: `hr_hiring`
* **Role Name**: `Talent Acquisition Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringapplicantsscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringApplicantsScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringApplicantsScreen`
* **Acceptance Criteria**:
- The HrHiringApplicantsScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_applicants-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_applicants-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_applicants-content` (Type: layout, Required: 1)
* **hrhiringapplicants_content** -> `hrhiringapplicants-content` (Type: layout, Required: 0)
* **hrhiringapplicants_btn_1** -> `hrhiringapplicants-btn-1` (Type: button, Required: 0)
* **hrhiringapplicants_btn_4** -> `hrhiringapplicants-btn-4` (Type: button, Required: 0)
* **hrhiringapplicants_title** -> `hrhiringapplicants-title` (Type: header, Required: 0)
* **hrhiringapplicants_btn_3** -> `hrhiringapplicants-btn-3` (Type: button, Required: 0)
* **hrhiringapplicants_btn_5** -> `hrhiringapplicants-btn-5` (Type: button, Required: 0)
* **hrhiringapplicants_screen** -> `hrhiringapplicants-screen` (Type: layout, Required: 0)
* **hrhiringapplicants_btn_2** -> `hrhiringapplicants-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `323` (Required: 1)
* Component ID: `857` (Required: 1)
* Component ID: `1391` (Required: 1)
* Component ID: `4416` (Required: 1)
* Component ID: `4417` (Required: 1)
* Component ID: `4418` (Required: 1)
* Component ID: `4419` (Required: 1)
* Component ID: `4420` (Required: 1)
* Component ID: `4421` (Required: 1)
* Component ID: `4422` (Required: 1)
* Component ID: `4423` (Required: 1)
* Component ID: `4424` (Required: 1)

## 7. API / Data Mapping
* API ID: `4644` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_applicants_runtime`
* **Test Name**: `HrHiringApplicantsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrHiringApplicantsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/applicants`)
3. **should_be_visible** (Selector: `hr_hiring_applicants-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_hiring_applicants-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_hiring_applicants-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
