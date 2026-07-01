# SCREEN DATA CONTEXT: physician_analytics

Below are the database records from `governance.db` used to configure and build the **Physician - PhysicianAnalyticsScreen** screen.

---

## 1. Screen Record
* **ID**: `599`
* **App ID**: `1`
* **Role ID**: `9`
* **Screen Code**: `physician_analytics`
* **Screen Name**: `PhysicianAnalyticsScreen`
* **Route Path**: `/clinical/physician-analytics`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/physician_analytics_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `1`
* **App Code**: `ui`
* **App Name**: `PrimeCare UI Client`

## 3. Role Record
* **ID**: `9`
* **Role Code**: `physician`
* **Role Name**: `Physician`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the PrimeCare UI Client module to enable Physician personnel to oversee, audit, and coordinate operations related to physician analytics.`
* **User Story**: `As a Physician, I want to access the Physician Analytics within the PrimeCare UI Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Physician Analytics`
* **Acceptance Criteria**:
- The Physician Analytics route loads successfully within the PrimeCare UI Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physician access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physician_analytics-screen` (Type: layout, Required: 1)
* **page_title** -> `physician_analytics-title` (Type: header, Required: 1)
* **primary_content** -> `physician_analytics-content` (Type: layout, Required: 1)
* **physician analytics_title** -> `physician analytics-title` (Type: header, Required: 0)
* **physician analytics_btn_1** -> `physician analytics-btn-1` (Type: button, Required: 0)
* **physician analytics_screen** -> `physician analytics-screen` (Type: layout, Required: 0)
* **physician analytics_content** -> `physician analytics-content` (Type: layout, Required: 0)
* **physician analytics_loading** -> `physician analytics-loading` (Type: loading, Required: 0)
* **physician analytics_btn_2** -> `physician analytics-btn-2` (Type: button, Required: 0)
* **physician analytics_btn_3** -> `physician analytics-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `523` (Required: 1)
* Component ID: `1057` (Required: 1)
* Component ID: `1591` (Required: 1)
* Component ID: `6240` (Required: 1)
* Component ID: `6241` (Required: 1)
* Component ID: `6242` (Required: 1)
* Component ID: `6243` (Required: 1)
* Component ID: `6244` (Required: 1)
* Component ID: `6245` (Required: 1)
* Component ID: `6246` (Required: 1)

## 7. API / Data Mapping
* API ID: `4948` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physician_analytics_runtime`
* **Test Name**: `Physician Analytics Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Physician Analytics`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physician`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Physician Analytics`)
4. **click_sidebar_link** (Selector: `None`, Value: `Physician Analytics`)
5. **check_url** (Selector: `None`, Value: `/clinical/physician-analytics`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
