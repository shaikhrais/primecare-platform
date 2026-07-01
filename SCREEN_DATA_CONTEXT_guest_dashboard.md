# SCREEN DATA CONTEXT: guest_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - GuestDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `20`
* **App ID**: `5`
* **Role ID**: `13`
* **Screen Code**: `guest_dashboard`
* **Screen Name**: `GuestDashboardScreen`
* **Route Path**: `/common/guest-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Guest personnel to oversee, audit, and coordinate operations related to guestdashboardscreen.`
* **User Story**: `As a Guest, I want to access the GuestDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GuestDashboardScreen`
* **Acceptance Criteria**:
- The GuestDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `guest_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `guest_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `guest_dashboard-content` (Type: layout, Required: 1)
* **guestdashboard_content** -> `guestdashboard-content` (Type: layout, Required: 0)
* **guestdashboard_loading** -> `guestdashboard-loading` (Type: loading, Required: 0)
* **guestdashboard_btn_5** -> `guestdashboard-btn-5` (Type: button, Required: 0)
* **guestdashboard_btn_4** -> `guestdashboard-btn-4` (Type: button, Required: 0)
* **guestdashboard_btn_2** -> `guestdashboard-btn-2` (Type: button, Required: 0)
* **guestdashboard_screen** -> `guestdashboard-screen` (Type: layout, Required: 0)
* **guestdashboard_title** -> `guestdashboard-title` (Type: header, Required: 0)
* **guestdashboard_btn_3** -> `guestdashboard-btn-3` (Type: button, Required: 0)
* **guestdashboard_btn_1** -> `guestdashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `28` (Required: 1)
* Component ID: `562` (Required: 1)
* Component ID: `1096` (Required: 1)
* Component ID: `1763` (Required: 1)
* Component ID: `1764` (Required: 1)
* Component ID: `1765` (Required: 1)
* Component ID: `1766` (Required: 1)
* Component ID: `1767` (Required: 1)

## 7. API / Data Mapping
* API ID: `4271` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `guest_dashboard_runtime`
* **Test Name**: `GuestDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Guest Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Guest Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Guest Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/guest-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
