# SCREEN DATA CONTEXT: compliance_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `45`
* **App ID**: `10`
* **Role ID**: `33`
* **Screen Code**: `compliance_manager_dashboard`
* **Screen Name**: `ComplianceManagerDashboardScreen`
* **Route Path**: `/offices/corporate/roles/compliance_manager/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_manager_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancemanagerdashboardscreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceManagerDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceManagerDashboardScreen`
* **Acceptance Criteria**:
- The ComplianceManagerDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_manager_dashboard-content` (Type: layout, Required: 1)
* **compliancemanagerdashboard_screen** -> `compliancemanagerdashboard-screen` (Type: layout, Required: 0)
* **compliancemanagerdashboard_title** -> `compliancemanagerdashboard-title` (Type: header, Required: 0)
* **compliancemanagerdashboard_btn_1** -> `compliancemanagerdashboard-btn-1` (Type: button, Required: 0)
* **compliancemanagerdashboard_btn_2** -> `compliancemanagerdashboard-btn-2` (Type: button, Required: 0)
* **compliancemanagerdashboard_btn_3** -> `compliancemanagerdashboard-btn-3` (Type: button, Required: 0)
* **compliancemanagerdashboard_content** -> `compliancemanagerdashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `53` (Required: 1)
* Component ID: `587` (Required: 1)
* Component ID: `1121` (Required: 1)
* Component ID: `1981` (Required: 1)
* Component ID: `1982` (Required: 1)
* Component ID: `1983` (Required: 1)
* Component ID: `1984` (Required: 1)

## 7. API / Data Mapping
* API ID: `4300` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_manager_dashboard_runtime`
* **Test Name**: `ComplianceManagerDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Manager Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Manager Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Manager Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/corporate/roles/compliance_manager/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
