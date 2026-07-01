# SCREEN DATA CONTEXT: it_admin_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - ItAdminDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `760`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `it_admin_dashboard`
* **Screen Name**: `ItAdminDashboardScreen`
* **Route Path**: `/offices/corporate/roles/it_admin/dashboard`
* **Actual File Path**: `apps/primecare_corporate/lib/features/itadmin/screens/it_admin_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to it admin dashboard.`
* **User Story**: `As a Guest, I want to access the It Admin Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `It Admin Dashboard`
* **Acceptance Criteria**:
- The It Admin Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `it_admin_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `it_admin_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `it_admin_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7176` (Required: 1)
* Component ID: `7177` (Required: 1)
* Component ID: `7178` (Required: 1)
* Component ID: `7179` (Required: 1)
* Component ID: `7180` (Required: 1)
* Component ID: `7181` (Required: 1)
* Component ID: `7182` (Required: 1)
* Component ID: `7183` (Required: 1)

## 7. API / Data Mapping
* API ID: `5150` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `it_admin_dashboard_runtime`
* **Test Name**: `It Admin Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `It Admin Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `It Admin Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `It Admin Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/it_admin/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
