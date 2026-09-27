# SCREEN DATA CONTEXT: vip_manager_dashboard

Below are the database records from `governance.db` used to configure and build the **VIP Client Manager - VipManagerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `60`
* **App ID**: `12`
* **Role ID**: `50`
* **Screen Code**: `vip_manager_dashboard`
* **Screen Name**: `VipManagerDashboardScreen`
* **Route Path**: `/management/vip-manager-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `12`
* **App Code**: `su`
* **App Name**: `Primecare Support`

## 3. Role Record
* **ID**: `50`
* **Role Code**: `vip_manager`
* **Role Name**: `VIP Client Manager`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Support module to enable VIP Client Manager personnel to oversee, audit, and coordinate operations related to vipmanagerdashboardscreen.`
* **User Story**: `As a VIP Client Manager, I want to access the VipManagerDashboardScreen within the Primecare Support application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `VipManagerDashboardScreen`
* **Acceptance Criteria**:
- The VipManagerDashboardScreen route loads successfully within the Primecare Support workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only VIP Client Manager access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `vip_manager_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `vip_manager_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `vip_manager_dashboard-content` (Type: layout, Required: 1)
* **vipmanagerdashboard_title** -> `vipmanagerdashboard-title` (Type: header, Required: 0)
* **vipmanagerdashboard_btn_2** -> `vipmanagerdashboard-btn-2` (Type: button, Required: 0)
* **vipmanagerdashboard_screen** -> `vipmanagerdashboard-screen` (Type: layout, Required: 0)
* **vipmanagerdashboard_content** -> `vipmanagerdashboard-content` (Type: layout, Required: 0)
* **vipmanagerdashboard_btn_1** -> `vipmanagerdashboard-btn-1` (Type: button, Required: 0)
* **vipmanagerdashboard_btn_3** -> `vipmanagerdashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `68` (Required: 1)
* Component ID: `602` (Required: 1)
* Component ID: `1136` (Required: 1)
* Component ID: `2116` (Required: 1)
* Component ID: `2117` (Required: 1)
* Component ID: `2118` (Required: 1)
* Component ID: `2119` (Required: 1)
* Component ID: `2120` (Required: 1)
* Component ID: `2121` (Required: 1)

## 7. API / Data Mapping
* API ID: `4315` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `vip_manager_dashboard_runtime`
* **Test Name**: `VipManagerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `VipManagerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `vip_manager`)
2. **visit** (Selector: `None`, Value: `/management/vip-manager-dashboard`)
3. **should_be_visible** (Selector: `vip_manager_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `vip_manager_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `vip_manager_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
