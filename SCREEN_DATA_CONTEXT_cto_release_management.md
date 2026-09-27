# SCREEN DATA CONTEXT: cto_release_management

Below are the database records from `governance.db` used to configure and build the **Guest - CtoReleaseManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `754`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `cto_release_management`
* **Screen Name**: `CtoReleaseManagementScreen`
* **Route Path**: `/offices/corporate/roles/cto/release-management`
* **Actual File Path**: `apps/primecare_corporate/lib/features/generated_screens/cto_release_management_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to cto release management.`
* **User Story**: `As a Guest, I want to access the Cto Release Management within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Cto Release Management`
* **Acceptance Criteria**:
- The Cto Release Management route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cto_release_management-screen` (Type: layout, Required: 1)
* **page_title** -> `cto_release_management-title` (Type: header, Required: 1)
* **primary_content** -> `cto_release_management-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7140` (Required: 1)
* Component ID: `7141` (Required: 1)
* Component ID: `7142` (Required: 1)
* Component ID: `7143` (Required: 1)
* Component ID: `7144` (Required: 1)
* Component ID: `7145` (Required: 1)
* Component ID: `7146` (Required: 1)

## 7. API / Data Mapping
* API ID: `5144` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cto_release_management_runtime`
* **Test Name**: `Cto Release Management Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Cto Release Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/offices/corporate/roles/cto/release-management`)
3. **should_be_visible** (Selector: `cto_release_management-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cto_release_management-title`, Value: `None`)
5. **should_be_visible** (Selector: `cto_release_management-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
