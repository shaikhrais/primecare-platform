# SCREEN DATA CONTEXT: chiropractor_client_intake

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorClientIntakeScreen** screen.

---

## 1. Screen Record
* **ID**: `292`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_client_intake`
* **Screen Name**: `ChiropractorClientIntakeScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/client-intake`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_client_intake_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorclientintakescreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorClientIntakeScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorClientIntakeScreen`
* **Acceptance Criteria**:
- The ChiropractorClientIntakeScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_client_intake-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_client_intake-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_client_intake-content` (Type: layout, Required: 1)
* **chiropractorclientintake_content** -> `chiropractorclientintake-content` (Type: layout, Required: 0)
* **chiropractorclientintake_btn_2** -> `chiropractorclientintake-btn-2` (Type: button, Required: 0)
* **chiropractorclientintake_btn_3** -> `chiropractorclientintake-btn-3` (Type: button, Required: 0)
* **chiropractorclientintake_screen** -> `chiropractorclientintake-screen` (Type: layout, Required: 0)
* **chiropractorclientintake_title** -> `chiropractorclientintake-title` (Type: header, Required: 0)
* **chiropractorclientintake_btn_1** -> `chiropractorclientintake-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `300` (Required: 1)
* Component ID: `834` (Required: 1)
* Component ID: `1368` (Required: 1)
* Component ID: `4192` (Required: 1)
* Component ID: `4193` (Required: 1)
* Component ID: `4194` (Required: 1)
* Component ID: `4195` (Required: 1)
* Component ID: `4196` (Required: 1)
* Component ID: `4197` (Required: 1)
* Component ID: `4198` (Required: 1)
* Component ID: `4199` (Required: 1)
* Component ID: `4200` (Required: 1)
* Component ID: `4201` (Required: 1)

## 7. API / Data Mapping
* API ID: `4615` (Required: 1)
* API ID: `4616` (Required: 1)
* API ID: `4617` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_client_intake_runtime`
* **Test Name**: `ChiropractorClientIntakeScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Client Intake`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Client Intake`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Client Intake`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/client-intake`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
