# SCREEN DATA CONTEXT: compliance_dashboard

Below are the database records from `governance.db` used to configure and build the **Compliance Manager - ComplianceDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `485`
* **App ID**: `5`
* **Role ID**: `33`
* **Screen Code**: `compliance_dashboard`
* **Screen Name**: `ComplianceDashboardScreen`
* **Route Path**: `/management/compliance-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/compliance_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `33`
* **Role Code**: `compliance`
* **Role Name**: `Compliance Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Compliance Manager personnel to oversee, audit, and coordinate operations related to compliancedashboardscreen.`
* **User Story**: `As a Compliance Manager, I want to access the ComplianceDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ComplianceDashboardScreen`
* **Acceptance Criteria**:
- The ComplianceDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Compliance Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `compliance_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `compliance_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `compliance_dashboard-content` (Type: layout, Required: 1)
* **compliancedashboard_title** -> `compliancedashboard-title` (Type: header, Required: 0)
* **compliancedashboard_btn_3** -> `compliancedashboard-btn-3` (Type: button, Required: 0)
* **compliancedashboard_btn_1** -> `compliancedashboard-btn-1` (Type: button, Required: 0)
* **compliancedashboard_btn_2** -> `compliancedashboard-btn-2` (Type: button, Required: 0)
* **compliancedashboard_screen** -> `compliancedashboard-screen` (Type: layout, Required: 0)
* **compliancedashboard_content** -> `compliancedashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `414` (Required: 1)
* Component ID: `948` (Required: 1)
* Component ID: `1482` (Required: 1)
* Component ID: `5234` (Required: 1)
* Component ID: `5235` (Required: 1)
* Component ID: `5236` (Required: 1)
* Component ID: `5237` (Required: 1)
* Component ID: `5238` (Required: 1)
* Component ID: `5239` (Required: 1)
* Component ID: `5240` (Required: 1)
* Component ID: `5241` (Required: 1)
* Component ID: `5242` (Required: 1)
* Component ID: `5243` (Required: 1)

## 7. API / Data Mapping
* API ID: `4802` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `compliance_dashboard_runtime`
* **Test Name**: `ComplianceDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Compliance Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `compliance`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Compliance Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Compliance Dashboard`)
5. **check_url** (Selector: `None`, Value: `/management/compliance-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
