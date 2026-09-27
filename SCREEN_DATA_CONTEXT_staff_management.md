# SCREEN DATA CONTEXT: staff_management

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - StaffManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `505`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `staff_management`
* **Screen Name**: `StaffManagementScreen`
* **Route Path**: `/executive/staff-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/staff_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to staffmanagementscreen.`
* **User Story**: `As a Franchise Owner, I want to access the StaffManagementScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `StaffManagementScreen`
* **Acceptance Criteria**:
- The StaffManagementScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `staff_management-screen` (Type: layout, Required: 1)
* **page_title** -> `staff_management-title` (Type: header, Required: 1)
* **primary_content** -> `staff_management-content` (Type: layout, Required: 1)
* **staffmanagement_title** -> `staffmanagement-title` (Type: header, Required: 0)
* **staffmanagement_loading** -> `staffmanagement-loading` (Type: loading, Required: 0)
* **staffmanagement_screen** -> `staffmanagement-screen` (Type: layout, Required: 0)
* **staffmanagement_btn_2** -> `staffmanagement-btn-2` (Type: button, Required: 0)
* **staffmanagement_content** -> `staffmanagement-content` (Type: layout, Required: 0)
* **staffmanagement_btn_1** -> `staffmanagement-btn-1` (Type: button, Required: 0)
* **staffmanagement_btn_3** -> `staffmanagement-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `434` (Required: 1)
* Component ID: `968` (Required: 1)
* Component ID: `1502` (Required: 1)
* Component ID: `5431` (Required: 1)
* Component ID: `5432` (Required: 1)
* Component ID: `5433` (Required: 1)
* Component ID: `5434` (Required: 1)
* Component ID: `5435` (Required: 1)
* Component ID: `5436` (Required: 1)
* Component ID: `5437` (Required: 1)
* Component ID: `5438` (Required: 1)
* Component ID: `5439` (Required: 1)

## 7. API / Data Mapping
* API ID: `4822` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `staff_management_runtime`
* **Test Name**: `StaffManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `StaffManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **visit** (Selector: `None`, Value: `/executive/staff-management`)
3. **should_be_visible** (Selector: `staff_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `staff_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `staff_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
