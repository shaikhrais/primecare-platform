# SCREEN DATA CONTEXT: franchise_analytics

Below are the database records from `governance.db` used to configure and build the **Franchise Owner - FranchiseAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `110`
* **App ID**: `1`
* **Role ID**: `29`
* **Screen Code**: `franchise_analytics`
* **Screen Name**: `FranchiseAnalyticsScreen`
* **Route Path**: `/common/franchise-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/franchise_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `29`
* **Role Code**: `owner`
* **Role Name**: `Franchise Owner`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Franchise Owner personnel to oversee, audit, and coordinate operations related to franchiseanalyticsscreen.`
* **User Story**: `As a Franchise Owner, I want to access the FranchiseAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `FranchiseAnalyticsScreen`
* **Acceptance Criteria**:
- The FranchiseAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Franchise Owner access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `franchise_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `franchise_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `franchise_analytics-content` (Type: layout, Required: 1)
* **franchiseanalytics_content** -> `franchiseanalytics-content` (Type: layout, Required: 0)
* **franchiseanalytics_title** -> `franchiseanalytics-title` (Type: header, Required: 0)
* **franchiseanalytics_btn_1** -> `franchiseanalytics-btn-1` (Type: button, Required: 0)
* **franchiseanalytics_btn_2** -> `franchiseanalytics-btn-2` (Type: button, Required: 0)
* **franchiseanalytics_screen** -> `franchiseanalytics-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `118` (Required: 1)
* Component ID: `652` (Required: 1)
* Component ID: `1186` (Required: 1)
* Component ID: `2545` (Required: 1)
* Component ID: `2546` (Required: 1)
* Component ID: `2547` (Required: 1)
* Component ID: `2548` (Required: 1)
* Component ID: `2549` (Required: 1)
* Component ID: `2550` (Required: 1)
* Component ID: `2551` (Required: 1)
* Component ID: `2552` (Required: 1)
* Component ID: `2553` (Required: 1)
* Component ID: `2554` (Required: 1)

## 7. API / Data Mapping
* API ID: `4387` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `franchise_analytics_runtime`
* **Test Name**: `FranchiseAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Franchise Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `owner`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Franchise Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Franchise Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/franchise-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
