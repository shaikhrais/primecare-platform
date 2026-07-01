# SCREEN DATA CONTEXT: api_key_manager

Below are the database records from `governance.db` used to configure and build the **Guest - ApiKeyManagerScreen** screen.

---

## 1. Screen Record
* **ID**: `904`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `api_key_manager`
* **Screen Name**: `ApiKeyManagerScreen`
* **Route Path**: `/generated/api-key-manager`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/api_key_manager_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to api key manager.`
* **User Story**: `As a Guest, I want to access the Api Key Manager within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Api Key Manager`
* **Acceptance Criteria**:
- The Api Key Manager route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `api_key_manager-screen` (Type: layout, Required: 1)
* **page_title** -> `api_key_manager-title` (Type: header, Required: 1)
* **primary_content** -> `api_key_manager-content` (Type: layout, Required: 1)
* **api_key_manager_screen_iconbutton_button_1** -> `api_key_manager_screen_iconbutton_button_1` (Type: button, Required: 0)
* **api_key_manager_screen_iconbutton_button_3** -> `api_key_manager_screen_iconbutton_button_3` (Type: button, Required: 0)
* **api_key_manager_screen_iconbutton_button_2** -> `api_key_manager_screen_iconbutton_button_2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7975` (Required: 1)
* Component ID: `7976` (Required: 1)
* Component ID: `7977` (Required: 1)
* Component ID: `7978` (Required: 1)
* Component ID: `7979` (Required: 1)

## 7. API / Data Mapping
* API ID: `5322` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `api_key_manager_runtime`
* **Test Name**: `Api Key Manager Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Api Key Manager`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Api Key Manager`)
4. **click_sidebar_link** (Selector: `None`, Value: `Api Key Manager`)
5. **check_url** (Selector: `None`, Value: `/generated/api-key-manager`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
