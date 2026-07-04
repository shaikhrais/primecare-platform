# SCREEN DATA CONTEXT: consent

Below are the database records from `governance.db` used to configure and build the **Guest - ConsentScreen** screen.

---

## 1. Screen Record
* **ID**: `620`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `consent`
* **Screen Name**: `ConsentScreen`
* **Route Path**: `/generated/consent`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/auth/consent_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to consent.`
* **User Story**: `As a Guest, I want to access the Consent within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Consent`
* **Acceptance Criteria**:
- The Consent route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `consent-screen` (Type: layout, Required: 1)
* **page_title** -> `consent-title` (Type: header, Required: 1)
* **primary_content** -> `consent-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `6410` (Required: 1)
* Component ID: `6411` (Required: 1)
* Component ID: `6412` (Required: 1)
* Component ID: `6413` (Required: 1)

## 7. API / Data Mapping
* API ID: `4973` (Required: 1)
* API ID: `4974` (Required: 1)
* API ID: `4975` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `consent_runtime`
* **Test Name**: `Consent Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Consent`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/consent`)
3. **should_be_visible** (Selector: `consent-screen`, Value: `None`)
4. **should_be_visible** (Selector: `consent-title`, Value: `None`)
5. **should_be_visible** (Selector: `consent-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
