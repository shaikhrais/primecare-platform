# SCREEN DATA CONTEXT: governance_officer_dashboard

Below are the database records from `governance.db` used to configure and build the **Governance Officer - GovernanceOfficerDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `48`
* **App ID**: `10`
* **Role ID**: `36`
* **Screen Code**: `governance_officer_dashboard`
* **Screen Name**: `GovernanceOfficerDashboardScreen`
* **Route Path**: `/management/governance-officer-dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/management/governance_officer_dashboard_screen.dart`
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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Governance module to enable Governance Officer personnel to oversee, audit, and coordinate operations related to governanceofficerdashboardscreen.`
* **User Story**: `As a Governance Officer, I want to access the GovernanceOfficerDashboardScreen within the Primecare Governance application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `GovernanceOfficerDashboardScreen`
* **Acceptance Criteria**:
- The GovernanceOfficerDashboardScreen route loads successfully within the Primecare Governance workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Governance Officer access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `governance_officer_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `governance_officer_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `governance_officer_dashboard-content` (Type: layout, Required: 1)
* **governanceofficerdashboard_content** -> `governanceofficerdashboard-content` (Type: layout, Required: 0)
* **governanceofficerdashboard_title** -> `governanceofficerdashboard-title` (Type: header, Required: 0)
* **governanceofficerdashboard_btn_3** -> `governanceofficerdashboard-btn-3` (Type: button, Required: 0)
* **governanceofficerdashboard_btn_2** -> `governanceofficerdashboard-btn-2` (Type: button, Required: 0)
* **governanceofficerdashboard_screen** -> `governanceofficerdashboard-screen` (Type: layout, Required: 0)
* **governanceofficerdashboard_btn_1** -> `governanceofficerdashboard-btn-1` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `56` (Required: 1)
* Component ID: `590` (Required: 1)
* Component ID: `1124` (Required: 1)
* Component ID: `2005` (Required: 1)
* Component ID: `2006` (Required: 1)
* Component ID: `2007` (Required: 1)
* Component ID: `2008` (Required: 1)
* Component ID: `2009` (Required: 1)
* Component ID: `2010` (Required: 1)
* Component ID: `2011` (Required: 1)
* Component ID: `2012` (Required: 1)

## 7. API / Data Mapping
* API ID: `4303` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `governance_officer_dashboard_runtime`
* **Test Name**: `GovernanceOfficerDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `GovernanceOfficerDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `governance`)
2. **visit** (Selector: `None`, Value: `/management/governance-officer-dashboard`)
3. **should_be_visible** (Selector: `governance_officer_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `governance_officer_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `governance_officer_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
