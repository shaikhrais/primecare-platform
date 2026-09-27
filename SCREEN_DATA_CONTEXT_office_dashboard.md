# SCREEN DATA CONTEXT: office_dashboard

Below are the database records from `governance.db` used to configure and build the **Administrative Assistant - OfficeDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `23`
* **App ID**: `5`
* **Role ID**: `59`
* **Screen Code**: `office_dashboard`
* **Screen Name**: `OfficeDashboardScreen`
* **Route Path**: `/common/office-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Administrative Assistant personnel to oversee, audit, and coordinate operations related to officedashboardscreen.`
* **User Story**: `As a Administrative Assistant, I want to access the OfficeDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `OfficeDashboardScreen`
* **Acceptance Criteria**:
- The OfficeDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Administrative Assistant access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `office_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `office_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `office_dashboard-content` (Type: layout, Required: 1)
* **officedashboard_btn_1** -> `officedashboard-btn-1` (Type: button, Required: 0)
* **officedashboard_btn_3** -> `officedashboard-btn-3` (Type: button, Required: 0)
* **officedashboard_btn_2** -> `officedashboard-btn-2` (Type: button, Required: 0)
* **officedashboard_content** -> `officedashboard-content` (Type: layout, Required: 0)
* **officedashboard_screen** -> `officedashboard-screen` (Type: layout, Required: 0)
* **officedashboard_title** -> `officedashboard-title` (Type: header, Required: 0)
* **officedashboard_loading** -> `officedashboard-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `31` (Required: 1)
* Component ID: `565` (Required: 1)
* Component ID: `1099` (Required: 1)
* Component ID: `1784` (Required: 1)
* Component ID: `1785` (Required: 1)
* Component ID: `1786` (Required: 1)
* Component ID: `1787` (Required: 1)
* Component ID: `1788` (Required: 1)
* Component ID: `1789` (Required: 1)
* Component ID: `1790` (Required: 1)
* Component ID: `1791` (Required: 1)
* Component ID: `1792` (Required: 1)
* Component ID: `1793` (Required: 1)

## 7. API / Data Mapping
* API ID: `4276` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `office_dashboard_runtime`
* **Test Name**: `OfficeDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `OfficeDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `admin`)
2. **visit** (Selector: `None`, Value: `/common/office-dashboard`)
3. **should_be_visible** (Selector: `office_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `office_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `office_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
