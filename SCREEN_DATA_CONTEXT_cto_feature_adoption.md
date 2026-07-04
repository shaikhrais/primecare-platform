# SCREEN DATA CONTEXT: cto_feature_adoption

Below are the database records from `governance.db` used to configure and build the **Guest - CtoFeatureAdoptionScreen** screen.

---

## 1. Screen Record
* **ID**: `749`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_feature_adoption`
* **Screen Name**: `CtoFeatureAdoptionScreen`
* **Route Path**: `/offices/corporate/roles/cto/feature-adoption`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_feature_adoption_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto feature adoption.`
* **User Story**: `As a Guest, I want to access the Cto Feature Adoption within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Feature Adoption`
* **Acceptance Criteria**:
- The Cto Feature Adoption route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_feature_adoption-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_feature_adoption-title` (Type: header, Required: 1)
* **primary_content** -> `cto_feature_adoption-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7113` (Required: 1)
* Component ID: `7114` (Required: 1)
* Component ID: `7115` (Required: 1)
* Component ID: `7116` (Required: 1)
* Component ID: `7117` (Required: 1)
* Component ID: `7118` (Required: 1)

## 7. API / Data Mapping
* API ID: `5137` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_feature_adoption_runtime`
* **Test Name**: `Cto Feature Adoption Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Feature Adoption`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/feature-adoption`)
3. **should_be_visible** (Selector: `cto_feature_adoption-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_feature_adoption-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_feature_adoption-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
