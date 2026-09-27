# SCREEN DATA CONTEXT: screen_not_implemented

Below are the database records from `governance.db` used to configure and build the **Guest - ScreenNotImplementedScreen** screen.

---

## 1. Screen Record
* **ID**: `1030`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `screen_not_implemented`
* **Screen Name**: `ScreenNotImplementedScreen`
* **Route Path**: `/generated/screen-not-implemented`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/shared_screen_stubs.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to screen not implemented.`
* **User Story**: `As a Guest, I want to access the Screen Not Implemented within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Screen Not Implemented`
* **Acceptance Criteria**:
- The Screen Not Implemented route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `screen_not_implemented-screen` (Type: layout, Required: 1)
* **page_title** -> `screen_not_implemented-title` (Type: header, Required: 1)
* **primary_content** -> `screen_not_implemented-content` (Type: layout, Required: 1)
* **screennotimplemented_title** -> `screennotimplemented-title` (Type: header, Required: 0)
* **sharedstubs_btn_trigger_scan** -> `sharedstubs-btn-trigger-scan` (Type: button, Required: 0)
* **sharedstubs_btn_manual_refresh** -> `sharedstubs-btn-manual-refresh` (Type: button, Required: 0)
* **sharedstubs_content** -> `sharedstubs-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `8667` (Required: 1)
* Component ID: `8668` (Required: 1)
* Component ID: `8669` (Required: 1)
* Component ID: `8670` (Required: 1)
* Component ID: `8671` (Required: 1)

## 7. API / Data Mapping
* API ID: `5494` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `screen_not_implemented_runtime`
* **Test Name**: `Screen Not Implemented Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Screen Not Implemented`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/screen-not-implemented`)
3. **should_be_visible** (Selector: `screen_not_implemented-screen`, Value: `None`)
4. **should_be_visible** (Selector: `screen_not_implemented-title`, Value: `None`)
5. **should_be_visible** (Selector: `screen_not_implemented-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
