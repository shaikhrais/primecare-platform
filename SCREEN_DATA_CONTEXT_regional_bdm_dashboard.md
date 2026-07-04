# SCREEN DATA CONTEXT: regional_bdm_dashboard

Below are the database records from `governance.db` used to configure and build the **Regional BDM - RegionalBdmDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `55`
* **App ID**: `5`
* **Role ID**: `42`
* **Screen Code**: `regional_bdm_dashboard`
* **Screen Name**: `RegionalBdmDashboardScreen`
* **Route Path**: `/offices/business_development/roles/regional_bdm/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/regional_bdm_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `42`
* **Role Code**: `regional_bdm`
* **Role Name**: `Regional BDM`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Regional BDM personnel to oversee, audit, and coordinate operations related to regionalbdmdashboardscreen.`
* **User Story**: `As a Regional BDM, I want to access the RegionalBdmDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `RegionalBdmDashboardScreen`
* **Acceptance Criteria**:
- The RegionalBdmDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Regional BDM access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `regional_bdm_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `regional_bdm_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `regional_bdm_dashboard-content` (Type: layout, Required: 1)
* **regionalbdmdashboard_title** -> `regionalbdmdashboard-title` (Type: header, Required: 0)
* **regionalbdmdashboard_screen** -> `regionalbdmdashboard-screen` (Type: layout, Required: 0)
* **regionalbdmdashboard_btn_3** -> `regionalbdmdashboard-btn-3` (Type: button, Required: 0)
* **regionalbdmdashboard_btn_1** -> `regionalbdmdashboard-btn-1` (Type: button, Required: 0)
* **regionalbdmdashboard_content** -> `regionalbdmdashboard-content` (Type: layout, Required: 0)
* **regionalbdmdashboard_btn_2** -> `regionalbdmdashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `63` (Required: 1)
* Component ID: `597` (Required: 1)
* Component ID: `1131` (Required: 1)
* Component ID: `2071` (Required: 1)
* Component ID: `2072` (Required: 1)
* Component ID: `2073` (Required: 1)
* Component ID: `2074` (Required: 1)
* Component ID: `2075` (Required: 1)
* Component ID: `2076` (Required: 1)
* Component ID: `2077` (Required: 1)

## 7. API / Data Mapping
* API ID: `4310` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `regional_bdm_dashboard_runtime`
* **Test Name**: `RegionalBdmDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `RegionalBdmDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `regional_bdm`)
2. **visit** (Selector: `None`, Value: `/offices/business_development/roles/regional_bdm/dashboard`)
3. **should_be_visible** (Selector: `regional_bdm_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `regional_bdm_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `regional_bdm_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
