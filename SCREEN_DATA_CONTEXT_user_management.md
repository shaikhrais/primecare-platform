# SCREEN DATA CONTEXT: user_management

Below are the database records from `governance.db` used to configure and build the **Guest - UserManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `935`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `user_management`
* **Screen Name**: `UserManagementScreen`
* **Route Path**: `/generated/user-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/user_management_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to user management.`
* **User Story**: `As a Guest, I want to access the User Management within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `User Management`
* **Acceptance Criteria**:
- The User Management route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `user_management-screen` (Type: layout, Required: 1)
* **page_title** -> `user_management-title` (Type: header, Required: 1)
* **primary_content** -> `user_management-content` (Type: layout, Required: 1)
* **user_management_screen_iconbutton_button_1** -> `user_management_screen_iconbutton_button_1` (Type: button, Required: 0)
* **user_management_screen_iconbutton_button_2** -> `user_management_screen_iconbutton_button_2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8124` (Required: 1)
* Component ID: `8125` (Required: 1)
* Component ID: `8126` (Required: 1)
* Component ID: `8127` (Required: 1)
* Component ID: `8128` (Required: 1)

## 7. API / Data Mapping
* API ID: `5367` (Required: 1)
* API ID: `5368` (Required: 1)
* API ID: `5369` (Required: 1)
* API ID: `5370` (Required: 1)
* API ID: `5371` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `user_management_runtime`
* **Test Name**: `User Management Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `User Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/user-management`)
3. **should_be_visible** (Selector: `user_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `user_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `user_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
