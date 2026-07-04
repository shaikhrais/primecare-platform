# SCREEN DATA CONTEXT: ticket_center

Below are the database records from `governance.db` used to configure and build the **Guest - TicketCenterScreen** screen.

---

## 1. Screen Record
* **ID**: `826`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `ticket_center`
* **Screen Name**: `TicketCenterScreen`
* **Route Path**: `/governance/tickets`
* **Actual File Path**: `apps/primecare_governance/lib/features/audit/screens/ticket_center_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to ticket center.`
* **User Story**: `As a Guest, I want to access the Ticket Center within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Ticket Center`
* **Acceptance Criteria**:
- The Ticket Center route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ticket_center-screen` (Type: layout, Required: 1)
* **page_title** -> `ticket_center-title` (Type: header, Required: 1)
* **primary_content** -> `ticket_center-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7533` (Required: 1)
* Component ID: `7534` (Required: 1)
* Component ID: `7535` (Required: 1)
* Component ID: `7536` (Required: 1)
* Component ID: `7537` (Required: 1)

## 7. API / Data Mapping
* API ID: `5221` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ticket_center_runtime`
* **Test Name**: `Ticket Center Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ticket Center`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/governance/tickets`)
3. **should_be_visible** (Selector: `ticket_center-screen`, Value: `None`)
4. **should_be_visible** (Selector: `ticket_center-title`, Value: `None`)
5. **should_be_visible** (Selector: `ticket_center-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
