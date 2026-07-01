# SCREEN DATA CONTEXT: responsive_preview

Below are the database records from `governance.db` used to configure and build the **Governance Officer - ResponsivePreviewScreen** screen.

---

## 1. Screen Record
* **ID**: `589`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `responsive_preview`
* **Screen Name**: `ResponsivePreviewScreen`
* **Route Path**: `/common/responsive-preview`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/responsive_preview_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to responsivepreviewscreen.`
* **User Story**: `As a Governance Officer, I want to access the ResponsivePreviewScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ResponsivePreviewScreen`
* **Acceptance Criteria**:
- The ResponsivePreviewScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `responsive_preview-screen` (Type: layout, Required: 1)
* **page_title** -> `responsive_preview-title` (Type: header, Required: 1)
* **primary_content** -> `responsive_preview-content` (Type: layout, Required: 1)
* **responsivepreview_btn_2** -> `responsivepreview-btn-2` (Type: button, Required: 0)
* **responsivepreview_title** -> `responsivepreview-title` (Type: header, Required: 0)
* **responsivepreview_loading** -> `responsivepreview-loading` (Type: loading, Required: 0)
* **responsivepreview_screen** -> `responsivepreview-screen` (Type: layout, Required: 0)
* **responsivepreview_btn_3** -> `responsivepreview-btn-3` (Type: button, Required: 0)
* **responsivepreview_btn_1** -> `responsivepreview-btn-1` (Type: button, Required: 0)
* **responsivepreview_content** -> `responsivepreview-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `513` (Required: 1)
* Component ID: `1047` (Required: 1)
* Component ID: `1581` (Required: 1)
* Component ID: `6143` (Required: 1)
* Component ID: `6144` (Required: 1)
* Component ID: `6145` (Required: 1)
* Component ID: `6146` (Required: 1)
* Component ID: `6147` (Required: 1)
* Component ID: `6148` (Required: 1)
* Component ID: `6149` (Required: 1)
* Component ID: `6150` (Required: 1)
* Component ID: `6151` (Required: 1)
* Component ID: `6152` (Required: 1)

## 7. API / Data Mapping
* API ID: `4938` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `responsive_preview_runtime`
* **Test Name**: `ResponsivePreviewScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Responsive Preview`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Responsive Preview`)
4. **click_sidebar_link** (Selector: `None`, Value: `Responsive Preview`)
5. **check_url** (Selector: `None`, Value: `/common/responsive-preview`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
