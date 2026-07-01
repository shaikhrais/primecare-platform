# SCREEN DATA CONTEXT: premium_concierge_dashboard

Below are the database records from `governance.db` used to configure and build the **Premium Concierge Care Coordinator - PremiumConciergeDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `54`
* **App ID**: `12`
* **Role ID**: `49`
* **Screen Code**: `premium_concierge_dashboard`
* **Screen Name**: `PremiumConciergeDashboardScreen`
* **Route Path**: `/management/premium-concierge-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `12`
* **App Code**: `su`
* **App Name**: `Primecare Support`

## 3. Role Record
* **ID**: `49`
* **Role Code**: `premium_concierge`
* **Role Name**: `Premium Concierge Care Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Support module to enable Premium Concierge Care Coordinator personnel to oversee, audit, and coordinate operations related to premiumconciergedashboardscreen.`
* **User Story**: `As a Premium Concierge Care Coordinator, I want to access the PremiumConciergeDashboardScreen within the Primecare Support application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PremiumConciergeDashboardScreen`
* **Acceptance Criteria**:
- The PremiumConciergeDashboardScreen route loads successfully within the Primecare Support workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Premium Concierge Care Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `premium_concierge_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `premium_concierge_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `premium_concierge_dashboard-content` (Type: layout, Required: 1)
* **premiumconciergedashboard_content** -> `premiumconciergedashboard-content` (Type: layout, Required: 0)
* **premiumconciergedashboard_btn_1** -> `premiumconciergedashboard-btn-1` (Type: button, Required: 0)
* **premiumconciergedashboard_screen** -> `premiumconciergedashboard-screen` (Type: layout, Required: 0)
* **premiumconciergedashboard_btn_2** -> `premiumconciergedashboard-btn-2` (Type: button, Required: 0)
* **premiumconciergedashboard_btn_3** -> `premiumconciergedashboard-btn-3` (Type: button, Required: 0)
* **premiumconciergedashboard_title** -> `premiumconciergedashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `62` (Required: 1)
* Component ID: `596` (Required: 1)
* Component ID: `1130` (Required: 1)
* Component ID: `2063` (Required: 1)
* Component ID: `2064` (Required: 1)
* Component ID: `2065` (Required: 1)
* Component ID: `2066` (Required: 1)
* Component ID: `2067` (Required: 1)
* Component ID: `2068` (Required: 1)
* Component ID: `2069` (Required: 1)
* Component ID: `2070` (Required: 1)

## 7. API / Data Mapping
* API ID: `4309` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `premium_concierge_dashboard_runtime`
* **Test Name**: `PremiumConciergeDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Premium Concierge Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `premium_concierge`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Premium Concierge Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Premium Concierge Dashboard`)
5. **check_url** (Selector: `None`, Value: `/management/premium-concierge-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
