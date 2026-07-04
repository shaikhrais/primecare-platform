# SCREEN DATA CONTEXT: clinical_trial_recruitment_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ClinicalTrialRecruitmentDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1010`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `clinical_trial_recruitment_dashboard`
* **Screen Name**: `ClinicalTrialRecruitmentDashboardScreen`
* **Route Path**: `/generated/clinical-trial-recruitment-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/research/clinical_trial_recruitment_dashboard.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to clinical trial recruitment dashboard.`
* **User Story**: `As a Guest, I want to access the Clinical Trial Recruitment Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Clinical Trial Recruitment Dashboard`
* **Acceptance Criteria**:
- The Clinical Trial Recruitment Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `clinical_trial_recruitment_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `clinical_trial_recruitment_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `clinical_trial_recruitment_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8539` (Required: 1)
* Component ID: `8540` (Required: 1)
* Component ID: `8541` (Required: 1)
* Component ID: `8542` (Required: 1)
* Component ID: `8543` (Required: 1)

## 7. API / Data Mapping
* API ID: `5474` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `clinical_trial_recruitment_dashboard_runtime`
* **Test Name**: `Clinical Trial Recruitment Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Clinical Trial Recruitment Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/clinical-trial-recruitment-dashboard`)
3. **should_be_visible** (Selector: `clinical_trial_recruitment_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `clinical_trial_recruitment_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `clinical_trial_recruitment_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
