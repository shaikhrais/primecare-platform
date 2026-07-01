# SCREEN DATA CONTEXT: ticket_management

Below are the database records from `governance.db` used to configure and build the **Customer Support - TicketManagementScreen** screen.

---

## 1. Screen Record
* **ID**: `557`
* **App ID**: `5`
* **Role ID**: `61`
* **Screen Code**: `ticket_management`
* **Screen Name**: `TicketManagementScreen`
* **Route Path**: `/staff/ticket-management`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/ticket_management_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `61`
* **Role Code**: `customer_support`
* **Role Name**: `Customer Support`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Customer Support personnel to oversee, audit, and coordinate operations related to ticketmanagementscreen.`
* **User Story**: `As a Customer Support, I want to access the TicketManagementScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `TicketManagementScreen`
* **Acceptance Criteria**:
- The TicketManagementScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Customer Support access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `ticket_management-screen` (Type: layout, Required: 1)
* **page_title** -> `ticket_management-title` (Type: header, Required: 1)
* **primary_content** -> `ticket_management-content` (Type: layout, Required: 1)
* **ticketmanagement_btn_4** -> `ticketmanagement-btn-4` (Type: button, Required: 0)
* **ticketmanagement_screen** -> `ticketmanagement-screen` (Type: layout, Required: 0)
* **ticketmanagement_btn_1** -> `ticketmanagement-btn-1` (Type: button, Required: 0)
* **ticketmanagement_btn_2** -> `ticketmanagement-btn-2` (Type: button, Required: 0)
* **ticketmanagement_loading** -> `ticketmanagement-loading` (Type: loading, Required: 0)
* **ticketmanagement_title** -> `ticketmanagement-title` (Type: header, Required: 0)
* **ticketmanagement_btn_5** -> `ticketmanagement-btn-5` (Type: button, Required: 0)
* **ticketmanagement_content** -> `ticketmanagement-content` (Type: layout, Required: 0)
* **ticketmanagement_btn_3** -> `ticketmanagement-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `481` (Required: 1)
* Component ID: `1015` (Required: 1)
* Component ID: `1549` (Required: 1)
* Component ID: `5872` (Required: 1)
* Component ID: `5873` (Required: 1)
* Component ID: `5874` (Required: 1)
* Component ID: `5875` (Required: 1)
* Component ID: `5876` (Required: 1)
* Component ID: `5877` (Required: 1)
* Component ID: `5878` (Required: 1)
* Component ID: `5879` (Required: 1)
* Component ID: `5880` (Required: 1)
* Component ID: `5881` (Required: 1)

## 7. API / Data Mapping
* API ID: `4904` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `ticket_management_runtime`
* **Test Name**: `TicketManagementScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Ticket Management`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `customer_support`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Ticket Management`)
4. **click_sidebar_link** (Selector: `None`, Value: `Ticket Management`)
5. **check_url** (Selector: `None`, Value: `/staff/ticket-management`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
