# SCREEN DATA CONTEXT: feature_flag_controller

Below are the database records from `governance.db` used to configure and build the **Guest - FeatureFlagControllerScreen** screen.

---

## 1. Screen Record
* **ID**: `912`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `feature_flag_controller`
* **Screen Name**: `FeatureFlagControllerScreen`
* **Route Path**: `/generated/feature-flag-controller`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/feature_flag_controller.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to feature flag controller.`
* **User Story**: `As a Guest, I want to access the Feature Flag Controller within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Feature Flag Controller`
* **Acceptance Criteria**:
- The Feature Flag Controller route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `feature_flag_controller-screen` (Type: layout, Required: 1)
* **page_title** -> `feature_flag_controller-title` (Type: header, Required: 1)
* **primary_content** -> `feature_flag_controller-content` (Type: layout, Required: 1)
* **feature_flag_controller_iconbutton_button_1** -> `feature_flag_controller_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8011` (Required: 1)
* Component ID: `8012` (Required: 1)
* Component ID: `8013` (Required: 1)
* Component ID: `8014` (Required: 1)

## 7. API / Data Mapping
* API ID: `5332` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `feature_flag_controller_runtime`
* **Test Name**: `Feature Flag Controller Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Feature Flag Controller`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/feature-flag-controller`)
3. **should_be_visible** (Selector: `feature_flag_controller-screen`, Value: `None`)
4. **should_be_visible** (Selector: `feature_flag_controller-title`, Value: `None`)
5. **should_be_visible** (Selector: `feature_flag_controller-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
