# SCREEN DATA CONTEXT: asynchronous_consultation_inbox

Below are the database records from `governance.db` used to configure and build the **Guest - AsynchronousConsultationInboxScreen** screen.

---

## 1. Screen Record
* **ID**: `1018`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `asynchronous_consultation_inbox`
* **Screen Name**: `AsynchronousConsultationInboxScreen`
* **Route Path**: `/generated/asynchronous-consultation-inbox`
* **Actual File Path**: `packages/primecare_ui/lib/src/features/telehealth/asynchronous_consultation_inbox.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to asynchronous consultation inbox.`
* **User Story**: `As a Guest, I want to access the Asynchronous Consultation Inbox within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Asynchronous Consultation Inbox`
* **Acceptance Criteria**:
- The Asynchronous Consultation Inbox route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `asynchronous_consultation_inbox-screen` (Type: layout, Required: 1)
* **page_title** -> `asynchronous_consultation_inbox-title` (Type: header, Required: 1)
* **primary_content** -> `asynchronous_consultation_inbox-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `8588` (Required: 1)
* Component ID: `8589` (Required: 1)
* Component ID: `8590` (Required: 1)
* Component ID: `8591` (Required: 1)
* Component ID: `8592` (Required: 1)

## 7. API / Data Mapping
* API ID: `5484` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `asynchronous_consultation_inbox_runtime`
* **Test Name**: `Asynchronous Consultation Inbox Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Asynchronous Consultation Inbox`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Asynchronous Consultation Inbox`)
4. **click_sidebar_link** (Selector: `None`, Value: `Asynchronous Consultation Inbox`)
5. **check_url** (Selector: `None`, Value: `/generated/asynchronous-consultation-inbox`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
