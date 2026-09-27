# SCREEN DATA CONTEXT: hsw_dashboard

Below are the database records from `governance.db` used to configure and build the **Home Support Worker - HswDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `5`
* **App ID**: `6`
* **Role ID**: `52`
* **Screen Code**: `hsw_dashboard`
* **Screen Name**: `HswDashboardScreen`
* **Route Path**: `/clinical/hsw-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/hsw_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `52`
* **Role Code**: `hsw`
* **Role Name**: `Home Support Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Home Support Worker personnel to oversee, audit, and coordinate operations related to hswdashboardscreen.`
* **User Story**: `As a Home Support Worker, I want to access the HswDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `HswDashboardScreen`
* **Acceptance Criteria**:
- The HswDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Home Support Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `hsw_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `hsw_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `hsw_dashboard-content` (Type: layout, Required: 1)
* **hswdashboard_btn_2** -> `hswdashboard-btn-2` (Type: button, Required: 0)
* **hswdashboard_title** -> `hswdashboard-title` (Type: header, Required: 0)
* **hswdashboard_content** -> `hswdashboard-content` (Type: layout, Required: 0)
* **hswdashboard_btn_1** -> `hswdashboard-btn-1` (Type: button, Required: 0)
* **hswdashboard_loading** -> `hswdashboard-loading` (Type: loading, Required: 0)
* **hswdashboard_btn_3** -> `hswdashboard-btn-3` (Type: button, Required: 0)
* **hswdashboard_screen** -> `hswdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `13` (Required: 1)
* Component ID: `547` (Required: 1)
* Component ID: `1081` (Required: 1)
* Component ID: `1643` (Required: 1)
* Component ID: `1644` (Required: 1)
* Component ID: `1645` (Required: 1)
* Component ID: `1646` (Required: 1)

## 7. API / Data Mapping
* API ID: `4254` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `hsw_dashboard_runtime`
* **Test Name**: `HswDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `HswDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `hsw`)
2. **visit** (Selector: `None`, Value: `/clinical/hsw-dashboard`)
3. **should_be_visible** (Selector: `hsw_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `hsw_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `hsw_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
