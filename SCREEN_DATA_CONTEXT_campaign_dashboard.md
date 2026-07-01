# SCREEN DATA CONTEXT: campaign_dashboard

Below are the database records from `governance.db` used to configure and build the **Head of Marketing - CampaignDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `499`
* **App ID**: `11`
* **Role ID**: `38`
* **Screen Code**: `campaign_dashboard`
* **Screen Name**: `CampaignDashboardScreen`
* **Route Path**: `/management/campaign-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `11`
* **App Code**: `ma`
* **App Name**: `Primecare Marketing`

## 3. Role Record
* **ID**: `38`
* **Role Code**: `marketing`
* **Role Name**: `Head of Marketing`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Marketing module to enable Head of Marketing personnel to oversee, audit, and coordinate operations related to campaigndashboardscreen.`
* **User Story**: `As a Head of Marketing, I want to access the CampaignDashboardScreen within the Primecare Marketing application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CampaignDashboardScreen`
* **Acceptance Criteria**:
- The CampaignDashboardScreen route loads successfully within the Primecare Marketing workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Marketing access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `campaign_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `campaign_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `campaign_dashboard-content` (Type: layout, Required: 1)
* **campaigndashboard_content** -> `campaigndashboard-content` (Type: layout, Required: 0)
* **campaigndashboard_btn_1** -> `campaigndashboard-btn-1` (Type: button, Required: 0)
* **campaigndashboard_title** -> `campaigndashboard-title` (Type: header, Required: 0)
* **campaigndashboard_loading** -> `campaigndashboard-loading` (Type: loading, Required: 0)
* **campaigndashboard_btn_2** -> `campaigndashboard-btn-2` (Type: button, Required: 0)
* **campaigndashboard_btn_3** -> `campaigndashboard-btn-3` (Type: button, Required: 0)
* **campaigndashboard_screen** -> `campaigndashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `428` (Required: 1)
* Component ID: `962` (Required: 1)
* Component ID: `1496` (Required: 1)
* Component ID: `5373` (Required: 1)
* Component ID: `5374` (Required: 1)
* Component ID: `5375` (Required: 1)
* Component ID: `5376` (Required: 1)
* Component ID: `5377` (Required: 1)
* Component ID: `5378` (Required: 1)
* Component ID: `5379` (Required: 1)
* Component ID: `5380` (Required: 1)

## 7. API / Data Mapping
* API ID: `4816` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `campaign_dashboard_runtime`
* **Test Name**: `CampaignDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Campaign Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `marketing`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Campaign Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Campaign Dashboard`)
5. **check_url** (Selector: `None`, Value: `/management/campaign-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
