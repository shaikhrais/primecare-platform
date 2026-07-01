# SCREEN DATA CONTEXT: caregiver_dashboard

Below are the database records from `governance.db` used to configure and build the **Caregiver - CaregiverDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `12`
* **App ID**: `5`
* **Role ID**: `12`
* **Screen Code**: `caregiver_dashboard`
* **Screen Name**: `CaregiverDashboardScreen`
* **Route Path**: `/offices/clinical/roles/caregiver/dashboard`
* **Actual File Path**: `packages/primecare_ui/lib/src/screens/common/caregiver_dashboard_screen.dart`
* **Stage/Status**: `wired`

## 2. App Record
* **ID**: `5`
* **App Code**: `cl`
* **App Name**: `Primecare Client`

## 3. Role Record
* **ID**: `12`
* **Role Code**: `caregiver`
* **Role Name**: `Caregiver`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Client module to enable Caregiver personnel to oversee, audit, and coordinate operations related to caregiverdashboardscreen.`
* **User Story**: `As a Caregiver, I want to access the CaregiverDashboardScreen within the Primecare Client application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `CaregiverDashboardScreen`
* **Acceptance Criteria**:
- The CaregiverDashboardScreen route loads successfully within the Primecare Client workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Caregiver access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `caregiver_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `caregiver_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `caregiver_dashboard-content` (Type: layout, Required: 1)
* **caregiverdashboard_btn_2** -> `caregiverdashboard-btn-2` (Type: button, Required: 0)
* **caregiverdashboard_btn_3** -> `caregiverdashboard-btn-3` (Type: button, Required: 0)
* **caregiverdashboard_btn_1** -> `caregiverdashboard-btn-1` (Type: button, Required: 0)
* **caregiverdashboard_content** -> `caregiverdashboard-content` (Type: layout, Required: 0)
* **caregiverdashboard_screen** -> `caregiverdashboard-screen` (Type: layout, Required: 0)
* **caregiverdashboard_title** -> `caregiverdashboard-title` (Type: header, Required: 0)

## 6. Component Mapping
* Component ID: `20` (Required: 1)
* Component ID: `554` (Required: 1)
* Component ID: `1088` (Required: 1)
* Component ID: `1703` (Required: 1)
* Component ID: `1704` (Required: 1)
* Component ID: `1705` (Required: 1)
* Component ID: `1706` (Required: 1)
* Component ID: `1707` (Required: 1)
* Component ID: `1708` (Required: 1)

## 7. API / Data Mapping
* API ID: `4261` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `caregiver_dashboard_runtime`
* **Test Name**: `CaregiverDashboardScreen Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `Caregiver Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `caregiver`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `Caregiver Dashboard`)
4. **click_sidebar_link** (Selector: `None`, Value: `Caregiver Dashboard`)
5. **check_url** (Selector: `None`, Value: `/offices/clinical/roles/caregiver/dashboard`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
