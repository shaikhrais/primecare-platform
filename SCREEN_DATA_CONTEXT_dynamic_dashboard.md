# SCREEN DATA CONTEXT: dynamic_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - DynamicDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `1029`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `dynamic_dashboard`
* **Screen Name**: `DynamicDashboardScreen`
* **Route Path**: `/generated/dynamic-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to dynamic dashboard.`
* **User Story**: `As a Guest, I want to access the Dynamic Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Dynamic Dashboard`
* **Acceptance Criteria**:
- The Dynamic Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `dynamic_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `dynamic_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `dynamic_dashboard-content` (Type: layout, Required: 1)
* **dashboard_btn_run_compliance_scan** -> `dashboard-btn-run-compliance-scan` (Type: button, Required: 0)
* **dashboard_btn_trigger_actions** -> `dashboard-btn-trigger-actions` (Type: button, Required: 0)
* **dynamicscreendashboard_content** -> `dynamicscreendashboard-content` (Type: layout, Required: 0)
* **dashboard_btn_update_policies** -> `dashboard-btn-update-policies` (Type: button, Required: 0)
* **dashboard_btn_refresh_telemetry** -> `dashboard-btn-refresh-telemetry` (Type: button, Required: 0)
* **dashboard_btn_export_logs** -> `dashboard-btn-export-logs` (Type: button, Required: 0)
* **dashboard_btn_sync_security_posture** -> `dashboard-btn-sync-security-posture` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `8657` (Required: 1)
* Component ID: `8658` (Required: 1)
* Component ID: `8659` (Required: 1)
* Component ID: `8660` (Required: 1)
* Component ID: `8661` (Required: 1)
* Component ID: `8662` (Required: 1)
* Component ID: `8663` (Required: 1)
* Component ID: `8664` (Required: 1)
* Component ID: `8665` (Required: 1)
* Component ID: `8666` (Required: 1)

## 7. API / Data Mapping
* API ID: `4266` (Required: 1)
* API ID: `4267` (Required: 1)
* API ID: `4268` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `dynamic_dashboard_runtime`
* **Test Name**: `Dynamic Dashboard Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Dynamic Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Dynamic Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Dynamic Dashboard`)
5. **check_url** (Selector: `None`, Value: `/generated/dynamic-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
