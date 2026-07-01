# SCREEN DATA CONTEXT: policy_management

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - PolicyManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `488`
* **App ID**: `5`
* **Role ID**: `33`
* **Screen Code**: `policy_management`
* **Screen Name**: `PolicyManagementScreen`
* **Route Path**: `/management/policy-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/policy_management_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to policymanagementscreen.`
* **User Story**: `As a Compliance Manager, I want to access the PolicyManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PolicyManagementScreen`
* **Acceptance Criteria**:
- The PolicyManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `policy_management-screen` (Type: layout, Required: 1)
* **page_title** -> `policy_management-title` (Type: header, Required: 1)
* **primary_content** -> `policy_management-content` (Type: layout, Required: 1)
* **policymanagement_loading** -> `policymanagement-loading` (Type: loading, Required: 0)
* **policymanagement_btn_2** -> `policymanagement-btn-2` (Type: button, Required: 0)
* **policymanagement_btn_1** -> `policymanagement-btn-1` (Type: button, Required: 0)
* **policymanagement_btn_3** -> `policymanagement-btn-3` (Type: button, Required: 0)
* **policymanagement_screen** -> `policymanagement-screen` (Type: layout, Required: 0)
* **policymanagement_title** -> `policymanagement-title` (Type: header, Required: 0)
* **policymanagement_content** -> `policymanagement-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `417` (Required: 1)
* Component ID: `951` (Required: 1)
* Component ID: `1485` (Required: 1)
* Component ID: `5264` (Required: 1)
* Component ID: `5265` (Required: 1)
* Component ID: `5266` (Required: 1)
* Component ID: `5267` (Required: 1)
* Component ID: `5268` (Required: 1)
* Component ID: `5269` (Required: 1)
* Component ID: `5270` (Required: 1)
* Component ID: `5271` (Required: 1)
* Component ID: `5272` (Required: 1)

## 7. API / Data Mapping
* API ID: `4805` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `policy_management_runtime`
* **Test Name**: `PolicyManagementScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Policy Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Policy Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Policy Management`)
5. **check_url** (Selector: `None`, Value: `/management/policy-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
