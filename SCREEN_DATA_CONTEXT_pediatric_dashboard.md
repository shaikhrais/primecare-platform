# SCREEN DATA CONTEXT: pediatric_dashboard

Below are the database records from `governance.db` used to configure and build the **Pediatric Specialist - PediatricDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `8`
* **App ID**: `6`
* **Role ID**: `11`
* **Screen Code**: `pediatric_dashboard`
* **Screen Name**: `PediatricDashboardScreen`
* **Route Path**: `/clinical/pediatric-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/pediatric_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `11`
* **Role Code**: `pediatric`
* **Role Name**: `Pediatric Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Pediatric Specialist personnel to oversee, audit, and coordinate operations related to pediatricdashboardscreen.`
* **User Story**: `As a Pediatric Specialist, I want to access the PediatricDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PediatricDashboardScreen`
* **Acceptance Criteria**:
- The PediatricDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Pediatric Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `pediatric_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `pediatric_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `pediatric_dashboard-content` (Type: layout, Required: 1)
* **pediatricdashboard_btn_1** -> `pediatricdashboard-btn-1` (Type: button, Required: 0)
* **pediatricdashboard_btn_4** -> `pediatricdashboard-btn-4` (Type: button, Required: 0)
* **pediatricdashboard_btn_2** -> `pediatricdashboard-btn-2` (Type: button, Required: 0)
* **pediatricdashboard_btn_3** -> `pediatricdashboard-btn-3` (Type: button, Required: 0)
* **pediatricdashboard_screen** -> `pediatricdashboard-screen` (Type: layout, Required: 0)
* **pediatricdashboard_content** -> `pediatricdashboard-content` (Type: layout, Required: 0)
* **pediatricdashboard_title** -> `pediatricdashboard-title` (Type: header, Required: 0)
* **pediatricdashboard_btn_5** -> `pediatricdashboard-btn-5` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `16` (Required: 1)
* Component ID: `550` (Required: 1)
* Component ID: `1084` (Required: 1)
* Component ID: `1667` (Required: 1)
* Component ID: `1668` (Required: 1)
* Component ID: `1669` (Required: 1)
* Component ID: `1670` (Required: 1)
* Component ID: `1671` (Required: 1)
* Component ID: `1672` (Required: 1)
* Component ID: `1673` (Required: 1)
* Component ID: `1674` (Required: 1)
* Component ID: `1675` (Required: 1)
* Component ID: `1676` (Required: 1)

## 7. API / Data Mapping
* API ID: `4257` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `pediatric_dashboard_runtime`
* **Test Name**: `PediatricDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PediatricDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `pediatric`)
2. **visit** (Selector: `None`, Value: `/clinical/pediatric-dashboard`)
3. **should_be_visible** (Selector: `pediatric_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `pediatric_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `pediatric_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
