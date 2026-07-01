# SCREEN DATA CONTEXT: customer_support_tickets

Below are the database records from `governance.db` used to configure and build the **Guest - CustomerSupportTicketsScreen** screen.

---

## 1. Screen Record
* **ID**: `873`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `customer_support_tickets`
* **Screen Name**: `CustomerSupportTicketsScreen`
* **Route Path**: `/generated/customer-support-tickets`
* **Actual File Path**: `apps/primecare_support/lib/features/generated_screens/customer_support_tickets_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to customer support tickets.`
* **User Story**: `As a Guest, I want to access the Customer Support Tickets within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Customer Support Tickets`
* **Acceptance Criteria**:
- The Customer Support Tickets route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `customer_support_tickets-screen` (Type: layout, Required: 1)
* **page_title** -> `customer_support_tickets-title` (Type: header, Required: 1)
* **primary_content** -> `customer_support_tickets-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7799` (Required: 1)
* Component ID: `7800` (Required: 1)
* Component ID: `7801` (Required: 1)
* Component ID: `7802` (Required: 1)
* Component ID: `7803` (Required: 1)
* Component ID: `7804` (Required: 1)
* Component ID: `7805` (Required: 1)
* Component ID: `7806` (Required: 1)

## 7. API / Data Mapping
* API ID: `5275` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `customer_support_tickets_runtime`
* **Test Name**: `Customer Support Tickets Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Customer Support Tickets`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Customer Support Tickets`)
4. **click_sidebar_link** (Selector: `None`, Value: `Customer Support Tickets`)
5. **check_url** (Selector: `None`, Value: `/generated/customer-support-tickets`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
