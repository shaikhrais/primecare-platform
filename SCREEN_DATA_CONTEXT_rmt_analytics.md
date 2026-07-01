# SCREEN DATA CONTEXT: rmt_analytics

Below are the database records from `governance.db` used to configure and build the **Registered Massage Therapist (RMT) - RmtAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `76`
* **App ID**: `1`
* **Role ID**: `3`
* **Screen Code**: `rmt_analytics`
* **Screen Name**: `RmtAnalyticsScreen`
* **Route Path**: `/offices/clinical/roles/rmt/analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/rmt_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `3`
* **Role Code**: `rmt`
* **Role Name**: `Registered Massage Therapist (RMT)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Registered Massage Therapist (RMT) personnel to oversee, audit, and coordinate operations related to rmtanalyticsscreen.`
* **User Story**: `As a Registered Massage Therapist (RMT), I want to access the RmtAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RmtAnalyticsScreen`
* **Acceptance Criteria**:
- The RmtAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Registered Massage Therapist (RMT) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `rmt_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `rmt_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `rmt_analytics-content` (Type: layout, Required: 1)
* **rmtanalytics_btn_1** -> `rmtanalytics-btn-1` (Type: button, Required: 0)
* **rmtanalytics_title** -> `rmtanalytics-title` (Type: header, Required: 0)
* **rmtanalytics_screen** -> `rmtanalytics-screen` (Type: layout, Required: 0)
* **rmtanalytics_content** -> `rmtanalytics-content` (Type: layout, Required: 0)
* **rmtanalytics_btn_2** -> `rmtanalytics-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `84` (Required: 1)
* Component ID: `618` (Required: 1)
* Component ID: `1152` (Required: 1)
* Component ID: `2255` (Required: 1)
* Component ID: `2256` (Required: 1)
* Component ID: `2257` (Required: 1)
* Component ID: `2258` (Required: 1)
* Component ID: `2259` (Required: 1)
* Component ID: `2260` (Required: 1)
* Component ID: `2261` (Required: 1)
* Component ID: `2262` (Required: 1)
* Component ID: `2263` (Required: 1)
* Component ID: `2264` (Required: 1)

## 7. API / Data Mapping
* API ID: `4341` (Required: 1)
* API ID: `4342` (Required: 1)
* API ID: `4343` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `rmt_analytics_runtime`
* **Test Name**: `RmtAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `RMT Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `rmt`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `RMT Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `RMT Analytics`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/rmt/analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
