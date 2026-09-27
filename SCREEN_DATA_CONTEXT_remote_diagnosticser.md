# SCREEN DATA CONTEXT: remote_diagnosticser

Below are the database records from `governance.db` used to configure and build the **Guest - RemoteDiagnosticserScreen** screen.

---

## 1. Screen Record
* **ID**: `1022`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `remote_diagnosticser`
* **Screen Name**: `RemoteDiagnosticserScreen`
* **Route Path**: `/generated/remote-diagnosticser`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/remote_diagnostics_viewer.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to remote diagnosticser.`
* **User Story**: `As a Guest, I want to access the Remote Diagnosticser within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Remote Diagnosticser`
* **Acceptance Criteria**:
- The Remote Diagnosticser route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `remote_diagnosticser-screen` (Type: layout, Required: 1)
* **page_title** -> `remote_diagnosticser-title` (Type: header, Required: 1)
* **primary_content** -> `remote_diagnosticser-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8613` (Required: 1)
* Component ID: `8614` (Required: 1)
* Component ID: `8615` (Required: 1)
* Component ID: `8616` (Required: 1)
* Component ID: `8617` (Required: 1)
* Component ID: `8618` (Required: 1)

## 7. API / Data Mapping
* API ID: `5488` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `remote_diagnosticser_runtime`
* **Test Name**: `Remote Diagnosticser Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Remote Diagnosticser`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/remote-diagnosticser`)
3. **should_be_visible** (Selector: `remote_diagnosticser-screen`, Value: `None`)
4. **should_be_visible** (Selector: `remote_diagnosticser-title`, Value: `None`)
5. **should_be_visible** (Selector: `remote_diagnosticser-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
