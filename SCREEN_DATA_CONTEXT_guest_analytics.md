# SCREEN DATA CONTEXT: guest_analytics

Below are the database records from `governance.db` used to configure and build the **Guest - GuestAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `113`
* **App ID**: `1`
* **Role ID**: `13`
* **Screen Code**: `guest_analytics`
* **Screen Name**: `GuestAnalyticsScreen`
* **Route Path**: `/common/guest-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/guest_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Guest personnel to oversee, audit, and coordinate operations related to guestanalyticsscreen.`
* **User Story**: `As a Guest, I want to access the GuestAnalyticsScreen within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GuestAnalyticsScreen`
* **Acceptance Criteria**:
- The GuestAnalyticsScreen route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `guest_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `guest_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `guest_analytics-content` (Type: layout, Required: 1)
* **guestanalytics_screen** -> `guestanalytics-screen` (Type: layout, Required: 0)
* **guestanalytics_btn_1** -> `guestanalytics-btn-1` (Type: button, Required: 0)
* **guestanalytics_btn_3** -> `guestanalytics-btn-3` (Type: button, Required: 0)
* **guestanalytics_title** -> `guestanalytics-title` (Type: header, Required: 0)
* **guestanalytics_btn_2** -> `guestanalytics-btn-2` (Type: button, Required: 0)
* **guestanalytics_content** -> `guestanalytics-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `121` (Required: 1)
* Component ID: `655` (Required: 1)
* Component ID: `1189` (Required: 1)
* Component ID: `2573` (Required: 1)
* Component ID: `2574` (Required: 1)
* Component ID: `2575` (Required: 1)
* Component ID: `2576` (Required: 1)
* Component ID: `2577` (Required: 1)

## 7. API / Data Mapping
* API ID: `4390` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `guest_analytics_runtime`
* **Test Name**: `GuestAnalyticsScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Guest Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Guest Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Guest Analytics`)
5. **check_url** (Selector: `None`, Value: `/common/guest-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
