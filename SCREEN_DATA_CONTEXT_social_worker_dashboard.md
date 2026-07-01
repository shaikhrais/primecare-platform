# SCREEN DATA CONTEXT: social_worker_dashboard

Below are the database records from `governance.db` used to configure and build the **Social Worker - SocialWorkerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `28`
* **App ID**: `6`
* **Role ID**: `4`
* **Screen Code**: `social_worker_dashboard`
* **Screen Name**: `SocialWorkerDashboardScreen`
* **Route Path**: `/offices/clinical/roles/social_worker/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/social_worker_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `4`
* **Role Code**: `social_worker`
* **Role Name**: `Social Worker`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Social Worker personnel to oversee, audit, and coordinate operations related to socialworkerdashboardscreen.`
* **User Story**: `As a Social Worker, I want to access the SocialWorkerDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `SocialWorkerDashboardScreen`
* **Acceptance Criteria**:
- The SocialWorkerDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Social Worker access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `social_worker_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `social_worker_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `social_worker_dashboard-content` (Type: layout, Required: 1)
* **socialworkerdashboard_btn_1** -> `socialworkerdashboard-btn-1` (Type: button, Required: 0)
* **socialworkerdashboard_screen** -> `socialworkerdashboard-screen` (Type: layout, Required: 0)
* **socialworkerdashboard_btn_2** -> `socialworkerdashboard-btn-2` (Type: button, Required: 0)
* **socialworkerdashboard_title** -> `socialworkerdashboard-title` (Type: header, Required: 0)
* **socialworkerdashboard_loading** -> `socialworkerdashboard-loading` (Type: loading, Required: 0)
* **socialworkerdashboard_btn_3** -> `socialworkerdashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `36` (Required: 1)
* Component ID: `570` (Required: 1)
* Component ID: `1104` (Required: 1)
* Component ID: `1826` (Required: 1)
* Component ID: `1827` (Required: 1)
* Component ID: `1828` (Required: 1)
* Component ID: `1829` (Required: 1)
* Component ID: `1830` (Required: 1)
* Component ID: `1831` (Required: 1)

## 7. API / Data Mapping
* API ID: `4281` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `social_worker_dashboard_runtime`
* **Test Name**: `SocialWorkerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Social Worker Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `social_worker`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Social Worker Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Social Worker Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/social_worker/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
