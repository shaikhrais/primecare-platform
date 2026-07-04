# SCREEN DATA CONTEXT: role_access

Below are the database records from `governance.db` used to configure and build the **Guest - RoleAccessScreen** screen.

---

## 1. Screen Record
* **ID**: `928`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `role_access`
* **Screen Name**: `RoleAccessScreen`
* **Route Path**: `/generated/role-access`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/role_screen_access_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to role access.`
* **User Story**: `As a Guest, I want to access the Role Access within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Role Access`
* **Acceptance Criteria**:
- The Role Access route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `role_access-screen` (Type: layout, Required: 1)
* **page_title** -> `role_access-title` (Type: header, Required: 1)
* **primary_content** -> `role_access-content` (Type: layout, Required: 1)
* **role_access_btn_save** -> `role-access-btn-save` (Type: button, Required: 0)
* **role_screen_access_screen_textfield_input_1** -> `role_screen_access_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8085` (Required: 1)
* Component ID: `8086` (Required: 1)
* Component ID: `8087` (Required: 1)
* Component ID: `8088` (Required: 1)
* Component ID: `8089` (Required: 1)
* Component ID: `8090` (Required: 1)
* Component ID: `8091` (Required: 1)

## 7. API / Data Mapping
* API ID: `5356` (Required: 1)
* API ID: `5357` (Required: 1)
* API ID: `5358` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `role_access_runtime`
* **Test Name**: `Role Access Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Role Access`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/role-access`)
3. **should_be_visible** (Selector: `role_access-screen`, Value: `None`)
4. **should_be_visible** (Selector: `role_access-title`, Value: `None`)
5. **should_be_visible** (Selector: `role_access-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
