# SCREEN DATA CONTEXT: psw_messaging

Below are the database records from `governance.db` used to configure and build the **Guest - PswMessagingScreen** screen.

---

## 1. Screen Record
* **ID**: `696`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_messaging`
* **Screen Name**: `PswMessagingScreen`
* **Route Path**: `/generated/psw-messaging`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_messaging_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw messaging.`
* **User Story**: `As a Guest, I want to access the Psw Messaging within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Messaging`
* **Acceptance Criteria**:
- The Psw Messaging route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_messaging-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_messaging-title` (Type: header, Required: 1)
* **primary_content** -> `psw_messaging-content` (Type: layout, Required: 1)
* **psw_messaging_btn_refresh** -> `psw-messaging-btn-refresh` (Type: button, Required: 0)
* **pswmessaging_list** -> `pswmessaging-list` (Type: data_display, Required: 0)
* **psw_messaging_btn_send** -> `psw-messaging-btn-send` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6823` (Required: 1)
* Component ID: `6824` (Required: 1)
* Component ID: `6825` (Required: 1)
* Component ID: `6826` (Required: 1)

## 7. API / Data Mapping
* API ID: `5068` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_messaging_runtime`
* **Test Name**: `Psw Messaging Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Messaging`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-messaging`)
3. **should_be_visible** (Selector: `psw_messaging-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_messaging-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_messaging-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
