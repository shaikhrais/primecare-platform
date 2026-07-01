# SCREEN DATA CONTEXT: chiropractor_analytics

Below are the database records from `governance.db` used to configure and build the **Chiropractor - ChiropractorAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `92`
* **App ID**: `1`
* **Role ID**: `1`
* **Screen Code**: `chiropractor_analytics`
* **Screen Name**: `ChiropractorAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/chiropractor_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to chiropractoranalyticsscreen.`
* **User Story**: `As a Chiropractor, I want to access the ChiropractorAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ChiropractorAnalyticsScreen`
* **Acceptance Criteria**:
- The ChiropractorAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `chiropractor_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `chiropractor_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `chiropractor_analytics-content` (Type: layout, Required: 1)
* **chiropractoranalytics_content** -> `chiropractoranalytics-content` (Type: layout, Required: 0)
* **chiropractoranalytics_screen** -> `chiropractoranalytics-screen` (Type: layout, Required: 0)
* **chiropractoranalytics_title** -> `chiropractoranalytics-title` (Type: header, Required: 0)
* **chiropractoranalytics_btn_1** -> `chiropractoranalytics-btn-1` (Type: button, Required: 0)
* **chiropractoranalytics_btn_2** -> `chiropractoranalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `100` (Required: 1)
* Component ID: `634` (Required: 1)
* Component ID: `1168` (Required: 1)
* Component ID: `2401` (Required: 1)
* Component ID: `2402` (Required: 1)
* Component ID: `2403` (Required: 1)
* Component ID: `2404` (Required: 1)
* Component ID: `2405` (Required: 1)
* Component ID: `2406` (Required: 1)
* Component ID: `2407` (Required: 1)
* Component ID: `2408` (Required: 1)
* Component ID: `2409` (Required: 1)
* Component ID: `2410` (Required: 1)
* Component ID: `2411` (Required: 1)
* Component ID: `2412` (Required: 1)
* Component ID: `2413` (Required: 1)
* Component ID: `2414` (Required: 1)
* Component ID: `2415` (Required: 1)
* Component ID: `2416` (Required: 1)

## 7. API / Data Mapping
* API ID: `4369` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `chiropractor_analytics_runtime`
* **Test Name**: `ChiropractorAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Chiropractor Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Chiropractor Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Chiropractor Analytics`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
