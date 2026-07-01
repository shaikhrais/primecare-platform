# SCREEN DATA CONTEXT: onboarding

Below are the database records from `governance.db` used to configure and build the **HR Director - OnboardingScreen** screen.

---

## 1. Screen Record
* **ID**: `494`
* **App ID**: `5`
* **Role ID**: `27`
* **Screen Code**: `onboarding`
* **Screen Name**: `OnboardingScreen`
* **Route Path**: `/management/onboarding`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/onboarding_screen.dart`
* **Stage/Status**: `production_ready`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to onboardingscreen.`
* **User Story**: `As a HR Director, I want to access the OnboardingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OnboardingScreen`
* **Acceptance Criteria**:
- The OnboardingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `onboarding-screen` (Type: layout, Required: 1)
* **page_title** -> `onboarding-title` (Type: header, Required: 1)
* **primary_content** -> `onboarding-content` (Type: layout, Required: 1)
* **onboarding_btn_3** -> `onboarding-btn-3` (Type: button, Required: 0)
* **onboarding_btn_1** -> `onboarding-btn-1` (Type: button, Required: 0)
* **onboarding_loading** -> `onboarding-loading` (Type: loading, Required: 0)
* **onboarding_btn_2** -> `onboarding-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `423` (Required: 1)
* Component ID: `957` (Required: 1)
* Component ID: `1491` (Required: 1)
* Component ID: `5323` (Required: 1)
* Component ID: `5324` (Required: 1)
* Component ID: `5325` (Required: 1)
* Component ID: `5326` (Required: 1)
* Component ID: `5327` (Required: 1)
* Component ID: `5328` (Required: 1)
* Component ID: `5329` (Required: 1)
* Component ID: `5330` (Required: 1)
* Component ID: `5331` (Required: 1)
* Component ID: `5332` (Required: 1)

## 7. API / Data Mapping
* API ID: `4811` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `onboarding_runtime`
* **Test Name**: `OnboardingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Onboarding`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Onboarding`)
4. **click_sidebar_link** (Selector: `None`, Value: `Onboarding`)
5. **check_url** (Selector: `None`, Value: `/management/onboarding`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
