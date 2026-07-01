# SCREEN DATA CONTEXT: chiropractor_command_center

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `290`
* **App ID**: `6`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_command_center`
* **Screen Name**: `ChiropractorCommandCenterScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_command_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractorcommandcenterscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorCommandCenterScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorCommandCenterScreen`
* **Acceptance Criteria**:
- The ChiropractorCommandCenterScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_command_center-content` (Type: layout, Required: 1)
* **chiropractorcommandcenter_screen** -> `chiropractorcommandcenter-screen` (Type: layout, Required: 0)
* **chiropractorcommandcenter_title** -> `chiropractorcommandcenter-title` (Type: header, Required: 0)
* **chiropractorcommandcenter_btn_1** -> `chiropractorcommandcenter-btn-1` (Type: button, Required: 0)
* **chiropractorcommandcenter_btn_2** -> `chiropractorcommandcenter-btn-2` (Type: button, Required: 0)
* **chiropractorcommandcenter_btn_3** -> `chiropractorcommandcenter-btn-3` (Type: button, Required: 0)
* **chiropractorcommandcenter_content** -> `chiropractorcommandcenter-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `298` (Required: 1)
* Component ID: `832` (Required: 1)
* Component ID: `1366` (Required: 1)
* Component ID: `4169` (Required: 1)
* Component ID: `4170` (Required: 1)
* Component ID: `4171` (Required: 1)
* Component ID: `4172` (Required: 1)
* Component ID: `4173` (Required: 1)
* Component ID: `4174` (Required: 1)
* Component ID: `4175` (Required: 1)
* Component ID: `4176` (Required: 1)
* Component ID: `4177` (Required: 1)
* Component ID: `4178` (Required: 1)
* Component ID: `4179` (Required: 1)
* Component ID: `4180` (Required: 1)
* Component ID: `4181` (Required: 1)
* Component ID: `4182` (Required: 1)
* Component ID: `4183` (Required: 1)

## 7. API / Data Mapping
* API ID: `4613` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_command_center_runtime`
* **Test Name**: `ChiropractorCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Command Center`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
