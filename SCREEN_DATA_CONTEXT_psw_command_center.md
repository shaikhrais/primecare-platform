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
* **Stage/Status**: `template_created`

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
* **Test Name**: `Psw Command Center Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Command Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/system-logs`)
3. **should_be_visible** (Selector: `psw_command_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_command_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_command_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
