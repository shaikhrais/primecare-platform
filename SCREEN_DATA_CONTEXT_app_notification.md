# SCREEN DATA CONTEXT: app_notification

Below are the database records from `governance.db` used to configure and build the **Guest - AppNotificationScreen** screen.

---

## 1. Screen Record
* **ID**: `982`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `app_notification`
* **Screen Name**: `AppNotificationScreen`
* **Route Path**: `/generated/app-notification`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/operations/app_notification_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to app notification.`
* **User Story**: `As a Guest, I want to access the App Notification within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `App Notification`
* **Acceptance Criteria**:
- The App Notification route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `app_notification-screen` (Type: layout, Required: 1)
* **page_title** -> `app_notification-title` (Type: header, Required: 1)
* **primary_content** -> `app_notification-content` (Type: layout, Required: 1)
* **app_notification_screen_iconbutton_button_1** -> `app_notification_screen_iconbutton_button_1` (Type: button, Required: 0)
* **app_notification_screen_textfield_input_1** -> `app_notification_screen_textfield_input_1` (Type: field, Required: 0)

## 6. Component Mapping
* Component ID: `8348` (Required: 1)
* Component ID: `8349` (Required: 1)
* Component ID: `8350` (Required: 1)
* Component ID: `8351` (Required: 1)
* Component ID: `8352` (Required: 1)
* Component ID: `8353` (Required: 1)
* Component ID: `8354` (Required: 1)

## 7. API / Data Mapping
* API ID: `5422` (Required: 1)
* API ID: `5423` (Required: 1)
* API ID: `5424` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `app_notification_runtime`
* **Test Name**: `App Notification Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `App Notification`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/app-notification`)
3. **should_be_visible** (Selector: `app_notification-screen`, Value: `None`)
4. **should_be_visible** (Selector: `app_notification-title`, Value: `None`)
5. **should_be_visible** (Selector: `app_notification-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
