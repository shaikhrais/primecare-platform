# SCREEN DATA CONTEXT: control_center

Below are the database records from `governance.db` used to configure and build the **Guest - ControlCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `827`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `control_center`
* **Screen Name**: `ControlCenterScreen`
* **Route Path**: `/governance/control-center`
* **Actual File Path**: `apps/primecare_governance/lib/features/executive/screens/control_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to control center.`
* **User Story**: `As a Guest, I want to access the Control Center within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Control Center`
* **Acceptance Criteria**:
- The Control Center route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `control_center-screen` (Type: layout, Required: 1)
* **page_title** -> `control_center-title` (Type: header, Required: 1)
* **primary_content** -> `control_center-content` (Type: layout, Required: 1)
* **data_cy_btn_dispatch** -> `data-cy-btn-dispatch` (Type: button, Required: 0)
* **data_cy_btn_upload_proof** -> `data-cy-btn-upload-proof` (Type: button, Required: 0)
* **control_center_screen_iconbutton_button_1** -> `control_center_screen_iconbutton_button_1` (Type: button, Required: 0)
* **control_center_screen_iconbutton_button_2** -> `control_center_screen_iconbutton_button_2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7538` (Required: 1)
* Component ID: `7539` (Required: 1)
* Component ID: `7540` (Required: 1)
* Component ID: `7541` (Required: 1)
* Component ID: `7542` (Required: 1)
* Component ID: `7543` (Required: 1)
* Component ID: `7544` (Required: 1)

## 7. API / Data Mapping
* API ID: `5222` (Required: 1)
* API ID: `5223` (Required: 1)
* API ID: `5224` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `control_center_runtime`
* **Test Name**: `Control Center Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Control Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Control Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `Control Center`)
5. **check_url** (Selector: `None`, Value: `/governance/control-center`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
