# SCREEN DATA CONTEXT: receptionist_dashboard

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - ReceptionistDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `71`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `receptionist_dashboard`
* **Screen Name**: `ReceptionistDashboardScreen`
* **Route Path**: `/staff/receptionist-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `59`
* **Role Code**: `admin`
* **Role Name**: `Administrative Assistant`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to receptionistdashboardscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the ReceptionistDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `ReceptionistDashboardScreen`
* **Acceptance Criteria**:
- The ReceptionistDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `receptionist_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `receptionist_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `receptionist_dashboard-content` (Type: layout, Required: 1)
* **receptionistdashboard_title** -> `receptionistdashboard-title` (Type: header, Required: 0)
* **receptionistdashboard_btn_3** -> `receptionistdashboard-btn-3` (Type: button, Required: 0)
* **receptionistdashboard_btn_4** -> `receptionistdashboard-btn-4` (Type: button, Required: 0)
* **receptionistdashboard_btn_2** -> `receptionistdashboard-btn-2` (Type: button, Required: 0)
* **receptionistdashboard_btn_1** -> `receptionistdashboard-btn-1` (Type: button, Required: 0)
* **receptionistdashboard_btn_5** -> `receptionistdashboard-btn-5` (Type: button, Required: 0)
* **receptionistdashboard_content** -> `receptionistdashboard-content` (Type: layout, Required: 0)
* **receptionistdashboard_screen** -> `receptionistdashboard-screen` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `79` (Required: 1)
* Component ID: `613` (Required: 1)
* Component ID: `1147` (Required: 1)
* Component ID: `2211` (Required: 1)
* Component ID: `2212` (Required: 1)
* Component ID: `2213` (Required: 1)
* Component ID: `2214` (Required: 1)
* Component ID: `2215` (Required: 1)
* Component ID: `2216` (Required: 1)
* Component ID: `2217` (Required: 1)
* Component ID: `2218` (Required: 1)
* Component ID: `2219` (Required: 1)
* Component ID: `2220` (Required: 1)

## 7. API / Data Mapping
* API ID: `4336` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `receptionist_dashboard_runtime`
* **Test Name**: `ReceptionistDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `ReceptionistDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/staff/receptionist-dashboard`)
3. **should_be_visible** (Selector: `receptionist_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `receptionist_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `receptionist_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
