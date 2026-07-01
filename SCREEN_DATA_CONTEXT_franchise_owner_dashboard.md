# SCREEN DATA CONTEXT: franchise_owner_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - FranchiseOwnerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `793`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `franchise_owner_dashboard`
* **Screen Name**: `FranchiseOwnerDashboardScreen`
* **Route Path**: `/offices/franchise/roles/franchise_owner/dashboard`
* **Actual File Path**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to franchise owner dashboard.`
* **User Story**: `As a Guest, I want to access the Franchise Owner Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Franchise Owner Dashboard`
* **Acceptance Criteria**:
- The Franchise Owner Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_owner_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_owner_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_owner_dashboard-content` (Type: layout, Required: 1)

## 6. Component Mapping
* Component ID: `7341` (Required: 1)
* Component ID: `7342` (Required: 1)
* Component ID: `7343` (Required: 1)
* Component ID: `7344` (Required: 1)
* Component ID: `7345` (Required: 1)
* Component ID: `7346` (Required: 1)
* Component ID: `7347` (Required: 1)
* Component ID: `7348` (Required: 1)

## 7. API / Data Mapping
* API ID: `5181` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_owner_dashboard_runtime`
* **Test Name**: `Franchise Owner Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Owner Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Owner Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Owner Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/franchise/roles/franchise_owner/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
