# SCREEN DATA CONTEXT: sso_redirect

Below are the database records from `governance.db` used to configure and build the **Guest - SsoRedirectScreen** screen.

---

## 1. Screen Record
* **ID**: `900`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `sso_redirect`
* **Screen Name**: `SsoRedirectScreen`
* **Route Path**: `/generated/sso-redirect`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/sso_redirect_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to sso redirect.`
* **User Story**: `As a Guest, I want to access the Sso Redirect within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Sso Redirect`
* **Acceptance Criteria**:
- The Sso Redirect route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `sso_redirect-screen` (Type: layout, Required: 1)
* **page_title** -> `sso_redirect-title` (Type: header, Required: 1)
* **primary_content** -> `sso_redirect-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7954` (Required: 1)
* Component ID: `7955` (Required: 1)
* Component ID: `7956` (Required: 1)
* Component ID: `7957` (Required: 1)

## 7. API / Data Mapping
* API ID: `5314` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `sso_redirect_runtime`
* **Test Name**: `Sso Redirect Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Sso Redirect`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Sso Redirect`)
4. **click_sidebar_link** (Selector: `None`, Value: `Sso Redirect`)
5. **check_url** (Selector: `None`, Value: `/generated/sso-redirect`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
