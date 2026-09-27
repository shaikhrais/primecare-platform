# SCREEN DATA CONTEXT: api_health_dashboard

Below are the database records from `governance.db` used to configure and build the **Governance Officer - ApiHealthDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `585`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `api_health_dashboard`
* **Screen Name**: `ApiHealthDashboardScreen`
* **Route Path**: `/common/api-health-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/api_health_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `10`
* **App Code**: `go`
* **App Name**: `Primecare Governance`

## 3. Role Record
* **ID**: `36`
* **Role Code**: `governance`
* **Role Name**: `Governance Officer`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to apihealthdashboardscreen.`
* **User Story**: `As a Governance Officer, I want to access the ApiHealthDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ApiHealthDashboardScreen`
* **Acceptance Criteria**:
- The ApiHealthDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `api_health_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `api_health_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `api_health_dashboard-content` (Type: layout, Required: 1)
* **apihealthdashboard_btn_2** -> `apihealthdashboard-btn-2` (Type: button, Required: 0)
* **apihealthdashboard_btn_1** -> `apihealthdashboard-btn-1` (Type: button, Required: 0)
* **apihealthdashboard_content** -> `apihealthdashboard-content` (Type: layout, Required: 0)
* **apihealthdashboard_btn_3** -> `apihealthdashboard-btn-3` (Type: button, Required: 0)
* **apihealthdashboard_screen** -> `apihealthdashboard-screen` (Type: layout, Required: 0)
* **apihealthdashboard_title** -> `apihealthdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `509` (Required: 1)
* Component ID: `1043` (Required: 1)
* Component ID: `1577` (Required: 1)
* Component ID: `6102` (Required: 1)
* Component ID: `6103` (Required: 1)
* Component ID: `6104` (Required: 1)
* Component ID: `6105` (Required: 1)
* Component ID: `6106` (Required: 1)
* Component ID: `6107` (Required: 1)
* Component ID: `6108` (Required: 1)
* Component ID: `6109` (Required: 1)
* Component ID: `6110` (Required: 1)
* Component ID: `6111` (Required: 1)
* Component ID: `6112` (Required: 1)
* Component ID: `6113` (Required: 1)

## 7. API / Data Mapping
* API ID: `4934` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `api_health_dashboard_runtime`
* **Test Name**: `ApiHealthDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ApiHealthDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/common/api-health-dashboard`)
3. **should_be_visible** (Selector: `api_health_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `api_health_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `api_health_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
