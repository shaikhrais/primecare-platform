# SCREEN DATA CONTEXT: cns_dashboard

Below are the database records from `governance.db` used to configure and build the **Clinical Nurse Specialist - CnsDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `4`
* **App ID**: `6`
* **Role ID**: `10`
* **Screen Code**: `cns_dashboard`
* **Screen Name**: `CnsDashboardScreen`
* **Route Path**: `/clinical/cns-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/clinical/cns_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `10`
* **Role Code**: `cns`
* **Role Name**: `Clinical Nurse Specialist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Clinical Nurse Specialist personnel to oversee, audit, and coordinate operations related to cnsdashboardscreen.`
* **User Story**: `As a Clinical Nurse Specialist, I want to access the CnsDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CnsDashboardScreen`
* **Acceptance Criteria**:
- The CnsDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Clinical Nurse Specialist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `cns_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `cns_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `cns_dashboard-content` (Type: layout, Required: 1)
* **cnsdashboard_content** -> `cnsdashboard-content` (Type: layout, Required: 0)
* **cnsdashboard_btn_2** -> `cnsdashboard-btn-2` (Type: button, Required: 0)
* **cnsdashboard_btn_1** -> `cnsdashboard-btn-1` (Type: button, Required: 0)
* **cnsdashboard_title** -> `cnsdashboard-title` (Type: header, Required: 0)
* **cnsdashboard_screen** -> `cnsdashboard-screen` (Type: layout, Required: 0)
* **cnsdashboard_btn_3** -> `cnsdashboard-btn-3` (Type: button, Required: 0)
* **cnsdashboard_loading** -> `cnsdashboard-loading` (Type: loading, Required: 0)

## 6. Component Mapping
* Component ID: `12` (Required: 1)
* Component ID: `546` (Required: 1)
* Component ID: `1080` (Required: 1)
* Component ID: `1635` (Required: 1)
* Component ID: `1636` (Required: 1)
* Component ID: `1637` (Required: 1)
* Component ID: `1638` (Required: 1)
* Component ID: `1639` (Required: 1)
* Component ID: `1640` (Required: 1)
* Component ID: `1641` (Required: 1)
* Component ID: `1642` (Required: 1)

## 7. API / Data Mapping
* API ID: `4253` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `cns_dashboard_runtime`
* **Test Name**: `CnsDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `CnsDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `cns`)
2. **visit** (Selector: `None`, Value: `/clinical/cns-dashboard`)
3. **should_be_visible** (Selector: `cns_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `cns_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `cns_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
