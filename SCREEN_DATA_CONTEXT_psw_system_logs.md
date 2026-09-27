# SCREEN DATA CONTEXT: psw_system_logs

Below are the database records from `governance.db` used to configure and build the **Guest - PswSystemLogsScreen** screen.

---

## 1. Screen Record
* **ID**: `692`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_system_logs`
* **Screen Name**: `PswSystemLogsScreen`
* **Route Path**: `/generated/psw-system-logs`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_system_logs_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw system logs.`
* **User Story**: `As a Guest, I want to access the Psw System Logs within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw System Logs`
* **Acceptance Criteria**:
- The Psw System Logs route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_system_logs-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_system_logs-title` (Type: header, Required: 1)
* **primary_content** -> `psw_system_logs-content` (Type: layout, Required: 1)
* **pswlogs_btn_export** -> `pswlogs-btn-export` (Type: button, Required: 0)
* **pswlogs_btn_report** -> `pswlogs-btn-report` (Type: button, Required: 0)
* **pswsystemlogs_content** -> `pswsystemlogs-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6800` (Required: 1)
* Component ID: `6801` (Required: 1)
* Component ID: `6802` (Required: 1)
* Component ID: `6803` (Required: 1)
* Component ID: `6804` (Required: 1)
* Component ID: `6805` (Required: 1)

## 7. API / Data Mapping
* API ID: `5060` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_system_logs_runtime`
* **Test Name**: `Psw System Logs Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw System Logs`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-system-logs`)
3. **should_be_visible** (Selector: `psw_system_logs-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_system_logs-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_system_logs-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
