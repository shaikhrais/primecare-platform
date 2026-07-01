# SCREEN DATA CONTEXT: event_and_webinar_manager

Below are the database records from `governance.db` used to configure and build the **Guest - EventAndWebinarManagerScreen** screen.

---

## 1. Screen Record
* **ID**: `976`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `event_and_webinar_manager`
* **Screen Name**: `EventAndWebinarManagerScreen`
* **Route Path**: `/generated/event-and-webinar-manager`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/marketing/event_and_webinar_manager.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to event and webinar manager.`
* **User Story**: `As a Guest, I want to access the Event And Webinar Manager within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Event And Webinar Manager`
* **Acceptance Criteria**:
- The Event And Webinar Manager route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `event_and_webinar_manager-screen` (Type: layout, Required: 1)
* **page_title** -> `event_and_webinar_manager-title` (Type: header, Required: 1)
* **primary_content** -> `event_and_webinar_manager-content` (Type: layout, Required: 1)
* **event_and_webinar_manager_iconbutton_button_1** -> `event_and_webinar_manager_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8321` (Required: 1)
* Component ID: `8322` (Required: 1)
* Component ID: `8323` (Required: 1)
* Component ID: `8324` (Required: 1)

## 7. API / Data Mapping
* API ID: `5416` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `event_and_webinar_manager_runtime`
* **Test Name**: `Event And Webinar Manager Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Event And Webinar Manager`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Event And Webinar Manager`)
4. **click_sidebar_link** (Selector: `None`, Value: `Event And Webinar Manager`)
5. **check_url** (Selector: `None`, Value: `/generated/event-and-webinar-manager`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
