# SCREEN DATA CONTEXT: messaging

Below are the database records from `governance.db` used to configure and build the **Caregiver - MessagingScreen** screen.

---

## 1. Screen Record
* **ID**: `578`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `messaging`
* **Screen Name**: `MessagingScreen`
* **Route Path**: `/clinic/messaging`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/messaging_screen.dart`
* **Stage/Status**: `production_ready`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to messagingscreen.`
* **User Story**: `As a Caregiver, I want to access the MessagingScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `MessagingScreen`
* **Acceptance Criteria**:
- The MessagingScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `messaging-screen` (Type: layout, Required: 1)
* **page_title** -> `messaging-title` (Type: header, Required: 1)
* **primary_content** -> `messaging-content` (Type: layout, Required: 1)
* **messaging_loading** -> `messaging-loading` (Type: loading, Required: 0)
* **messaging_btn_2** -> `messaging-btn-2` (Type: button, Required: 0)
* **messaging_btn_1** -> `messaging-btn-1` (Type: button, Required: 0)
* **messaging_btn_3** -> `messaging-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `502` (Required: 1)
* Component ID: `1036` (Required: 1)
* Component ID: `1570` (Required: 1)
* Component ID: `6033` (Required: 1)
* Component ID: `6034` (Required: 1)
* Component ID: `6035` (Required: 1)
* Component ID: `6036` (Required: 1)
* Component ID: `6037` (Required: 1)
* Component ID: `6038` (Required: 1)
* Component ID: `6039` (Required: 1)
* Component ID: `6040` (Required: 1)
* Component ID: `6041` (Required: 1)
* Component ID: `6042` (Required: 1)

## 7. API / Data Mapping
* API ID: `4925` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `messaging_runtime`
* **Test Name**: `MessagingScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Messaging`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Messaging`)
4. **click_sidebar_link** (Selector: `None`, Value: `Messaging`)
5. **check_url** (Selector: `None`, Value: `/clinic/messaging`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
