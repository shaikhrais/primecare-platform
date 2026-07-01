# SCREEN DATA CONTEXT: crisis_protocol_trigger

Below are the database records from `governance.db` used to configure and build the **Guest - CrisisProtocolTriggerScreen** screen.

---

## 1. Screen Record
* **ID**: `908`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `crisis_protocol_trigger`
* **Screen Name**: `CrisisProtocolTriggerScreen`
* **Route Path**: `/generated/crisis-protocol-trigger`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/crisis_protocol_trigger_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to crisis protocol trigger.`
* **User Story**: `As a Guest, I want to access the Crisis Protocol Trigger within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Crisis Protocol Trigger`
* **Acceptance Criteria**:
- The Crisis Protocol Trigger route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `crisis_protocol_trigger-screen` (Type: layout, Required: 1)
* **page_title** -> `crisis_protocol_trigger-title` (Type: header, Required: 1)
* **primary_content** -> `crisis_protocol_trigger-content` (Type: layout, Required: 1)
* **crisis_protocol_trigger_screen_elevatedbutton_button_1** -> `crisis_protocol_trigger_screen_elevatedbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `7994` (Required: 1)
* Component ID: `7995` (Required: 1)
* Component ID: `7996` (Required: 1)
* Component ID: `7997` (Required: 1)
* Component ID: `7998` (Required: 1)

## 7. API / Data Mapping
* API ID: `5328` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `crisis_protocol_trigger_runtime`
* **Test Name**: `Crisis Protocol Trigger Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Crisis Protocol Trigger`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Crisis Protocol Trigger`)
4. **click_sidebar_link** (Selector: `None`, Value: `Crisis Protocol Trigger`)
5. **check_url** (Selector: `None`, Value: `/generated/crisis-protocol-trigger`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
