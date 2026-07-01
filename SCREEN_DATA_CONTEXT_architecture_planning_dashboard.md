# SCREEN DATA CONTEXT: architecture_planning_dashboard

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - ArchitecturePlanningDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `10`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `architecture_planning_dashboard`
* **Screen Name**: `ArchitecturePlanningDashboardScreen`
* **Route Path**: `/common/architecture-planning-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `7`
* **App Code**: `co`
* **App Name**: `Primecare Corporate`

## 3. Role Record
* **ID**: `24`
* **Role Code**: `cto`
* **Role Name**: `Chief Technology Officer (CTO)`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to architectureplanningdashboardscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the ArchitecturePlanningDashboardScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ArchitecturePlanningDashboardScreen`
* **Acceptance Criteria**:
- The ArchitecturePlanningDashboardScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `architecture_planning_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `architecture_planning_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `architecture_planning_dashboard-content` (Type: layout, Required: 1)
* **architectureplanningdashboard_btn_1** -> `architectureplanningdashboard-btn-1` (Type: button, Required: 0)
* **architectureplanningdashboard_btn_2** -> `architectureplanningdashboard-btn-2` (Type: button, Required: 0)
* **architectureplanningdashboard_content** -> `architectureplanningdashboard-content` (Type: layout, Required: 0)
* **architectureplanningdashboard_btn_3** -> `architectureplanningdashboard-btn-3` (Type: button, Required: 0)
* **architectureplanningdashboard_title** -> `architectureplanningdashboard-title` (Type: header, Required: 0)
* **architectureplanningdashboard_screen** -> `architectureplanningdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `18` (Required: 1)
* Component ID: `552` (Required: 1)
* Component ID: `1086` (Required: 1)
* Component ID: `1683` (Required: 1)
* Component ID: `1684` (Required: 1)
* Component ID: `1685` (Required: 1)
* Component ID: `1686` (Required: 1)
* Component ID: `1687` (Required: 1)
* Component ID: `1688` (Required: 1)
* Component ID: `1689` (Required: 1)
* Component ID: `1690` (Required: 1)
* Component ID: `1691` (Required: 1)
* Component ID: `1692` (Required: 1)

## 7. API / Data Mapping
* API ID: `4259` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `architecture_planning_dashboard_runtime`
* **Test Name**: `ArchitecturePlanningDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Architecture Planning Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Architecture Planning Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Architecture Planning Dashboard`)
5. **check_url** (Selector: `None`, Value: `/common/architecture-planning-dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
