# SCREEN DATA CONTEXT: xray_review

Below are the database records from `governance.db` used to configure and build the **Chiropractor - XrayReviewScreen** screen.

---

## 1. Screen Record
* **ID**: `547`
* **App ID**: `5`
* **Role ID**: `1`
* **Screen Code**: `xray_review`
* **Screen Name**: `XrayReviewScreen`
* **Route Path**: `/offices/clinical/roles/chiropractor/xray-review`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/allied/xray_review_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `1`
* **Role Code**: `chiropractor`
* **Role Name**: `Chiropractor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Chiropractor personnel to oversee, audit, and coordinate operations related to xrayreviewscreen.`
* **User Story**: `As a Chiropractor, I want to access the XrayReviewScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `XrayReviewScreen`
* **Acceptance Criteria**:
- The XrayReviewScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chiropractor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `xray_review-screen` (Type: layout, Required: 1)
* **page_title** -> `xray_review-title` (Type: header, Required: 1)
* **primary_content** -> `xray_review-content` (Type: layout, Required: 1)
* **xrayreview_content** -> `xrayreview-content` (Type: layout, Required: 0)
* **xrayreview_btn_1** -> `xrayreview-btn-1` (Type: button, Required: 0)
* **xrayreview_btn_2** -> `xrayreview-btn-2` (Type: button, Required: 0)
* **xrayreview_title** -> `xrayreview-title` (Type: header, Required: 0)
* **xrayreview_loading** -> `xrayreview-loading` (Type: loading, Required: 0)
* **xrayreview_screen** -> `xrayreview-screen` (Type: layout, Required: 0)
* **xrayreview_btn_3** -> `xrayreview-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `471` (Required: 1)
* Component ID: `1005` (Required: 1)
* Component ID: `1539` (Required: 1)
* Component ID: `5784` (Required: 1)
* Component ID: `5785` (Required: 1)
* Component ID: `5786` (Required: 1)
* Component ID: `5787` (Required: 1)
* Component ID: `5788` (Required: 1)
* Component ID: `5789` (Required: 1)
* Component ID: `5790` (Required: 1)
* Component ID: `5791` (Required: 1)

## 7. API / Data Mapping
* API ID: `4884` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `xray_review_runtime`
* **Test Name**: `XrayReviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Xray Review`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `chiropractor`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Xray Review`)
4. **click_sidebar_link** (Selector: `None`, Value: `Xray Review`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/chiropractor/xray-review`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
