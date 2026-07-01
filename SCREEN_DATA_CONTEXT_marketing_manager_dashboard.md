# SCREEN DATA CONTEXT: marketing_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - MarketingManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `800`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `marketing_manager_dashboard`
* **Screen Name**: `MarketingManagerDashboardScreen`
* **Route Path**: `/offices/franchise/roles/marketing_manager/dashboard`
* **Actual File Path**: `apps/primecare_franchise/lib/features/marketing_manager/screens/marketing_manager_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to marketing manager dashboard.`
* **User Story**: `As a Guest, I want to access the Marketing Manager Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Marketing Manager Dashboard`
* **Acceptance Criteria**:
- The Marketing Manager Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `marketing_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `marketing_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `marketing_manager_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7379` (Required: 1)
* Component ID: `7380` (Required: 1)
* Component ID: `7381` (Required: 1)
* Component ID: `7382` (Required: 1)
* Component ID: `7383` (Required: 1)
* Component ID: `7384` (Required: 1)
* Component ID: `7385` (Required: 1)

## 7. API / Data Mapping
* API ID: `5188` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `marketing_manager_dashboard_runtime`
* **Test Name**: `Marketing Manager Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Marketing Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Marketing Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Marketing Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/marketing_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
