# SCREEN DATA CONTEXT: credential_expiry

Below are the database records from `governance.db` used to configure and build the **HR Director - CredentialExpiryScreen** screen.

---

## 1. Screen Record
* **ID**: `492`
* **App ID**: `5`
* **Role ID**: `27`
* **Screen Code**: `credential_expiry`
* **Screen Name**: `CredentialExpiryScreen`
* **Route Path**: `/management/credential-expiry`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/credential_expiry_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable HR Director personnel to oversee, audit, and coordinate operations related to credentialexpiryscreen.`
* **User Story**: `As a HR Director, I want to access the CredentialExpiryScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CredentialExpiryScreen`
* **Acceptance Criteria**:
- The CredentialExpiryScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `credential_expiry-screen` (Type: layout, Required: 1)
* **page_title** -> `credential_expiry-title` (Type: header, Required: 1)
* **primary_content** -> `credential_expiry-content` (Type: layout, Required: 1)
* **credentialexpiry_content** -> `credentialexpiry-content` (Type: layout, Required: 0)
* **credentialexpiry_btn_1** -> `credentialexpiry-btn-1` (Type: button, Required: 0)
* **credentialexpiry_btn_2** -> `credentialexpiry-btn-2` (Type: button, Required: 0)
* **credentialexpiry_btn_3** -> `credentialexpiry-btn-3` (Type: button, Required: 0)
* **credentialexpiry_title** -> `credentialexpiry-title` (Type: header, Required: 0)
* **credentialexpiry_loading** -> `credentialexpiry-loading` (Type: loading, Required: 0)
* **credentialexpiry_screen** -> `credentialexpiry-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `421` (Required: 1)
* Component ID: `955` (Required: 1)
* Component ID: `1489` (Required: 1)
* Component ID: `5303` (Required: 1)
* Component ID: `5304` (Required: 1)
* Component ID: `5305` (Required: 1)
* Component ID: `5306` (Required: 1)
* Component ID: `5307` (Required: 1)
* Component ID: `5308` (Required: 1)
* Component ID: `5309` (Required: 1)
* Component ID: `5310` (Required: 1)
* Component ID: `5311` (Required: 1)
* Component ID: `5312` (Required: 1)

## 7. API / Data Mapping
* API ID: `4809` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `credential_expiry_runtime`
* **Test Name**: `CredentialExpiryScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Credential Expiry`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Credential Expiry`)
4. **click_sidebar_link** (Selector: `None`, Value: `Credential Expiry`)
5. **check_url** (Selector: `None`, Value: `/management/credential-expiry`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
