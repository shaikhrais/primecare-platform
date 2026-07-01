# SCREEN DATA CONTEXT: psw_dashboard

Below are the database records from `governance.db` used to configure and build the **Personal Support Worker (PSW) - PswDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `61`
* **App ID**: `6`
* **Role ID**: `51`
* **Screen Code**: `psw_dashboard`
* **Screen Name**: `PswDashboardScreen`
* **Route Path**: `/offices/clinical/roles/psw/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `51`
* **Role Code**: `psw`
* **Role Name**: `Personal Support Worker (PSW)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Personal Support Worker (PSW) personnel to oversee, audit, and coordinate operations related to pswdashboardscreen.`
* **User Story**: `As a Personal Support Worker (PSW), I want to access the PswDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PswDashboardScreen`
* **Acceptance Criteria**:
- The PswDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Personal Support Worker (PSW) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `psw_dashboard-content` (Type: layout, Required: 1)
* **pswdashboard_title** -> `pswdashboard-title` (Type: header, Required: 0)
* **pswdashboard_btn_emergency** -> `pswdashboard-btn-emergency` (Type: button, Required: 0)
* **pswdashboard_btn_checkin** -> `pswdashboard-btn-checkin` (Type: button, Required: 0)
* **pswdashboard_btn_1** -> `pswdashboard-btn-1` (Type: button, Required: 0)
* **pswdashboard_btn_3** -> `pswdashboard-btn-3` (Type: button, Required: 0)
* **pswdashboard_screen** -> `pswdashboard-screen` (Type: layout, Required: 0)
* **pswdashboard_loading** -> `pswdashboard-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `69` (Required: 1)
* Component ID: `603` (Required: 1)
* Component ID: `1137` (Required: 1)
* Component ID: `2122` (Required: 1)
* Component ID: `2123` (Required: 1)
* Component ID: `2124` (Required: 1)
* Component ID: `2125` (Required: 1)
* Component ID: `2126` (Required: 1)
* Component ID: `2127` (Required: 1)
* Component ID: `2128` (Required: 1)
* Component ID: `2129` (Required: 1)

## 7. API / Data Mapping
* API ID: `4316` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_dashboard_runtime`
* **Test Name**: `PswDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `psw`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/psw/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
