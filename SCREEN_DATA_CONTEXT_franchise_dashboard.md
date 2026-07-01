# SCREEN DATA CONTEXT: franchise_dashboard

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `19`
* **App ID**: `9`
* **Role ID**: `29`
* **Screen Code**: `franchise_dashboard`
* **Screen Name**: `FranchiseDashboardScreen`
* **Route Path**: `/common/franchise-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `9`
* **App Code**: `fr`
* **App Name**: `Primecare Franchise`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Franchise module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchisedashboardscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseDashboardScreen within the Primecare Franchise application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseDashboardScreen`
* **Acceptance Criteria**:
- The FranchiseDashboardScreen route loads successfully within the Primecare Franchise workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_dashboard-content` (Type: layout, Required: 1)
* **franchisedashboard_content** -> `franchisedashboard-content` (Type: layout, Required: 0)
* **franchisedashboard_screen** -> `franchisedashboard-screen` (Type: layout, Required: 0)
* **franchisedashboard_title** -> `franchisedashboard-title` (Type: header, Required: 0)
* **franchisedashboard_btn_2** -> `franchisedashboard-btn-2` (Type: button, Required: 0)
* **franchisedashboard_btn_1** -> `franchisedashboard-btn-1` (Type: button, Required: 0)
* **franchisedashboard_btn_3** -> `franchisedashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `27` (Required: 1)
* Component ID: `561` (Required: 1)
* Component ID: `1095` (Required: 1)
* Component ID: `1753` (Required: 1)
* Component ID: `1754` (Required: 1)
* Component ID: `1755` (Required: 1)
* Component ID: `1756` (Required: 1)
* Component ID: `1757` (Required: 1)
* Component ID: `1758` (Required: 1)
* Component ID: `1759` (Required: 1)
* Component ID: `1760` (Required: 1)
* Component ID: `1761` (Required: 1)
* Component ID: `1762` (Required: 1)

## 7. API / Data Mapping
* API ID: `4270` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_dashboard_runtime`
* **Test Name**: `FranchiseDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/franchise-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
