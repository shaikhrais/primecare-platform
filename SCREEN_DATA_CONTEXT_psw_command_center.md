# SCREEN DATA CONTEXT: psw_command_center

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswCommandCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `343`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_command_center`
* **Screen Name**: `PswCommandCenterScreen`
* **Route Path**: `/offices/clinical/roles/psw/system-logs`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswcommandcenterscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswCommandCenterScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswCommandCenterScreen`
* **Acceptance Criteria**:
- The PswCommandCenterScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_command_center-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_command_center-title` (Type: header, Required: 1)
* **primary_content** -> `psw_command_center-content` (Type: layout, Required: 1)
* **pswcommandcenter_title** -> `pswcommandcenter-title` (Type: header, Required: 0)
* **pswcommandcenter_btn_2** -> `pswcommandcenter-btn-2` (Type: button, Required: 0)
* **pswcommandcenter_btn_1** -> `pswcommandcenter-btn-1` (Type: button, Required: 0)
* **pswcommandcenter_content** -> `pswcommandcenter-content` (Type: layout, Required: 0)
* **pswcommandcenter_loading** -> `pswcommandcenter-loading` (Type: loading, Required: 0)
* **pswcommandcenter_btn_3** -> `pswcommandcenter-btn-3` (Type: button, Required: 0)
* **pswcommandcenter_screen** -> `pswcommandcenter-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `351` (Required: 1)
* Component ID: `885` (Required: 1)
* Component ID: `1419` (Required: 1)
* Component ID: `4624` (Required: 1)
* Component ID: `4625` (Required: 1)
* Component ID: `4626` (Required: 1)
* Component ID: `4627` (Required: 1)
* Component ID: `4628` (Required: 1)
* Component ID: `4629` (Required: 1)
* Component ID: `4630` (Required: 1)
* Component ID: `4631` (Required: 1)
* Component ID: `4632` (Required: 1)
* Component ID: `4633` (Required: 1)

## 7. API / Data Mapping
* API ID: `4676` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_command_center_runtime`
* **Test Name**: `PswCommandCenterScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Command Center`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Command Center`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/system-logs`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
