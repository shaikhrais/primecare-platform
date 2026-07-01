# SCREEN DATA CONTEXT: community_outreach_analytics

Below are the database records from `governance.db` used to configure and build the **Community Outreach Lead - CommunityOutreachAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `186`
* **App ID**: `1`
* **Role ID**: `32`
* **Screen Code**: `community_outreach_analytics`
* **Screen Name**: `CommunityOutreachAnalyticsScreen`
* **Route Path**: `/management/community-outreach-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/community_outreach_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `32`
* **Role Code**: `community_outreach`
* **Role Name**: `Community Outreach Lead`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Community Outreach Lead personnel to oversee, audit, and coordinate operations related to communityoutreachanalyticsscreen.`
* **User Story**: `As a Community Outreach Lead, I want to access the CommunityOutreachAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CommunityOutreachAnalyticsScreen`
* **Acceptance Criteria**:
- The CommunityOutreachAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Community Outreach Lead access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `community_outreach_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `community_outreach_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `community_outreach_analytics-content` (Type: layout, Required: 1)
* **communityoutreachanalytics_loading** -> `communityoutreachanalytics-loading` (Type: loading, Required: 0)
* **communityoutreachanalytics_content** -> `communityoutreachanalytics-content` (Type: layout, Required: 0)
* **communityoutreachanalytics_title** -> `communityoutreachanalytics-title` (Type: header, Required: 0)
* **communityoutreachanalytics_screen** -> `communityoutreachanalytics-screen` (Type: layout, Required: 0)
* **communityoutreachanalytics_btn_2** -> `communityoutreachanalytics-btn-2` (Type: button, Required: 0)
* **communityoutreachanalytics_btn_3** -> `communityoutreachanalytics-btn-3` (Type: button, Required: 0)
* **communityoutreachanalytics_btn_1** -> `communityoutreachanalytics-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `194` (Required: 1)
* Component ID: `728` (Required: 1)
* Component ID: `1262` (Required: 1)
* Component ID: `3216` (Required: 1)
* Component ID: `3217` (Required: 1)
* Component ID: `3218` (Required: 1)
* Component ID: `3219` (Required: 1)
* Component ID: `3220` (Required: 1)
* Component ID: `3221` (Required: 1)
* Component ID: `3222` (Required: 1)
* Component ID: `3223` (Required: 1)
* Component ID: `3224` (Required: 1)
* Component ID: `3225` (Required: 1)

## 7. API / Data Mapping
* API ID: `4475` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `community_outreach_analytics_runtime`
* **Test Name**: `CommunityOutreachAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Community Outreach Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `community_outreach`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Community Outreach Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Community Outreach Analytics`)
5. **check_url** (Selector: `None`, Value: `/management/community-outreach-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
