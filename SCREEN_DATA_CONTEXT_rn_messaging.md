# SCREEN DATA CONTEXT: rn_messaging

Below are the database records from `governance.db` used to configure and build the **Guest - RnMessagingScreen** screen.

---

## 1. Screen Record
* **ID**: `700`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `rn_messaging`
* **Screen Name**: `RnMessagingScreen`
* **Route Path**: `/generated/rn-messaging`
* **Actual File Path**: `apps/primecare_clinic/lib/features/rn/screens/rn_messaging_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to rn messaging.`
* **User Story**: `As a Guest, I want to access the Rn Messaging within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Rn Messaging`
* **Acceptance Criteria**:
- The Rn Messaging route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rn_messaging-screen` (Type: layout, Required: 1)
* **page_title** -> `rn_messaging-title` (Type: header, Required: 1)
* **primary_content** -> `rn_messaging-content` (Type: layout, Required: 1)
* **rnmessagingscreen_screen** -> `rnmessagingscreen-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6842` (Required: 1)
* Component ID: `6843` (Required: 1)
* Component ID: `6844` (Required: 1)
* Component ID: `6845` (Required: 1)
* Component ID: `6846` (Required: 1)

## 7. API / Data Mapping
* API ID: `5076` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rn_messaging_runtime`
* **Test Name**: `Rn Messaging Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rn Messaging`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/rn-messaging`)
3. **should_be_visible** (Selector: `rn_messaging-screen`, Value: `None`)
4. **should_be_visible** (Selector: `rn_messaging-title`, Value: `None`)
5. **should_be_visible** (Selector: `rn_messaging-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
