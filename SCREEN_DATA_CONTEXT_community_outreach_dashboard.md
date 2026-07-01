# SCREEN DATA CONTEXT: community_outreach_dashboard

Below are the database records from `governance.db` used to configure and build the **Community Outreach Lead - CommunityOutreachDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `44`
* **App ID**: `5`
* **Role ID**: `32`
* **Screen Code**: `community_outreach_dashboard`
* **Screen Name**: `CommunityOutreachDashboardScreen`
* **Route Path**: `/offices/marketing/roles/community_outreach/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/community_outreach_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `32`
* **Role Code**: `community_outreach`
* **Role Name**: `Community Outreach Lead`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Community Outreach Lead personnel to oversee, audit, and coordinate operations related to communityoutreachdashboardscreen.`
* **User Story**: `As a Community Outreach Lead, I want to access the CommunityOutreachDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CommunityOutreachDashboardScreen`
* **Acceptance Criteria**:
- The CommunityOutreachDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Community Outreach Lead access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_outreach_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `community_outreach_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `community_outreach_dashboard-content` (Type: layout, Required: 1)
* **communityoutreachdashboard_title** -> `communityoutreachdashboard-title` (Type: header, Required: 0)
* **communityoutreachdashboard_btn_1** -> `communityoutreachdashboard-btn-1` (Type: button, Required: 0)
* **communityoutreachdashboard_content** -> `communityoutreachdashboard-content` (Type: layout, Required: 0)
* **communityoutreachdashboard_btn_2** -> `communityoutreachdashboard-btn-2` (Type: button, Required: 0)
* **communityoutreachdashboard_btn_3** -> `communityoutreachdashboard-btn-3` (Type: button, Required: 0)
* **communityoutreachdashboard_screen** -> `communityoutreachdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `52` (Required: 1)
* Component ID: `586` (Required: 1)
* Component ID: `1120` (Required: 1)
* Component ID: `1971` (Required: 1)
* Component ID: `1972` (Required: 1)
* Component ID: `1973` (Required: 1)
* Component ID: `1974` (Required: 1)
* Component ID: `1975` (Required: 1)
* Component ID: `1976` (Required: 1)
* Component ID: `1977` (Required: 1)
* Component ID: `1978` (Required: 1)
* Component ID: `1979` (Required: 1)
* Component ID: `1980` (Required: 1)

## 7. API / Data Mapping
* API ID: `4299` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_outreach_dashboard_runtime`
* **Test Name**: `CommunityOutreachDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Community Outreach Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `community_outreach`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Community Outreach Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Community Outreach Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/marketing/roles/community_outreach/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
