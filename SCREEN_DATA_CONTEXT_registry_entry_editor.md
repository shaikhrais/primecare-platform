# SCREEN DATA CONTEXT: registry_entry_editor

Below are the database records from `governance.db` used to configure and build the **Guest - RegistryEntryEditorScreen** screen.

---

## 1. Screen Record
* **ID**: `923`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `registry_entry_editor`
* **Screen Name**: `RegistryEntryEditorScreen`
* **Route Path**: `/generated/registry-entry-editor`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/registry_entry_editor.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to registry entry editor.`
* **User Story**: `As a Guest, I want to access the Registry Entry Editor within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Registry Entry Editor`
* **Acceptance Criteria**:
- The Registry Entry Editor route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `registry_entry_editor-screen` (Type: layout, Required: 1)
* **page_title** -> `registry_entry_editor-title` (Type: header, Required: 1)
* **primary_content** -> `registry_entry_editor-content` (Type: layout, Required: 1)
* **registry_entry_editor_textfield_input_1** -> `registry_entry_editor_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8062` (Required: 1)
* Component ID: `8063` (Required: 1)
* Component ID: `8064` (Required: 1)
* Component ID: `8065` (Required: 1)
* Component ID: `8066` (Required: 1)

## 7. API / Data Mapping
* API ID: `5347` (Required: 1)
* API ID: `5348` (Required: 1)
* API ID: `5349` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `registry_entry_editor_runtime`
* **Test Name**: `Registry Entry Editor Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Registry Entry Editor`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Registry Entry Editor`)
4. **click_sidebar_link** (Selector: `None`, Value: `Registry Entry Editor`)
5. **check_url** (Selector: `None`, Value: `/generated/registry-entry-editor`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
