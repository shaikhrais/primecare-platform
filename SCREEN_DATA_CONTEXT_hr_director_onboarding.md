# SCREEN DATA CONTEXT: hr_director_onboarding

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorOnboardingScreen** screen.

---

## 1. Screen Record
* **ID**: `314`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_onboarding`
* **Screen Name**: `HrDirectorOnboardingScreen`
* **Route Path**: `/executive/hr-director-onboarding`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_onboarding_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectoronboardingscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorOnboardingScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorOnboardingScreen`
* **Acceptance Criteria**:
- The HrDirectorOnboardingScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_onboarding-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_onboarding-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_onboarding-content` (Type: layout, Required: 1)
* **hrdirectoronboarding_btn_1** -> `hrdirectoronboarding-btn-1` (Type: button, Required: 0)
* **hrdirectoronboarding_screen** -> `hrdirectoronboarding-screen` (Type: layout, Required: 0)
* **hrdirectoronboarding_content** -> `hrdirectoronboarding-content` (Type: layout, Required: 0)
* **hrdirectoronboarding_title** -> `hrdirectoronboarding-title` (Type: header, Required: 0)
* **hrdirectoronboarding_btn_3** -> `hrdirectoronboarding-btn-3` (Type: button, Required: 0)
* **hrdirectoronboarding_btn_2** -> `hrdirectoronboarding-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `322` (Required: 1)
* Component ID: `856` (Required: 1)
* Component ID: `1390` (Required: 1)
* Component ID: `4407` (Required: 1)
* Component ID: `4408` (Required: 1)
* Component ID: `4409` (Required: 1)
* Component ID: `4410` (Required: 1)
* Component ID: `4411` (Required: 1)
* Component ID: `4412` (Required: 1)
* Component ID: `4413` (Required: 1)
* Component ID: `4414` (Required: 1)
* Component ID: `4415` (Required: 1)

## 7. API / Data Mapping
* API ID: `4643` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_onboarding_runtime`
* **Test Name**: `HrDirectorOnboardingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrDirectorOnboardingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **visit** (Selector: `None`, Value: `/executive/hr-director-onboarding`)
3. **should_be_visible** (Selector: `hr_director_onboarding-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_director_onboarding-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_director_onboarding-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
