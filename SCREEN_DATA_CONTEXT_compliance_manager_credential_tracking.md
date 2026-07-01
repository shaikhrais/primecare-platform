# SCREEN DATA CONTEXT: compliance_manager_credential_tracking

Below are the database records from `governance.db` used to configure and build the **Guest - ComplianceManagerCredentialTrackingScreen** screen.

---

## 1. Screen Record
* **ID**: `739`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `compliance_manager_credential_tracking`
* **Screen Name**: `ComplianceManagerCredentialTrackingScreen`
* **Route Path**: `/generated/compliance-manager-credential-tracking`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/compliance_manager_credential_tracking_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to compliance manager credential tracking.`
* **User Story**: `As a Guest, I want to access the Compliance Manager Credential Tracking within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Compliance Manager Credential Tracking`
* **Acceptance Criteria**:
- The Compliance Manager Credential Tracking route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_credential_tracking-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_credential_tracking-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_credential_tracking-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7054` (Required: 1)
* Component ID: `7055` (Required: 1)
* Component ID: `7056` (Required: 1)
* Component ID: `7057` (Required: 1)
* Component ID: `7058` (Required: 1)
* Component ID: `7059` (Required: 1)

## 7. API / Data Mapping
* API ID: `5123` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_credential_tracking_runtime`
* **Test Name**: `Compliance Manager Credential Tracking Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Credential Tracking`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Manager Credential Tracking`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Manager Credential Tracking`)
5. **check_url** (Selector: `None`, Value: `/generated/compliance-manager-credential-tracking`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
