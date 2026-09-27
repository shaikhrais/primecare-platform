# SCREEN DATA CONTEXT: api_monitoring

Below are the database records from `governance.db` used to configure and build the **Chief Technology Officer (CTO) - ApiMonitoringScreen** screen.

---

## 1. Screen Record
* **ID**: `481`
* **App ID**: `7`
* **Role ID**: `24`
* **Screen Code**: `api_monitoring`
* **Screen Name**: `ApiMonitoringScreen`
* **Route Path**: `/executive/api-monitoring`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/executive/api_monitoring_screen.dart`
* **Stage/Status**: `template_created`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Corporate module to enable Chief Technology Officer (CTO) personnel to oversee, audit, and coordinate operations related to apimonitoringscreen.`
* **User Story**: `As a Chief Technology Officer (CTO), I want to access the ApiMonitoringScreen within the Primecare Corporate application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ApiMonitoringScreen`
* **Acceptance Criteria**:
- The ApiMonitoringScreen route loads successfully within the Primecare Corporate workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Chief Technology Officer (CTO) access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `api_monitoring-screen` (Type: layout, Required: 1)
* **page_title** -> `api_monitoring-title` (Type: header, Required: 1)
* **primary_content** -> `api_monitoring-content` (Type: layout, Required: 1)
* **apimonitoring_btn_2** -> `apimonitoring-btn-2` (Type: button, Required: 0)
* **apimonitoring_loading** -> `apimonitoring-loading` (Type: loading, Required: 0)
* **apimonitoring_btn_1** -> `apimonitoring-btn-1` (Type: button, Required: 0)
* **apimonitoring_title** -> `apimonitoring-title` (Type: header, Required: 0)
* **apimonitoring_screen** -> `apimonitoring-screen` (Type: layout, Required: 0)
* **apimonitoring_content** -> `apimonitoring-content` (Type: layout, Required: 0)
* **apimonitoring_btn_3** -> `apimonitoring-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `410` (Required: 1)
* Component ID: `944` (Required: 1)
* Component ID: `1478` (Required: 1)
* Component ID: `5194` (Required: 1)
* Component ID: `5195` (Required: 1)
* Component ID: `5196` (Required: 1)
* Component ID: `5197` (Required: 1)
* Component ID: `5198` (Required: 1)
* Component ID: `5199` (Required: 1)
* Component ID: `5200` (Required: 1)
* Component ID: `5201` (Required: 1)
* Component ID: `5202` (Required: 1)
* Component ID: `5203` (Required: 1)

## 7. API / Data Mapping
* API ID: `4798` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `api_monitoring_runtime`
* **Test Name**: `ApiMonitoringScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ApiMonitoringScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cto`)
2. **visit** (Selector: `None`, Value: `/executive/api-monitoring`)
3. **should_be_visible** (Selector: `api_monitoring-screen`, Value: `None`)
4. **should_be_visible** (Selector: `api_monitoring-title`, Value: `None`)
5. **should_be_visible** (Selector: `api_monitoring-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
