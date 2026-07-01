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
* **Test Name**: `Admin User Management Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Admin User Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Admin User Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Admin User Management`)
5. **check_url** (Selector: `None`, Value: `/generated/admin-user-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
