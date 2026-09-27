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
* **Test Name**: `Asynchronous Consultation Inbox Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Asynchronous Consultation Inbox`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/asynchronous-consultation-inbox`)
3. **should_be_visible** (Selector: `asynchronous_consultation_inbox-screen`, Value: `None`)
4. **should_be_visible** (Selector: `asynchronous_consultation_inbox-title`, Value: `None`)
5. **should_be_visible** (Selector: `asynchronous_consultation_inbox-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
