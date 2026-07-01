# SCREEN DATA CONTEXT: hr_director_credential_expiry

Below are the database records from `governance.db` used to configure and build the **HR Director - HrDirectorCredentialExpiryScreen** screen.

---

## 1. Screen Record
* **ID**: `313`
* **App ID**: `7`
* **Role ID**: `27`
* **Screen Code**: `hr_director_credential_expiry`
* **Screen Name**: `HrDirectorCredentialExpiryScreen`
* **Route Path**: `/executive/hr-director-credential-expiry`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/hr_director_credential_expiry_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `27`
* **Role Code**: `hr_director`
* **Role Name**: `HR Director`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable HR Director personnel to oversee, audit, and coordinate operations related to hrdirectorcredentialexpiryscreen.`
* **User Story**: `As a HR Director, I want to access the HrDirectorCredentialExpiryScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HrDirectorCredentialExpiryScreen`
* **Acceptance Criteria**:
- The HrDirectorCredentialExpiryScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only HR Director access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hr_director_credential_expiry-screen` (Type: layout, Required: 1)
* **page_title** -> `hr_director_credential_expiry-title` (Type: header, Required: 1)
* **primary_content** -> `hr_director_credential_expiry-content` (Type: layout, Required: 1)
* **hrdirectorcredentialexpiry_btn_2** -> `hrdirectorcredentialexpiry-btn-2` (Type: button, Required: 0)
* **hrdirectorcredentialexpiry_screen** -> `hrdirectorcredentialexpiry-screen` (Type: layout, Required: 0)
* **hrdirectorcredentialexpiry_btn_3** -> `hrdirectorcredentialexpiry-btn-3` (Type: button, Required: 0)
* **hrdirectorcredentialexpiry_btn_1** -> `hrdirectorcredentialexpiry-btn-1` (Type: button, Required: 0)
* **hrdirectorcredentialexpiry_content** -> `hrdirectorcredentialexpiry-content` (Type: layout, Required: 0)
* **hrdirectorcredentialexpiry_title** -> `hrdirectorcredentialexpiry-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `321` (Required: 1)
* Component ID: `855` (Required: 1)
* Component ID: `1389` (Required: 1)
* Component ID: `4397` (Required: 1)
* Component ID: `4398` (Required: 1)
* Component ID: `4399` (Required: 1)
* Component ID: `4400` (Required: 1)
* Component ID: `4401` (Required: 1)
* Component ID: `4402` (Required: 1)
* Component ID: `4403` (Required: 1)
* Component ID: `4404` (Required: 1)
* Component ID: `4405` (Required: 1)
* Component ID: `4406` (Required: 1)

## 7. API / Data Mapping
* API ID: `4642` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hr_director_credential_expiry_runtime`
* **Test Name**: `HrDirectorCredentialExpiryScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `HR Director Credential Expiry`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hr_director`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `HR Director Credential Expiry`)
4. **click_sidebar_link** (Selector: `None`, Value: `HR Director Credential Expiry`)
5. **check_url** (Selector: `None`, Value: `/executive/hr-director-credential-expiry`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
