# SCREEN DATA CONTEXT: site_readiness

Below are the database records from `governance.db` used to configure and build the **Guest - SiteReadinessScreen** screen.

---

## 1. Screen Record
* **ID**: `986`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `site_readiness`
* **Screen Name**: `SiteReadinessScreen`
* **Route Path**: `/generated/site-readiness`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/site_readiness_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to site readiness.`
* **User Story**: `As a Guest, I want to access the Site Readiness within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Site Readiness`
* **Acceptance Criteria**:
- The Site Readiness route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `site_readiness-screen` (Type: layout, Required: 1)
* **page_title** -> `site_readiness-title` (Type: header, Required: 1)
* **primary_content** -> `site_readiness-content` (Type: layout, Required: 1)
* **site_readiness_screen_textfield_input_1** -> `site_readiness_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8372` (Required: 1)
* Component ID: `8373` (Required: 1)
* Component ID: `8374` (Required: 1)
* Component ID: `8375` (Required: 1)
* Component ID: `8376` (Required: 1)

## 7. API / Data Mapping
* API ID: `5434` (Required: 1)
* API ID: `5435` (Required: 1)
* API ID: `5436` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `site_readiness_runtime`
* **Test Name**: `Site Readiness Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Site Readiness`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/site-readiness`)
3. **should_be_visible** (Selector: `site_readiness-screen`, Value: `None`)
4. **should_be_visible** (Selector: `site_readiness-title`, Value: `None`)
5. **should_be_visible** (Selector: `site_readiness-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
