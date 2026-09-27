# SCREEN DATA CONTEXT: mfa

Below are the database records from `governance.db` used to configure and build the **Guest - MfaScreen** screen.

---

## 1. Screen Record
* **ID**: `949`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `mfa`
* **Screen Name**: `MfaScreen`
* **Route Path**: `/generated/mfa`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/auth/mfa_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to mfa.`
* **User Story**: `As a Guest, I want to access the Mfa within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Mfa`
* **Acceptance Criteria**:
- The Mfa route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `mfa-screen` (Type: layout, Required: 1)
* **page_title** -> `mfa-title` (Type: header, Required: 1)
* **primary_content** -> `mfa-content` (Type: layout, Required: 1)
* **mfa_view_elevatedbutton_button_1** -> `mfa_view_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8177` (Required: 1)
* Component ID: `8178` (Required: 1)
* Component ID: `8179` (Required: 1)
* Component ID: `8180` (Required: 1)
* Component ID: `8181` (Required: 1)

## 7. API / Data Mapping
* API ID: `5385` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `mfa_runtime`
* **Test Name**: `Mfa Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Mfa`
* **Expected Layout**: `dashboard`

### Test Steps
1. **visit** (Selector: `None`, Value: `/generated/mfa`)
2. **should_be_visible** (Selector: `mfa-screen`, Value: `None`)
3. **should_be_visible** (Selector: `mfa-title`, Value: `None`)
4. **should_be_visible** (Selector: `mfa-content`, Value: `None`)
5. **check_no_console_error** (Selector: `None`, Value: `None`)
6. **screenshot** (Selector: `None`, Value: `None`)
