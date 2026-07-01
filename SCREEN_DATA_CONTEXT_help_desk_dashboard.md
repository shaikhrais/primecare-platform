# SCREEN DATA CONTEXT: help_desk_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - HelpDeskDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `896`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `help_desk_dashboard`
* **Screen Name**: `HelpDeskDashboardScreen`
* **Route Path**: `/support/help-desk-dashboard`
* **Actual File Path**: `apps/primecare_support/lib/features/support/screens/help_desk_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to help desk dashboard.`
* **User Story**: `As a Guest, I want to access the Help Desk Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Help Desk Dashboard`
* **Acceptance Criteria**:
- The Help Desk Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `help_desk_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `help_desk_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `help_desk_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7928` (Required: 1)
* Component ID: `7929` (Required: 1)
* Component ID: `7930` (Required: 1)
* Component ID: `7931` (Required: 1)
* Component ID: `7932` (Required: 1)
* Component ID: `7933` (Required: 1)
* Component ID: `7934` (Required: 1)

## 7. API / Data Mapping
* API ID: `5310` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `help_desk_dashboard_runtime`
* **Test Name**: `Help Desk Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Help Desk Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Help Desk Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Help Desk Dashboard`)
5. **check_url** (Selector: `None`, Value: `/support/help-desk-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
