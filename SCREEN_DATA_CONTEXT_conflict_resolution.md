# SCREEN DATA CONTEXT: conflict_resolution

Below are the database records from `governance.db` used to configure and build the **Shift Supervisor - ConflictResolutionScreen** screen.

---

## 1. Screen Record
* **ID**: `514`
* **App ID**: `5`
* **Role ID**: `60`
* **Screen Code**: `conflict_resolution`
* **Screen Name**: `ConflictResolutionScreen`
* **Route Path**: `/staff/conflict-resolution`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/conflict_resolution_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `60`
* **Role Code**: `scheduler`
* **Role Name**: `Shift Supervisor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Shift Supervisor personnel to oversee, audit, and coordinate operations related to conflictresolutionscreen.`
* **User Story**: `As a Shift Supervisor, I want to access the ConflictResolutionScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ConflictResolutionScreen`
* **Acceptance Criteria**:
- The ConflictResolutionScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Shift Supervisor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `conflict_resolution-screen` (Type: layout, Required: 1)
* **page_title** -> `conflict_resolution-title` (Type: header, Required: 1)
* **primary_content** -> `conflict_resolution-content` (Type: layout, Required: 1)
* **conflictresolution_btn_3** -> `conflictresolution-btn-3` (Type: button, Required: 0)
* **conflictresolution_btn_5** -> `conflictresolution-btn-5` (Type: button, Required: 0)
* **conflictresolution_btn_2** -> `conflictresolution-btn-2` (Type: button, Required: 0)
* **conflictresolution_title** -> `conflictresolution-title` (Type: header, Required: 0)
* **conflictresolution_screen** -> `conflictresolution-screen` (Type: layout, Required: 0)
* **conflictresolution_content** -> `conflictresolution-content` (Type: layout, Required: 0)
* **conflictresolution_btn_4** -> `conflictresolution-btn-4` (Type: button, Required: 0)
* **conflictresolution_btn_1** -> `conflictresolution-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `443` (Required: 1)
* Component ID: `977` (Required: 1)
* Component ID: `1511` (Required: 1)
* Component ID: `5518` (Required: 1)
* Component ID: `5519` (Required: 1)
* Component ID: `5520` (Required: 1)
* Component ID: `5521` (Required: 1)
* Component ID: `5522` (Required: 1)
* Component ID: `5523` (Required: 1)
* Component ID: `5524` (Required: 1)
* Component ID: `5525` (Required: 1)

## 7. API / Data Mapping
* API ID: `4830` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `conflict_resolution_runtime`
* **Test Name**: `ConflictResolutionScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ConflictResolutionScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `scheduler`)
2. **visit** (Selector: `None`, Value: `/staff/conflict-resolution`)
3. **should_be_visible** (Selector: `conflict_resolution-screen`, Value: `None`)
4. **should_be_visible** (Selector: `conflict_resolution-title`, Value: `None`)
5. **should_be_visible** (Selector: `conflict_resolution-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
