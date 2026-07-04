# SCREEN DATA CONTEXT: admin_screen_health

Below are the database records from `governance.db` used to configure and build the **Guest - AdminScreenHealthScreen** screen.

---

## 1. Screen Record
* **ID**: `1263`
* **App ID**: `1`
* **Role ID**: `None`
* **Screen Code**: `admin_screen_health`
* **Screen Name**: `AdminScreenHealthScreen`
* **Route Path**: `/admin/screen-health`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/admin/admin_screen_health_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `None`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `public`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Authorized Staff personnel to oversee, audit, and coordinate operations related to adminscreenhealthscreen.`
* **User Story**: `As a Authorized Staff, I want to access the AdminScreenHealthScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `AdminScreenHealthScreen`
* **Acceptance Criteria**:
- The AdminScreenHealthScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Authorized Staff access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `admin_screen_health-screen` (Type: layout, Required: 1)
* **page_title** -> `admin_screen_health-title` (Type: header, Required: 1)
* **primary_content** -> `admin_screen_health-content` (Type: layout, Required: 1)

## 6. Component Mapping
* No custom components mapped.

## 7. API / Data Mapping
* API ID: `5496` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `admin_screen_health_runtime`
* **Test Name**: `AdminScreenHealthScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `AdminScreenHealthScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/admin/screen-health`)
3. **should_be_visible** (Selector: `admin_screen_health-screen`, Value: `None`)
4. **should_be_visible** (Selector: `admin_screen_health-title`, Value: `None`)
5. **should_be_visible** (Selector: `admin_screen_health-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
