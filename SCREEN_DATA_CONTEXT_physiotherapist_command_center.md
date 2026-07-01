# SCREEN DATA CONTEXT: physiotherapist_command_center

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `335`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_command_center`
* **Screen Name**: `PhysiotherapistCommandCenterScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/command-center`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_command_center_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistcommandcenterscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistCommandCenterScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistCommandCenterScreen`
* **Acceptance Criteria**:
- The PhysiotherapistCommandCenterScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_command_center-content` (Type: layout, Required: 1)
* **physiotherapistcommandcenter_btn_2** -> `physiotherapistcommandcenter-btn-2` (Type: button, Required: 0)
* **physiotherapistcommandcenter_content** -> `physiotherapistcommandcenter-content` (Type: layout, Required: 0)
* **physiotherapistcommandcenter_title** -> `physiotherapistcommandcenter-title` (Type: header, Required: 0)
* **physiotherapistcommandcenter_btn_3** -> `physiotherapistcommandcenter-btn-3` (Type: button, Required: 0)
* **physiotherapistcommandcenter_btn_1** -> `physiotherapistcommandcenter-btn-1` (Type: button, Required: 0)
* **physiotherapistcommandcenter_screen** -> `physiotherapistcommandcenter-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `343` (Required: 1)
* Component ID: `877` (Required: 1)
* Component ID: `1411` (Required: 1)
* Component ID: `4562` (Required: 1)
* Component ID: `4563` (Required: 1)
* Component ID: `4564` (Required: 1)
* Component ID: `4565` (Required: 1)
* Component ID: `4566` (Required: 1)
* Component ID: `4567` (Required: 1)
* Component ID: `4568` (Required: 1)
* Component ID: `4569` (Required: 1)
* Component ID: `4570` (Required: 1)

## 7. API / Data Mapping
* API ID: `4664` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_command_center_runtime`
* **Test Name**: `PhysiotherapistCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physiotherapist Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physiotherapist Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physiotherapist Command Center`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/command-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
