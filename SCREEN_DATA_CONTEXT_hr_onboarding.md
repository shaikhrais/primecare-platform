# SCREEN DATA CONTEXT: hr_onboarding

Below are the database records from `governance.db` used to configure and build the **Guest - HrOnboardingScreen** screen.

---

## 1. Screen Record
* **ID**: `965`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `hr_onboarding`
* **Screen Name**: `HrOnboardingScreen`
* **Route Path**: `/generated/hr-onboarding`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/generated_screens/hr_onboarding_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to hr onboarding.`
* **User Story**: `As a Guest, I want to access the Hr Onboarding within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Hr Onboarding`
* **Acceptance Criteria**:
- The Hr Onboarding route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_onboarding-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_onboarding-title` (Type: header, Required: 1)
* **primary_content** -> `hr_onboarding-content` (Type: layout, Required: 1)
* **hr_onboarding_screen_elevatedbutton_button_1** -> `hr_onboarding_screen_elevatedbutton_button_1` (Type: button, Required: 0)
* **hr_onboarding_screen_iconbutton_button_1** -> `hr_onboarding_screen_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8260` (Required: 1)
* Component ID: `8261` (Required: 1)
* Component ID: `8262` (Required: 1)
* Component ID: `8263` (Required: 1)
* Component ID: `8264` (Required: 1)
* Component ID: `8265` (Required: 1)
* Component ID: `8266` (Required: 1)

## 7. API / Data Mapping
* API ID: `5403` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_onboarding_runtime`
* **Test Name**: `Hr Onboarding Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Hr Onboarding`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/hr-onboarding`)
3. **should_be_visible** (Selector: `hr_onboarding-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hr_onboarding-title`, Value: `None`)
5. **should_be_visible** (Selector: `hr_onboarding-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
