# SCREEN DATA CONTEXT: hr_hiring_onboarding

Below are the database records from `governance.db` used to configure and build the **Talent Acquisition Manager - HrHiringOnboardingScreen** screen.

---

## 1. Screen Record
* **ID**: `318`
* **App ID**: `5`
* **Role ID**: `45`
* **Screen Code**: `hr_hiring_onboarding`
* **Screen Name**: `HrHiringOnboardingScreen`
* **Route Path**: `/offices/franchise/roles/hr_hiring/onboarding`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/hr_hiring_onboarding_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Talent Acquisition Manager personnel to oversee, audit, and coordinate operations related to hrhiringonboardingscreen.`
* **User Story**: `As a Talent Acquisition Manager, I want to access the HrHiringOnboardingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrHiringOnboardingScreen`
* **Acceptance Criteria**:
- The HrHiringOnboardingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Talent Acquisition Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_hiring_onboarding-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_hiring_onboarding-title` (Type: header, Required: 1)
* **primary_content** -> `hr_hiring_onboarding-content` (Type: layout, Required: 1)
* **hrhiringonboarding_screen** -> `hrhiringonboarding-screen` (Type: layout, Required: 0)
* **hrhiringonboarding_btn_5** -> `hrhiringonboarding-btn-5` (Type: button, Required: 0)
* **hrhiringonboarding_btn_1** -> `hrhiringonboarding-btn-1` (Type: button, Required: 0)
* **hrhiringonboarding_content** -> `hrhiringonboarding-content` (Type: layout, Required: 0)
* **hrhiringonboarding_title** -> `hrhiringonboarding-title` (Type: header, Required: 0)
* **hrhiringonboarding_btn_4** -> `hrhiringonboarding-btn-4` (Type: button, Required: 0)
* **hrhiringonboarding_btn_2** -> `hrhiringonboarding-btn-2` (Type: button, Required: 0)
* **hrhiringonboarding_btn_3** -> `hrhiringonboarding-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `326` (Required: 1)
* Component ID: `860` (Required: 1)
* Component ID: `1394` (Required: 1)
* Component ID: `4443` (Required: 1)
* Component ID: `4444` (Required: 1)
* Component ID: `4445` (Required: 1)
* Component ID: `4446` (Required: 1)
* Component ID: `4447` (Required: 1)
* Component ID: `4448` (Required: 1)
* Component ID: `4449` (Required: 1)
* Component ID: `4450` (Required: 1)

## 7. API / Data Mapping
* API ID: `4647` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_hiring_onboarding_runtime`
* **Test Name**: `HrHiringOnboardingScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HrHiringOnboardingScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_hiring`)
2. **visit** (Selector: `None`, Value: `/offices/franchise/roles/hr_hiring/onboarding`)
3. **should_be_visible** (Selector: `hr_hiring_onboarding-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_hiring_onboarding-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_hiring_onboarding-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
