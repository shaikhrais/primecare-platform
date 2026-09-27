# SCREEN DATA CONTEXT: admin_user_management

Below are the database records from `governance.db` used to configure and build the **Guest - AdminUserManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `903`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `admin_user_management`
* **Screen Name**: `AdminUserManagementScreen`
* **Route Path**: `/generated/admin-user-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/admin_user_management.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to admin user management.`
* **User Story**: `As a Guest, I want to access the Admin User Management within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Admin User Management`
* **Acceptance Criteria**:
- The Admin User Management route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `admin_user_management-screen` (Type: layout, Required: 1)
* **page_title** -> `admin_user_management-title` (Type: header, Required: 1)
* **primary_content** -> `admin_user_management-content` (Type: layout, Required: 1)
* **admin_user_management_iconbutton_button_1** -> `admin_user_management_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7969` (Required: 1)
* Component ID: `7970` (Required: 1)
* Component ID: `7971` (Required: 1)
* Component ID: `7972` (Required: 1)
* Component ID: `7973` (Required: 1)
* Component ID: `7974` (Required: 1)

## 7. API / Data Mapping
* API ID: `5317` (Required: 1)
* API ID: `5318` (Required: 1)
* API ID: `5319` (Required: 1)
* API ID: `5320` (Required: 1)
* API ID: `5321` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `admin_user_management_runtime`
* **Test Name**: `Admin User Management Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Admin User Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/admin-user-management`)
3. **should_be_visible** (Selector: `admin_user_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `admin_user_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `admin_user_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
