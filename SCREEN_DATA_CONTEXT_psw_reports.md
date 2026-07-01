# SCREEN DATA CONTEXT: psw_reports

Below are the database records from `governance.db` used to configure and build the **Guest - PswReportsScreen** screen.

---

## 1. Screen Record
* **ID**: `690`
* **App ID**: `6`
* **Role ID**: `13`
* **Screen Code**: `psw_reports`
* **Screen Name**: `PswReportsScreen`
* **Route Path**: `/generated/psw-reports`
* **Actual File Path**: `apps/primecare_clinic/lib/features/psw/screens/psw_reports_screen.dart`
* **Stage/Status**: `wired`

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
* **Business Purpose**: `Provides a dedicated management interface within the Primecare Clinic module to enable Guest personnel to oversee, audit, and coordinate operations related to psw reports.`
* **User Story**: `As a Guest, I want to access the Psw Reports within the Primecare Clinic application so that I can review real-time status details, execute core operational workflows, and manage my domain responsibilities.`
* **Sidebar Label**: `Psw Reports`
* **Acceptance Criteria**:
- The Psw Reports route loads successfully within the Primecare Clinic workspace.
- The interface correctly displays all primary modules and active widgets.
- Role-based access control restricts unauthorized actions, permitting only Guest access.
- System telemetry and data tables refresh correctly upon user interaction.

## 5. Required Elements
* **screen_root** -> `psw_reports-screen` (Type: layout, Required: 1)
* **page_title** -> `psw_reports-title` (Type: header, Required: 1)
* **primary_content** -> `psw_reports-content` (Type: layout, Required: 1)
* **pswreports_btn_generate** -> `pswreports-btn-generate` (Type: button, Required: 0)
* **pswreports_content** -> `pswreports-content` (Type: layout, Required: 0)

## 6. Component Mapping
* Component ID: `6791` (Required: 1)
* Component ID: `6792` (Required: 1)
* Component ID: `6793` (Required: 1)
* Component ID: `6794` (Required: 1)

## 7. API / Data Mapping
* API ID: `5058` (Required: 1)

## 8. Test Definition & Steps
* **Test Code**: `psw_reports_runtime`
* **Test Name**: `Psw Reports Smoke Test`
* **Test Type**: `e2e`
* **Expected Title**: `PSW Reports`
* **Expected Layout**: `dashboard`

### Test Steps
1. **login_as_role** (Selector: `None`, Value: `guest`)
2. **verify_sidebar_exists** (Selector: `app-sidebar`, Value: `None`)
3. **verify_sidebar_link_exists** (Selector: `None`, Value: `PSW Reports`)
4. **click_sidebar_link** (Selector: `None`, Value: `PSW Reports`)
5. **check_url** (Selector: `None`, Value: `/generated/psw-reports`)
6. **verify_topbar_exists** (Selector: `app-topbar`, Value: `None`)
7. **verify_main_content_exists** (Selector: `app-content-slot`, Value: `None`)
8. **verify_screen_not_empty** (Selector: `None`, Value: `None`)
9. **verify_forbidden_text_absent** (Selector: `None`, Value: `None`)
10. **verify_no_console_errors** (Selector: `None`, Value: `None`)
11. **screenshot** (Selector: `None`, Value: `None`)
