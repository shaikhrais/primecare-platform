# SCREEN DATA CONTEXT: message_archiveer

Below are the database records from `governance.db` used to configure and build the **Guest - MessageArchiveerScreen** screen.

---

## 1. Screen Record
* **ID**: `917`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `message_archiveer`
* **Screen Name**: `MessageArchiveerScreen`
* **Route Path**: `/generated/message-archiveer`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/admin/message_archive_viewer.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to message archiveer.`
* **User Story**: `As a Guest, I want to access the Message Archiveer within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Message Archiveer`
* **Acceptance Criteria**:
- The Message Archiveer route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `message_archiveer-screen` (Type: layout, Required: 1)
* **page_title** -> `message_archiveer-title` (Type: header, Required: 1)
* **primary_content** -> `message_archiveer-content` (Type: layout, Required: 1)
* **message_archive_viewer_iconbutton_button_2** -> `message_archive_viewer_iconbutton_button_2` (Type: button, Required: 0)
* **message_archive_viewer_textfield_input_1** -> `message_archive_viewer_textfield_input_1` (Type: field, Required: 0)
* **message_archive_viewer_textbutton_button_1** -> `message_archive_viewer_textbutton_button_1` (Type: button, Required: 0)
* **message_archive_viewer_iconbutton_button_1** -> `message_archive_viewer_iconbutton_button_1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8030` (Required: 1)
* Component ID: `8031` (Required: 1)
* Component ID: `8032` (Required: 1)
* Component ID: `8033` (Required: 1)
* Component ID: `8034` (Required: 1)
* Component ID: `8035` (Required: 1)
* Component ID: `8036` (Required: 1)

## 7. API / Data Mapping
* API ID: `5337` (Required: 1)
* API ID: `5338` (Required: 1)
* API ID: `5339` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `message_archiveer_runtime`
* **Test Name**: `Message Archiveer Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Message Archiveer`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Message Archiveer`)
4. **click_sidebar_link** (Selector: `None`, Value: `Message Archiveer`)
5. **check_url** (Selector: `None`, Value: `/generated/message-archiveer`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
