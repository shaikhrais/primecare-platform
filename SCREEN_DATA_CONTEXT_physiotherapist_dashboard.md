# SCREEN DATA CONTEXT: physiotherapist_dashboard

Below are the database records from `governance.db` used to configure and build the **Physiotherapist - PhysiotherapistDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `25`
* **App ID**: `6`
* **Role ID**: `2`
* **Screen Code**: `physiotherapist_dashboard`
* **Screen Name**: `PhysiotherapistDashboardScreen`
* **Route Path**: `/offices/clinical/roles/physiotherapist/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `2`
* **Role Code**: `physio`
* **Role Name**: `Physiotherapist`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Physiotherapist personnel to oversee, audit, and coordinate operations related to physiotherapistdashboardscreen.`
* **User Story**: `As a Physiotherapist, I want to access the PhysiotherapistDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `PhysiotherapistDashboardScreen`
* **Acceptance Criteria**:
- The PhysiotherapistDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Physiotherapist access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `physiotherapist_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `physiotherapist_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `physiotherapist_dashboard-content` (Type: layout, Required: 1)
* **physiotherapistdashboard_btn_1** -> `physiotherapistdashboard-btn-1` (Type: button, Required: 0)
* **physiotherapistdashboard_loading** -> `physiotherapistdashboard-loading` (Type: loading, Required: 0)
* **physiotherapistdashboard_btn_3** -> `physiotherapistdashboard-btn-3` (Type: button, Required: 0)
* **physiotherapistdashboard_title** -> `physiotherapistdashboard-title` (Type: header, Required: 0)
* **physiotherapistdashboard_screen** -> `physiotherapistdashboard-screen` (Type: layout, Required: 0)
* **physiotherapistdashboard_btn_2** -> `physiotherapistdashboard-btn-2` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `33` (Required: 1)
* Component ID: `567` (Required: 1)
* Component ID: `1101` (Required: 1)
* Component ID: `1802` (Required: 1)
* Component ID: `1803` (Required: 1)
* Component ID: `1804` (Required: 1)
* Component ID: `1805` (Required: 1)
* Component ID: `1806` (Required: 1)
* Component ID: `1807` (Required: 1)
* Component ID: `1808` (Required: 1)
* Component ID: `1809` (Required: 1)

## 7. API / Data Mapping
* API ID: `4278` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `physiotherapist_dashboard_runtime`
* **Test Name**: `PhysiotherapistDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `PhysiotherapistDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `physio`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/physiotherapist/dashboard`)
3. **should_be_visible** (Selector: `physiotherapist_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `physiotherapist_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `physiotherapist_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
