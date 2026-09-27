# SCREEN DATA CONTEXT: blueprint_sandbox

Below are the database records from `governance.db` used to configure and build the **Guest - BlueprintSandboxScreen** screen.

---

## 1. Screen Record
* **ID**: `820`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `blueprint_sandbox`
* **Screen Name**: `BlueprintSandboxScreen`
* **Route Path**: `/generated/blueprint-sandbox`
* **Actual File Path**: `apps/primecare_governance/lib/core/ui/dynamic_screen_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to blueprint sandbox.`
* **User Story**: `As a Guest, I want to access the Blueprint Sandbox within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Blueprint Sandbox`
* **Acceptance Criteria**:
- The Blueprint Sandbox route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `blueprint_sandbox-screen` (Type: layout, Required: 1)
* **page_title** -> `blueprint_sandbox-title` (Type: header, Required: 1)
* **primary_content** -> `blueprint_sandbox-content` (Type: layout, Required: 1)
* **dynamic_screen_view_iconbutton_button_1** -> `dynamic_screen_view_iconbutton_button_1` (Type: button, Required: 0)
* **dynamic_screen_view_textfield_input_1** -> `dynamic_screen_view_textfield_input_1` (Type: field, Required: 0)
* **dynamic_screen_view_textbutton_button_1** -> `dynamic_screen_view_textbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7500` (Required: 1)
* Component ID: `7501` (Required: 1)
* Component ID: `7502` (Required: 1)
* Component ID: `7503` (Required: 1)
* Component ID: `7504` (Required: 1)
* Component ID: `7505` (Required: 1)

## 7. API / Data Mapping
* API ID: `5209` (Required: 1)
* API ID: `5210` (Required: 1)
* API ID: `5211` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `blueprint_sandbox_runtime`
* **Test Name**: `Blueprint Sandbox Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Blueprint Sandbox`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/blueprint-sandbox`)
3. **should_be_visible** (Selector: `blueprint_sandbox-screen`, Value: `None`)
4. **should_be_visible** (Selector: `blueprint_sandbox-title`, Value: `None`)
5. **should_be_visible** (Selector: `blueprint_sandbox-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
