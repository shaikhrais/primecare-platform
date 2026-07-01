# SCREEN DATA CONTEXT: cto_system_verification

Below are the database records from `governance.db` used to configure and build the **Guest - CtoSystemVerificationScreen** screen.

---

## 1. Screen Record
* **ID**: `757`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_system_verification`
* **Screen Name**: `CtoSystemVerificationScreen`
* **Route Path**: `/offices/corporate/roles/cto/system-verification`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_system_verification_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto system verification.`
* **User Story**: `As a Guest, I want to access the Cto System Verification within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto System Verification`
* **Acceptance Criteria**:
- The Cto System Verification route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_system_verification-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_system_verification-title` (Type: header, Required: 1)
* **primary_content** -> `cto_system_verification-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7158` (Required: 1)
* Component ID: `7159` (Required: 1)
* Component ID: `7160` (Required: 1)
* Component ID: `7161` (Required: 1)
* Component ID: `7162` (Required: 1)

## 7. API / Data Mapping
* API ID: `5147` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_system_verification_runtime`
* **Test Name**: `Cto System Verification Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `CTO System Verification`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `CTO System Verification`)
4. **click_sidebar_link** (Selector: `None`, Value: `CTO System Verification`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/cto/system-verification`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
