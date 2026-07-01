# SCREEN DATA CONTEXT: rmt_command_center

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `352`
* **App ID**: `6`
* **Role ID**: `3`
* **Screen Code**: `rmt_command_center`
* **Screen Name**: `RmtCommandCenterScreen`
* **Route Path**: `/offices/clinical/roles/rmt/command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_command_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtcommandcenterscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtCommandCenterScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtCommandCenterScreen`
* **Acceptance Criteria**:
- The RmtCommandCenterScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_command_center-content` (Type: layout, Required: 1)
* **rmtcommandcenter_loading** -> `rmtcommandcenter-loading` (Type: loading, Required: 0)
* **rmtcommandcenter_title** -> `rmtcommandcenter-title` (Type: header, Required: 0)
* **rmtcommandcenter_btn_2** -> `rmtcommandcenter-btn-2` (Type: button, Required: 0)
* **rmtcommandcenter_btn_1** -> `rmtcommandcenter-btn-1` (Type: button, Required: 0)
* **rmtcommandcenter_screen** -> `rmtcommandcenter-screen` (Type: layout, Required: 0)
* **rmtcommandcenter_btn_3** -> `rmtcommandcenter-btn-3` (Type: button, Required: 0)
* **rmtcommandcenter_content** -> `rmtcommandcenter-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `358` (Required: 1)
* Component ID: `892` (Required: 1)
* Component ID: `1426` (Required: 1)
* Component ID: `4699` (Required: 1)
* Component ID: `4700` (Required: 1)
* Component ID: `4701` (Required: 1)
* Component ID: `4702` (Required: 1)
* Component ID: `4703` (Required: 1)
* Component ID: `4704` (Required: 1)
* Component ID: `4705` (Required: 1)
* Component ID: `4706` (Required: 1)
* Component ID: `4707` (Required: 1)

## 7. API / Data Mapping
* API ID: `4683` (Required: 1)
* API ID: `4684` (Required: 1)
* API ID: `4685` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_command_center_runtime`
* **Test Name**: `RmtCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Command Center`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
