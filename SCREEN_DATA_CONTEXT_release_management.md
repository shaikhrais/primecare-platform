# SCREEN DATA CONTEXT: release_management

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - ReleaseManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `484`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `release_management`
* **Screen Name**: `ReleaseManagementScreen`
* **Route Path**: `/executive/release-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/release_management_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to releasemanagementscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the ReleaseManagementScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReleaseManagementScreen`
* **Acceptance Criteria**:
- The ReleaseManagementScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `release_management-screen` (Type: layout, Required: 1)
* **page_title** -> `release_management-title` (Type: header, Required: 1)
* **primary_content** -> `release_management-content` (Type: layout, Required: 1)
* **releasemanagement_btn_1** -> `releasemanagement-btn-1` (Type: button, Required: 0)
* **releasemanagement_screen** -> `releasemanagement-screen` (Type: layout, Required: 0)
* **releasemanagement_btn_3** -> `releasemanagement-btn-3` (Type: button, Required: 0)
* **releasemanagement_loading** -> `releasemanagement-loading` (Type: loading, Required: 0)
* **releasemanagement_title** -> `releasemanagement-title` (Type: header, Required: 0)
* **releasemanagement_btn_2** -> `releasemanagement-btn-2` (Type: button, Required: 0)
* **releasemanagement_content** -> `releasemanagement-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `413` (Required: 1)
* Component ID: `947` (Required: 1)
* Component ID: `1481` (Required: 1)
* Component ID: `5224` (Required: 1)
* Component ID: `5225` (Required: 1)
* Component ID: `5226` (Required: 1)
* Component ID: `5227` (Required: 1)
* Component ID: `5228` (Required: 1)
* Component ID: `5229` (Required: 1)
* Component ID: `5230` (Required: 1)
* Component ID: `5231` (Required: 1)
* Component ID: `5232` (Required: 1)
* Component ID: `5233` (Required: 1)

## 7. API / Data Mapping
* API ID: `4801` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `release_management_runtime`
* **Test Name**: `ReleaseManagementScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ReleaseManagementScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **visit** (Selector: `None`, Value: `/executive/release-management`)
3. **should_be_visible** (Selector: `release_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `release_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `release_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
