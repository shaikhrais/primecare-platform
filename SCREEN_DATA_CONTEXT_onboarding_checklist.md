# SCREEN DATA CONTEXT: onboarding_checklist

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - OnboardingChecklistScreen** screen.

---

## 1. Screen Record
* **ID**: `523`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `onboarding_checklist`
* **Screen Name**: `OnboardingChecklistScreen`
* **Route Path**: `/staff/onboarding-checklist`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/onboarding_checklist_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to onboardingchecklistscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the OnboardingChecklistScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OnboardingChecklistScreen`
* **Acceptance Criteria**:
- The OnboardingChecklistScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `onboarding_checklist-screen` (Type: layout, Required: 1)
* **page_title** -> `onboarding_checklist-title` (Type: header, Required: 1)
* **primary_content** -> `onboarding_checklist-content` (Type: layout, Required: 1)
* **onboardingchecklist_btn_3** -> `onboardingchecklist-btn-3` (Type: button, Required: 0)
* **onboardingchecklist_title** -> `onboardingchecklist-title` (Type: header, Required: 0)
* **onboardingchecklist_btn_2** -> `onboardingchecklist-btn-2` (Type: button, Required: 0)
* **onboardingchecklist_btn_5** -> `onboardingchecklist-btn-5` (Type: button, Required: 0)
* **onboardingchecklist_screen** -> `onboardingchecklist-screen` (Type: layout, Required: 0)
* **onboardingchecklist_content** -> `onboardingchecklist-content` (Type: layout, Required: 0)
* **onboardingchecklist_btn_1** -> `onboardingchecklist-btn-1` (Type: button, Required: 0)
* **onboardingchecklist_btn_4** -> `onboardingchecklist-btn-4` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `452` (Required: 1)
* Component ID: `986` (Required: 1)
* Component ID: `1520` (Required: 1)
* Component ID: `5605` (Required: 1)
* Component ID: `5606` (Required: 1)
* Component ID: `5607` (Required: 1)
* Component ID: `5608` (Required: 1)
* Component ID: `5609` (Required: 1)
* Component ID: `5610` (Required: 1)
* Component ID: `5611` (Required: 1)
* Component ID: `5612` (Required: 1)

## 7. API / Data Mapping
* API ID: `4839` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `onboarding_checklist_runtime`
* **Test Name**: `OnboardingChecklistScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OnboardingChecklistScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/staff/onboarding-checklist`)
3. **should_be_visible** (Selector: `onboarding_checklist-screen`, Value: `None`)
4. **should_be_visible** (Selector: `onboarding_checklist-title`, Value: `None`)
5. **should_be_visible** (Selector: `onboarding_checklist-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
