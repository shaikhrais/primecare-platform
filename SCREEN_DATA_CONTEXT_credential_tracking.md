# SCREEN DATA CONTEXT: credential_tracking

Below are the database records from `governance.db` used to configure and build the **Guest - CredentialTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `725`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `credential_tracking`
* **Screen Name**: `CredentialTrackingScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/credential-tracking`
* **Actual File Path**: `apps/primecare_corporate/lib/features/compliance/screens/credential_tracking_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to credential tracking.`
* **User Story**: `As a Guest, I want to access the Credential Tracking within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Credential Tracking`
* **Acceptance Criteria**:
- The Credential Tracking route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `credential_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `credential_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `credential_tracking-content` (Type: layout, Required: 1)
* **credentialtrackingscreen_screen** -> `credentialtrackingscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6980` (Required: 1)
* Component ID: `6981` (Required: 1)
* Component ID: `6982` (Required: 1)
* Component ID: `6983` (Required: 1)
* Component ID: `6984` (Required: 1)

## 7. API / Data Mapping
* API ID: `5103` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `credential_tracking_runtime`
* **Test Name**: `Credential Tracking Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Credential Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Credential Tracking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Credential Tracking`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/credential-tracking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
