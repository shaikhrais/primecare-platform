# SCREEN DATA CONTEXT: infrastructure_dashboard

Below are the database records from `governance.db` used to configure and build the **Infrastructure Auditor - InfrastructureDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `21`
* **App ID**: `5`
* **Role ID**: `17`
* **Screen Code**: `infrastructure_dashboard`
* **Screen Name**: `InfrastructureDashboardScreen`
* **Route Path**: `/common/infrastructure-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `17`
* **Role Code**: `infrastructure`
* **Role Name**: `Infrastructure Auditor`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Infrastructure Auditor personnel to oversee, audit, and coordinate operations related to infrastructuredashboardscreen.`
* **User Story**: `As a Infrastructure Auditor, I want to access the InfrastructureDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `InfrastructureDashboardScreen`
* **Acceptance Criteria**:
- The InfrastructureDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Infrastructure Auditor access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `infrastructure_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `infrastructure_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `infrastructure_dashboard-content` (Type: layout, Required: 1)
* **infrastructuredashboard_btn_1** -> `infrastructuredashboard-btn-1` (Type: button, Required: 0)
* **infrastructuredashboard_title** -> `infrastructuredashboard-title` (Type: header, Required: 0)
* **infrastructuredashboard_btn_3** -> `infrastructuredashboard-btn-3` (Type: button, Required: 0)
* **infrastructuredashboard_btn_2** -> `infrastructuredashboard-btn-2` (Type: button, Required: 0)
* **infrastructuredashboard_screen** -> `infrastructuredashboard-screen` (Type: layout, Required: 0)
* **infrastructuredashboard_content** -> `infrastructuredashboard-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `29` (Required: 1)
* Component ID: `563` (Required: 1)
* Component ID: `1097` (Required: 1)
* Component ID: `1768` (Required: 1)
* Component ID: `1769` (Required: 1)
* Component ID: `1770` (Required: 1)
* Component ID: `1771` (Required: 1)
* Component ID: `1772` (Required: 1)
* Component ID: `1773` (Required: 1)

## 7. API / Data Mapping
* API ID: `4272` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `infrastructure_dashboard_runtime`
* **Test Name**: `InfrastructureDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `InfrastructureDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `infrastructure`)
2. **visit** (Selector: `None`, Value: `/common/infrastructure-dashboard`)
3. **should_be_visible** (Selector: `infrastructure_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `infrastructure_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `infrastructure_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
