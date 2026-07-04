# SCREEN DATA CONTEXT: intake_dashboard

Below are the database records from `governance.db` used to configure and build the **Intake Coordinator - IntakeDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `22`
* **App ID**: `6`
* **Role ID**: `7`
* **Screen Code**: `intake_dashboard`
* **Screen Name**: `IntakeDashboardScreen`
* **Route Path**: `/offices/clinical/roles/intake_coordinator/dashboard-dup-1`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/intake_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `7`
* **Role Code**: `intake`
* **Role Name**: `Intake Coordinator`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Intake Coordinator personnel to oversee, audit, and coordinate operations related to intakedashboardscreen.`
* **User Story**: `As a Intake Coordinator, I want to access the IntakeDashboardScreen within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `IntakeDashboardScreen`
* **Acceptance Criteria**:
- The IntakeDashboardScreen route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Intake Coordinator access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `intake_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `intake_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `intake_dashboard-content` (Type: layout, Required: 1)
* **intakedashboard_btn_1** -> `intakedashboard-btn-1` (Type: button, Required: 0)
* **intakedashboard_btn_3** -> `intakedashboard-btn-3` (Type: button, Required: 0)
* **intakedashboard_content** -> `intakedashboard-content` (Type: layout, Required: 0)
* **intakedashboard_screen** -> `intakedashboard-screen` (Type: layout, Required: 0)
* **intakedashboard_btn_2** -> `intakedashboard-btn-2` (Type: button, Required: 0)
* **intakedashboard_loading** -> `intakedashboard-loading` (Type: loading, Required: 0)
* **intakedashboard_title** -> `intakedashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `30` (Required: 1)
* Component ID: `564` (Required: 1)
* Component ID: `1098` (Required: 1)
* Component ID: `1774` (Required: 1)
* Component ID: `1775` (Required: 1)
* Component ID: `1776` (Required: 1)
* Component ID: `1777` (Required: 1)
* Component ID: `1778` (Required: 1)
* Component ID: `1779` (Required: 1)
* Component ID: `1780` (Required: 1)
* Component ID: `1781` (Required: 1)
* Component ID: `1782` (Required: 1)
* Component ID: `1783` (Required: 1)

## 7. API / Data Mapping
* API ID: `4273` (Required: 1)
* API ID: `4274` (Required: 1)
* API ID: `4275` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `intake_dashboard_runtime`
* **Test Name**: `IntakeDashboardScreen Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `IntakeDashboardScreen`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `intake`)
2. **visit** (Selector: `None`, Value: `/offices/clinical/roles/intake_coordinator/dashboard-dup-1`)
3. **should_be_visible** (Selector: `intake_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `intake_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `intake_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
