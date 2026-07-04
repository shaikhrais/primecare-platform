# SCREEN DATA CONTEXT: psw_messages

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - MessagesScreen** screen.

---

## 1. Screen Record
* **ID**: `234`
* **App ID**: `1`
* **Role ID**: `51`
* **Screen Code**: `psw_messages`
* **Screen Name**: `MessagesScreen`
* **Route Path**: `/offices/clinical/roles/psw/messages`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswmessagesscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswMessagesScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswMessagesScreen`
* **Acceptance Criteria**:
- The PswMessagesScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_messages-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_messages-title` (Type: header, Required: 1)
* **primary_content** -> `psw_messages-content` (Type: layout, Required: 1)
* **pswmessages_title** -> `pswmessages-title` (Type: header, Required: 0)
* **pswmessages_btn_4** -> `pswmessages-btn-4` (Type: button, Required: 0)
* **pswmessages_content** -> `pswmessages-content` (Type: layout, Required: 0)
* **pswmessages_btn_1** -> `pswmessages-btn-1` (Type: button, Required: 0)
* **pswmessages_btn_2** -> `pswmessages-btn-2` (Type: button, Required: 0)
* **pswmessages_loading** -> `pswmessages-loading` (Type: loading, Required: 0)
* **pswmessages_btn_3** -> `pswmessages-btn-3` (Type: button, Required: 0)
* **pswmessages_screen** -> `pswmessages-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `242` (Required: 1)
* Component ID: `776` (Required: 1)
* Component ID: `1310` (Required: 1)
* Component ID: `3672` (Required: 1)
* Component ID: `3673` (Required: 1)
* Component ID: `3674` (Required: 1)
* Component ID: `3675` (Required: 1)
* Component ID: `3676` (Required: 1)
* Component ID: `3677` (Required: 1)
* Component ID: `3678` (Required: 1)
* Component ID: `3679` (Required: 1)
* Component ID: `3680` (Required: 1)
* Component ID: `3681` (Required: 1)
* Component ID: `4685` (Required: 1)
* Component ID: `4686` (Required: 1)
* Component ID: `4687` (Required: 1)
* Component ID: `4688` (Required: 1)

## 7. API / Data Mapping
* API ID: `4527` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_messages_runtime`
* **Test Name**: `Messages Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Messages`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/psw/messages`)
3. **should_be_visible** (Selector: `psw_messages-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_messages-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_messages-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
