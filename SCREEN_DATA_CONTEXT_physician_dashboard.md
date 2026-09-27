# SCREEN DATA CONTEXT: physician_dashboard

Below are the database records from `governance.db` used to configure and build the **Physician - PhysicianDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `9`
* **App ID**: `6`
* **Role ID**: `9`
* **Screen Code**: `physician_dashboard`
* **Screen Name**: `PhysicianDashboardScreen`
* **Route Path**: `/clinical/physician-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/physician_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `9`
* **Role Code**: `physician`
* **Role Name**: `Physician`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physician personnel to oversee, audit, and coordinate operations related to physiciandashboardscreen.`
* **User Story**: `As a Physician, I want to access the PhysicianDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysicianDashboardScreen`
* **Acceptance Criteria**:
- The PhysicianDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physician access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physician_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `physician_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `physician_dashboard-content` (Type: layout, Required: 1)
* **physiciandashboard_btn_1** -> `physiciandashboard-btn-1` (Type: button, Required: 0)
* **physiciandashboard_title** -> `physiciandashboard-title` (Type: header, Required: 0)
* **physiciandashboard_screen** -> `physiciandashboard-screen` (Type: layout, Required: 0)
* **physiciandashboard_btn_2** -> `physiciandashboard-btn-2` (Type: button, Required: 0)
* **physiciandashboard_loading** -> `physiciandashboard-loading` (Type: loading, Required: 0)
* **physiciandashboard_btn_3** -> `physiciandashboard-btn-3` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `17` (Required: 1)
* Component ID: `551` (Required: 1)
* Component ID: `1085` (Required: 1)
* Component ID: `1677` (Required: 1)
* Component ID: `1678` (Required: 1)
* Component ID: `1679` (Required: 1)
* Component ID: `1680` (Required: 1)
* Component ID: `1681` (Required: 1)
* Component ID: `1682` (Required: 1)

## 7. API / Data Mapping
* API ID: `4258` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physician_dashboard_runtime`
* **Test Name**: `PhysicianDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysicianDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physician`)
2. **visit** (Selector: `None`, Value: `/clinical/physician-dashboard`)
3. **should_be_visible** (Selector: `physician_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physician_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `physician_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
