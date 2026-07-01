# SCREEN DATA CONTEXT: consent_management_console

Below are the database records from `governance.db` used to configure and build the **Guest - ConsentManagementConsoleScreen** screen.

---

## 1. Screen Record
* **ID**: `907`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `consent_management_console`
* **Screen Name**: `ConsentManagementConsoleScreen`
* **Route Path**: `/generated/consent-management-console`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/consent_management_console.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to consent management console.`
* **User Story**: `As a Guest, I want to access the Consent Management Console within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Consent Management Console`
* **Acceptance Criteria**:
- The Consent Management Console route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `consent_management_console-screen` (Type: layout, Required: 1)
* **page_title** -> `consent_management_console-title` (Type: header, Required: 1)
* **primary_content** -> `consent_management_console-content` (Type: layout, Required: 1)
* **consent_management_console_outlinedbutton_button_1** -> `consent_management_console_outlinedbutton_button_1` (Type: button, Required: 0)
* **consent_management_console_iconbutton_button_1** -> `consent_management_console_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7990` (Required: 1)
* Component ID: `7991` (Required: 1)
* Component ID: `7992` (Required: 1)
* Component ID: `7993` (Required: 1)

## 7. API / Data Mapping
* API ID: `5325` (Required: 1)
* API ID: `5326` (Required: 1)
* API ID: `5327` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `consent_management_console_runtime`
* **Test Name**: `Consent Management Console Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Consent Management Console`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Consent Management Console`)
4. **click_sidebar_link** (Selector: `None`, Value: `Consent Management Console`)
5. **check_url** (Selector: `None`, Value: `/generated/consent-management-console`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
