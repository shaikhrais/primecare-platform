# SCREEN DATA CONTEXT: dynamic_screen_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - DynamicScreenDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `17`
* **App ID**: `5`
* **Role ID**: `13`
* **Screen Code**: `dynamic_screen_dashboard`
* **Screen Name**: `DynamicScreenDashboardScreen`
* **Route Path**: `/common/dynamic-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Guest personnel to oversee, audit, and coordinate operations related to dynamicscreendashboardscreen.`
* **User Story**: `As a Guest, I want to access the DynamicScreenDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `DynamicScreenDashboardScreen`
* **Acceptance Criteria**:
- The DynamicScreenDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `dynamic_screen_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `dynamic_screen_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `dynamic_screen_dashboard-content` (Type: layout, Required: 1)
* **dashboard_btn_run_compliance_scan** -> `dashboard-btn-run-compliance-scan` (Type: button, Required: 0)
* **dashboard_btn_trigger_actions** -> `dashboard-btn-trigger-actions` (Type: button, Required: 0)
* **dynamicscreendashboard_content** -> `dynamicscreendashboard-content` (Type: layout, Required: 0)
* **dashboard_btn_update_policies** -> `dashboard-btn-update-policies` (Type: button, Required: 0)
* **dashboard_btn_refresh_telemetry** -> `dashboard-btn-refresh-telemetry` (Type: button, Required: 0)
* **dashboard_btn_export_logs** -> `dashboard-btn-export-logs` (Type: button, Required: 0)
* **dashboard_btn_sync_security_posture** -> `dashboard-btn-sync-security-posture` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `25` (Required: 1)
* Component ID: `559` (Required: 1)
* Component ID: `1093` (Required: 1)
* Component ID: `1741` (Required: 1)
* Component ID: `1742` (Required: 1)
* Component ID: `1743` (Required: 1)
* Component ID: `1744` (Required: 1)
* Component ID: `1745` (Required: 1)

## 7. API / Data Mapping
* API ID: `4266` (Required: 1)
* API ID: `4267` (Required: 1)
* API ID: `4268` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `dynamic_screen_dashboard_runtime`
* **Test Name**: `DynamicScreenDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `DynamicScreenDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/common/dynamic-dashboard`)
3. **should_be_visible** (Selector: `dynamic_screen_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `dynamic_screen_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `dynamic_screen_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
