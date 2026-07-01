# SCREEN DATA CONTEXT: business_development_dashboard

Below are the database records from `governance.db` used to configure and build the **Head of Business Development - BusinessDevelopmentDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `11`
* **App ID**: `4`
* **Role ID**: `37`
* **Screen Code**: `business_development_dashboard`
* **Screen Name**: `BusinessDevelopmentDashboardScreen`
* **Route Path**: `/common/business-development-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `4`
* **App Code**: `bd`
* **App Name**: `Primecare Business Development`

## 3. Role Record
* **ID**: `37`
* **Role Code**: `bus_dev`
* **Role Name**: `Head of Business Development`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Business Development module to enable Head of Business Development personnel to oversee, audit, and coordinate operations related to businessdevelopmentdashboardscreen.`
* **User Story**: `As a Head of Business Development, I want to access the BusinessDevelopmentDashboardScreen within the Primecare Business Development application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `BusinessDevelopmentDashboardScreen`
* **Acceptance Criteria**:
- The BusinessDevelopmentDashboardScreen route loads successfully within the Primecare Business Development workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Head of Business Development access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `business_development_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `business_development_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `business_development_dashboard-content` (Type: layout, Required: 1)
* **businessdevelopmentdashboard_btn_1** -> `businessdevelopmentdashboard-btn-1` (Type: button, Required: 0)
* **businessdevelopmentdashboard_title** -> `businessdevelopmentdashboard-title` (Type: header, Required: 0)
* **businessdevelopmentdashboard_btn_3** -> `businessdevelopmentdashboard-btn-3` (Type: button, Required: 0)
* **businessdevelopmentdashboard_btn_2** -> `businessdevelopmentdashboard-btn-2` (Type: button, Required: 0)
* **businessdevelopmentdashboard_content** -> `businessdevelopmentdashboard-content` (Type: layout, Required: 0)
* **businessdevelopmentdashboard_screen** -> `businessdevelopmentdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `19` (Required: 1)
* Component ID: `553` (Required: 1)
* Component ID: `1087` (Required: 1)
* Component ID: `1693` (Required: 1)
* Component ID: `1694` (Required: 1)
* Component ID: `1695` (Required: 1)
* Component ID: `1696` (Required: 1)
* Component ID: `1697` (Required: 1)
* Component ID: `1698` (Required: 1)
* Component ID: `1699` (Required: 1)
* Component ID: `1700` (Required: 1)
* Component ID: `1701` (Required: 1)
* Component ID: `1702` (Required: 1)

## 7. API / Data Mapping
* API ID: `4260` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `business_development_dashboard_runtime`
* **Test Name**: `BusinessDevelopmentDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Business Development Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `bus_dev`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Business Development Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Business Development Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/business-development-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
