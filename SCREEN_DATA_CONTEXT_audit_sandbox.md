# SCREEN DATA CONTEXT: audit_sandbox

Below are the database records from `governance.db` used to configure and build the **Guest - AuditSandboxScreen** screen.

---

## 1. Screen Record
* **ID**: `821`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `audit_sandbox`
* **Screen Name**: `AuditSandboxScreen`
* **Route Path**: `/generated/audit-sandbox`
* **Actual File Path**: `apps/primecare_governance/lib/core/ui/dynamic_screen_view.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to audit sandbox.`
* **User Story**: `As a Guest, I want to access the Audit Sandbox within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Audit Sandbox`
* **Acceptance Criteria**:
- The Audit Sandbox route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `audit_sandbox-screen` (Type: layout, Required: 1)
* **page_title** -> `audit_sandbox-title` (Type: header, Required: 1)
* **primary_content** -> `audit_sandbox-content` (Type: layout, Required: 1)
* **dynamic_screen_view_iconbutton_button_1** -> `dynamic_screen_view_iconbutton_button_1` (Type: button, Required: 0)
* **dynamic_screen_view_textfield_input_1** -> `dynamic_screen_view_textfield_input_1` (Type: field, Required: 0)
* **dynamic_screen_view_textbutton_button_1** -> `dynamic_screen_view_textbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7506` (Required: 1)
* Component ID: `7507` (Required: 1)
* Component ID: `7508` (Required: 1)
* Component ID: `7509` (Required: 1)
* Component ID: `7510` (Required: 1)
* Component ID: `7511` (Required: 1)

## 7. API / Data Mapping
* API ID: `5212` (Required: 1)
* API ID: `5213` (Required: 1)
* API ID: `5214` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `audit_sandbox_runtime`
* **Test Name**: `Audit Sandbox Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Audit Sandbox`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Audit Sandbox`)
4. **click_sidebar_link** (Selector: `None`, Value: `Audit Sandbox`)
5. **check_url** (Selector: `None`, Value: `/generated/audit-sandbox`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
