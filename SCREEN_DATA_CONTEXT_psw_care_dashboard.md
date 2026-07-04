# SCREEN DATA CONTEXT: psw_care_dashboard

Below are the database records from `governance.db` used to configure and build the **Guest - PswCareDashboardScreen** screen.

---

## 1. Screen Record
* **ID**: `694`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_care_dashboard`
* **Screen Name**: `PswCareDashboardScreen`
* **Route Path**: `/generated/psw-care-dashboard`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_care_dashboard_screen.dart`
* **Stage/Status**: `template_created`

## 2. App Record
* **ID**: `6`
* **App Code**: `ci`
* **App Name**: `Primecare Clinic`

## 3. Role Record
* **ID**: `13`
* **Role Code**: `guest`
* **Role Name**: `Guest`
* **Role Type**: `staff`

## 4. Screen Requirement Record
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw care dashboard.`
* **User Story**: `As a Guest, I want to access the Psw Care Dashboard within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Care Dashboard`
* **Acceptance Criteria**:
- The Psw Care Dashboard route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_care_dashboard-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_care_dashboard-title` (Type: header, Required: 1)
* **primary_content** -> `psw_care_dashboard-content` (Type: layout, Required: 1)
* **pswcaredashboard_content** -> `pswcaredashboard-content` (Type: layout, Required: 0)
* **psw_dashboard_btn_generate_report** -> `psw-dashboard-btn-generate-report` (Type: button, Required: 0)
* **psw_dashboard_btn_update_record** -> `psw-dashboard-btn-update-record` (Type: button, Required: 0)
* **psw_dashboard_btn_collaborate** -> `psw-dashboard-btn-collaborate` (Type: button, Required: 0)

## 6. Component Mapping
* Component ID: `6811` (Required: 1)
* Component ID: `6812` (Required: 1)
* Component ID: `6813` (Required: 1)
* Component ID: `6814` (Required: 1)
* Component ID: `6815` (Required: 1)
* Component ID: `6816` (Required: 1)
* Component ID: `6817` (Required: 1)

## 7. API / Data Mapping
* API ID: `5062` (Required: 1)
* API ID: `5063` (Required: 1)
* API ID: `5064` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_care_dashboard_runtime`
* **Test Name**: `Psw Care Dashboard Runtime Test`
* **Test Type**: `e2e`
* **Expected Title**: `Psw Care Dashboard`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **visit** (Selector: `None`, Value: `/generated/psw-care-dashboard`)
3. **should_be_visible** (Selector: `psw_care_dashboard-screen`, Value: `None`)
4. **should_be_visible** (Selector: `psw_care_dashboard-title`, Value: `None`)
5. **should_be_visible** (Selector: `psw_care_dashboard-content`, Value: `None`)
6. **check_no_console_error** (Selector: `None`, Value: `None`)
7. **screenshot** (Selector: `None`, Value: `None`)
