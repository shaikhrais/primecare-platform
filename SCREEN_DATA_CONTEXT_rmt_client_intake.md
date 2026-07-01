# SCREEN DATA CONTEXT: rmt_client_intake

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtClientIntakeScreen** screen.

---

## 1. Screen Record
* **ID**: `354`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_client_intake`
* **Screen Name**: `RmtClientIntakeScreen`
* **Route Path**: `/offices/clinical/roles/rmt/client-intake`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_client_intake_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtclientintakescreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtClientIntakeScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtClientIntakeScreen`
* **Acceptance Criteria**:
- The RmtClientIntakeScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_client_intake-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_client_intake-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_client_intake-content` (Type: layout, Required: 1)
* **rmtclientintake_btn_2** -> `rmtclientintake-btn-2` (Type: button, Required: 0)
* **rmtclientintake_title** -> `rmtclientintake-title` (Type: header, Required: 0)
* **rmtclientintake_btn_1** -> `rmtclientintake-btn-1` (Type: button, Required: 0)
* **rmtclientintake_btn_3** -> `rmtclientintake-btn-3` (Type: button, Required: 0)
* **rmtclientintake_loading** -> `rmtclientintake-loading` (Type: loading, Required: 0)
* **rmtclientintake_screen** -> `rmtclientintake-screen` (Type: layout, Required: 0)
* **rmtclientintake_content** -> `rmtclientintake-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `360` (Required: 1)
* Component ID: `894` (Required: 1)
* Component ID: `1428` (Required: 1)
* Component ID: `4718` (Required: 1)
* Component ID: `4719` (Required: 1)
* Component ID: `4720` (Required: 1)
* Component ID: `4721` (Required: 1)
* Component ID: `4722` (Required: 1)
* Component ID: `4723` (Required: 1)
* Component ID: `4724` (Required: 1)
* Component ID: `4725` (Required: 1)
* Component ID: `4726` (Required: 1)
* Component ID: `4727` (Required: 1)

## 7. API / Data Mapping
* API ID: `4689` (Required: 1)
* API ID: `4690` (Required: 1)
* API ID: `4691` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_client_intake_runtime`
* **Test Name**: `RmtClientIntakeScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Client Intake`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Client Intake`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Client Intake`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/client-intake`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
