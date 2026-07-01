# SCREEN DATA CONTEXT: rpn_dashboard

Below are the database records from `governance.db` used to configure and build the **Registered Practical Nurse (RPN) - RpnDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `64`
* **App ID**: `6`
* **Role ID**: `55`
* **Screen Code**: `rpn_dashboard`
* **Screen Name**: `RpnDashboardScreen`
* **Route Path**: `/offices/clinical/roles/rpn/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/rpn/rpn_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `55`
* **Role Code**: `rpn`
* **Role Name**: `Registered Practical Nurse (RPN)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Registered Practical Nurse (RPN) personnel to oversee, audit, and coordinate operations related to rpndashboardscreen.`
* **User Story**: `As a Registered Practical Nurse (RPN), I want to access the RpnDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RpnDashboardScreen`
* **Acceptance Criteria**:
- The RpnDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Practical Nurse (RPN) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rpn_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `rpn_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `rpn_dashboard-content` (Type: layout, Required: 1)
* **rpndashboard_screen** -> `rpndashboard-screen` (Type: layout, Required: 0)
* **rpndashboard_btn_2** -> `rpndashboard-btn-2` (Type: button, Required: 0)
* **rpndashboard_loading** -> `rpndashboard-loading` (Type: loading, Required: 0)
* **rpndashboard_btn_3** -> `rpndashboard-btn-3` (Type: button, Required: 0)
* **rpndashboard_title** -> `rpndashboard-title` (Type: header, Required: 0)
* **rpndashboard_btn_1** -> `rpndashboard-btn-1` (Type: button, Required: 0)
* **rpndashboard_content** -> `rpndashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `72` (Required: 1)
* Component ID: `606` (Required: 1)
* Component ID: `1140` (Required: 1)
* Component ID: `2150` (Required: 1)
* Component ID: `2151` (Required: 1)
* Component ID: `2152` (Required: 1)
* Component ID: `2153` (Required: 1)
* Component ID: `2154` (Required: 1)
* Component ID: `2155` (Required: 1)
* Component ID: `2156` (Required: 1)
* Component ID: `2157` (Required: 1)
* Component ID: `2158` (Required: 1)
* Component ID: `2159` (Required: 1)

## 7. API / Data Mapping
* API ID: `4323` (Required: 1)
* API ID: `4324` (Required: 1)
* API ID: `4325` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rpn_dashboard_runtime`
* **Test Name**: `RpnDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Rpn Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rpn`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Rpn Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Rpn Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rpn/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
