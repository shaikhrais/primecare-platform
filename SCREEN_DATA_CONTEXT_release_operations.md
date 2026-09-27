# SCREEN DATA CONTEXT: release_operations

Below are the database records from `governance.db` used to configure and build the **Governance Officer - ReleaseOperationsScreen** screen.

---

## 1. Screen Record
* **ID**: `586`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `release_operations`
* **Screen Name**: `ReleaseOperationsScreen`
* **Route Path**: `/common/release-operations`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/release_operations_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to releaseoperationsscreen.`
* **User Story**: `As a Governance Officer, I want to access the ReleaseOperationsScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReleaseOperationsScreen`
* **Acceptance Criteria**:
- The ReleaseOperationsScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `release_operations-screen` (Type: layout, Required: 1)
* **page_title** -> `release_operations-title` (Type: header, Required: 1)
* **primary_content** -> `release_operations-content` (Type: layout, Required: 1)
* **releaseoperations_btn_2** -> `releaseoperations-btn-2` (Type: button, Required: 0)
* **releaseoperations_btn_1** -> `releaseoperations-btn-1` (Type: button, Required: 0)
* **releaseoperations_screen** -> `releaseoperations-screen` (Type: layout, Required: 0)
* **releaseoperations_title** -> `releaseoperations-title` (Type: header, Required: 0)
* **releaseoperations_btn_3** -> `releaseoperations-btn-3` (Type: button, Required: 0)
* **releaseoperations_loading** -> `releaseoperations-loading` (Type: loading, Required: 0)
* **releaseoperations_content** -> `releaseoperations-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `510` (Required: 1)
* Component ID: `1044` (Required: 1)
* Component ID: `1578` (Required: 1)
* Component ID: `6114` (Required: 1)
* Component ID: `6115` (Required: 1)
* Component ID: `6116` (Required: 1)
* Component ID: `6117` (Required: 1)
* Component ID: `6118` (Required: 1)
* Component ID: `6119` (Required: 1)
* Component ID: `6120` (Required: 1)
* Component ID: `6121` (Required: 1)
* Component ID: `6122` (Required: 1)

## 7. API / Data Mapping
* API ID: `4935` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `release_operations_runtime`
* **Test Name**: `ReleaseOperationsScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ReleaseOperationsScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/common/release-operations`)
3. **should_be_visible** (Selector: `release_operations-screen`, Value: `None`)
4. **should_be_visible** (Selector: `release_operations-title`, Value: `None`)
5. **should_be_visible** (Selector: `release_operations-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
