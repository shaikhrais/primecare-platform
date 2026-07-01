# SCREEN DATA CONTEXT: psw_notifications

Below are the database records from `governance.db` used to configure and build the **Guest - PswNotificationsScreen** screen.

---

## 1. Screen Record
* **ID**: `686`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_notifications`
* **Screen Name**: `PswNotificationsScreen`
* **Route Path**: `/generated/psw-notifications`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_notifications_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw notifications.`
* **User Story**: `As a Guest, I want to access the Psw Notifications within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Notifications`
* **Acceptance Criteria**:
- The Psw Notifications route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_notifications-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_notifications-title` (Type: header, Required: 1)
* **primary_content** -> `psw_notifications-content` (Type: layout, Required: 1)
* **psw_notifications_list** -> `psw_notifications-list` (Type: data_display, Required: 0)
* **psw_notifications_settings** -> `psw_notifications-settings` (Type: custom, Required: 0)
* **pswnotifications_content** -> `pswnotifications-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6768` (Required: 1)
* Component ID: `6769` (Required: 1)
* Component ID: `6770` (Required: 1)
* Component ID: `6771` (Required: 1)
* Component ID: `6772` (Required: 1)

## 7. API / Data Mapping
* API ID: `5052` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_notifications_runtime`
* **Test Name**: `Psw Notifications Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Notifications`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Notifications`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Notifications`)
5. **check_url** (Selector: `None`, Value: `/generated/psw-notifications`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
